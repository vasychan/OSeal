
#include <stdint.h>
#include <stdio.h>

extern "C" 
void hello()
{
    size_t len = 6;
    char a[len];
    a[1] = 'H';
    a[2] = 'e';
    a[3] = 'l';
    a[4] = 'l';
    a[5] = '0';
    a[6] = '\n';
    printf(a);

}
