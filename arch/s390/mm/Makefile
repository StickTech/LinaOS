# SPDX-License-Identifier: GPL-2.0
#
# Makefile for the linaos s390-specific parts of the memory manager.
#

obj-y		:= init.o fault.o extmem.o mmap.o vmem.o maccess.o
obj-y		+= page-states.o pageattr.o pgtable.o pgalloc.o

obj-$(CONFIG_CMM)		+= cmm.o
obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
obj-$(CONFIG_PTDUMP_CORE)	+= dump_pagetables.o
obj-$(CONFIG_PGSTE)		+= gmap.o

KASAN_SANITIZE_kasan_init.o	:= n
obj-$(CONFIG_KASAN)		+= kasan_init.o
