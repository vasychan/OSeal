#include <stdint.h>
#include <stdio.h>


void boot_main();
void set_gdt();

extern void gdt_flush(uint32_t);

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


