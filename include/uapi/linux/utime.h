/* SPDX-License-Identifier: GPL-2.0 WITH LinaOS-syscall-note */
#ifndef _LINUX_UTIME_H
#define _LINUX_UTIME_H

#include <linaos/types.h>

struct utimbuf {
	__kernel_old_time_t actime;
	__kernel_old_time_t modtime;
};

#endif
