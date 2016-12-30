
#include <stdint.h>
#include <stdio.h>
/*
extern "C" 
void boot_kernel()
{
    //just tutorial
    //__asm__ __volatile__("mov  %eax,%esp");
    size_t len = 6;
    char a[len];
    a[1] = 'H';
    a[2] = 'e';
    a[3] = 'l';
    a[4] = 'l';
    a[5] = '0';
    a[6] = '\n';
//    printf(a);
}
*/
struct gdt_struct
{
        unsigned short limit_low;
        unsigned short base_low;
        unsigned char base_middle;
        unsigned char access;
        unsigned char granularity;
        unsigned char base_high;
}__attribute__((packed));;

struct gdt_ptr
{
    unsigned short limit;
    unsigned int base;
}__attribute__((packed));;

struct gdt_struct gdt[3];
struct gdt_ptr _gp;

extern "C"
void set_gdt()
{
    _gp.base = *((uint32_t*)&gdt);
    gdt[1].base_high = (0 >> 24) & 0xff;
    gdt[1].base_low = (0 & 0xffff);
    gdt[1].base_middle = (0 >> 16) & 0xff;
    gdt[1].limit_low = (0 & 0xffff); //ulimit
    gdt[1].granularity = (0 >> 4) & 0xffff;
    gdt[1].access = 0; //begin
    //gdt_flush((uint32_t)&_gp);

}


