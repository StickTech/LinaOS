/* SPDX-License-Identifier: GPL-2.0 */
OUTPUT_ARCH(powerpc:common)
ENTRY(_zimage_start_opd)
EXTERN(_zimage_start_opd)
SECTIONS
{
  .text      :
  {
    _start = .;
    *(.text)
    *(.fixup)
    _etext = .;
  }
  . = ALIGN(4096);
  .data    :
  {
    *(.rodata*)
    *(.data*)
    *(__builtin_*)
    *(.sdata*)
    *(.got2)

    _dtb_start = .;
    *(.kernel:dtb)
    _dtb_end = .;

    _vmlinaos_start =  .;
    *(.kernel:vmlinaos.strip)
    _vmlinaos_end =  .;

    _initrd_start =  .;
    *(.kernel:initrd)
    _initrd_end =  .;
  }

  . = ALIGN(4096);
  _edata  =  .;
  __bss_start = .;
  .bss       :
  {
   *(.sbss)
   *(.bss)
  }
  _end = . ;

  /DISCARD/ :
  {
    *(.comment)
  }
}
