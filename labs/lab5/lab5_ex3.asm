;=================================================
; Name: Athan	Chu
; Email: achu046
; 
; Lab: lab 5, ex 3
; Lab section: 24 
; TA: David Feng
; 
;=================================================
.orig x3000
lea r0, introPrompt
puts


ld r3, ptr_3200
jsrr r3

ld r3, dec_one
ld r1, remoteDataPtr2_ori
ld r4 ,routine
jsrr r4

HALT

;local
introPrompt .stringz "Enter a 16 digit number starting with b\n"
dec_one .fill #1
remoteDataPtr2_ori .fill x4010
ptr_3200 .fill x3200
routine .fill x4200


;sub routi1nea : SUB_INPUT_CALCULATE_BINARY_3200
;input (r0?) : reads from getc to input binary
;postcondition: subroutine calculates decimal value of the binary entered, and stores it in R2
;Return value (R2): the decimal value equivalent to the entered binary

.orig x3200
ST r7, backup_r7_x3200

ld r2, dec_0_x3200
ld r3, dec_16_x3200
LD R4, ascii_b

LD r6, remoteDataPtr
loop_bruh
GETC
out
NOT R2, R0
ADD R2, R2, #1
ADD R2, R2, R4
BRnp initial_error

input_loop
	GETC
	out
	BRnzp possible_error
	pass_no_error
	STR r0, r6, #0
	add r6, r6, #1
	add r3, r3, #-1
	brp input_loop
	
	
LD r6, remoteDataPtr
ld r3, dec_16_x3200
doing_math_loop
	LDR r0, r6, #0
	add r6, r6, #1
	LD R4, ascii_1_x3200
	NOT R5, R0 ;twos complement num: 48 -> -49, 49 -> -50
	ADD R5, R5, #1; add one; -49 -> -48, -50 -> -49
	ADD R5, R5, R4; add 48; -48 -> 1; -49 -> 0
	BRz add_ttl ;jumps to adding loop while calculate how many times number should be multiplied to rep correct place  value
	ADD R3, R3, #-1
	BRp doing_math_loop
	
	BRnz end
and r4, r4, x0
add_ttl
	LD R1, dec_1_x3200
	ADD R4, R3, #-1
	BRnz add_one ;hits this at the end, when r4 is filled with 0
	add_loop ;keep multiplying by two until u reach proper value
		ADD R1, R1, R1
		ADD R4, R4, #-1
		BRp add_loop
	add r2, r2, r1 ;store into r2 my guy
	add r3, r3, #-1
	brp doing_math_loop
	

end
ld r7, backup_r7_x3200
brnzp ehere

add_one 
ADD R2, R2, #1
STI r2, remoteDataPtr2
ld r7, backup_r7_x3200

ehere
ld r0, mewl
out


ld r7, backup_r7_x3200
ret

initial_error
	lea r0, error_msg
	puts
	lea r0, introPrompt_x3200
	puts
	BRnzp loop_bruh

possible_error
	AND R5, R5, x0
	ADD R5, R5, r0
	LD R4, ascii_2
	ADD R5, R5, R4
	BRzp definite_error
	
	AND R5, R5, x0
	ADD R5, r5, r0
	LD R4, dec_neg49
	ADD R5, R5, R4
	BRz pass_no_error
	
	AND R5, R5, x0
	ADD R5, r5, r0
	LD R4, dec_neg48
	ADD R5, R5, R4
	BRz pass_no_error
	
	AND R5, R5, x0
	ADD R5, r5, r0
	LD R4, dec_neg32
	ADD R5, R5, R4
	BRz print_spac
	
	BRnp definite_error

print_spac
	ADD R3, R3, #-1
	brnzp input_loop

definite_error
	lea r0, error_msg
	puts
	lea r0, inputPrompt_x3200
	puts
	BRnzp input_loop
	


;sub routine data
error_msg .stringz "\nInvalid input\n"
introPrompt_x3200 .stringz "Enter a 16 digit number starting with b\n"
inputPrompt_x3200 .stringz "Enter a 16 digit number using 1's and 0's\n"
mewl .stringz "\n"
space_x3200 .fill #32
ascii_b .FIll #98
ascii_1_x3200	.fill #49
ascii_2 .fill #-50
dec_neg48 .fill #-48
dec_neg49 .fill #-49
dec_neg32 .fill #-32
dec_16_x3200 .fill #16
dec_0_x3200 .fill #0
dec_1_x3200 .fill #1
backup_r7_x3200 .blkw #1

remoteDataPtr2 .fill x4010
remoteDataPtr .fill x4000
;subroutine : SUB_OUTPUT_DEC_IN_BINARY_3200
;input (R1) : pointer to array with values that are desired to be printed in binary
;postcondition : prints values of the array in binary with a b in front of them
;return value: none? just prints?


.orig x4200
ST R7, backup_r7
ST R1, backup_r1
ST R3, backup_r3
LDR R5, R1, #0
;ADD R5, R5, #1

ld r3, dec_10_x3200
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
	ADD R3, R3, #-1
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
dec_10_x3200 .fill #1
backup_r7 .blkw #1 
backup_r1 .blkw #1 
backup_r3 .blkw #1 


.orig x4000
array .BLKW #16
val2 .BLKW #1


.end

.end
