.section .multiboot2
.align 8
.long 0xE85250D6          # magic number
.long 0                  # architecture (0 = i386)
.long multiboot_header_end - multiboot_header
.long -(0xE85250D6 + 0 + (multiboot_header_end - multiboot_header))  # checksum

multiboot_header:
    # End tag
    .short 0
    .short 0
    .long 8
multiboot_header_end:
