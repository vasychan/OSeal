section .data
    msg: db 'bbhello world'
    msglen equ $-msg

section .text
    global _start 
    _start:
       mov  ah,0x01         
          mov  ch,0x00         
             mov  cl,0x13         
                int   0x11            ;Вызвать BIOS 
    ; mov ecx, 0
    ;loop:
       ; movzx ax, byte [msg+ecx]
        ;mov [0xB8002+ecx], cl  
        inc ecx 
        ;mov al, 2Bh 
        ;mov [0xB8002+ecx], al
        inc ecx 
        ;cmp ecx, msglen*2
    ;jne loop

        ;extern hello
        ;call hello 
    ret
