	.file	"lab4.c"
	.intel_syntax noprefix
	.comm	array,40,32
	.section	.rodata
.LC0:
	.string	"The sum is %d\n"
	.text
	.globl	main
	.type	main, @function
main:
	push	ebp
	mov	ebp, esp
	and	esp, -16
	sub	esp, 32
	mov	DWORD PTR [esp+24], 0
	mov	DWORD PTR [esp+28], 1
	jmp	.L2
.L3:
	mov	eax, DWORD PTR [esp+28]
	lea	ecx, [eax-1]
	mov	edx, DWORD PTR [esp+28]
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	mov	DWORD PTR array[0+ecx*4], eax
	add	DWORD PTR [esp+28], 1
.L2:
	cmp	DWORD PTR [esp+28], 10
	jle	.L3
	mov	DWORD PTR [esp+28], 0
	jmp	.L4
.L5:
	mov	eax, DWORD PTR [esp+28]
	mov	eax, DWORD PTR array[0+eax*4]
	add	DWORD PTR [esp+24], eax
	add	DWORD PTR [esp+28], 1
.L4:
	cmp	DWORD PTR [esp+28], 9
	jle	.L5
	mov	eax, OFFSET FLAT:.LC0
	mov	edx, DWORD PTR [esp+24]
	mov	DWORD PTR [esp+4], edx
	mov	DWORD PTR [esp], eax
	call	printf
	mov	eax, 0
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3"
	.section	.note.GNU-stack,"",@progbits
