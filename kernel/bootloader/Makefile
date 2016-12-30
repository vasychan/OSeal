CC=g++
CPPFLAGS=-c -fpermissive
LDFLAGS=-m32 -L/usr/lib32
KERNEL_C_FLAGS=-ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti

#all:  boot_asm.o boot_main.o
#	${CC} ${LDFLAGS} -lc -T linker.ld -o oseal.bin -ffreestanding -O2 -nostdlib boot_asm.o boot_main.o -lgcc
boot_main.o: boot_main.cpp vesa.cpp
	${CC} ${CPPFLAGS} ${KERNEL_C_FLAGS} ${LDFLAGS} boot_main.cpp vesa.cpp
	nasm -f elf boot.asm -o boot_asm.o 

clean:
	rm -f *.o bootloader oseal.bin
