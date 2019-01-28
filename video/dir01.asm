model tiny
    .code
    org 100h
    locals
_start:
mov     ax, 1
int     10h

mov     ax, 0b800h
mov     es, ax          ;video buffer address
mov     di, 600         ;position on a screen

mov     ax, 97
draw_lop:
stosw
inc     ah
cmp     ah, 255
jne     draw_lop

xor     ax, ax
int     16h

ret

end _start