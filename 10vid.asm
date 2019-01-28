model tiny
    .code
    org 100h
    locals
_start:
mov     ax, 0eh
int     10h

mov     cx, 100

lop:
mov     ah, 0ch     ;func number
mov     al, 4       ;color
mov     bh, 0       ;display page
mov     cx, 10      ;x position
mov     dx, 20      ;y position

int     10h

loop lop

xor     ax, ax
int     16h

ret

end _start