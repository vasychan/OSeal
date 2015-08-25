CC=g++
CPPFLAGS=-lc -fpermissive 
LDFLAGS=-m32 -L/usr/lib32
KERNEL_C_FLAGS=

all:  test_asm.o test_c.o
	ld -melf_i386 -o print test_c.o test_asm.o -lc -I/lib/ld-linux.so.2
	#${CC} ${LDFLAGS} -lc -o test  test_asm.o test_c.o 
test_c.o: test_c.cpp
	${CC} ${CPPFLAGS} ${LDFLAGS} -c test_c.cpp
test_asm.o: test.asm
	nasm -f elf test.asm -o test_asm.o 

clean:
	rm -f *.o print
