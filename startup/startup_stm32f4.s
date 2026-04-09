.syntax unified 
.cpu cortex-m4 
.thumb 

.extern _estack 
.extern _sidata 
.extern _sdata 
.extern _edata 
.extern _sbss 
.extern _ebss 
.extern main

.global g_pfnVectors 
.global Reset_Handler 

/* --- 1. The Vector Table --- */
.section .isr_vector,"a",%progbits 
g_pfnVectors: 
  .word _estack            /* Initial Stack Pointer */
  .word Reset_Handler      /* Reset Vector */
  .word Default_Handler    /* NMI */
  .word Default_Handler    /* Hard Fault */
  .word Default_Handler    /* MemManage */
  .word Default_Handler    /* BusFault */
  .word Default_Handler    /* UsageFault */
  .word 0 
  .word 0 
  .word 0 
  .word 0 
  .word Default_Handler    /* SVC */
  .word Default_Handler    /* DebugMon */
  .word 0 
  .word Default_Handler    /* PendSV */
  .word Default_Handler    /* SysTick */

/* --- 2. The Reset Handler --- */
.section .text.Reset_Handler,"ax",%progbits 
Reset_Handler: 
  /* copy .data */ 
  ldr r0, =_sidata 
  ldr r1, =_sdata 
  ldr r2, =_edata 
1: cmp r1, r2 
  bcc 2f 
  b 3f 
2: ldr r3, [r0], #4 
  str r3, [r1], #4 
  b 1b 
3: 
  /* zero .bss */ 
  ldr r1, =_sbss 
  ldr r2, =_ebss 
  movs r3, #0 
4: cmp r1, r2 
  bcc 5f 
  b 6f 
5: str r3, [r1], #4 
  b 4b 
6: 
  /* System ready, call main */
  bl main 
7: b 7b 

/* --- 3. The Default Handler (Trap) --- */
.section .text.Default_Handler,"ax",%progbits
Default_Handler:
  b Default_Handler