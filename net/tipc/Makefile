# SPDX-License-Identifier: GPL-2.0
#
# Makefile for the LinaOS TIPC layer
#

obj-$(CONFIG_TIPC) := tipc.o

tipc-y	+= addr.o bcast.o bearer.o \
	   core.o link.o discover.o msg.o  \
	   name_distr.o  subscr.o monitor.o name_table.o net.o  \
	   netlink.o netlink_compat.o node.o socket.o eth_media.o \
	   topsrv.o group.o trace.o

CFLAGS_trace.o += -I$(src)

tipc-$(CONFIG_TIPC_MEDIA_UDP)	+= udp_media.o
tipc-$(CONFIG_TIPC_MEDIA_IB)	+= ib_media.o
tipc-$(CONFIG_SYSCTL)		+= sysctl.o
tipc-$(CONFIG_TIPC_CRYPTO)	+= crypto.o


obj-$(CONFIG_TIPC_DIAG)	+= diag.o
