CC=g++
DIR=`pwd`
BOOT_DIR=bootloader
TERM_DIR=wterm
LDFLAGS=-m32 -L/usr/lib32

CPPFLAGS=-c -fpermissive
KERNEL_C_FLAGS=-ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti



all:  kernel.o
	(cd ${BOOT_DIR} && ${MAKE} && cd ../)  
	${CC} ${LDFLAGS} -lc -T linker.ld -o oseal.bin -ffreestanding -O2 -nostdlib ${BOOT_DIR}/boot_asm.o ${BOOT_DIR}/boot_main.o kernel.o -lgcc 

kernel.o: kernel.cpp
	${CC} ${CPPFLAGS} ${LDFLAGS} kernel.cpp

kernel_start.o: kernel_start.asm
	nasm -f elf kernel_start.asm -o kernel_start.o

clean:
	cd ${BOOT_DIR} && ${MAKE} clean
	rm -f *.o
