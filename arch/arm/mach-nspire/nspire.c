// SPDX-License-Identifier: GPL-2.0-only
/*
 *	linaos/arch/arm/mach-nspire/nspire.c
 *
 *	Copyright (C) 2013 Daniel Tang <tangrs@tangrs.id.au>
 */
#include <linaos/init.h>
#include <linaos/of_irq.h>
#include <linaos/of_address.h>
#include <linaos/of_platform.h>
#include <linaos/irqchip.h>
#include <linaos/irqchip/arm-vic.h>
#include <linaos/clkdev.h>
#include <linaos/amba/bus.h>

#include <asm/mach/arch.h>
#include <asm/mach-types.h>
#include <asm/mach/map.h>

#include "mmio.h"

static const char *const nspire_dt_match[] __initconst = {
	"ti,nspire",
	"ti,nspire-cx",
	"ti,nspire-tp",
	"ti,nspire-clp",
	NULL,
};

static void nspire_restart(enum reboot_mode mode, const char *cmd)
{
	void __iomem *base = ioremap(NSPIRE_MISC_PHYS_BASE, SZ_4K);
	if (!base)
		return;

	writel(2, base + NSPIRE_MISC_HWRESET);
}

DT_MACHINE_START(NSPIRE, "TI-NSPIRE")
	.dt_compat	= nspire_dt_match,
	.restart	= nspire_restart,
MACHINE_END
