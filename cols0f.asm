model tiny
    .code
    org 100h
    locals
_start:
mov     ax, 0fh
int     10h

mov     ax, 0a000h
mov     es, ax

mov     cl, 04h
mov     di, 0
lop:

mov     dx, 03c4h
mov     al, 2
mov     ah, cl
out     dx, ax

mov     ax, 0ffh

push    cx

mov     cx, 1000
rep     stosb

pop     cx
loop    lop

xor     ax, ax
int     16h

ret

end _start