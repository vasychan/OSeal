
#include "gdt.h"

struct gdt_struct gdt[3];
struct gdt_ptr _gp;


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
