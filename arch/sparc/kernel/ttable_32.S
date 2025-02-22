/* SPDX-License-Identifier: GPL-2.0 */
/* The Sparc trap table, bootloader gives us control at _start. */
        __HEAD

        .globl  _start
_start:

	.globl _stext
_stext:

	.globl  trapbase
trapbase:

#ifdef CONFIG_SMP
trapbase_cpu0:
#endif
/* We get control passed to us here at t_zero. */
t_zero:	b gokernel; nop; nop; nop;
t_tflt:	SRMMU_TFAULT                        /* Inst. Access Exception        */
t_bins:	TRAP_ENTRY(0x2, bad_instruction)    /* Illegal Instruction           */
t_pins:	TRAP_ENTRY(0x3, priv_instruction)   /* Privileged Instruction        */
t_fpd:	TRAP_ENTRY(0x4, fpd_trap_handler)   /* Floating Point Disabled       */
t_wovf:	WINDOW_SPILL                        /* Window Overflow               */
t_wunf:	WINDOW_FILL                         /* Window Underflow              */
t_mna:	TRAP_ENTRY(0x7, mna_handler)        /* Memory Address Not Aligned    */
t_fpe:	TRAP_ENTRY(0x8, fpe_trap_handler)   /* Floating Point Exception      */
t_dflt:	SRMMU_DFAULT                        /* Data Miss Exception           */
t_tio:	TRAP_ENTRY(0xa, do_tag_overflow)    /* Tagged Instruction Ovrflw     */
t_wpt:	TRAP_ENTRY(0xb, do_watchpoint)      /* Watchpoint Detected           */
t_badc:	BAD_TRAP(0xc) BAD_TRAP(0xd) BAD_TRAP(0xe) BAD_TRAP(0xf) BAD_TRAP(0x10)
t_irq1:	TRAP_ENTRY_INTERRUPT(1)             /* IRQ Software/SBUS Level 1     */
t_irq2:	TRAP_ENTRY_INTERRUPT(2)             /* IRQ SBUS Level 2              */
t_irq3:	TRAP_ENTRY_INTERRUPT(3)             /* IRQ SCSI/DMA/SBUS Level 3     */
t_irq4:	TRAP_ENTRY_INTERRUPT(4)             /* IRQ Software Level 4          */
t_irq5:	TRAP_ENTRY_INTERRUPT(5)             /* IRQ SBUS/Ethernet Level 5     */
t_irq6:	TRAP_ENTRY_INTERRUPT(6)             /* IRQ Software Level 6          */
t_irq7:	TRAP_ENTRY_INTERRUPT(7)             /* IRQ Video/SBUS Level 5        */
t_irq8:	TRAP_ENTRY_INTERRUPT(8)             /* IRQ SBUS Level 6              */
t_irq9:	TRAP_ENTRY_INTERRUPT(9)             /* IRQ SBUS Level 7              */
t_irq10:TRAP_ENTRY_INTERRUPT(10)            /* IRQ Timer #1 (one we use)     */
t_irq11:TRAP_ENTRY_INTERRUPT(11)            /* IRQ Floppy Intr.              */
t_irq12:TRAP_ENTRY_INTERRUPT(12)            /* IRQ Zilog serial chip         */
t_irq13:TRAP_ENTRY_INTERRUPT(13)            /* IRQ Audio Intr.               */
t_irq14:TRAP_ENTRY_INTERRUPT(14)            /* IRQ Timer #2                  */

	.globl	t_nmi
t_nmi:	TRAP_ENTRY(0x1f, linaos_trap_ipi15_sun4m)

t_racc:	TRAP_ENTRY(0x20, do_reg_access)     /* General Register Access Error */
t_iacce:BAD_TRAP(0x21)                      /* Instr Access Error            */
t_bad22:BAD_TRAP(0x22)
	BAD_TRAP(0x23)
t_cpdis:TRAP_ENTRY(0x24, do_cp_disabled)    /* Co-Processor Disabled         */
t_uflsh:SKIP_TRAP(0x25, unimp_flush)        /* Unimplemented FLUSH inst.     */
t_bad26:BAD_TRAP(0x26) BAD_TRAP(0x27)
t_cpexc:TRAP_ENTRY(0x28, do_cp_exception)   /* Co-Processor Exception        */
t_dacce:SRMMU_DFAULT                        /* Data Access Error             */
t_hwdz:	TRAP_ENTRY(0x2a, do_hw_divzero)     /* Division by zero, you lose... */
t_dserr:BAD_TRAP(0x2b)                      /* Data Store Error              */
t_daccm:BAD_TRAP(0x2c)                      /* Data Access MMU-Miss          */
t_bad2d:BAD_TRAP(0x2d) BAD_TRAP(0x2e) BAD_TRAP(0x2f) BAD_TRAP(0x30) BAD_TRAP(0x31)
t_bad32:BAD_TRAP(0x32) BAD_TRAP(0x33) BAD_TRAP(0x34) BAD_TRAP(0x35) BAD_TRAP(0x36)
t_bad37:BAD_TRAP(0x37) BAD_TRAP(0x38) BAD_TRAP(0x39) BAD_TRAP(0x3a) BAD_TRAP(0x3b)
t_iaccm:BAD_TRAP(0x3c)                      /* Instr Access MMU-Miss         */
t_bad3d:BAD_TRAP(0x3d) BAD_TRAP(0x3e) BAD_TRAP(0x3f) BAD_TRAP(0x40) BAD_TRAP(0x41)
t_bad42:BAD_TRAP(0x42) BAD_TRAP(0x43) BAD_TRAP(0x44) BAD_TRAP(0x45) BAD_TRAP(0x46)
t_bad47:BAD_TRAP(0x47) BAD_TRAP(0x48) BAD_TRAP(0x49) BAD_TRAP(0x4a) BAD_TRAP(0x4b)
t_bad4c:BAD_TRAP(0x4c) BAD_TRAP(0x4d) BAD_TRAP(0x4e) BAD_TRAP(0x4f) BAD_TRAP(0x50)
t_bad51:BAD_TRAP(0x51) BAD_TRAP(0x52) BAD_TRAP(0x53) BAD_TRAP(0x54) BAD_TRAP(0x55)
t_bad56:BAD_TRAP(0x56) BAD_TRAP(0x57) BAD_TRAP(0x58) BAD_TRAP(0x59) BAD_TRAP(0x5a)
t_bad5b:BAD_TRAP(0x5b) BAD_TRAP(0x5c) BAD_TRAP(0x5d) BAD_TRAP(0x5e) BAD_TRAP(0x5f)
t_bad60:BAD_TRAP(0x60) BAD_TRAP(0x61) BAD_TRAP(0x62) BAD_TRAP(0x63) BAD_TRAP(0x64)
t_bad65:BAD_TRAP(0x65) BAD_TRAP(0x66) BAD_TRAP(0x67) BAD_TRAP(0x68) BAD_TRAP(0x69)
t_bad6a:BAD_TRAP(0x6a) BAD_TRAP(0x6b) BAD_TRAP(0x6c) BAD_TRAP(0x6d) BAD_TRAP(0x6e)
t_bad6f:BAD_TRAP(0x6f) BAD_TRAP(0x70) BAD_TRAP(0x71) BAD_TRAP(0x72) BAD_TRAP(0x73)
t_bad74:BAD_TRAP(0x74) BAD_TRAP(0x75) BAD_TRAP(0x76) BAD_TRAP(0x77) BAD_TRAP(0x78)
t_bad79:BAD_TRAP(0x79) BAD_TRAP(0x7a) BAD_TRAP(0x7b) BAD_TRAP(0x7c) BAD_TRAP(0x7d)
t_bad7e:BAD_TRAP(0x7e) BAD_TRAP(0x7f)
t_bad80:BAD_TRAP(0x80)                      /* SunOS System Call             */
t_sbkpt:BREAKPOINT_TRAP                     /* Software Breakpoint/KGDB      */
t_divz:	TRAP_ENTRY(0x82, do_hw_divzero)     /* Divide by zero trap           */
t_flwin:TRAP_ENTRY(0x83, do_flush_windows)  /* Flush Windows Trap            */
t_clwin:BAD_TRAP(0x84)                      /* Clean Windows Trap            */
t_rchk:	BAD_TRAP(0x85)                      /* Range Check                   */
t_funal:BAD_TRAP(0x86)                      /* Fix Unaligned Access Trap     */
t_iovf:	BAD_TRAP(0x87)                      /* Integer Overflow Trap         */
t_bad88:BAD_TRAP(0x88)                      /* Slowaris System Call          */
t_bad89:BAD_TRAP(0x89)                      /* Net-B.S. System Call          */
t_bad8a:BAD_TRAP(0x8a) BAD_TRAP(0x8b) BAD_TRAP(0x8c) BAD_TRAP(0x8d) BAD_TRAP(0x8e)
t_bad8f:BAD_TRAP(0x8f)
t_linaos:LINUX_SYSCALL_TRAP                  /* LinaOS System Call             */
t_bad91:BAD_TRAP(0x91) BAD_TRAP(0x92) BAD_TRAP(0x93) BAD_TRAP(0x94) BAD_TRAP(0x95)
t_bad96:BAD_TRAP(0x96) BAD_TRAP(0x97) BAD_TRAP(0x98) BAD_TRAP(0x99) BAD_TRAP(0x9a)
t_bad9b:BAD_TRAP(0x9b) BAD_TRAP(0x9c) BAD_TRAP(0x9d) BAD_TRAP(0x9e) BAD_TRAP(0x9f)
t_getcc:GETCC_TRAP                          /* Get Condition Codes           */
t_setcc:SETCC_TRAP                          /* Set Condition Codes           */
t_getpsr:GETPSR_TRAP                        /* Get PSR Register              */
t_bada3:BAD_TRAP(0xa3) BAD_TRAP(0xa4) BAD_TRAP(0xa5) BAD_TRAP(0xa6)
t_bada7:BAD_TRAP(0xa7)
t_bada8:BAD_TRAP(0xa8) BAD_TRAP(0xa9) BAD_TRAP(0xaa) BAD_TRAP(0xab)
t_badac:BAD_TRAP(0xac) BAD_TRAP(0xad) BAD_TRAP(0xae) BAD_TRAP(0xaf) BAD_TRAP(0xb0)
t_badb1:BAD_TRAP(0xb1) BAD_TRAP(0xb2) BAD_TRAP(0xb3) BAD_TRAP(0xb4) BAD_TRAP(0xb5)
t_badb6:BAD_TRAP(0xb6) BAD_TRAP(0xb7) BAD_TRAP(0xb8) BAD_TRAP(0xb9) BAD_TRAP(0xba)
t_badbb:BAD_TRAP(0xbb) BAD_TRAP(0xbc) BAD_TRAP(0xbd) BAD_TRAP(0xbe) BAD_TRAP(0xbf)
t_badc0:BAD_TRAP(0xc0) BAD_TRAP(0xc1) BAD_TRAP(0xc2) BAD_TRAP(0xc3) BAD_TRAP(0xc4)
t_badc5:BAD_TRAP(0xc5) BAD_TRAP(0xc6) BAD_TRAP(0xc7) BAD_TRAP(0xc8) BAD_TRAP(0xc9)
t_badca:BAD_TRAP(0xca) BAD_TRAP(0xcb) BAD_TRAP(0xcc) BAD_TRAP(0xcd) BAD_TRAP(0xce)
t_badcf:BAD_TRAP(0xcf) BAD_TRAP(0xd0) BAD_TRAP(0xd1) BAD_TRAP(0xd2) BAD_TRAP(0xd3)
t_badd4:BAD_TRAP(0xd4) BAD_TRAP(0xd5) BAD_TRAP(0xd6) BAD_TRAP(0xd7) BAD_TRAP(0xd8)
t_badd9:BAD_TRAP(0xd9) BAD_TRAP(0xda) BAD_TRAP(0xdb) BAD_TRAP(0xdc) BAD_TRAP(0xdd)
t_badde:BAD_TRAP(0xde) BAD_TRAP(0xdf) BAD_TRAP(0xe0) BAD_TRAP(0xe1) BAD_TRAP(0xe2)
t_bade3:BAD_TRAP(0xe3) BAD_TRAP(0xe4) BAD_TRAP(0xe5) BAD_TRAP(0xe6) BAD_TRAP(0xe7)
t_bade8:BAD_TRAP(0xe8) BAD_TRAP(0xe9) BAD_TRAP(0xea) BAD_TRAP(0xeb) BAD_TRAP(0xec)
t_baded:BAD_TRAP(0xed) BAD_TRAP(0xee) BAD_TRAP(0xef) BAD_TRAP(0xf0) BAD_TRAP(0xf1)
t_badf2:BAD_TRAP(0xf2) BAD_TRAP(0xf3) BAD_TRAP(0xf4) BAD_TRAP(0xf5) BAD_TRAP(0xf6)
t_badf7:BAD_TRAP(0xf7) BAD_TRAP(0xf8) BAD_TRAP(0xf9) BAD_TRAP(0xfa) BAD_TRAP(0xfb)
t_badfc:BAD_TRAP(0xfc)
t_kgdb:	KGDB_TRAP(0xfd)
dbtrap:	BAD_TRAP(0xfe)                      /* Debugger/PROM breakpoint #1   */
dbtrap2:BAD_TRAP(0xff)                      /* Debugger/PROM breakpoint #2   */

	.globl	end_traptable
end_traptable:

#ifdef CONFIG_SMP
	/* Trap tables for the other cpus. */
	.globl	trapbase_cpu1, trapbase_cpu2, trapbase_cpu3
trapbase_cpu1:
	BAD_TRAP(0x0)
	SRMMU_TFAULT
	TRAP_ENTRY(0x2, bad_instruction)
	TRAP_ENTRY(0x3, priv_instruction)
	TRAP_ENTRY(0x4, fpd_trap_handler)
	WINDOW_SPILL
	WINDOW_FILL
	TRAP_ENTRY(0x7, mna_handler)
	TRAP_ENTRY(0x8, fpe_trap_handler)
	SRMMU_DFAULT
	TRAP_ENTRY(0xa, do_tag_overflow)
	TRAP_ENTRY(0xb, do_watchpoint)
	BAD_TRAP(0xc) BAD_TRAP(0xd) BAD_TRAP(0xe) BAD_TRAP(0xf) BAD_TRAP(0x10)
	TRAP_ENTRY_INTERRUPT(1) TRAP_ENTRY_INTERRUPT(2)
	TRAP_ENTRY_INTERRUPT(3) TRAP_ENTRY_INTERRUPT(4)
	TRAP_ENTRY_INTERRUPT(5) TRAP_ENTRY_INTERRUPT(6)
	TRAP_ENTRY_INTERRUPT(7)	TRAP_ENTRY_INTERRUPT(8)
	TRAP_ENTRY_INTERRUPT(9) TRAP_ENTRY_INTERRUPT(10)
	TRAP_ENTRY_INTERRUPT(11) TRAP_ENTRY_INTERRUPT(12)
	TRAP_ENTRY_INTERRUPT(13) TRAP_ENTRY_INTERRUPT(14)
	TRAP_ENTRY(0x1f, linaos_trap_ipi15_sun4m)
	TRAP_ENTRY(0x20, do_reg_access)
	BAD_TRAP(0x21)
	BAD_TRAP(0x22)
	BAD_TRAP(0x23)
	TRAP_ENTRY(0x24, do_cp_disabled)
	SKIP_TRAP(0x25, unimp_flush)
	BAD_TRAP(0x26)
	BAD_TRAP(0x27)
	TRAP_ENTRY(0x28, do_cp_exception)
	SRMMU_DFAULT
	TRAP_ENTRY(0x2a, do_hw_divzero)
	BAD_TRAP(0x2b)
	BAD_TRAP(0x2c)
	BAD_TRAP(0x2d) BAD_TRAP(0x2e) BAD_TRAP(0x2f) BAD_TRAP(0x30) BAD_TRAP(0x31)
	BAD_TRAP(0x32) BAD_TRAP(0x33) BAD_TRAP(0x34) BAD_TRAP(0x35) BAD_TRAP(0x36)
	BAD_TRAP(0x37) BAD_TRAP(0x38) BAD_TRAP(0x39) BAD_TRAP(0x3a) BAD_TRAP(0x3b)
	BAD_TRAP(0x3c) BAD_TRAP(0x3d) BAD_TRAP(0x3e) BAD_TRAP(0x3f) BAD_TRAP(0x40)
	BAD_TRAP(0x41) BAD_TRAP(0x42) BAD_TRAP(0x43) BAD_TRAP(0x44) BAD_TRAP(0x45)
	BAD_TRAP(0x46) BAD_TRAP(0x47) BAD_TRAP(0x48) BAD_TRAP(0x49) BAD_TRAP(0x4a)
	BAD_TRAP(0x4b) BAD_TRAP(0x4c) BAD_TRAP(0x4d) BAD_TRAP(0x4e) BAD_TRAP(0x4f)
	BAD_TRAP(0x50)
	BAD_TRAP(0x51) BAD_TRAP(0x52) BAD_TRAP(0x53) BAD_TRAP(0x54) BAD_TRAP(0x55)
	BAD_TRAP(0x56) BAD_TRAP(0x57) BAD_TRAP(0x58) BAD_TRAP(0x59) BAD_TRAP(0x5a)
	BAD_TRAP(0x5b) BAD_TRAP(0x5c) BAD_TRAP(0x5d) BAD_TRAP(0x5e) BAD_TRAP(0x5f)
	BAD_TRAP(0x60) BAD_TRAP(0x61) BAD_TRAP(0x62) BAD_TRAP(0x63) BAD_TRAP(0x64)
	BAD_TRAP(0x65) BAD_TRAP(0x66) BAD_TRAP(0x67) BAD_TRAP(0x68) BAD_TRAP(0x69)
	BAD_TRAP(0x6a) BAD_TRAP(0x6b) BAD_TRAP(0x6c) BAD_TRAP(0x6d) BAD_TRAP(0x6e)
	BAD_TRAP(0x6f) BAD_TRAP(0x70) BAD_TRAP(0x71) BAD_TRAP(0x72) BAD_TRAP(0x73)
	BAD_TRAP(0x74) BAD_TRAP(0x75) BAD_TRAP(0x76) BAD_TRAP(0x77) BAD_TRAP(0x78)
	BAD_TRAP(0x79) BAD_TRAP(0x7a) BAD_TRAP(0x7b) BAD_TRAP(0x7c) BAD_TRAP(0x7d)
	BAD_TRAP(0x7e) BAD_TRAP(0x7f)
	BAD_TRAP(0x80)
	BREAKPOINT_TRAP
	TRAP_ENTRY(0x82, do_hw_divzero)
	TRAP_ENTRY(0x83, do_flush_windows)
	BAD_TRAP(0x84) BAD_TRAP(0x85) BAD_TRAP(0x86)
	BAD_TRAP(0x87) BAD_TRAP(0x88) BAD_TRAP(0x89)
	BAD_TRAP(0x8a) BAD_TRAP(0x8b) BAD_TRAP(0x8c)
	BAD_TRAP(0x8d) BAD_TRAP(0x8e) BAD_TRAP(0x8f)
	LINUX_SYSCALL_TRAP BAD_TRAP(0x91)
	BAD_TRAP(0x92) BAD_TRAP(0x93) BAD_TRAP(0x94)
	BAD_TRAP(0x95) BAD_TRAP(0x96) BAD_TRAP(0x97) BAD_TRAP(0x98) BAD_TRAP(0x99)
	BAD_TRAP(0x9a) BAD_TRAP(0x9b) BAD_TRAP(0x9c) BAD_TRAP(0x9d) BAD_TRAP(0x9e)
	BAD_TRAP(0x9f)
	GETCC_TRAP
	SETCC_TRAP
	GETPSR_TRAP
	BAD_TRAP(0xa3) BAD_TRAP(0xa4) BAD_TRAP(0xa5) BAD_TRAP(0xa6)
	BAD_TRAP(0xa7) BAD_TRAP(0xa8) BAD_TRAP(0xa9) BAD_TRAP(0xaa) BAD_TRAP(0xab)
	BAD_TRAP(0xac) BAD_TRAP(0xad) BAD_TRAP(0xae) BAD_TRAP(0xaf) BAD_TRAP(0xb0)
	BAD_TRAP(0xb1) BAD_TRAP(0xb2) BAD_TRAP(0xb3) BAD_TRAP(0xb4) BAD_TRAP(0xb5)
	BAD_TRAP(0xb6) BAD_TRAP(0xb7) BAD_TRAP(0xb8) BAD_TRAP(0xb9) BAD_TRAP(0xba)
	BAD_TRAP(0xbb) BAD_TRAP(0xbc) BAD_TRAP(0xbd) BAD_TRAP(0xbe) BAD_TRAP(0xbf)
	BAD_TRAP(0xc0) BAD_TRAP(0xc1) BAD_TRAP(0xc2) BAD_TRAP(0xc3) BAD_TRAP(0xc4)
	BAD_TRAP(0xc5) BAD_TRAP(0xc6) BAD_TRAP(0xc7) BAD_TRAP(0xc8) BAD_TRAP(0xc9)
	BAD_TRAP(0xca) BAD_TRAP(0xcb) BAD_TRAP(0xcc) BAD_TRAP(0xcd) BAD_TRAP(0xce)
	BAD_TRAP(0xcf) BAD_TRAP(0xd0) BAD_TRAP(0xd1) BAD_TRAP(0xd2) BAD_TRAP(0xd3)
	BAD_TRAP(0xd4) BAD_TRAP(0xd5) BAD_TRAP(0xd6) BAD_TRAP(0xd7) BAD_TRAP(0xd8)
	BAD_TRAP(0xd9) BAD_TRAP(0xda) BAD_TRAP(0xdb) BAD_TRAP(0xdc) BAD_TRAP(0xdd)
	BAD_TRAP(0xde) BAD_TRAP(0xdf) BAD_TRAP(0xe0) BAD_TRAP(0xe1) BAD_TRAP(0xe2)
	BAD_TRAP(0xe3) BAD_TRAP(0xe4) BAD_TRAP(0xe5) BAD_TRAP(0xe6) BAD_TRAP(0xe7)
	BAD_TRAP(0xe8) BAD_TRAP(0xe9) BAD_TRAP(0xea) BAD_TRAP(0xeb) BAD_TRAP(0xec)
	BAD_TRAP(0xed) BAD_TRAP(0xee) BAD_TRAP(0xef) BAD_TRAP(0xf0) BAD_TRAP(0xf1)
	BAD_TRAP(0xf2) BAD_TRAP(0xf3) BAD_TRAP(0xf4) BAD_TRAP(0xf5) BAD_TRAP(0xf6)
	BAD_TRAP(0xf7) BAD_TRAP(0xf8) BAD_TRAP(0xf9) BAD_TRAP(0xfa) BAD_TRAP(0xfb)
	BAD_TRAP(0xfc)
	KGDB_TRAP(0xfd)
	BAD_TRAP(0xfe)
	BAD_TRAP(0xff)

trapbase_cpu2:
	BAD_TRAP(0x0)
	SRMMU_TFAULT
	TRAP_ENTRY(0x2, bad_instruction)
	TRAP_ENTRY(0x3, priv_instruction)
	TRAP_ENTRY(0x4, fpd_trap_handler)
	WINDOW_SPILL
	WINDOW_FILL
	TRAP_ENTRY(0x7, mna_handler)
	TRAP_ENTRY(0x8, fpe_trap_handler)
	SRMMU_DFAULT
	TRAP_ENTRY(0xa, do_tag_overflow)
	TRAP_ENTRY(0xb, do_watchpoint)
	BAD_TRAP(0xc) BAD_TRAP(0xd) BAD_TRAP(0xe) BAD_TRAP(0xf) BAD_TRAP(0x10)
	TRAP_ENTRY_INTERRUPT(1)
	TRAP_ENTRY_INTERRUPT(2)
	TRAP_ENTRY_INTERRUPT(3)
	TRAP_ENTRY_INTERRUPT(4)
	TRAP_ENTRY_INTERRUPT(5)
	TRAP_ENTRY_INTERRUPT(6)
	TRAP_ENTRY_INTERRUPT(7)
	TRAP_ENTRY_INTERRUPT(8)
	TRAP_ENTRY_INTERRUPT(9)
	TRAP_ENTRY_INTERRUPT(10)
	TRAP_ENTRY_INTERRUPT(11)
	TRAP_ENTRY_INTERRUPT(12)
	TRAP_ENTRY_INTERRUPT(13)
	TRAP_ENTRY_INTERRUPT(14)
	TRAP_ENTRY(0x1f, linaos_trap_ipi15_sun4m)
	TRAP_ENTRY(0x20, do_reg_access)
	BAD_TRAP(0x21)
	BAD_TRAP(0x22)
	BAD_TRAP(0x23)
	TRAP_ENTRY(0x24, do_cp_disabled)
	SKIP_TRAP(0x25, unimp_flush)
	BAD_TRAP(0x26)
	BAD_TRAP(0x27)
	TRAP_ENTRY(0x28, do_cp_exception)
	SRMMU_DFAULT
	TRAP_ENTRY(0x2a, do_hw_divzero)
	BAD_TRAP(0x2b)
	BAD_TRAP(0x2c)
	BAD_TRAP(0x2d) BAD_TRAP(0x2e) BAD_TRAP(0x2f) BAD_TRAP(0x30) BAD_TRAP(0x31)
	BAD_TRAP(0x32) BAD_TRAP(0x33) BAD_TRAP(0x34) BAD_TRAP(0x35) BAD_TRAP(0x36)
	BAD_TRAP(0x37) BAD_TRAP(0x38) BAD_TRAP(0x39) BAD_TRAP(0x3a) BAD_TRAP(0x3b)
	BAD_TRAP(0x3c) BAD_TRAP(0x3d) BAD_TRAP(0x3e) BAD_TRAP(0x3f) BAD_TRAP(0x40)
	BAD_TRAP(0x41) BAD_TRAP(0x42) BAD_TRAP(0x43) BAD_TRAP(0x44) BAD_TRAP(0x45)
	BAD_TRAP(0x46) BAD_TRAP(0x47) BAD_TRAP(0x48) BAD_TRAP(0x49) BAD_TRAP(0x4a)
	BAD_TRAP(0x4b) BAD_TRAP(0x4c) BAD_TRAP(0x4d) BAD_TRAP(0x4e) BAD_TRAP(0x4f)
	BAD_TRAP(0x50)
	BAD_TRAP(0x51) BAD_TRAP(0x52) BAD_TRAP(0x53) BAD_TRAP(0x54) BAD_TRAP(0x55)
	BAD_TRAP(0x56) BAD_TRAP(0x57) BAD_TRAP(0x58) BAD_TRAP(0x59) BAD_TRAP(0x5a)
	BAD_TRAP(0x5b) BAD_TRAP(0x5c) BAD_TRAP(0x5d) BAD_TRAP(0x5e) BAD_TRAP(0x5f)
	BAD_TRAP(0x60) BAD_TRAP(0x61) BAD_TRAP(0x62) BAD_TRAP(0x63) BAD_TRAP(0x64)
	BAD_TRAP(0x65) BAD_TRAP(0x66) BAD_TRAP(0x67) BAD_TRAP(0x68) BAD_TRAP(0x69)
	BAD_TRAP(0x6a) BAD_TRAP(0x6b) BAD_TRAP(0x6c) BAD_TRAP(0x6d) BAD_TRAP(0x6e)
	BAD_TRAP(0x6f) BAD_TRAP(0x70) BAD_TRAP(0x71) BAD_TRAP(0x72) BAD_TRAP(0x73)
	BAD_TRAP(0x74) BAD_TRAP(0x75) BAD_TRAP(0x76) BAD_TRAP(0x77) BAD_TRAP(0x78)
	BAD_TRAP(0x79) BAD_TRAP(0x7a) BAD_TRAP(0x7b) BAD_TRAP(0x7c) BAD_TRAP(0x7d)
	BAD_TRAP(0x7e) BAD_TRAP(0x7f)
	BAD_TRAP(0x80)
	BREAKPOINT_TRAP
	TRAP_ENTRY(0x82, do_hw_divzero)
	TRAP_ENTRY(0x83, do_flush_windows)
	BAD_TRAP(0x84)
	BAD_TRAP(0x85)
	BAD_TRAP(0x86) BAD_TRAP(0x87) BAD_TRAP(0x88)
	BAD_TRAP(0x89) BAD_TRAP(0x8a) BAD_TRAP(0x8b) BAD_TRAP(0x8c)
	BAD_TRAP(0x8d) BAD_TRAP(0x8e) BAD_TRAP(0x8f)
	LINUX_SYSCALL_TRAP BAD_TRAP(0x91)
	BAD_TRAP(0x92) BAD_TRAP(0x93) BAD_TRAP(0x94)
	BAD_TRAP(0x95) BAD_TRAP(0x96) BAD_TRAP(0x97) BAD_TRAP(0x98) BAD_TRAP(0x99)
	BAD_TRAP(0x9a) BAD_TRAP(0x9b) BAD_TRAP(0x9c) BAD_TRAP(0x9d) BAD_TRAP(0x9e)
	BAD_TRAP(0x9f)
	GETCC_TRAP
	SETCC_TRAP
	GETPSR_TRAP
	BAD_TRAP(0xa3) BAD_TRAP(0xa4) BAD_TRAP(0xa5) BAD_TRAP(0xa6)
	BAD_TRAP(0xa7) BAD_TRAP(0xa8) BAD_TRAP(0xa9) BAD_TRAP(0xaa) BAD_TRAP(0xab)
	BAD_TRAP(0xac) BAD_TRAP(0xad) BAD_TRAP(0xae) BAD_TRAP(0xaf) BAD_TRAP(0xb0)
	BAD_TRAP(0xb1) BAD_TRAP(0xb2) BAD_TRAP(0xb3) BAD_TRAP(0xb4) BAD_TRAP(0xb5)
	BAD_TRAP(0xb6) BAD_TRAP(0xb7) BAD_TRAP(0xb8) BAD_TRAP(0xb9) BAD_TRAP(0xba)
	BAD_TRAP(0xbb) BAD_TRAP(0xbc) BAD_TRAP(0xbd) BAD_TRAP(0xbe) BAD_TRAP(0xbf)
	BAD_TRAP(0xc0) BAD_TRAP(0xc1) BAD_TRAP(0xc2) BAD_TRAP(0xc3) BAD_TRAP(0xc4)
	BAD_TRAP(0xc5) BAD_TRAP(0xc6) BAD_TRAP(0xc7) BAD_TRAP(0xc8) BAD_TRAP(0xc9)
	BAD_TRAP(0xca) BAD_TRAP(0xcb) BAD_TRAP(0xcc) BAD_TRAP(0xcd) BAD_TRAP(0xce)
	BAD_TRAP(0xcf) BAD_TRAP(0xd0) BAD_TRAP(0xd1) BAD_TRAP(0xd2) BAD_TRAP(0xd3)
	BAD_TRAP(0xd4) BAD_TRAP(0xd5) BAD_TRAP(0xd6) BAD_TRAP(0xd7) BAD_TRAP(0xd8)
	BAD_TRAP(0xd9) BAD_TRAP(0xda) BAD_TRAP(0xdb) BAD_TRAP(0xdc) BAD_TRAP(0xdd)
	BAD_TRAP(0xde) BAD_TRAP(0xdf) BAD_TRAP(0xe0) BAD_TRAP(0xe1) BAD_TRAP(0xe2)
	BAD_TRAP(0xe3) BAD_TRAP(0xe4) BAD_TRAP(0xe5) BAD_TRAP(0xe6) BAD_TRAP(0xe7)
	BAD_TRAP(0xe8) BAD_TRAP(0xe9) BAD_TRAP(0xea) BAD_TRAP(0xeb) BAD_TRAP(0xec)
	BAD_TRAP(0xed) BAD_TRAP(0xee) BAD_TRAP(0xef) BAD_TRAP(0xf0) BAD_TRAP(0xf1)
	BAD_TRAP(0xf2) BAD_TRAP(0xf3) BAD_TRAP(0xf4) BAD_TRAP(0xf5) BAD_TRAP(0xf6)
	BAD_TRAP(0xf7) BAD_TRAP(0xf8) BAD_TRAP(0xf9) BAD_TRAP(0xfa) BAD_TRAP(0xfb)
	BAD_TRAP(0xfc)
	KGDB_TRAP(0xfd)
	BAD_TRAP(0xfe)
	BAD_TRAP(0xff)

trapbase_cpu3:
	BAD_TRAP(0x0)
	SRMMU_TFAULT
	TRAP_ENTRY(0x2, bad_instruction)
	TRAP_ENTRY(0x3, priv_instruction)
	TRAP_ENTRY(0x4, fpd_trap_handler)
	WINDOW_SPILL
	WINDOW_FILL
	TRAP_ENTRY(0x7, mna_handler)
	TRAP_ENTRY(0x8, fpe_trap_handler)
	SRMMU_DFAULT
	TRAP_ENTRY(0xa, do_tag_overflow)
	TRAP_ENTRY(0xb, do_watchpoint)
	BAD_TRAP(0xc) BAD_TRAP(0xd) BAD_TRAP(0xe) BAD_TRAP(0xf) BAD_TRAP(0x10)
	TRAP_ENTRY_INTERRUPT(1)
	TRAP_ENTRY_INTERRUPT(2)
	TRAP_ENTRY_INTERRUPT(3)
	TRAP_ENTRY_INTERRUPT(4)
	TRAP_ENTRY_INTERRUPT(5)
	TRAP_ENTRY_INTERRUPT(6)
	TRAP_ENTRY_INTERRUPT(7)
	TRAP_ENTRY_INTERRUPT(8)
	TRAP_ENTRY_INTERRUPT(9)
	TRAP_ENTRY_INTERRUPT(10)
	TRAP_ENTRY_INTERRUPT(11)
	TRAP_ENTRY_INTERRUPT(12)
	TRAP_ENTRY_INTERRUPT(13)
	TRAP_ENTRY_INTERRUPT(14)
	TRAP_ENTRY(0x1f, linaos_trap_ipi15_sun4m)
	TRAP_ENTRY(0x20, do_reg_access)
	BAD_TRAP(0x21)
	BAD_TRAP(0x22)
	BAD_TRAP(0x23)
	TRAP_ENTRY(0x24, do_cp_disabled)
	SKIP_TRAP(0x25, unimp_flush)
	BAD_TRAP(0x26)
	BAD_TRAP(0x27)
	TRAP_ENTRY(0x28, do_cp_exception)
	SRMMU_DFAULT
	TRAP_ENTRY(0x2a, do_hw_divzero)
	BAD_TRAP(0x2b) BAD_TRAP(0x2c)
	BAD_TRAP(0x2d) BAD_TRAP(0x2e) BAD_TRAP(0x2f) BAD_TRAP(0x30) BAD_TRAP(0x31)
	BAD_TRAP(0x32) BAD_TRAP(0x33) BAD_TRAP(0x34) BAD_TRAP(0x35) BAD_TRAP(0x36)
	BAD_TRAP(0x37) BAD_TRAP(0x38) BAD_TRAP(0x39) BAD_TRAP(0x3a) BAD_TRAP(0x3b)
	BAD_TRAP(0x3c) BAD_TRAP(0x3d) BAD_TRAP(0x3e) BAD_TRAP(0x3f) BAD_TRAP(0x40)
	BAD_TRAP(0x41) BAD_TRAP(0x42) BAD_TRAP(0x43) BAD_TRAP(0x44) BAD_TRAP(0x45)
	BAD_TRAP(0x46) BAD_TRAP(0x47) BAD_TRAP(0x48) BAD_TRAP(0x49) BAD_TRAP(0x4a)
	BAD_TRAP(0x4b) BAD_TRAP(0x4c) BAD_TRAP(0x4d) BAD_TRAP(0x4e) BAD_TRAP(0x4f)
	BAD_TRAP(0x50)
	BAD_TRAP(0x51) BAD_TRAP(0x52) BAD_TRAP(0x53) BAD_TRAP(0x54) BAD_TRAP(0x55)
	BAD_TRAP(0x56) BAD_TRAP(0x57) BAD_TRAP(0x58) BAD_TRAP(0x59) BAD_TRAP(0x5a)
	BAD_TRAP(0x5b) BAD_TRAP(0x5c) BAD_TRAP(0x5d) BAD_TRAP(0x5e) BAD_TRAP(0x5f)
	BAD_TRAP(0x60) BAD_TRAP(0x61) BAD_TRAP(0x62) BAD_TRAP(0x63) BAD_TRAP(0x64)
	BAD_TRAP(0x65) BAD_TRAP(0x66) BAD_TRAP(0x67) BAD_TRAP(0x68) BAD_TRAP(0x69)
	BAD_TRAP(0x6a) BAD_TRAP(0x6b) BAD_TRAP(0x6c) BAD_TRAP(0x6d) BAD_TRAP(0x6e)
	BAD_TRAP(0x6f) BAD_TRAP(0x70) BAD_TRAP(0x71) BAD_TRAP(0x72) BAD_TRAP(0x73)
	BAD_TRAP(0x74) BAD_TRAP(0x75) BAD_TRAP(0x76) BAD_TRAP(0x77) BAD_TRAP(0x78)
	BAD_TRAP(0x79) BAD_TRAP(0x7a) BAD_TRAP(0x7b) BAD_TRAP(0x7c) BAD_TRAP(0x7d)
	BAD_TRAP(0x7e) BAD_TRAP(0x7f)
	BAD_TRAP(0x80)
	BREAKPOINT_TRAP
	TRAP_ENTRY(0x82, do_hw_divzero)
	TRAP_ENTRY(0x83, do_flush_windows)
	BAD_TRAP(0x84) BAD_TRAP(0x85)
	BAD_TRAP(0x86) BAD_TRAP(0x87) BAD_TRAP(0x88)
	BAD_TRAP(0x89) BAD_TRAP(0x8a) BAD_TRAP(0x8b) BAD_TRAP(0x8c)
	BAD_TRAP(0x8d) BAD_TRAP(0x8e) BAD_TRAP(0x8f)
	LINUX_SYSCALL_TRAP
	BAD_TRAP(0x91) BAD_TRAP(0x92) BAD_TRAP(0x93) BAD_TRAP(0x94)
	BAD_TRAP(0x95) BAD_TRAP(0x96) BAD_TRAP(0x97) BAD_TRAP(0x98) BAD_TRAP(0x99)
	BAD_TRAP(0x9a) BAD_TRAP(0x9b) BAD_TRAP(0x9c) BAD_TRAP(0x9d) BAD_TRAP(0x9e)
	BAD_TRAP(0x9f)
	GETCC_TRAP
	SETCC_TRAP
	GETPSR_TRAP
	BAD_TRAP(0xa3) BAD_TRAP(0xa4) BAD_TRAP(0xa5) BAD_TRAP(0xa6)
	BAD_TRAP(0xa7) BAD_TRAP(0xa8) BAD_TRAP(0xa9) BAD_TRAP(0xaa) BAD_TRAP(0xab)
	BAD_TRAP(0xac) BAD_TRAP(0xad) BAD_TRAP(0xae) BAD_TRAP(0xaf) BAD_TRAP(0xb0)
	BAD_TRAP(0xb1) BAD_TRAP(0xb2) BAD_TRAP(0xb3) BAD_TRAP(0xb4) BAD_TRAP(0xb5)
	BAD_TRAP(0xb6) BAD_TRAP(0xb7) BAD_TRAP(0xb8) BAD_TRAP(0xb9) BAD_TRAP(0xba)
	BAD_TRAP(0xbb) BAD_TRAP(0xbc) BAD_TRAP(0xbd) BAD_TRAP(0xbe) BAD_TRAP(0xbf)
	BAD_TRAP(0xc0) BAD_TRAP(0xc1) BAD_TRAP(0xc2) BAD_TRAP(0xc3) BAD_TRAP(0xc4)
	BAD_TRAP(0xc5) BAD_TRAP(0xc6) BAD_TRAP(0xc7) BAD_TRAP(0xc8) BAD_TRAP(0xc9)
	BAD_TRAP(0xca) BAD_TRAP(0xcb) BAD_TRAP(0xcc) BAD_TRAP(0xcd) BAD_TRAP(0xce)
	BAD_TRAP(0xcf) BAD_TRAP(0xd0) BAD_TRAP(0xd1) BAD_TRAP(0xd2) BAD_TRAP(0xd3)
	BAD_TRAP(0xd4) BAD_TRAP(0xd5) BAD_TRAP(0xd6) BAD_TRAP(0xd7) BAD_TRAP(0xd8)
	BAD_TRAP(0xd9) BAD_TRAP(0xda) BAD_TRAP(0xdb) BAD_TRAP(0xdc) BAD_TRAP(0xdd)
	BAD_TRAP(0xde) BAD_TRAP(0xdf) BAD_TRAP(0xe0) BAD_TRAP(0xe1) BAD_TRAP(0xe2)
	BAD_TRAP(0xe3) BAD_TRAP(0xe4) BAD_TRAP(0xe5) BAD_TRAP(0xe6) BAD_TRAP(0xe7)
	BAD_TRAP(0xe8) BAD_TRAP(0xe9) BAD_TRAP(0xea) BAD_TRAP(0xeb) BAD_TRAP(0xec)
	BAD_TRAP(0xed) BAD_TRAP(0xee) BAD_TRAP(0xef) BAD_TRAP(0xf0) BAD_TRAP(0xf1)
	BAD_TRAP(0xf2) BAD_TRAP(0xf3) BAD_TRAP(0xf4) BAD_TRAP(0xf5) BAD_TRAP(0xf6)
	BAD_TRAP(0xf7) BAD_TRAP(0xf8) BAD_TRAP(0xf9) BAD_TRAP(0xfa) BAD_TRAP(0xfb)
	BAD_TRAP(0xfc)
	KGDB_TRAP(0xfd)
	BAD_TRAP(0xfe)
	BAD_TRAP(0xff)

#endif
