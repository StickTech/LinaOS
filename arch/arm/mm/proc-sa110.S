/* SPDX-License-Identifier: GPL-2.0-only */
/*
 *  linaos/arch/arm/mm/proc-sa110.S
 *
 *  Copyright (C) 1997-2002 Russell King
 *  hacked for non-paged-MM by Hyok S. Choi, 2003.
 *
 *  MMU functions for SA110
 *
 *  These are the low level assembler for performing cache and TLB
 *  functions on the StrongARM-110.
 */
#include <linaos/linkage.h>
#include <linaos/init.h>
#include <linaos/pgtable.h>
#include <asm/assembler.h>
#include <asm/asm-offsets.h>
#include <asm/hwcap.h>
#include <mach/hardware.h>
#include <asm/pgtable-hwdef.h>
#include <asm/ptrace.h>

#include "proc-macros.S"

/*
 * the cache line size of the I and D cache
 */
#define DCACHELINESIZE	32

	.text

/*
 * cpu_sa110_proc_init()
 */
ENTRY(cpu_sa110_proc_init)
	mov	r0, #0
	mcr	p15, 0, r0, c15, c1, 2		@ Enable clock switching
	ret	lr

/*
 * cpu_sa110_proc_fin()
 */
ENTRY(cpu_sa110_proc_fin)
	mov	r0, #0
	mcr	p15, 0, r0, c15, c2, 2		@ Disable clock switching
	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
	bic	r0, r0, #0x1000			@ ...i............
	bic	r0, r0, #0x000e			@ ............wca.
	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
	ret	lr

/*
 * cpu_sa110_reset(loc)
 *
 * Perform a soft reset of the system.  Put the CPU into the
 * same state as it would be if it had been reset, and branch
 * to what would be the reset vector.
 *
 * loc: location to jump to for soft reset
 */
	.align	5
	.pushsection	.idmap.text, "ax"
ENTRY(cpu_sa110_reset)
	mov	ip, #0
	mcr	p15, 0, ip, c7, c7, 0		@ invalidate I,D caches
	mcr	p15, 0, ip, c7, c10, 4		@ drain WB
#ifdef CONFIG_MMU
	mcr	p15, 0, ip, c8, c7, 0		@ invalidate I & D TLBs
#endif
	mrc	p15, 0, ip, c1, c0, 0		@ ctrl register
	bic	ip, ip, #0x000f			@ ............wcam
	bic	ip, ip, #0x1100			@ ...i...s........
	mcr	p15, 0, ip, c1, c0, 0		@ ctrl register
	ret	r0
ENDPROC(cpu_sa110_reset)
	.popsection

/*
 * cpu_sa110_do_idle(type)
 *
 * Cause the processor to idle
 *
 * type: call type:
 *   0 = slow idle
 *   1 = fast idle
 *   2 = switch to slow processor clock
 *   3 = switch to fast processor clock
 */
	.align	5

ENTRY(cpu_sa110_do_idle)
	mcr	p15, 0, ip, c15, c2, 2		@ disable clock switching
	ldr	r1, =UNCACHEABLE_ADDR		@ load from uncacheable loc
	ldr	r1, [r1, #0]			@ force switch to MCLK
	mov	r0, r0				@ safety
	mov	r0, r0				@ safety
	mov	r0, r0				@ safety
	mcr	p15, 0, r0, c15, c8, 2		@ Wait for interrupt, cache aligned
	mov	r0, r0				@ safety
	mov	r0, r0				@ safety
	mov	r0, r0				@ safety
	mcr	p15, 0, r0, c15, c1, 2		@ enable clock switching
	ret	lr

/* ================================= CACHE ================================ */

/*
 * cpu_sa110_dcache_clean_area(addr,sz)
 *
 * Clean the specified entry of any caches such that the MMU
 * translation fetches will obtain correct data.
 *
 * addr: cache-unaligned virtual address
 */
	.align	5
ENTRY(cpu_sa110_dcache_clean_area)
1:	mcr	p15, 0, r0, c7, c10, 1		@ clean D entry
	add	r0, r0, #DCACHELINESIZE
	subs	r1, r1, #DCACHELINESIZE
	bhi	1b
	ret	lr

/* =============================== PageTable ============================== */

/*
 * cpu_sa110_switch_mm(pgd)
 *
 * Set the translation base pointer to be as described by pgd.
 *
 * pgd: new page tables
 */
	.align	5
ENTRY(cpu_sa110_switch_mm)
#ifdef CONFIG_MMU
	str	lr, [sp, #-4]!
	bl	v4wb_flush_kern_cache_all	@ clears IP
	mcr	p15, 0, r0, c2, c0, 0		@ load page table pointer
	mcr	p15, 0, ip, c8, c7, 0		@ invalidate I & D TLBs
	ldr	pc, [sp], #4
#else
	ret	lr
#endif

/*
 * cpu_sa110_set_pte_ext(ptep, pte, ext)
 *
 * Set a PTE and flush it out
 */
	.align	5
ENTRY(cpu_sa110_set_pte_ext)
#ifdef CONFIG_MMU
	armv3_set_pte_ext wc_disable=0
	mov	r0, r0
	mcr	p15, 0, r0, c7, c10, 1		@ clean D entry
	mcr	p15, 0, r0, c7, c10, 4		@ drain WB
#endif
	ret	lr

	.type	__sa110_setup, #function
__sa110_setup:
	mov	r10, #0
	mcr	p15, 0, r10, c7, c7		@ invalidate I,D caches on v4
	mcr	p15, 0, r10, c7, c10, 4		@ drain write buffer on v4
#ifdef CONFIG_MMU
	mcr	p15, 0, r10, c8, c7		@ invalidate I,D TLBs on v4
#endif

	adr	r5, sa110_crval
	ldmia	r5, {r5, r6}
	mrc	p15, 0, r0, c1, c0		@ get control register v4
	bic	r0, r0, r5
	orr	r0, r0, r6
	ret	lr
	.size	__sa110_setup, . - __sa110_setup

	/*
	 *  R
	 * .RVI ZFRS BLDP WCAM
	 * ..01 0001 ..11 1101
	 * 
	 */
	.type	sa110_crval, #object
sa110_crval:
	crval	clear=0x00003f3f, mmuset=0x0000113d, ucset=0x00001130

	__INITDATA

	@ define struct processor (see <asm/proc-fns.h> and proc-macros.S)
	define_processor_functions sa110, dabort=v4_early_abort, pabort=legacy_pabort

	.section ".rodata"

	string	cpu_arch_name, "armv4"
	string	cpu_elf_name, "v4"
	string	cpu_sa110_name, "StrongARM-110"

	.align

	.section ".proc.info.init", "a"

	.type	__sa110_proc_info,#object
__sa110_proc_info:
	.long	0x4401a100
	.long	0xfffffff0
	.long   PMD_TYPE_SECT | \
		PMD_SECT_BUFFERABLE | \
		PMD_SECT_CACHEABLE | \
		PMD_SECT_AP_WRITE | \
		PMD_SECT_AP_READ
	.long   PMD_TYPE_SECT | \
		PMD_SECT_AP_WRITE | \
		PMD_SECT_AP_READ
	initfn	__sa110_setup, __sa110_proc_info
	.long	cpu_arch_name
	.long	cpu_elf_name
	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_26BIT | HWCAP_FAST_MULT
	.long	cpu_sa110_name
	.long	sa110_processor_functions
	.long	v4wb_tlb_fns
	.long	v4wb_user_fns
	.long	v4wb_cache_fns
	.size	__sa110_proc_info, . - __sa110_proc_info
