; MAIN FILE FOR LOAD NOW

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

section .text
%include "pm.asm"
%include "kernel.asm"
;bits 16
;resb 0x7C00
global _start
_start:
    
    call load_pm
    ;----------------------------------- 
    ;----------------------------------- 
    ;----------------------------------- 
    ;---- WHOO, we in 32b mode now -----
    ;----------------------------------- 
    ;----------------------------------- 
    ;-----------------------------------

   
    ; far, far jump in main kernel function
    jmp CODE_SEG:main_kernel
   
    jmp $


