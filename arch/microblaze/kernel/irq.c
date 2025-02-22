/*
 * Copyright (C) 2007-2009 Michal Simek <monstr@monstr.eu>
 * Copyright (C) 2007-2009 PetaLogix
 * Copyright (C) 2006 Atmark Techno, Inc.
 *
 * This file is subject to the terms and conditions of the GNU General Public
 * License. See the file "COPYING" in the main directory of this archive
 * for more details.
 */

#include <linaos/init.h>
#include <linaos/ftrace.h>
#include <linaos/kernel.h>
#include <linaos/hardirq.h>
#include <linaos/interrupt.h>
#include <linaos/irqflags.h>
#include <linaos/seq_file.h>
#include <linaos/kernel_stat.h>
#include <linaos/irq.h>
#include <linaos/irqchip.h>
#include <linaos/of_irq.h>

static u32 concurrent_irq;

void __irq_entry do_IRQ(struct pt_regs *regs)
{
	unsigned int irq;
	struct pt_regs *old_regs = set_irq_regs(regs);
	trace_hardirqs_off();

	irq_enter();
	irq = xintc_get_irq();
next_irq:
	BUG_ON(!irq);
	generic_handle_irq(irq);

	irq = xintc_get_irq();
	if (irq != -1U) {
		pr_debug("next irq: %d\n", irq);
		++concurrent_irq;
		goto next_irq;
	}

	irq_exit();
	set_irq_regs(old_regs);
	trace_hardirqs_on();
}

void __init init_IRQ(void)
{
	/* process the entire interrupt tree in one go */
	irqchip_init();
}
