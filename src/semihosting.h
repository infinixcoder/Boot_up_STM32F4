#ifndef SEMIHOSTING_H
#define SEMIHOSTING_H

#include <stdint.h>

// 0x04 is the official ARM semihosting command number for "SYS_WRITE0"
#define SYS_WRITE0 0x04

// 'static inline' prevents multiple-definition errors if you include
// this header in more than one .c file later on.
static inline void semihosting_print(const char *str)
{
    register uint32_t r0 __asm__("r0") = SYS_WRITE0;
    register uint32_t r1 __asm__("r1") = (uint32_t)str;

    __asm__ volatile(
        "bkpt 0xAB \n"
        :
        : "r"(r0), "r"(r1)
        : "memory");
}

#endif /* SEMIHOSTING_H */