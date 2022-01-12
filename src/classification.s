 	.syntax unified
 	.cpu cortex-m3
 	.thumb
 	.align 2
 	.global	classification
 	.thumb_func

@ CG2028 Assignment, Sem 2, AY 2021/21
@ (c) CG2028 Teaching Team, ECE NUS, 2021

@ student 1: Name: Roycius Lim Yuanwei , Matriculation No.: A0218024R
@ student 2: Name: Renzo , Matriculation No.:

@Register map
@R0 - N, returns class
@R1 - points address
@R2 - label address
@R3 - sample address
@R4 - sample x
@R5 - sample y
@R6 - current smallest d^2
@R7 - label of current smallest d^2
@R8 - label
@R9 - x or d^2
@R10 - y

classification:
@ PUSH / save (only those) registers which are modified by your function
		PUSH {R4-R10}
@ parameter registers need not be saved.

@ write asm function body here
        @ load samples
		LDR R4,[R3]         @ 0x05934000
		LDR R5,[R3,#4]      @ 0x05935004
        @ do first iteration
		LDR R8,[R2],#4      @ 0x04928004
		LDR R9,[R1],#4      @ 0x04919004
		LDR R10,[R1],#4     @ 0x0491A004
		SUB R9,R4           @ 0x00499004
		MUL R9,R9           @ 0x00009919
		SUB R10,R5          @ 0x004AA005
		MUL R10,R10         @ 0x0000AA1A
		ADD R9,R10          @ 0x0089900A
		MOV R6,R9           @ 0x01A06009
		MOV R7,R8           @ 0x01A07008
		SUBS R0,#1          @ 0x02500001
		BLE END             @ 0xD8800034
LOOP:
		LDR R8,[R2],#4      @ 0x04928004
		LDR R9,[R1],#4      @ 0x04919004
		LDR R10,[R1],#4     @ 0x0491A004
		SUB R9,R4           @ 0x00499004
		MUL R9,R9           @ 0x00009919
		SUB R10,R5          @ 0x004AA005
		MUL R10,R10         @ 0x0000AA1A
		ADD R9,R10          @ 0x0089900A
		CMP R9,R6           @ 0x01590006
		ITT LE
		MOVLE R6,R9
		MOVLE R7,R8
		SUBS R0,#1          @ 0x02500001
		BGT LOOP            @ 0xC8000034
END:
		MOV R0,R7           @ 0x01A00007
@ POP / restore original register values. DO NOT save or restore R0. Why?
		POP {R4-R10}
@ return to C program
		BX	LR


@label: .word value

@.lcomm label num_bytes
