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

;resb 0x7C00
section .text

bits 16
global _start
_start:
    load_pm

%include "pm_set.asm"
    xor ax, ax
    mov ds, ax
    ;cli
    ;lgdt [gdtr]

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

   
    ;jmp CODE_SEG:clear_pipe

   
   
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




;gdtinfo:
;   dw gdt_end - gdt - 1   ;last byte in table
;   dd gdt         ;start of table
 
;gdt        dd 0,0  ; entry 0 is always unused
;flatdesc    db 0xff, 0xff, 0, 0, 0, 10010010b, 11001111b, 0
;gdt_end:


; Descriptor CONFIG
;gdt_start:
;gdt_null: ; Initialization null
;    dd 0x0
;    dd 0x0
;gdt_cs:
;    dw 0xFFFF ; Limit
;   dw 0x0000 ; Base
;    db 0x0000   ; Base 23:16
;    db 10011011b
;    db 11011111b
;    db 0x0000
;gdt_ds:
;    dw 0xFFFF ; Limit
;    dw 0x0000 ; Base
;    db 0x0000   ; Base 23:16
;    db 10010011b
;    db 11011111b
;    db 0x0000
;gdt_end: ; Pour avoir la taille du GDT

;gdt_descriptor:
;    dw gdt_end - gdt_start - 1 ; GDT size
;    dd gdt_start

; Constants to get address of gdt
CODE_SEG equ  CODE_DESC -gdtr 
DATA_SEG equ  DATA_DESC-gdtr 


;*********************************
;* Global Descriptor Table (GDT) *
;*********************************
NULL_DESC:
    dd 0            ; null descriptor
    dd 0

CODE_DESC:
    dw 0xFFFF       ; limit low
    dw 0            ; base low
    db 0            ; base middle
    db 10011010b    ; access
    db 11001111b    ; granularity
    db 0            ; base high

DATA_DESC:
    dw 0xFFFF       ; limit low
    dw 0            ; base low
    db 0            ; base middle
    db 10010010b    ; access
    db 11001111b    ; granularity
    db 0            ; base high

gdtr:
    Limit dw gdtr - NULL_DESC - 1 ; length of GDT
    Base dd NULL_DESC   ; base of GDT



;-----------------------------------------------------------
;---------------------- 32 BIT SEGMENT ---------------------
;-----------------------------------------------------------
bits 32 
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
    .hang:
        hlt
        jmp .hang


times 510-($-$$) db 0  ; fill sector w/ 0's
db 0x55          ; req'd by some BIOSes
db 0xAA


