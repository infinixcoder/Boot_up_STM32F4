#include "semihosting.h"

int main(void)
{
    // If this prints, your boot sequence is flawless!
    semihosting_print("\n=======================================\n");
    semihosting_print(" SUCCESS: Hello from Bare-Metal Main!\n");
    semihosting_print("=======================================\n\n");

    while (1)
    {
        // Infinite loop to keep the microcontroller running
    }

    return 0;
}