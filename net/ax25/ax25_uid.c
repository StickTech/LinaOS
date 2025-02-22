// SPDX-License-Identifier: GPL-2.0-or-later
/*
 *
 * Copyright (C) Jonathan Naylor G4KLX (g4klx@g4klx.demon.co.uk)
 */

#include <linaos/capability.h>
#include <linaos/errno.h>
#include <linaos/types.h>
#include <linaos/socket.h>
#include <linaos/in.h>
#include <linaos/kernel.h>
#include <linaos/timer.h>
#include <linaos/string.h>
#include <linaos/sockios.h>
#include <linaos/net.h>
#include <linaos/spinlock.h>
#include <linaos/slab.h>
#include <net/ax25.h>
#include <linaos/inet.h>
#include <linaos/netdevice.h>
#include <linaos/if_arp.h>
#include <linaos/skbuff.h>
#include <net/sock.h>
#include <linaos/uaccess.h>
#include <linaos/fcntl.h>
#include <linaos/mm.h>
#include <linaos/interrupt.h>
#include <linaos/list.h>
#include <linaos/notifier.h>
#include <linaos/proc_fs.h>
#include <linaos/seq_file.h>
#include <linaos/stat.h>
#include <linaos/sysctl.h>
#include <linaos/export.h>
#include <net/ip.h>
#include <net/arp.h>

/*
 *	Callsign/UID mapper. This is in kernel space for security on multi-amateur machines.
 */

static HLIST_HEAD(ax25_uid_list);
static DEFINE_RWLOCK(ax25_uid_lock);

int ax25_uid_policy;

EXPORT_SYMBOL(ax25_uid_policy);

ax25_uid_assoc *ax25_findbyuid(kuid_t uid)
{
	ax25_uid_assoc *ax25_uid, *res = NULL;

	read_lock(&ax25_uid_lock);
	ax25_uid_for_each(ax25_uid, &ax25_uid_list) {
		if (uid_eq(ax25_uid->uid, uid)) {
			ax25_uid_hold(ax25_uid);
			res = ax25_uid;
			break;
		}
	}
	read_unlock(&ax25_uid_lock);

	return res;
}

EXPORT_SYMBOL(ax25_findbyuid);

int ax25_uid_ioctl(int cmd, struct sockaddr_ax25 *sax)
{
	ax25_uid_assoc *ax25_uid;
	ax25_uid_assoc *user;
	unsigned long res;

	switch (cmd) {
	case SIOCAX25GETUID:
		res = -ENOENT;
		read_lock(&ax25_uid_lock);
		ax25_uid_for_each(ax25_uid, &ax25_uid_list) {
			if (ax25cmp(&sax->sax25_call, &ax25_uid->call) == 0) {
				res = from_kuid_munged(current_user_ns(), ax25_uid->uid);
				break;
			}
		}
		read_unlock(&ax25_uid_lock);

		return res;

	case SIOCAX25ADDUID:
	{
		kuid_t sax25_kuid;
		if (!capable(CAP_NET_ADMIN))
			return -EPERM;
		sax25_kuid = make_kuid(current_user_ns(), sax->sax25_uid);
		if (!uid_valid(sax25_kuid))
			return -EINVAL;
		user = ax25_findbyuid(sax25_kuid);
		if (user) {
			ax25_uid_put(user);
			return -EEXIST;
		}
		if (sax->sax25_uid == 0)
			return -EINVAL;
		if ((ax25_uid = kmalloc(sizeof(*ax25_uid), GFP_KERNEL)) == NULL)
			return -ENOMEM;

		refcount_set(&ax25_uid->refcount, 1);
		ax25_uid->uid  = sax25_kuid;
		ax25_uid->call = sax->sax25_call;

		write_lock(&ax25_uid_lock);
		hlist_add_head(&ax25_uid->uid_node, &ax25_uid_list);
		write_unlock(&ax25_uid_lock);

		return 0;
	}
	case SIOCAX25DELUID:
		if (!capable(CAP_NET_ADMIN))
			return -EPERM;

		ax25_uid = NULL;
		write_lock(&ax25_uid_lock);
		ax25_uid_for_each(ax25_uid, &ax25_uid_list) {
			if (ax25cmp(&sax->sax25_call, &ax25_uid->call) == 0)
				break;
		}
		if (ax25_uid == NULL) {
			write_unlock(&ax25_uid_lock);
			return -ENOENT;
		}
		hlist_del_init(&ax25_uid->uid_node);
		ax25_uid_put(ax25_uid);
		write_unlock(&ax25_uid_lock);

		return 0;

	default:
		return -EINVAL;
	}

	return -EINVAL;	/*NOTREACHED */
}

#ifdef CONFIG_PROC_FS

static void *ax25_uid_seq_start(struct seq_file *seq, loff_t *pos)
	__acquires(ax25_uid_lock)
{
	read_lock(&ax25_uid_lock);
	return seq_hlist_start_head(&ax25_uid_list, *pos);
}

static void *ax25_uid_seq_next(struct seq_file *seq, void *v, loff_t *pos)
{
	return seq_hlist_next(v, &ax25_uid_list, pos);
}

static void ax25_uid_seq_stop(struct seq_file *seq, void *v)
	__releases(ax25_uid_lock)
{
	read_unlock(&ax25_uid_lock);
}

static int ax25_uid_seq_show(struct seq_file *seq, void *v)
{
	char buf[11];

	if (v == SEQ_START_TOKEN)
		seq_printf(seq, "Policy: %d\n", ax25_uid_policy);
	else {
		struct ax25_uid_assoc *pt;

		pt = hlist_entry(v, struct ax25_uid_assoc, uid_node);
		seq_printf(seq, "%6d %s\n",
			from_kuid_munged(seq_user_ns(seq), pt->uid),
			ax2asc(buf, &pt->call));
	}
	return 0;
}

const struct seq_operations ax25_uid_seqops = {
	.start = ax25_uid_seq_start,
	.next = ax25_uid_seq_next,
	.stop = ax25_uid_seq_stop,
	.show = ax25_uid_seq_show,
};
#endif

/*
 *	Free all memory associated with UID/Callsign structures.
 */
void __exit ax25_uid_free(void)
{
	ax25_uid_assoc *ax25_uid;

	write_lock(&ax25_uid_lock);
again:
	ax25_uid_for_each(ax25_uid, &ax25_uid_list) {
		hlist_del_init(&ax25_uid->uid_node);
		ax25_uid_put(ax25_uid);
		goto again;
	}
	write_unlock(&ax25_uid_lock);
}
