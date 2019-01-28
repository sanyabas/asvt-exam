model tiny
    .code
    org 100h
    locals
_start:
mov     ax, 0ffh
int     10h

mov     ax, 0a000h
mov     es, ax

mov     di, 0
mov     ax, 0
lop:

mov     cx, 200
rep     stosb

inc     ax
cmp     ax, 0ffh
jne     lop

xor     ax, ax
int     16h

ret

end _start