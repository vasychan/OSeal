;bits 16
;resb 0x7C00
;global load_pm
load_pm:
    xor ax, ax
    mov ds, ax
    cli
    lgdt [gdtr]

    ; fucking a20, i forgotten it    
    in al, 0x93         

    or al, 2 
    and al, ~1          
    out 0x92, al

    mov eax, cr0
    or al, 1
    mov cr0, eax
    ret 


;*********************************
;* Global Descriptor Table (GDT) *
;* initialized here              *
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
CODE_SEG equ  CODE_DESC - NULL_DESC
DATA_SEG equ  DATA_DESC- NULL_DESC
