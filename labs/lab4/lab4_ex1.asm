;=================================================
; Name: Athan Chu	
; Email: achu046		
; 
; Lab: lab 4, ex 1
; Lab section: 24
; TA: David Feng
; 
;=================================================
.orig x3000


LD R1, arr_ptr
LD R3, dec_10
LD R4, dec_0
;AND R4, R4,x0

do_while
	STR R4, R1, #0
	ADD R4, R4, #1
	ADD R1, R1, #1
	ADD R3, R3, #-1
	BRp do_while
	
LD R1, arr_ptr
LD R3, dec_7
;probably could have just done this with pointer arithmetic
;so something like
;ADD R2, R1, #6
looploop
	ADD R3, R3, #-1
	BRnz ill
	ADD R1,R1,#1
	BR looploop
	
ill

LDR R2, R1, #0
HALT

arr_ptr .fill x4000
dec_10 .fill #10
dec_0 .fill #0
dec_7 .fill #7

.orig x4000
array .BLKW #10

.end
