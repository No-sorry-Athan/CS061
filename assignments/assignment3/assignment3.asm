;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Athan Chu
; Email: achu046@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 24
; TA: David Feng
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
LD R2, num_bits
LD R3, num_spaces

LD R4, num_spaces

pos_or_neg_check
	ADD R1,R1, #0
	BRn print_one
	ADD R1, R1, #0
	BRzp print_zero
end_pos_or_neg_check

print_one
	LD R0, ascii_1
	OUT
	
	ADD R1, R1, R1
	ADD R4, R4, #-1
	BRz print_space
	ADD R2, R2, #-1
	BRp pos_or_neg_check
end_print_one

print_zero
	LD R0, ascii_0
	OUT
	
	ADD R1, R1, R1
	ADD R4, R4, #-1
	BRz print_space
	ADD R2, R2, #-1
	BRp pos_or_neg_check
end_print_zero
	
print_space
	LD R4, num_spaces
	ADD R3, R3, #-1
	BRz end_print_space
	
	LD R0, space
	OUT
	
	ADD R2, R2, #-1
	BRp pos_or_neg_check
end_print_space

LD R0, newl
OUT
	
HALT
;---------------	
;Data
;---------------
Value_ptr	.FILL xB270	; The address where value to be displayed is stored
num_bits .FILL #16
num_spaces .FILL #4
ascii_0 .FILL #48
ascii_1 .FILL #49
space .STRINGZ " "
newl .STRINGZ "\n"
.ORIG xB270					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
