/* SPDX-License-Identifier: GPL-2.0 */
/*
 * Copyright (C) 2017-2018 MediaTek Inc.
 *
 * Author: Sean Wang <sean.wang@mediatek.com>
 *
 */
#ifndef __PINCTRL_MOORE_H
#define __PINCTRL_MOORE_H

#include <linaos/io.h>
#include <linaos/init.h>
#include <linaos/of.h>
#include <linaos/of_platform.h>
#include <linaos/platform_device.h>
#include <linaos/pinctrl/pinctrl.h>
#include <linaos/pinctrl/pinmux.h>
#include <linaos/pinctrl/pinconf.h>
#include <linaos/pinctrl/pinconf-generic.h>

#include "../core.h"
#include "../pinconf.h"
#include "../pinmux.h"
#include "mtk-eint.h"
#include "pinctrl-mtk-common-v2.h"

#define MTK_RANGE(_a)		{ .range = (_a), .nranges = ARRAY_SIZE(_a), }

#define MTK_PIN(_number, _name, _eint_m, _eint_n, _drv_n) {	\
		.number = _number,			\
		.name = _name,				\
		.eint = {				\
			.eint_m = _eint_m,		\
			.eint_n = _eint_n,		\
		},					\
		.drv_n = _drv_n,			\
		.funcs = NULL,				\
	}

#define PINCTRL_PIN_GROUP(name, id)			\
	{						\
		name,					\
		id##_pins,				\
		ARRAY_SIZE(id##_pins),			\
		id##_funcs,				\
	}

int mtk_moore_pinctrl_probe(struct platform_device *pdev,
			    const struct mtk_pin_soc *soc);

#endif /* __PINCTRL_MOORE_H */
