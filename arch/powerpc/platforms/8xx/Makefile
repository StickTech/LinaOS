# SPDX-License-Identifier: GPL-2.0
#
# Makefile for the PowerPC 8xx linaos kernel.
#
obj-y			+= m8xx_setup.o machine_check.o pic.o
obj-$(CONFIG_CPM1)		+= cpm1.o
obj-$(CONFIG_UCODE_PATCH)	+= micropatch.o
obj-$(CONFIG_MPC885ADS)   += mpc885ads_setup.o
obj-$(CONFIG_MPC86XADS)   += mpc86xads_setup.o
obj-$(CONFIG_PPC_EP88XC)  += ep88xc.o
obj-$(CONFIG_PPC_ADDER875) += adder875.o
obj-$(CONFIG_TQM8XX)      += tqm8xx_setup.o
