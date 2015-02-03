	.file	"lab2.c"
	.globl	year
	.data
	.align 4
	.type	year, @object
	.size	year, 4
year:
	.long	2020
	.text
	.globl	calc_age
	.type	calc_age, @function

year2:
	.long 	2050
	.text
	.global calc_age2
	.type	calc_age2, @function
	
calc_age:
	pushl	%ebp
	movl	%esp, %ebp
	movl	year, %eax
	subl	8(%ebp), %eax
	popl	%ebp
	ret
	.size	calc_age, .-calc_age
	.section	.rodata
	.align 4

calc_age2:
	pushl	%ebp
	movl 	%esp, %ebp
	movl 	year2, %eax
	subl 	8(%ebp), %eax
	popl 	%ebp
	ret
	.size	calc_age2, .-calc_age2
	.section 	.rodata
	.align	4
	
.LC0:
	.string	"Enter the year you were born: "
.LC1:
	.string	"%d"
	.align 4
.LC2:
	.string	"In the year %d, you will be %d years old\n"
	.text
	.globl	main
	.type	main, @function
.LC3:
	.string "In the year %d, you will be %d years old\n"
	.text
	.global	main
	.type	main, @function
main:
	pushl	%ebp
	movl	%esp, %ebp
	andl	$-16, %esp
	subl	$32, %esp
	movl	$.LC0, %eax
	movl	%eax, (%esp)
	call	printf
	movl	$.LC1, %eax
	leal	24(%esp), %edx
	movl	%edx, 4(%esp)
	movl	%eax, (%esp)
	call	__isoc99_scanf
	;
	movl	24(%esp), %eax
	movl	%eax, (%esp)
	call	calc_age
	movl	%eax, 28(%esp)
	movl	$.LC2, %eax
	movl	28(%esp), %edx
	movl	%edx, 8(%esp)
	movl	$2020, 4(%esp)
	movl	%eax, (%esp)
	call	printf
	movl	$0, %eax
	;
	movl	24(%esp), %eax
	movl	%eax, (%esp)
	call 	calc_age2
	movl	%eax, 28(%esp)
	movl 	$.LC3,	%eax
	movl	28(%esp), %edx
	movl	%edx, 8(%esp)
	movl 	$2050, 4(%esp)
	movl 	%eax, (%esp)
	call 	printf
	movl	$0, %eax
	
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3"
	.section	.note.GNU-stack,"",@progbits
