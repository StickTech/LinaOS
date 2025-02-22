/* SPDX-License-Identifier: GPL-2.0 WITH LinaOS-syscall-note */
/*
 * Generic HDLC support routines for LinaOS
 *
 * Copyright (C) 1999-2005 Krzysztof Halasa <khc@pm.waw.pl>
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of version 2 of the GNU General Public License
 * as published by the Free Software Foundation.
 */

#ifndef _UAPI__HDLC_H
#define _UAPI__HDLC_H


#define HDLC_MAX_MTU 1500	/* Ethernet 1500 bytes */
#if 0
#define HDLC_MAX_MRU (HDLC_MAX_MTU + 10 + 14 + 4) /* for ETH+VLAN over FR */
#else
#define HDLC_MAX_MRU 1600 /* as required for FR network */
#endif


#endif /* _UAPI__HDLC_H */
