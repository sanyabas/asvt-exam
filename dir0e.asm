model tiny
    .code
    org 100h
    locals
_start:
mov     ax, 10h
int     10h

mov     ax, 0a000h
mov     es, ax

mov     dx, 03c4h
mov     ax, 0402h
out     dx, ax

mov     di, 0
mov     ax, 0ffh

mov     cx, 2000
rep     stosb

xor     ax, ax
int     16h

ret

end _start