/* SPDX-License-Identifier: GPL-2.0-only */

#include <linaos/init.h>
#include <linaos/linkage.h>
#include <asm/page.h>

	__PAGE_ALIGNED_DATA

	.globl vdso_start, vdso_end
	.balign PAGE_SIZE
vdso_start:
	.incbin "arch/csky/kernel/vdso/vdso.so"
	.balign PAGE_SIZE
vdso_end:

	.previous
