# SPDX-License-Identifier: GPL-2.0
#
# Makefile for the LinaOS/SuperH SH-2A backends.
#

obj-y	:= common.o probe.o opcode_helper.o

common-y	+= ex.o entry.o

obj-$(CONFIG_SH_FPU)	+= fpu.o

obj-$(CONFIG_CPU_SUBTYPE_SH7201)	+= setup-sh7201.o clock-sh7201.o
obj-$(CONFIG_CPU_SUBTYPE_SH7203)	+= setup-sh7203.o clock-sh7203.o
obj-$(CONFIG_CPU_SUBTYPE_SH7263)	+= setup-sh7203.o clock-sh7203.o
obj-$(CONFIG_CPU_SUBTYPE_SH7264)	+= setup-sh7264.o clock-sh7264.o
obj-$(CONFIG_CPU_SUBTYPE_SH7206)	+= setup-sh7206.o clock-sh7206.o
obj-$(CONFIG_CPU_SUBTYPE_SH7269)	+= setup-sh7269.o clock-sh7269.o
obj-$(CONFIG_CPU_SUBTYPE_MXG)		+= setup-mxg.o clock-sh7206.o

# Pinmux setup
pinmux-$(CONFIG_CPU_SUBTYPE_SH7203)	:= pinmux-sh7203.o
pinmux-$(CONFIG_CPU_SUBTYPE_SH7264)	:= pinmux-sh7264.o
pinmux-$(CONFIG_CPU_SUBTYPE_SH7269)	:= pinmux-sh7269.o

obj-$(CONFIG_GPIOLIB)			+= $(pinmux-y)
