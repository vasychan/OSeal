#include "vesa.h"
MODE_INFO mode_info;

int get_mode_info(int mode)
{
    __dpmi_regs r;
    long dosbuf;
    int c;

    /* use the conventional memory transfer buffer */
    dosbuf = __tb & 0xFFFFF;

    /* initialize the buffer to zero */
    for (c=0; c<sizeof(MODE_INFO); c++)
    _farpokeb(_dos_ds, dosbuf+c, 0);

    /* call the VESA function */
    r.x.ax = 0x4F01;
    r.x.di = dosbuf & 0xF;
    r.x.es = (dosbuf>>4) & 0xFFFF;
    r.x.cx = mode;
    __dpmi_int(0x10, &r);

    /* quit if there was an error */
    if (r.h.ah)
    return -1;

    /* copy the resulting data into our structure */
    dosmemget(dosbuf, sizeof(MODE_INFO), &mode_info);

    /* it worked! */
    return 0;
}

int find_vesa_mode(int w, int h)
{
    int mode_list[256];
    int number_of_modes;
    long mode_ptr;
    int c;

    /* check that the VESA driver exists, and get information about it */
    if (get_vesa_info() != 0)
    return 0;

    /* convert the mode list pointer from seg:offset to a linear address */
    mode_ptr = ((vesa_info.VideoModePtr & 0xFFFF0000) >> 12) + 
      (vesa_info.VideoModePtr & 0xFFFF);

    number_of_modes = 0;

    /* read the list of available modes */
    while (_farpeekw(_dos_ds, mode_ptr) != 0xFFFF) {
    mode_list[number_of_modes] = _farpeekw(_dos_ds, mode_ptr);
    number_of_modes++;
    mode_ptr += 2;
    }

    /* scan through the list of modes looking for the one that we want */
    for (c=0; c<number_of_modes; c++) {

    /* get information about this mode */
    if (get_mode_info(mode_list[c]) != 0)
    continue;

    /* check the flags field to make sure this is a color graphics mode,
    * and that it is supported by the current hardware */
    if ((mode_info.ModeAttributes & 0x19) != 0x19)
    continue;

    /* check that this mode is the right size */
    if ((mode_info.XResolution != w) || (mode_info.YResolution != h))
    continue;

    /* check that there is only one color plane */
    if (mode_info.NumberOfPlanes != 1)
    continue;

    /* check that it is a packed-pixel mode (other values are used for
    * different memory layouts, eg. 6 for a truecolor resolution) */
    if (mode_info.MemoryModel != 4)
    continue;

    /* check that this is an 8-bit (256 color) mode */
    if (mode_info.BitsPerPixel != 8)
    continue;

    /* if it passed all those checks, this must be the mode we want! */
    return mode_list[c];
    }

    /* oh dear, there was no mode matching the one we wanted! */
    return 0; 
}

extern "C"
int set_vesa_mode(int w, int h)
{
    __dpmi_regs r;
    int mode_number;

    /* find the number for this mode */
    mode_number = find_vesa_mode(w, h);
    if (!mode_number)
    return -1;

    /* call the VESA mode set function */
    r.x.ax = 0x4F02;
    r.x.bx = mode_number;
    __dpmi_int(0x10, &r);
    if (r.h.ah)
    return -1;

    /* it worked! */
    return 0;
}

extern "C"
void enable_vga_mode()
    {
    char str[] = "start enable_vga_mode";
    int i = 0;
    volatile char *video = (volatile char*)0xB8700;
    while( str[i] != 0 )
        {
        *video++ = *(str + i);  
        *video++ = 0b00001010;
        i++;
        }
    }
