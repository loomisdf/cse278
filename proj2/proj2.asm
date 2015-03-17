global	main						;name this program the main function
extern printf, scanf				;define external functions that are called

section		.data
	msg: 		db "enter the first number in binary format:",0xA,0
	msg2: 		db "enter the second number in binary format:",0xA,0
	msgCalc: 	db "Enter the calculation to perform(add,sub,mul,div):",0xA,0 
	fmtScanf: 	db "%s",0				;scanf format string
	fmtPrintf: 	db "%s",0xA,0		;printf format string
	fmtResult: 	db "%d",0xA,0		;printf format string
	fmtOutput:  db "The result for %d %c %d is:",0xA,"binary = %s",0xA,0
	bitmask: 	dw 0
	one:		db '1'
	sAdd:		db "add",0
	sSub: 		db "sub",0
	sMul: 		db "mul",0
	sDiv: 		db "div",0 

section 	.bss
	input1: 	resb 100					;declare array of 100 bytes
	input2: 	resb 100
	calculation:resb 100
	output: 	resb 33
	val1: 		resb 4
	val2: 		resb 4
	calculationResult: resb 4
	symbol: 	resb 4

section 	.text
main:
	PUSH	msg			; print: enter the first number in binary format	
	CALL	printf	
	ADD 	esp, 4		
	
	SUB		esp, 4		; store the input
	MOV 	DWORD [esp], input1		
	SUB 	esp, 4
	MOV 	DWORD [esp], fmtScanf			
	CALL 	scanf					
	ADD 	esp, 8						
	
	PUSH 	msg2		; print: enter the second number in binary format
	CALL 	printf
	ADD 	esp, 4

	SUB 	esp, 4		; store the input
	MOV 	DWORD [esp], input2		
	SUB 	esp, 4
	MOV 	DWORD [esp], fmtScanf
	CALL 	scanf
	ADD 	esp, 8

	PUSH 	msgCalc		; print: Enter calculation to perform(add,sub,mul,div): 
	CALL 	printf
	ADD 	esp, 4

	SUB 	esp, 4		; store the input
	MOV 	DWORD [esp], calculation		
	SUB 	esp, 4
	MOV 	DWORD [esp], fmtScanf
	CALL 	scanf
	ADD 	esp, 8

	MOV 	ecx, 0		; convert the first val to decimal
LP1: 
	MOV		ebx, 31
	SUB 	ebx, ecx
	PUSH 	ecx			; save ecx on the stack
	MOV 	eax, 1
	MOV 	ecx, ebx
	SHL 	eax, cl 	; eax will contain the bitmask
	POP 	ecx			; pop ecx back from the stack
	MOV 	bl, [input1 + ecx] ; get the ith postion in the bit string 
	CMP 	bl, 49
	JNE		doNotOr1
	OR 		[val1], eax

doNotOr1:	
	ADD 	ecx, 1
	CMP 	ecx, 32
	JNE		LP1

	PUSH 	dword [val1] ; print out the decimal number
	PUSH	fmtResult
	CALL 	printf
	ADD 	esp, 8

	MOV 	ecx, 0		; convert the first val to decimal
LP2: 
	MOV		ebx, 31
	SUB 	ebx, ecx
	PUSH 	ecx			; save ecx on the stack
	MOV 	eax, 1
	MOV 	ecx, ebx
	SHL 	eax, cl 	; eax will contain the bitmask
	POP 	ecx			; pop ecx back from the stack
	MOV 	bl, [input2 + ecx] ; get the ith postion in the bit string 
	CMP 	bl, 49 		; 49 is the value of '1'
	JNE		doNotOr2
	OR 		[val2], eax

doNotOr2:	
	ADD 	ecx, 1
	CMP 	ecx, 32
	JNE		LP2

	PUSH 	dword [val2]
	PUSH 	fmtResult
	CALL 	printf
	ADD 	esp, 8

compareAdd:
	MOV 	eax, [calculation]
	MOV 	ebx, [sAdd]
	CMP 	eax, ebx
	JNE 	compareSub
	MOV 	eax, [val1]
	MOV 	ebx, [val2]
	ADD 	eax, ebx
	MOV 	[calculationResult], eax
	MOV 	dword [symbol], 43
	JMP 	stopCompare

compareSub:
	MOV 	eax, [calculation]
	MOV 	ebx, [sSub]
	CMP 	eax, ebx
	JNE 	compareMul
	MOV 	eax, [val1]
	MOV 	ebx, [val2]
	SUB 	eax, ebx
	MOV 	[calculationResult], eax
	MOV 	dword [symbol], 45
	JMP 	stopCompare

compareMul:
	MOV 	eax, [calculation]
	MOV 	ebx, [sMul]
	CMP 	eax, ebx
	JNE 	compareDiv
	MOV 	eax, [val1]
	MOV 	ebx, [val2]
	MUL 	ebx
	MOV 	[calculationResult], eax
	MOV 	dword [symbol], 42
	JMP 	stopCompare

compareDiv:	
	MOV 	eax, [val1]
	MOV 	ebx, [val2]
	DIV 	ebx
	MOV 	[calculationResult], eax
	MOV 	dword [symbol], 47
	JMP 	stopCompare

stopCompare:
	MOV 	ecx, 0
LP3:	
	MOV 	eax, [calculationResult]
	MOV 	ebx, 31	
	SUB 	ebx, ecx
	BT 		eax, ebx
	JC 		found1
	JMP 	found0
found1:
	MOV 	ebx, 49
	JMP 	incLoop		
found0:
	MOV 	ebx, 48
	JMP		incLoop
incLoop:
	MOV 	[output + ecx], bl
	add 	ecx, 1
	cmp 	ecx, 32
	JNE 	LP3
	
	PUSH 	output
	PUSH 	dword [val2]
	PUSH 	dword [symbol]	
	PUSH 	dword [val1] 
	PUSH 	fmtOutput
	CALL 	printf
	ADD 	esp, 20
	ret								;end program
