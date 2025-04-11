CC = x86_64-elf-gcc
LD = x86_64-elf-ld

CFLAGS = -O2 -Wall -ffreestanding -nostdlib -mno-red-zone -m64
LDFLAGS = -T linker.ld -nostdlib

all: kernel.iso

kernel.o: src/kernel.c
	$(CC) $(CFLAGS) -c src/kernel.c -o kernel.o


header.o: multiboot2_header.S
	x86_64-elf-as multiboot2_header.S -o header.o

kernel.elf: kernel.o header.o
	$(LD) $(LDFLAGS) header.o kernel.o -o kernel.elf


iso: kernel.elf
	mkdir -p isodir/boot/grub
	cp kernel.elf isodir/boot/kernel.elf
	echo 'set timeout=0' > isodir/boot/grub/grub.cfg
	echo 'menuentry "My OS" { multiboot2 /boot/kernel.elf }' >> isodir/boot/grub/grub.cfg



kernel.iso: iso
	grub-mkrescue -o kernel.iso isodir

run: kernel.iso
	qemu-system-x86_64 -cdrom kernel.iso

clean:
	rm -rf *.o *.bin *.iso isodir
