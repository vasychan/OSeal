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
    
    call debug_info 
    .hang:
        jmp .hang

bits 32
debug_info:
    ;print_msg hello_msg,hello_msg_lengh
    mov edx, START_MSG
    mov ebx, GREEN 
    ;call print_msg_32
    mprint_msg_32 START_MSG,GREEN,0xB8500
    ;mprint_msg_32 START2_MSG,GREEN,0xB8160

    ; set cursor
    mov dx,0x14 
    ;mov ax, 0x14
    mov ax, 0x000e
    out 0x03D4, ax
    ;out 0x03D5, ax
    ;out 0x03D5, dx 


    ;mprint_msg_32 START2_MSG,GREEN,0xB8630
    ;mov edx, START2_MSG
    ;call print_pm2
    ret

START_MSG db "kernel: switch to protected mode: Ok", 0
START2_MSG db "kernel: ready to obey, master", 0


