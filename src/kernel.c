// kernel.c
#include <stdint.h>

void kernel_main(void) {
    const char *str = "welcome to polarOS";
    uint16_t *vga = (uint16_t*)0xB8000;

    for (int i = 0; str[i] != 0; i++) {
        vga[i] = (0x0F << 8) | str[i];
    }

    while (1) {}
}
