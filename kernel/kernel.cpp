#include <stdio.h>

int main()
{

    return 0;
}


int test ()
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
    printf(a);
    return 0;
}


