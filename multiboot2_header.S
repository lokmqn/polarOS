.intel_syntax noprefix
.section .multiboot2_header
.align 8

    .long 0xE85250D6              # magic
    .long 0                       # architecture (0 = i386)
    .long multiboot_end - multiboot_header  # header length
    .long -(0xE85250D6 + 0 + (multiboot_end - multiboot_header))  # checksum

multiboot_header:
    .short 0                      # tag type (end tag)
    .short 0
    .long 8
multiboot_end:
