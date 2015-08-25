MBALIGN     equ  1<<0                   ; align loaded modules on page boundaries
MEMINFO     equ  1<<1                   ; provide memory map
FLAGS       equ  MBALIGN | MEMINFO      ; this is the Multiboot 'flag' field
MAGIC       equ  0x1BADB002             ; 'magic number' lets bootloader find the header
CHECKSUM    equ -(MAGIC + FLAGS)        ; checksum of above, to prove we are multiboot
 
section .multiboot
align 0x4
    dd MAGIC
    dd FLAGS
    dd CHECKSUM
 
section .bootstrap_stack
    align 0x4
    stack_bottom:
        times 16384 db 0
    stack_top:


;_create_gdt:
;   mov eax, [esp+4]  ; Get the pointer to the GDT, passed as a parameter.
;   lgdt [eax]        ; Load the new GDT pointer
;   mov ax, 0x10      ; 0x10 is the offset in the GDT to our data segment
;   mov ds, ax        ; Load all data segment selectors
;   mov es, ax
;   mov fs, ax
;   mov gs, ax
;   mov ss, ax
;   jmp 0x08:.flush   ; 0x08 is the offset to our code segment: Far jump!
;.flush:
;   ret

section .data
    hello_msg: db 'Hello0'
    hello_msg_lengh equ $-hello_msg

section .text

%macro test_print_int 1
    mov ah, 09h
    mov al, 'H'
    int 10h
%endmacro

%macro print_msg 2
       mov ecx, 1 
       mov cl,1 
       mov ebx, 0xB8000
       %%loop:
           movzx ax, byte[%1+ecx]
           mov [ebx+ecx], ax
           mov ax, 2Bh
           mov [(ebx+1)+ecx], ax
           inc ecx
           cmp ecx, %2 
       jne %%loop

%endmacro

bits 16
resb 0x7C00
global _start
_start:
    mov esp, stack_top

    ;mov ss, ax
    ;push ds

    cli
    xor ax, ax
    mov ds, ax
    lgdt [gdt_descriptor]

    ; enable protected mode
    ;mov eax, cr0
    ;or al, 1
    ;mov cr0, eax
    
    ;----------------------------------- 
    ;----------------------------------- 
    ;----------------------------------- 
    ;---- WHOO, we in 32b mode now -----
    ;----------------------------------- 
    ;----------------------------------- 
    ;-----------------------------------

   
    ;jmp dword CODE_SEG:clear_pipe

   
   
    ;print_msg hello_msg,hello_msg_lengh
    ;print_msg '1333',4
   
    ;mov ds, ax
    ;mov ss, ax
 

;    push ds
;    lgdt [gdtinfo]

;    cli
;    mov eax, cr0
;    or al, 1
;    mov cr0, eax
    
    ; // far jump
;    jmp 08h:clear_pipe

    ; print W in top left corner of screen
    ;xor ax, ax
    ;mov ax, testmsg

    ;mov 0B8000, testmsg
    ;mov 0B8001, 1Bh 

    ; far, far infinity  loop
;    jmp $
;    ret 

;-----------------------------------------------------------
;---------------------- 32 BIT SEGMENT ---------------------
;-----------------------------------------------------------
[bits 32]
clear_pipe:
    mov ax, DATA_SEG
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    ; Stack
    mov ebp, 0x90000
    mov esp, ebp
    cli
    hlt
    jmp $




;gdtinfo:
;   dw gdt_end - gdt - 1   ;last byte in table
;   dd gdt         ;start of table
 
;gdt        dd 0,0  ; entry 0 is always unused
;flatdesc    db 0xff, 0xff, 0, 0, 0, 10010010b, 11001111b, 0
;gdt_end:


; Descriptor CONFIG
gdt_start:
gdt_null: ; Initialization null
    dd 0x0
    dd 0x0
gdt_cs:
    dw 0xFFFF ; Limit
    dw 0x0000 ; Base
    db 0x0000   ; Base 23:16
    db 10011011b
    db 11011111b
    db 0x0000
gdt_ds:
    dw 0xFFFF ; Limit
    dw 0x0000 ; Base
    db 0x0000   ; Base 23:16
    db 10010011b
    db 11011111b
    db 0x0000
gdt_end: ; Pour avoir la taille du GDT
gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; GDT size
    dd gdt_start
; Constants to get address of gdt
CODE_SEG equ gdt_cs - gdt_start
DATA_SEG equ gdt_ds - gdt_start

times 510-($-$$) db 0  ; fill sector w/ 0's
db 0x55          ; req'd by some BIOSes
db 0xAA


;.hang:
;    hlt
;    jmp .hang
