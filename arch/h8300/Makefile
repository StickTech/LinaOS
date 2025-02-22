#
# arch/h8300/Makefile
#
# This file is subject to the terms and conditions of the GNU General Public
# License.  See the file "COPYING" in the main directory of this archive
# for more details.
#
# (C) Copyright 2002-2015 Yoshinori Sato <ysato@users.sourceforge.jp>
#

KBUILD_DEFCONFIG := edosk2674_defconfig

cflags-$(CONFIG_CPU_H8300H)	:= -mh
aflags-$(CONFIG_CPU_H8300H)	:= -mh -Wa,--mach=h8300h
ldflags-$(CONFIG_CPU_H8300H)	:= -mh8300helf_linaos
cflags-$(CONFIG_CPU_H8S)	:= -ms
aflags-$(CONFIG_CPU_H8S)	:= -ms -Wa,--mach=h8300s
ldflags-$(CONFIG_CPU_H8S)	:= -mh8300self_linaos

KBUILD_CFLAGS += $(cflags-y)
KBUILD_CFLAGS += -mint32 -fno-builtin
KBUILD_CFLAGS += -D__linaos__
KBUILD_CFLAGS += -DUTS_SYSNAME=\"uClinaos\"
KBUILD_AFLAGS += $(aflags-y)
KBUILD_LDFLAGS += $(ldflags-y)

CHECKFLAGS += -msize-long

ifeq ($(CROSS_COMPILE),)
CROSS_COMPILE := $(call cc-cross-prefix, h8300-unknown-linaos- h8300-linaos-)
endif

core-y	+= arch/$(ARCH)/kernel/ arch/$(ARCH)/mm/
core-y	+= arch/$(ARCH)/boot/dts/

libs-y	+= arch/$(ARCH)/lib/

boot := arch/h8300/boot

archclean:
	$(Q)$(MAKE) $(clean)=$(boot)

vmlinaos.srec vmlinaos.bin zImage uImage.bin: vmlinaos
	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@

define archhelp
  @echo  'vmlinaos.bin  - Create raw binary'
  @echo  'vmlinaos.srec - Create srec binary'
  @echo  'zImage       - Compressed kernel image'
endef
