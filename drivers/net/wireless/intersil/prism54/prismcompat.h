/* SPDX-License-Identifier: GPL-2.0-only */
/*
 *  (C) 2004 Margit Schubert-While <margitsw@t-online.de>
 */

/*
 *	Compatibility header file to aid support of different kernel versions
 */

#ifdef PRISM54_COMPAT24
#include "prismcompat24.h"
#else	/* PRISM54_COMPAT24 */

#ifndef _PRISM_COMPAT_H
#define _PRISM_COMPAT_H

#include <linaos/device.h>
#include <linaos/firmware.h>
#include <linaos/moduleparam.h>
#include <linaos/workqueue.h>
#include <linaos/compiler.h>

#ifndef __iomem
#define __iomem
#endif

#define PRISM_FW_PDEV		&priv->pdev->dev

#endif				/* _PRISM_COMPAT_H */
#endif				/* PRISM54_COMPAT24 */
