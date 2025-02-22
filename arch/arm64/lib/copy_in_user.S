/* SPDX-License-Identifier: GPL-2.0-only */
/*
 * Copy from user space to user space
 *
 * Copyright (C) 2012 ARM Ltd.
 */

#include <linaos/linkage.h>

#include <asm/asm-uaccess.h>
#include <asm/assembler.h>
#include <asm/cache.h>

/*
 * Copy from user space to user space (alignment handled by the hardware)
 *
 * Parameters:
 *	x0 - to
 *	x1 - from
 *	x2 - n
 * Returns:
 *	x0 - bytes not copied
 */
	.macro ldrb1 reg, ptr, val
	user_ldst 9998f, ldtrb, \reg, \ptr, \val
	.endm

	.macro strb1 reg, ptr, val
	user_ldst 9998f, sttrb, \reg, \ptr, \val
	.endm

	.macro ldrh1 reg, ptr, val
	user_ldst 9998f, ldtrh, \reg, \ptr, \val
	.endm

	.macro strh1 reg, ptr, val
	user_ldst 9998f, sttrh, \reg, \ptr, \val
	.endm

	.macro ldr1 reg, ptr, val
	user_ldst 9998f, ldtr, \reg, \ptr, \val
	.endm

	.macro str1 reg, ptr, val
	user_ldst 9998f, sttr, \reg, \ptr, \val
	.endm

	.macro ldp1 reg1, reg2, ptr, val
	user_ldp 9998f, \reg1, \reg2, \ptr, \val
	.endm

	.macro stp1 reg1, reg2, ptr, val
	user_stp 9998f, \reg1, \reg2, \ptr, \val
	.endm

end	.req	x5

SYM_FUNC_START(__arch_copy_in_user)
	add	end, x0, x2
#include "copy_template.S"
	mov	x0, #0
	ret
SYM_FUNC_END(__arch_copy_in_user)
EXPORT_SYMBOL(__arch_copy_in_user)

	.section .fixup,"ax"
	.align	2
9998:	sub	x0, end, dst			// bytes not copied
	ret
	.previous
