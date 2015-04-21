global	main						;name this program the main function
extern printf, scanf				;define external functions that are called

section		.data
	msg: 		db "enter the first number in binary format:",0xA,0
	msg2: 		db "enter the second number in binary format:",0xA,0
	msgCalc: 	db "Enter the calculation to perform(add,sub,mul,div):",0xA,0
	fmtScanf: 	db "%s",0				;scanf format string
	fmtPrintf: 	db "%s",0xA,0		;printf format string
	fmtResult: 	db "%f",0xA,0		;printf format string
	fmtOutput:  db "The result for %f %c %f is:",0xA,"binary = %s",0xA,0
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
	val164: 	resb 8
	val2: 		resb 4
	val264: 	resb 8
	calculationResult: resb 4
	calculationResult64: resq 1
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
	JNE	doNotOr1
	OR 	[val1], eax

doNotOr1:
	ADD 	ecx, 1
	CMP 	ecx, 32
	JNE	LP1

;	FLD 	dword [val1]
;	FSTP 	qword [val164]
;	PUSH 	dword [val164 + 4]
;	PUSH 	dword [val164]
;	PUSH	fmtResult
;	CALL 	printf
;	ADD 	esp, 12

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
	JNE	doNotOr2
	OR 	[val2], eax

doNotOr2:
	ADD 	ecx, 1
	CMP 	ecx, 32
	JNE		LP2

;	FLD 	dword [val2]
;	FSTP 	qword [val264]
;	PUSH 	dword [val264 + 4]
;	PUSH 	dword [val264]
;	PUSH 	fmtResult
;	CALL 	printf
;	ADD 	esp, 12

compareAdd:
	MOV 	eax, [calculation]
	MOV 	ebx, [sAdd]
	CMP 	eax, ebx
	JNE 	compareSub
	FLD 	dword [val1]
	FADD 	dword [val2]
	FST 	dword [calculationResult]
	FSTP 	qword [calculationResult64]
	MOV 	dword [symbol], 43
	JMP 	stopCompare

compareSub:
	MOV 	eax, [calculation]
	MOV 	ebx, [sSub]
	CMP 	eax, ebx
	JNE 	compareMul
	FLD 	dword [val1]
	FSUB 	dword [val2]
	FST 	dword [calculationResult]
	FSTP 	qword [calculationResult64]
	MOV 	dword [symbol], 45
	JMP 	stopCompare

compareMul:
	MOV 	eax, [calculation]
	MOV 	ebx, [sMul]
	CMP 	eax, ebx
	JNE 	compareDiv
	FLD 	dword [val1]
	FMUL 	dword [val2]
	FST 	dword [calculationResult]
	FSTP 	qword [calculationResult64]
	MOV 	dword [symbol], 42
	JMP 	stopCompare

compareDiv:
	FLD 	dword [val1]
	FDIV 	dword [val2]
	FST 	dword [calculationResult]
	FSTP 	qword [calculationResult64]
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
	FLD 	dword [val2]
	FSTP 	qword [val264]
	PUSH 	dword [val264 + 4]
	PUSH 	dword [val264]
	PUSH 	dword [symbol]
	FLD 	dword [val1]
	FSTP 	qword [val164]
	PUSH 	dword [val164 + 4]
	PUSH 	dword [val164]
	PUSH 	fmtOutput
	CALL 	printf
	ADD 	esp, 28
	ret								;end program
