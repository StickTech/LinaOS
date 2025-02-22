/* SPDX-License-Identifier: GPL-2.0-only */
/*
 *  linaos/arch/arm/lib/io-writesw-armv3.S
 *
 *  Copyright (C) 1995-2000 Russell King
 */
#include <linaos/linkage.h>
#include <asm/assembler.h>

.Loutsw_bad_alignment:
		adr	r0, .Loutsw_bad_align_msg
		mov	r2, lr
		b	panic
.Loutsw_bad_align_msg:
		.asciz	"outsw: bad buffer alignment (0x%p, lr=0x%08lX)\n"
		.align

.Loutsw_align:	tst	r1, #1
		bne	.Loutsw_bad_alignment

		add	r1, r1, #2

		ldr	r3, [r1, #-4]
		mov	r3, r3, lsr #16
		orr	r3, r3, r3, lsl #16
		str	r3, [r0]
		subs	r2, r2, #1
		reteq	lr

ENTRY(__raw_writesw)
		teq	r2, #0		@ do we have to check for the zero len?
		reteq	lr
		tst	r1, #3
		bne	.Loutsw_align

		stmfd	sp!, {r4, r5, r6, lr}

		subs	r2, r2, #8
		bmi	.Lno_outsw_8

.Loutsw_8_lp:	ldmia	r1!, {r3, r4, r5, r6}

		mov	ip, r3, lsl #16
		orr	ip, ip, ip, lsr #16
		str	ip, [r0]

		mov	ip, r3, lsr #16
		orr	ip, ip, ip, lsl #16
		str	ip, [r0]

		mov	ip, r4, lsl #16
		orr	ip, ip, ip, lsr #16
		str	ip, [r0]

		mov	ip, r4, lsr #16
		orr	ip, ip, ip, lsl #16
		str	ip, [r0]

		mov	ip, r5, lsl #16
		orr	ip, ip, ip, lsr #16
		str	ip, [r0]

		mov	ip, r5, lsr #16
		orr	ip, ip, ip, lsl #16
		str	ip, [r0]

		mov	ip, r6, lsl #16
		orr	ip, ip, ip, lsr #16
		str	ip, [r0]

		mov	ip, r6, lsr #16
		orr	ip, ip, ip, lsl #16
		str	ip, [r0]

		subs	r2, r2, #8
		bpl	.Loutsw_8_lp

		tst	r2, #7
		ldmfdeq	sp!, {r4, r5, r6, pc}

.Lno_outsw_8:	tst	r2, #4
		beq	.Lno_outsw_4

		ldmia	r1!, {r3, r4}

		mov	ip, r3, lsl #16
		orr	ip, ip, ip, lsr #16
		str	ip, [r0]

		mov	ip, r3, lsr #16
		orr	ip, ip, ip, lsl #16
		str	ip, [r0]

		mov	ip, r4, lsl #16
		orr	ip, ip, ip, lsr #16
		str	ip, [r0]

		mov	ip, r4, lsr #16
		orr	ip, ip, ip, lsl #16
		str	ip, [r0]

.Lno_outsw_4:	tst	r2, #2
		beq	.Lno_outsw_2

		ldr	r3, [r1], #4

		mov	ip, r3, lsl #16
		orr	ip, ip, ip, lsr #16
		str	ip, [r0]

		mov	ip, r3, lsr #16
		orr	ip, ip, ip, lsl #16
		str	ip, [r0]

.Lno_outsw_2:	tst	r2, #1

		ldrne	r3, [r1]

		movne	ip, r3, lsl #16
		orrne	ip, ip, ip, lsr #16
		strne	ip, [r0]

		ldmfd	sp!, {r4, r5, r6, pc}
