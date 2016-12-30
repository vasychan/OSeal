bits 32


%macro print_msg_16 1
    mov ah, 09h
    mov al, 'H'
    int 10h
%endmacro

VIDEO_MEMORY equ 0xb8500
%macro mprint_msg_32 3
    pusha   
    mov ecx, %1 ; STRING
    mov ebx, %2 ; COULEUR
    mov edx, %3
    %%loop:
        mov al, [ecx]
        mov ah, bl 
        cmp al, 0
        je %%mdone
        mov [edx], ax
        add edx,2
        add ecx,1
    jmp %%loop
        %%mdone:
    popa

%endmacro


print_msg_32:
    pusha   
    mov ecx, edx ; STRING
    mov ebx, ebx ; COULEUR
    mov edx, VIDEO_MEMORY
    print_loop:
        mov al, [ecx]
        mov ah, bl 
        cmp al, 0
        je done
        mov [edx], ax
        add edx,2 
        add ecx,1
    jmp print_loop
        done:
    ;add edx, 160
    popa
ret

JAUNE equ 00001110b
BLEU equ 00001001b
GREEN equ 00001010b
CYAN equ 00001011b
RED equ 00001100b
ROSE equ 00001101b
BLANC equ 00001111b


