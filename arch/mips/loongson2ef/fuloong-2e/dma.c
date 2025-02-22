// SPDX-License-Identifier: GPL-2.0
#include <linaos/dma-direct.h>

dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
{
	return paddr | 0x80000000;
}

phys_addr_t dma_to_phys(struct device *dev, dma_addr_t dma_addr)
{
	return dma_addr & 0x7fffffff;
}
