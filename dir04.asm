model tiny
    .code
    org 100h
    locals
_start:
mov     ax, 4
int     10h

mov     ax, 0b800h
mov     es, ax          ;video buffer address
mov     di, 600         ;position on a screen

mov     cx, 500
mov     ax, 0ffh
rep     stosb

xor     ax, ax
int     16h

mov     di, 2000h
add     di, 600
mov     ax, 0ffh
mov     cx, 500
rep     stosb

xor     ax, ax
int     16h

mov     di, 960h
mov     cx, 80
mov     ax, 85      ;01010101
rep     stosb

mov     cx, 80      
mov     ax, 170     ;10101010
rep     stosb

xor     ax, ax
int     16h


ret

end _start