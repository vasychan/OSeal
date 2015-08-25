extern "C++" int boot_main()
{

    //just tutorial
    int foo = 10, bar = 15;
    __asm__ __volatile__("addl  %%ebx,%%eax"
                             :"=a"(foo)
                             :"a"(foo), "b"(bar)
                            );
    return 1;
}

