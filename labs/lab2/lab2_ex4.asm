;=================================================
; Name: Athan Chu	
; Email:  achu046
; 
; Lab: lab 2, ex 4
; Lab section: 24
; TA: David Feng
; 
;=================================================
.orig x3000

;INSTRUCTIONS
LD R0, HEX_61
LD R1, HEX_1A

DO_WHILE_LOOP
	TRAP x21
	ADD R0, R0, #1
	ADD R1, R1, #-1
	BRp DO_WHILE_LOOP


HALT
;LOCAL DATA
HEX_61 .FILL x61
HEX_1A .FILL x1A


.end
