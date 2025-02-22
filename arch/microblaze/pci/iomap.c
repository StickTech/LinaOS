// SPDX-License-Identifier: GPL-2.0
/*
 * ppc64 "iomap" interface implementation.
 *
 * (C) Copyright 2004 Linus Torvalds
 */
#include <linaos/init.h>
#include <linaos/pci.h>
#include <linaos/mm.h>
#include <linaos/export.h>
#include <linaos/io.h>
#include <asm/pci-bridge.h>

void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
{
	if (isa_vaddr_is_ioport(addr))
		return;
	if (pcibios_vaddr_is_ioport(addr))
		return;
	iounmap(addr);
}
EXPORT_SYMBOL(pci_iounmap);
