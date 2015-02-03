        ;FILE "lab2.c"
        GLOBAL  year
        SECTION .data
        ALIGN 4
        GLOBAL year:object
        ;.size  year, 4
year: 
        dd      2020
        SECTION .text
        GLOBAL  calc_age
        GLOBAL calc_age:function
calc_age: 
        push    ebp
        mov     ebp,esp
        mov     eax, [year]
        sub     eax, [ebp+8]
        pop     ebp
        ret
        GLOBAL  calc_age:function (.-calc_age)
        SECTION         .rodata
        ALIGN 4
.LC0: 
        db      'Enter the year you were born: '
.LC1: 
        db      '%d'
        ALIGN 4
.LC2: 
        db      'In the year %d, you will be %d years old',10,''
        SECTION .text
        GLOBAL  main
        GLOBAL main:function
main: 
        push    ebp
        mov     ebp,esp
        and     esp,-16
        sub     esp,32
        mov     eax, .LC0
        mov     [esp],eax
        call    printf
        mov     eax, .LC1
        lea     edx, [esp+24]
        mov     [esp+4],edx
        mov     [esp],eax
        call    __isoc99_scanf
        mov     eax, [esp+24]
        mov     [esp],eax
        call    calc_age
        mov     [esp+28],eax
        mov     eax, .LC2
        mov     edx, [esp+28]
        mov     [esp+8],edx
        mov     dword [esp+4],2020
        mov     [esp],eax
        call    printf
        mov     eax,0
        leave
        ret
        GLOBAL  main:function (.-main)
        ;IDENT "GCC: (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3"
MISMATCH: "        .section        .note.GNU-stack,"",@progbits"

