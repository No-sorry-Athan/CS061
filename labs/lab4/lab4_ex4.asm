;=================================================
; Name: Athan Chu	
; Email: achu046		
; 
; Lab: lab 4, ex 4
; Lab section: 24
; TA: David Feng
; 
;=================================================
.orig x3000


LD R1, arr_ptr
LD R3, dec_10
LD R4, pow_2

do_while
	STR R4, R1, #0
	ADD R4, R4, R4
	ADD R1, R1, #1
	ADD R3, R3, #-1
	BRp do_while
	
LD R1, arr_ptr
LD R3, dec_7
looploop
	ADD R3, R3, #-1
	BRnz ill
	ADD R1,R1,#1
	BR looploop
	
ill

LDR R2, R1, #0
LD R1, arr_ptr
LD R3, dec_10
outputloop 
	LDR R0, R1, #0
	out
	ADD R1, R1, #1
	ADD R3, R3, #-1
	BRp outputloop



HALT

arr_ptr .fill x4000
dec_10 .fill #10
dec_0 .fill #0
pow_2 .fill #1
dec_7 .fill #7

.orig x4000
array .BLKW #10

.end
