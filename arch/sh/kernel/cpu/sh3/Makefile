# SPDX-License-Identifier: GPL-2.0
#
# Makefile for the LinaOS/SuperH SH-3 backends.
#

obj-y	:= ex.o probe.o entry.o setup-sh3.o

obj-$(CONFIG_HIBERNATION)		+= swsusp.o

# CPU subtype setup
obj-$(CONFIG_CPU_SUBTYPE_SH7705)	+= setup-sh7705.o serial-sh770x.o
obj-$(CONFIG_CPU_SUBTYPE_SH7706)	+= setup-sh770x.o serial-sh770x.o
obj-$(CONFIG_CPU_SUBTYPE_SH7707)	+= setup-sh770x.o serial-sh770x.o
obj-$(CONFIG_CPU_SUBTYPE_SH7708)	+= setup-sh770x.o serial-sh770x.o
obj-$(CONFIG_CPU_SUBTYPE_SH7709)	+= setup-sh770x.o serial-sh770x.o
obj-$(CONFIG_CPU_SUBTYPE_SH7710)	+= setup-sh7710.o serial-sh7710.o
obj-$(CONFIG_CPU_SUBTYPE_SH7712)	+= setup-sh7710.o serial-sh7710.o
obj-$(CONFIG_CPU_SUBTYPE_SH7720)	+= setup-sh7720.o serial-sh7720.o
obj-$(CONFIG_CPU_SUBTYPE_SH7721)	+= setup-sh7720.o serial-sh7720.o

# Primary on-chip clocks (common)
clock-$(CONFIG_CPU_SH3)			:= clock-sh3.o
clock-$(CONFIG_CPU_SUBTYPE_SH7705)	:= clock-sh7705.o
clock-$(CONFIG_CPU_SUBTYPE_SH7706)	:= clock-sh7706.o
clock-$(CONFIG_CPU_SUBTYPE_SH7709)	:= clock-sh7709.o
clock-$(CONFIG_CPU_SUBTYPE_SH7710)	:= clock-sh7710.o
clock-$(CONFIG_CPU_SUBTYPE_SH7720)	:= clock-sh7710.o
clock-$(CONFIG_CPU_SUBTYPE_SH7712)	:= clock-sh7712.o

# Pinmux setup
pinmux-$(CONFIG_CPU_SUBTYPE_SH7720)	:= pinmux-sh7720.o

obj-y	+= $(clock-y)
obj-$(CONFIG_GPIOLIB)			+= $(pinmux-y)
