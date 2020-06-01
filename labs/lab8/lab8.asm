;=================================================
; Name: Athan Chu
; Email: achu046@ucr.edu
; 
; Lab: lab 8, ex 1 & 2
; Lab section: 24
; TA: David Feng
; 
;=================================================

; test harness
					.orig x3000
				 
					ld r0, sub_print_opcode_table
					jsrr r0
					
					ld r0, sub_find_opcode
					jsrr r0
				
					halt
;-----------------------------------------------------------------------------------------------
; test harness local data:

sub_print_opcode_table .fill x3200
sub_print_opcode .fill x3400
sub_find_opcode .fill x3600
sub_get_string .fill x3800


;===============================================================================================


; subroutines:
;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODE_TABLE
; Parameters: None
; Postcondition: The subroutine has printed out a list of every LC3 instruction
;				 and corresponding opcode in the following format:
;					ADD = 0001
;					AND = 0101
;					BR = 0000
;					…
; Return Value: None
;-----------------------------------------------------------------------------------------------
					.orig x3200
					st r7, backup_r7_x3200
					ld r2, opcodes_po_ptr
					ld r1, instructions_po_ptr
					ld r3, dec_16_x3200
					printing_loop
						br word_loop
						ere0
						
						br find_next_word
						ere
						
						and r0, r0, #0
						lea r0, inbetween
						puts
						
						ld r5, sub_print_opop
						jsrr r5
						
						back_to_loop
						
						ld r0, newline_x3200
						out
						add r1, r1, #1
						add r2, r2, #1
						add r3, r3, #-1
						brp printing_loop
						
					ld r7, backup_r7_x3200
					and r0, r0, x0
					and r1, r1, x0
					and r2, r2, x0
					and r3, r3, x0
					ret			   
					find_next_word
						;add r1, r1, #1
						ldr r0, r1, #0
						add r0, r0, #0
						brnp find_next_word
						
					
					br ere
					
					word_loop
						and r0, r0, x0
						ldr r0, r1, #0
						out
						add r1, r1, #1
						ldr r0, r1, #0
						add r0 ,r0, #0
						brz ere0
						br word_loop
						
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODE_TABLE local data
opcodes_po_ptr		.fill x4000				; local pointer to remote table of opcodes
instructions_po_ptr	.fill x4100				; local pointer to remote table of instructions
sub_print_opop 		.fill x3400
newline_x3200			.fill #10
dec_16_x3200 			.fill #16

inbetween 				.stringz " = "

backup_r7_x3200 		.blkw #1



;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODE
; Parameters: R2 containing a 4-bit op-code in the 4 LSBs of the register
; Postcondition: The subroutine has printed out just the 4 bits as 4 ascii 1s and 0s
;				 The output is NOT newline terminated.
; Return Value: None
;-----------------------------------------------------------------------------------------------
					.orig x3400
					st r7, backup_r7_x3400
					
					and r5, r5, #0
					ldr r5, r2, #0
					ld r6, first_12_x3400
					
					first_12
						add r5, r5, r5
						add r6, r6, #-1
						brp first_12
					
					
					ld r6, dec_4_x3400
					return_here
					
					add r5, r5, #0
					brzp print_zero
					add r5, r5, #0
					brn print_one
					
					print_zero
						ld r0, ascii_zero_3400
						out
						add r5, r5, r5
						add r6, r6, #-1
						brp return_here
						
					add r6, r6, #0
					brz end_of_print
					print_one
						ld r0, ascii_one_3400
						out
						add r5, r5, r5
						add r6, r6, #-1
						brp return_here
				 
					end_of_print
				 
				 
					ld r7, backup_r7_x3400
					ret
;-----------------------------------------------------------------------------------------------
; SUB_PRINT_OPCODE local data
backup_r7_x3400 		.blkw #1
ascii_zero_3400		.fill #48
ascii_one_3400 		.fill #49
dec_4_x3400			.fill #4
first_12_x3400		.fill #12


;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_FIND_OPCODE
; Parameters: None
; Postcondition: The subroutine has invoked the SUB_GET_STRING subroutine and stored a string
; 				as local data; it has searched the AL instruction list for that string, and reported
;				either the instruction/opcode pair, OR "Invalid instruction"
; Return Value: None
;-----------------------------------------------------------------------------------------------
					.orig x3600
					rerun
				 st r7, backup_r7_x3600
				 
				 ld r0, sub_get_strstr
				 jsrr r0
				 
				 ld r5, hard_cap_16
				 and r6, r6,x0
				 add r6, r2, #0
				 
				 ld r1, instructions_fo_ptr
				 ld r3, opcodes_fo_ptr
				 
				 look_for_instructions
						br check_word
						
						end_of_word
						add r1, r1, #1
					and r2, r2, x0
					add r2, r6, #0
						add r3, r3, #1
						add r5, r5, #-1
						brp look_for_instructions
				 
				 
				 lea r0, error_msg
				 puts
				 
				 endoftheend
				 ld r7, backup_r7_x3600
				 ret
				 
				 check_word
					ldr r0, r1, #0
					not r0, r0
					add r0, r0, #1
					ldr r4, r2, #0
					add r0, r0, r4
					brz possible_match
				 
					
					br non_match
					brz end_of_word
					br check_word
					
				possible_match
					add r1, r1, #1
					add r2, r2, #1
					
					
					ldr r4, r2, #0
					add r4, r4, #0
					brz possible_end
					ldr r0, r1, #0
					not r0, r0
					add r0, r0, #1
					
					add r0, r0, r4
					brz possible_match
					br non_match
					
					
				possible_end
					ldr r0, r1, #0
					add r0, r0, #0
					brz definite_end
					br non_match
				
				definite_end
					and r0, r0, #0
					add r0, r6, #0
					puts
					
					lea r0, equals_part
					puts
					
					and r2, r2, x0
					add r2, r3, #0
					
					ld r0, print_opop
					jsrr r0
					
					ld r0, newestOfLines
					out
					
				br endoftheend
				
				non_match
					and r2, r2, x0
					add r2, r6, #0
					inner_loop
					add r1, r1, #1
					ldr r0, r1, #0
					add r0, r0, #0
					brnp inner_loop
					add r0, r0, #0
					brz end_of_word
					
					
				br endoftheend
				
					
;-----------------------------------------------------------------------------------------------
; SUB_FIND_OPCODE local data
backup_r7_x3600			.blkw #1
newestOfLines			.fill #10
hard_cap_16				.fill #16
opcodes_fo_ptr			.fill x4000
instructions_fo_ptr		.fill x4100
sub_get_strstr 			.fill x3800
print_opop				.fill x3400
equals_part				.stringz " = "
error_msg				.stringz "Invalid instruction\n"

;===============================================================================================


;-----------------------------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameters: R2 - the address to which the null-terminated string will be stored.
; Postcondition: The subroutine has prompted the user to enter a short string, terminated 
; 				by [ENTER]. That string has been stored as a null-terminated character array 
; 				at the address in R2
; Return Value: None (the address in R2 does not need to be preserved)
;-----------------------------------------------------------------------------------------------
					.orig x3800
					st r7, backup_r7_x3800
					ld r2, array_letters_ptr
					
					clear_array
						and r0, r0, x0
						str r0, r2, #0
						add r2, r2, #1
						ldr r0, r2, #0
						add r0, r0, #0
						brnp clear_array
					
					ld r4, mask
					ld r2, array_letters_ptr
					input_loop
						getc
						out
						and r3, r3, x0
						add r3, r0, #0
						add r3, r3, #-10
						brz terminated
						and r0, r0, r4
						str r0, r2, #0
						add r2, r2, #1
						br input_loop

					terminated
					ld r2, array_letters_ptr
					ld r7, backup_r7_x3800
					ret
;-----------------------------------------------------------------------------------------------
; SUB_GET_STRING local data

backup_r7_x3800 	.blkw #1
array_letters_ptr .fill x6000

mask 				.fill x005f



;===============================================================================================


;-----------------------------------------------------------------------------------------------
; REMOTE DATA
					.ORIG x4000			; list opcodes as numbers from #0 through #15, e.g. .fill #12 or .fill xC
; opcodes
	BR_VAL	.fill #0
	ADD_VAL .fill #1
	LD_VAL 	.fill #2
	ST_VAL	.fill #3
	JSR_VAL .fill #4
	AND_VAL .fill #5
	JSRR_VAL .fill #4
	LDR_VAL .fill #6
	STR_VAL .fill #7
	NOT_VAL .fill #9
	LDI_VAL .fill #10
	STI_VAL .fill #11
	RET_VAL .fill #12
	JMP_VAL .fill #10
	LEA_VAL .fill #14
	TRAP_VAL .fill #15
		
					.ORIG x4100			; list AL instructions as null-terminated character strings, e.g. .stringz "JMP"
								 		; - be sure to follow same order in opcode & instruction arrays!
								 		
	PRINT_BR	.STRINGZ	"BR"
	PRINT_ADD	.STRINGZ	"ADD"
	PRINT_LD	.STRINGZ	"LD"
	PRINT_ST	.STRINGZ        "ST"
	PRINT_JSR	.STRINGZ        "JSR"
	PRINT_AND	.STRINGZ        "AND"
	PRINT_JSRR	.STRINGZ        "JSRR"
	PRINT_LDR	.STRINGZ        "LDR"
	PRINT_STR	.STRINGZ        "STR"
	PRINT_NOT	.STRINGZ        "NOT"
	PRINT_LDI	.STRINGZ        "LDI"
	PRINT_STI	.STRINGZ        "STI"
	PRINT_RET	.STRINGZ        "RET"
	PRINT_JMP	.STRINGZ        "JMP"
	PRINT_LEA	.STRINGZ        "LEA"
	PRINT_TRAP	.STRINGZ        "TRAP"

; instructions	

.orig x6000
array_letters		.blkw #100
;===============================================================================================
