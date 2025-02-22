// SPDX-License-Identifier: GPL-2.0-only
/*
 * Old U-boot compatibility for Sam440ep based off bamboo.c code
 * original copyrights below
 *
 * Author: Josh Boyer <jwboyer@linaos.vnet.ibm.com>
 *
 * Copyright 2007 IBM Corporation
 *
 * Based on cuboot-ebony.c
 *
 * Modified from cuboot-bamboo.c for sam440ep:
 * Copyright 2008 Giuseppe Coviello <gicoviello@gmail.com>
 */

#include "ops.h"
#include "stdio.h"
#include "44x.h"
#include "4xx.h"
#include "cuboot.h"

#define TARGET_4xx
#define TARGET_44x
#include "ppcboot.h"

static bd_t bd;

static void sam440ep_fixups(void)
{
       unsigned long sysclk = 66666666;

       ibm440ep_fixup_clocks(sysclk, 11059200, 25000000);
       ibm4xx_sdram_fixup_memsize();
       ibm4xx_quiesce_eth((u32 *)0xef600e00, (u32 *)0xef600f00);
       dt_fixup_mac_addresses(&bd.bi_enetaddr, &bd.bi_enet1addr);
}

void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
		unsigned long r6, unsigned long r7)
{
	CUBOOT_INIT();
	platform_ops.fixups = sam440ep_fixups;
	platform_ops.exit = ibm44x_dbcr_reset;
	fdt_init(_dtb_start);
	serial_console_init();
}
