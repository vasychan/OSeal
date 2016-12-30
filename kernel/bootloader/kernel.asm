%include "print.asm"
;-----------------------------------------------------------
;---------------------- 32 BIT SEGMENT ---------------------
;-----------------------------------------------------------


bits 32 
main_kernel:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    ; Stack
    mov ebp, 0x90000
    mov esp, ebp
    
    ; ==============================
    ; MAIN FUNCTION MUST BE WRITE HERE
    ; ==============================

    call debug_info
    call vga_mode
    .hang:
        jmp .hang

bits 32
debug_info:
    ;print_msg hello_msg,hello_msg_lengh
    mov edx, START_MSG
    mov ebx, GREEN 
    mprint_msg_32 START_MSG,GREEN,0xB8500

    ; set cursor
    mov dx,0x14 
    ;mov ax, 0x14
    mov ax, 0x000e
    out 0x03D4, ax
    ;out 0x03D5, ax
    ;out 0x03D5, dx 

    ret

START_MSG db "kernel: switch to protected mode: Ok", 0

extern set_vesa_mode

bits 32
vga_mode:
    call set_vesa_mode
    ret

global add 
add:
    mov   eax, [esp+4]   ; argument 1
    add   eax, [esp+8]   ; argument 2
    ret

START_MSG2 db "kernel: call vesa mode", 0

