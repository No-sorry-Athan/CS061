;=================================================
; Name: Athan Chu	
; Email: achu046		
; 
; Lab: lab 5, ex 1
; Lab section: 24
; TA: David Feng
; 
;=================================================
;Main:
.orig x3000

;Instructions:
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
LD R3, dec_10

 
LD R2, ptr_3200
JSRR R2

HALT


;Local Data(Main):
arr_ptr .fill x4000
ptr_3200 .fill x3200
dec_10 .fill #10
dec_0 .fill #0
pow_2 .fill #1



;subroutine : SUB_OUTPUT_DEC_IN_BINARY_3200
;input (R1) : pointer to array with values that are desired to be printed in binary
;postcondition : prints values of the array in binary with a b in front of them
;return value: none? just prints?


.orig x3200
ST R7, backup_r7
ST R1, backup_r1
ST R3, backup_r3
LDR R5, R1, #0

LD R4, num_bits
LD R6, num_spaces
LD R7, num_spaces

print_b
	LD R0, char_b
	OUT
	
pos_or_neg_check
	ADD R5, R5, #0
	BRn print_one
	ADD R5, R5, #0
	BRzp print_zero

print_one
	LD R0, ascii_1
	OUT
	ADD R5, R5, R5
	ADD R7, R7, #-1
	BRz print_space
	ADD R4, R4, #-1
	BRp pos_or_neg_check
end_print_one

ADD R4, R4, #0
brz print_newl
	
print_zero
	LD R0, ascii_0
	OUT
	
	ADD R5, R5, R5
	ADD R7, R7, #-1
	BRz print_space
	ADD R4, R4, #-1
	BRp pos_or_neg_check
end_print_zero

ADD R4, R4, #0
brz print_newl

print_space
	LD R7, num_spaces
	ADD R6, R6, #-1
	BRz end_print_space
	
	LD R0, space
	PUTS
	
	ADD R4, R4, #-1
	BRp pos_or_neg_check
end_print_space

ADD R4, R4, #0
brz print_newl

print_newl
	LD R0, newl
	OUT
	
	ADD R1, R1, #1
	LDR R5, R1, #0
	LD R4, num_bits
	LD R6, num_spaces
	LD R7, num_spaces
	LD R3, backup_r3
	ADD R3, R3, #-1
	ST R3, backup_r3
	ADD R3, R3, #0
	BRp print_b
end_print_newl
	

LD r1, backup_r1
LD R3, backup_r3
LD R7, backup_r7

ret



newl .stringz "\n"
space .stringz " "
char_b .stringz "b"
ascii_0 .fill #48
ascii_1 .fill #49
num_bits .fill #16
num_spaces .fill #4
dec_10_x3200 .fill #10
backup_r7 .blkw #1 
backup_r1 .blkw #1 
backup_r3 .blkw #1 


.orig x4000
array .BLKW #10

.end
