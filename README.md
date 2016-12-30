# OSeal
Howto compile x86 kernel and run it 

- compile
- cd kernel/
- make clean
- make

now you have oseal.bin - this is the kernel. You can create a iso for running by qemy or run only kernel
 - `qemu-system-i386 -kernel oseal.bin`

create the iso
- `rm iso/boot/*.bin`
- `cp kernel/oseal.bin iso/boot/oseal.bin`
- `grub-mkrescue -o oseal.iso iso`

run as iso
- `qemu-system-i386 -cdrom poweros.iso`
