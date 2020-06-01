;=================================================
; Name: Athan Chu
; Email: achu046
; 
; Lab: lab 3, ex 4
; Lab section: 24
; TA: David Feng
; 
;=================================================
.ORIG x3000
;INSTRUCTIONS
LEA R0, beginning
PUTS

LD R3, ARR_PTR
LD R4, why

DO_WHILE_LOOP
	GETC
	OUT
	STR R0, R3, #0
	ADD R3, R3, #1
	NOT R0, R0 ;not 10 == -11
	ADD R0, R0, R4 ;r4 == 11
	BRnp DO_WHILE_LOOP

LD R3, ARR_PTR
PRINT_LOOP
	LDR R0, R3, #0
	ADD R0, R0, #0
	BRz leave_loop
	OUT
	
	ADD R3, R3, #1
	
	
	
	BR PRINT_LOOP
	
	
leave_loop
LEA R0, ending
PUTS
LD R0, newline
OUT
	
HALT
;DATA
beginning .STRINGZ "Please enter characters: \n" 
ending .STRINGZ "End of Program"
ARR_PTR .FILL x4000
newline .STRINGZ "\n"
why .FILL #11

;REMOTE DATA
.ORIG x4000
ARR .BLKW #100

.END
