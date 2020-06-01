;=================================================
; Name: Athan Chu
; Email: achu046
; 
; Lab: lab 3, ex 3
; Lab section: 24
; TA: David Feng
; 
;=================================================
.ORIG x3000
;INSTRUCTIONS
LEA R0, beginning
PUTS

LD R1, DEC_10
LEA R3, ARR

DO_WHILE_LOOP
	GETC
	OUT
	STR R0, R3, #0
	
	ADD R3, R3, #1
	ADD R1, R1, #-1
	BRp DO_WHILE_LOOP
LD R0, newline
OUT
LD R1, DEC_10
LEA R3, ARR
INSANE_SECOND_LOOP ;insane naming conventions
	LDR R0, R3, #0
	OUT
	LD R0, newline
	OUT
	
	ADD R3, R3, #1
	ADD R1, R1, #-1
	BRp INSANE_SECOND_LOOP

LEA R0, ending
PUTS
HALT
;DATA
ARR .BLKW #10
DEC_10 .FILL #10
newline .STRINGZ "\n"
beginning .STRINGZ "Please enter characters: \n" 
ending .STRINGZ "End of Program"

.END
