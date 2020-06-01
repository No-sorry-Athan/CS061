;=================================================
; Name: Athan	Chu
; Email: achu046
; 
; Lab: lab 5, ex 2
; Lab section: 24 
; TA: David Feng
; 
;=================================================
.orig x3000
lea r0, introPrompt
puts


ld r6, ptr_3200
jsrr r6

ld r3, dec_one
ld r1, remoteDataPtr2_ori
ld r4 ,routine
jsrr r4

HALT

;local
introPrompt .stringz "Enter a 16 digit number starting with b\n"
dec_one .fill #1
ptr_3200 .fill x3200
remoteDataPtr2_ori .fill x4010
routine .fill x4200

;sub routi1nea : SUB_INPUT_CALCULATE_BINARY_3200
;input (r0?) : reads from getc to input binary
;postcondition: subroutine calculates decimal value of the binary entered, and stores it in R2
;Return value (R2): the decimal value equivalent to the entered binary

.orig x3200
ST r7, backup_r7_x3200

ld r5, remoteDataPtr
ld r2, dec_0_x3200
ld r3, dec_16_x3200

GETC
out

input_loop
	GETC
	out
	STR r0, r5, #0
	ADD r5, r5, #1
	ADD R3, R3, #-1
	Brp input_loop


ld r3, dec_16_x3200
ld r6, remoteDataPtr

calculate_math
	LDR R0, r6, #0
	ADD r6, r6, #1
	LD R4, ascii_1_x3200
	NOT R5, R0 ;twos complement num: 48 -> -49, 49 -> -50
	ADD R5, R5, #1; add one; -49 -> -48, -50 -> -49
	ADD R5, R5, R4; add 48; -48 -> 1; -49 -> 0
	BRz add_ttl ;jumps to adding loop while calculate how many times number should be multiplied to rep correct place  value
	ADD R3, R3, #-1
	BRp calculate_math
	
	BRnz end
	
add_ttl
	LD R1, dec_1_x3200
	ADD R4, R3, #-1
	BRnz add_one
	add_loop ;keep multiplying by two until u reach proper value
		ADD R1, R1, R1
		ADD R4, R4, #-1
		BRp add_loop
	add r2, r2, r1 ;store into r2 my guy
	add r3, r3, #-1
	brp calculate_math
	

end
ld r7, backup_r7_x3200

add_one 
ADD R2, R2, #1
STI R2, remoteDataPtr2
ld r0, newlae
out

ld r7, backup_r7_x3200

ret




;sub routine data
ascii_1_x3200	.fill #49
dec_16_x3200 .fill #16
dec_0_x3200 .fill #0
dec_1_x3200 .fill #1
backup_r7_x3200 .blkw #1
newlae .stringz "\n"

remoteDataPtr .fill x4000
remoteDataPtr2 .fill x4010
;subroutine : SUB_OUTPUT_DEC_IN_BINARY_3200
;input (R1) : pointer to array with values that are desired to be printed in binary
;postcondition : prints values of the array in binary with a b in front of them
;return value: none? just prints?


.orig x4200
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
dec_10_x3200 .fill #1
backup_r7 .blkw #1 
backup_r1 .blkw #1 
backup_r3 .blkw #1 


.orig x4000
array .BLKW #16
val2 .BLKW #1


.end
