/* SPDX-License-Identifier: GPL-2.0-only */
/*
 *  linaos/arch/arm/lib/testclearbit.S
 *
 *  Copyright (C) 1995-1996 Russell King
 */
#include <linaos/linkage.h>
#include <asm/assembler.h>
#include "bitops.h"
                .text

testop	_test_and_clear_bit, bicne, strne
