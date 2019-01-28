model tiny
    .code
    org 100h
    locals
_start:
mov     ax, 11h
int     10h

mov     ax, 0a000h
mov     es, ax

mov     di, 0
mov     ax, 0ffh

mov     cx, 2000
rep     stosb

xor     ax, ax
int     16h

ret

end _start