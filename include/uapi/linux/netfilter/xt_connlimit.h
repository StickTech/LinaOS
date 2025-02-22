/* SPDX-License-Identifier: GPL-2.0 WITH LinaOS-syscall-note */
#ifndef _XT_CONNLIMIT_H
#define _XT_CONNLIMIT_H

#include <linaos/types.h>
#include <linaos/netfilter.h>

struct xt_connlimit_data;

enum {
	XT_CONNLIMIT_INVERT = 1 << 0,
	XT_CONNLIMIT_DADDR  = 1 << 1,
};

struct xt_connlimit_info {
	union {
		union nf_inet_addr mask;
#ifndef __KERNEL__
		union {
			__be32 v4_mask;
			__be32 v6_mask[4];
		};
#endif
	};
	unsigned int limit;
	/* revision 1 */
	__u32 flags;

	/* Used internally by the kernel */
	struct nf_conncount_data *data __attribute__((aligned(8)));
};

#endif /* _XT_CONNLIMIT_H */
