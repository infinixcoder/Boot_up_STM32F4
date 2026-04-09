/* 1. Define FLASH and RAM regions */
MEMORY
{
  FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 512K
  RAM (rwx)  : ORIGIN = 0x20000000, LENGTH = 128K
}

/* Define the estack symbol (Top of RAM) */
_estack = ORIGIN(RAM) + LENGTH(RAM);

SECTIONS
{
  /* 2. Define .isr_vector section */
  .isr_vector :
  {
    . = ALIGN(4);
    KEEP(*(.isr_vector))  /* Keep the vector table at the very start of Flash */
    . = ALIGN(4);
  } > FLASH

  /* 3 & 4. Define .text and .rodata sections */
  .text :
  {
    . = ALIGN(4);
    *(.text*)             /* Program code */
    *(.rodata*)           /* Read-only data (constants) */
    . = ALIGN(4);
    
    /* Define the sidata symbol (End of Flash data, start of .data load address) */
    _sidata = .; 
  } > FLASH

  /* 5. Define .data section */
  .data : AT(_sidata) 
  {
    . = ALIGN(4);
    /* Define the sdata symbol (Start of RAM destination) */
    _sdata = .;        
    
    *(.data*)             /* Initialized variables */
    
    . = ALIGN(4);
    /* Define the edata symbol (End of RAM destination) */
    _edata = .;        
  } > RAM

  /* 6. Define .bss section */
  .bss :
  {
    . = ALIGN(4);
    /* Define the sbss symbol (Start of zero-filled RAM) */
    _sbss = .;
    
    *(.bss*)              /* Uninitialized variables */
    *(COMMON)
    
    . = ALIGN(4);
    /* Define the ebss symbol (End of zero-filled RAM) */
    _ebss = .;
  } > RAM
}