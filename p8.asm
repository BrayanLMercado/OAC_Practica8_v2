%include "pc_io.inc"
section .data
    NL: db  13,10
    NL_L:    equ $-NL
    IncisoA: db "Inciso A) ",10,0
    IncisoB: db "Inciso B) ",10,0
    IncisoC: db "Inciso C) ",10,0
    IncisoD: db "Inciso D) ",10,0
    IncisoE: db "Inciso E) ",10,0
    IncisoF: db "Inciso F) ",10,0
section .bss
    cad resb 256

section .text
global _start:
    _start:mov esi,cad

    ;Inciso A
    mov edx,IncisoA
    call puts
    mov eax,0x2AEFFF43
    call printHex
    call new_line
    call printBin
    call new_line

    ;Inciso B
    mov edx,IncisoB
    call puts
    mov eax,0x2AEFFF43
    call printHex
    call new_line
    call printBin
    call new_line
    mov cl,5
    call revBit

    ;Inciso C
    mov edx,IncisoC
    call puts
    mov eax,0x2AEFFF43
    call printHex
    call new_line
    call printBin
    call new_line
    mov cl,5
    call setBit

    ;Inciso D
    mov edx,IncisoD
    call puts
    mov eax,0x2AEFFF43
    call printHex
    call new_line
    call printBin
    call new_line
    mov cl,5
    call clearBit

    ;Inciso E
    mov edx,IncisoE
    call puts
    mov eax,0x2AEFFF43
    call printHex
    call new_line
    call printBin
    call new_line
    mov cl,22
    call notBit

    ;Inciso F
    mov edx,IncisoF
    call puts
    mov eax,0x2AEFFF43
    call printHex
    call new_line
    call printBin
    call new_line
    mov cl,5
    call testBit
    ;Exit Call
    mov eax,1
    mov ebx,0
    int 0x80

printBin:
    pushad
    mov edi,eax
    mov ecx,32
    .cycle:
        xor al,al
        shl edi,1
        adc al,'0'
        call putchar
        mov byte[esi+ecx],al
        loop .cycle
    popad
    ret

revBit:
    pushad
    mov ebx,eax
    shr ebx,cl
    lahf
    and ah,0x1
    movzx eax,ah
    call printBin
    call new_line
    popad
    ret

setBit:
    pushad
    ror eax,cl
    or eax,0x1
    rol eax,cl
    call printBin
    call new_line
    popad
    ret

clearBit:
    pushad
    ror eax,cl
    and eax,0xFFFFFFFE
    rol eax,cl
    call printBin
    call new_line
    popad
    ret

notBit:
    pushad
    ror eax,cl
    xor eax,0x1
    rol eax,cl
    call printBin
    call new_line
    popad
    ret

testBit:
    pushad
    mov ebx,eax
    ror ebx,cl
    and ebx,0x1
    mov ah,bl
    rol ah,6
    sahf
    movzx eax,ah
    shr eax,6
    call printBin
    call new_line
    popad
    ret

new_line:
    pushad
    mov eax, 4
    mov ebx, 1
    mov ecx, NL
    mov edx, NL_L
    int 0x80
    popad
    ret

printHex:
    pushad
    mov edx, eax
    mov ebx, 0fh
    mov cl, 28
    .nxt: shr eax,cl
    .msk: and eax,ebx
    cmp al, 9
    jbe .menor
    add al,7
    .menor:add al,'0'
    mov byte [esi],al
    inc esi
    mov eax, edx
    cmp cl, 0
    je .print
    sub cl, 4
    cmp cl, 0
    ja .nxt
    je .msk
    .print: mov eax, 4
    mov ebx, 1
    sub esi, 8
    mov ecx, esi
    mov edx, 8
    int 80h
    popad
    ret

clearReg:
    xor eax,eax ; Limpieza De Registros
    xor ebx,ebx
    xor ecx,ecx
    xor edx,edx
    ret