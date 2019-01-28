model tiny
    .code
    org 100h
    locals
_start:
mov     ax, 3
int     10h

mov     ah, 09h     ;func number
mov     al, 97      ;symbol ASCII code
mov     bh, 0       ;display page
mov     bl, 35h     ;attributes
mov     cx, 10      ;symbols count

int     10h

xor     ax, ax
int     16h

ret

end _start