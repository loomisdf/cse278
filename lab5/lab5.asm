global main
extern printf, scanf

section .data
	input:	 	dd 0
	fmtMsg:	 	db "Enter input",0xA,0
	fmtPrintf:	db "result = %d",0xA,0
	fmtScanf:	db "%d",0

	section .text
main:
	push	fmtMsg
	call 	printf
	add 	esp, 4

	push 	input 
	push 	fmtScanf
	call 	scanf
	add 	esp, 8

	push 	dword [input] ;add first input to the stack 

	push 	fmtMsg 
	call 	printf
	add 	esp, 4
	
	push 	input
	push 	fmtScanf
	call 	scanf
	add 	esp, 8

	pop 	eax
	add 	eax, [input]

	push 	eax
	push 	fmtPrintf
	call 	printf
	add 	esp, 8
	
	ret
