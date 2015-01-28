global _start
 
section .data
        ; Align to the nearest 2 byte boundary, must be a power of two
        align 2
        ; String, which is just a collection of bytes, 0xA is newline
        str:     db 'My name is Daltin Loomis',0xA
        strLen:  equ $-str
 
section .bss
 
section .text
        _start:
 
;
;       op      dst,  src
;
                                ;
                                ; Call write(2) syscall:
                                ;       ssize_t write(int fd, const void *buf, size_t count)
                                ;
        mov     edx, strLen     ; Arg three: the length of the string
        mov     ecx, str        ; Arg two: the address of the string
        mov     ebx, 1          ; Arg one: file descriptor, in this case stdout
        mov     eax, 4          ; Syscall number, in this case the write(2) syscall: 
        int     0x80            ; Interrupt 0x80        
 
                                ;
                                ; Call exit(3) syscall
                                ;       void exit(int status)
                                ;
        mov     ebx, 0          ; Arg one: the status
        mov     eax, 1          ; Syscall number:
        int     0x80
