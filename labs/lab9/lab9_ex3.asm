;=================================================
; Name: Athan Chu
; Email: achu046
; 
; Lab: lab 9, ex 3
; Lab section: 24
; TA: David Feng
; 
;=================================================

; test harness
										.orig x3000
				 LD r4, BASE	
				 LD r5, MAX
				 LD r6, TOS
				 			 
				 lea r0, introPrompt
				 puts
				 
				 getc
				 out
				 
				 ld r2, negAsciiZero
				 add r0, r0, r2
				 
				 ld r1, sub_stack_push_ptr
				 jsrr r1
				 
				 ld r0, newline
				 out
				 
				 lea r0, introPrompt
				 puts
				 
				 getc
				 out
				 
				 ld r2, negAsciiZero
				 add r0, r0, r2
				 
				 ld r1, sub_stack_push_ptr
				 jsrr r1
				 
				 ld r0, newline
				 out
				 
				 lea r0, operandPrompt
				 puts
				 
				 getc
				 out
				 
				 ld r0, newline
				 out
				 
				 
				 
				 ld r1, sub_stack_mult_ptr
				 jsrr r1
				 
				 

				 
				 
				 halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
introPrompt .stringz "Enter a single digit numeric character: "
operandPrompt .stringz "Enter a desired operation (only mult created currently): "
newline .fill #10
negAsciiZero .fill #-48
sub_stack_push_ptr .fill x3200
sub_stack_pop_ptr .fill x3400
sub_stack_mult_ptr .fill x3600
BASE .fill xA000
TOS .fill xA000
MAX .fill xA005

loop_5 .fill #5



;===============================================================================================


; subroutines:

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH
; Parameter (R0): The value to push onto the stack
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R0) onto the stack (i.e to address TOS+1). 
;		    If the stack was already full (TOS = MAX), the subroutine has printed an
;		    overflow error message and terminated.
; Return Value: R6 ← updated TOS
;------------------------------------------------------------------------------------------
					.orig x3200
				 st r7, backup_r7_x3200
				and r3, r3, x0
				add r3, r3, r6
				not r3, r3
				add r3, r3, #1
				add r3, r3, r5
				BRz push_error
				add r6, r6, #1 
				str r0, r6, #0
				
				
				ending_x3200
				ld r7, backup_r7_x3200
					ret
					
				push_error
					lea r0, push_error_msg
					puts
					br ending_x3200
					
;-----------------------------------------------------------------------------------------------
; SUB_STACK_PUSH local data
push_error_msg .STRINGZ "Overflow\n"
backup_r7_x3200 .blkw #1


;===============================================================================================


;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available                      
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped MEM[TOS] off of the stack.
;		    If the stack was already empty (TOS = BASE), the subroutine has printed
;                an underflow error message and terminated.
; Return Value: R0 ← value popped off the stack
;		   R6 ← updated TOS
;------------------------------------------------------------------------------------------
					.orig x3400
				 st r7, backup_r7_x3400
				 and r3, r3, x0
				 add r3, r3, r6
				 not r3, r3
				 add r3, r3, #1
				 add r3, r3, r4
				 BRz pop_error
				 
				 ldr r0, r6, #0
					and r3, r3, x0
					
					str r3, r6, #0
					 add r6, r6, #-1
				
				 
				 ending_x3400
				 ld r7, backup_r7_x3400
					ret
					
					pop_error
					lea r0, pop_error_msg
					puts
					br ending_x3400
;-----------------------------------------------------------------------------------------------
; SUB_STACK_POP local data
pop_error_msg .STRINGZ "Underflow\n"
backup_r7_x3400 .blkw #1


;===============================================================================================

;------------------------------------------------------------------------------------------
; Subroutine: SUB_RPN_MULTIPLY
; Parameter (R4): BASE: A pointer to the base (one less than the lowest available
;                       address) of the stack
; Parameter (R5): MAX: The "highest" available address in the stack
; Parameter (R6): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped off the top two values of the stack,
;		    multiplied them together, and pushed the resulting value back
;		    onto the stack.
; Return Value: R6 ← updated TOS address
;------------------------------------------------------------------------------------------
					.orig x3600
				 st r7, backup_r7_x3600
				 st r4, backup_r4_x3600
				 st r5, backup_r5_x3600	
				 ld r1, pop_ptr
				 jsrr r1
				 and r3, r3, x0
				 add r3, r3, r0
				 st r3, backup_r3_temp
				 jsrr r1
				 ld r3, backup_r3_temp
				
				 and r4, r4, x0
				 add r4, r4, r0
				 ;add r3, r3, #-1
				 
					add r3, r3, #0
					brz zero_check
					
					add r0, r0, #0
					brz zero_check	
					
					and r0, r0, x0
				 loop_mult
					add r0, r0, r4
					add r3, r3, #-1
					brp loop_mult
				 
				 
				 
				 return
				 ld r1, push_ptr
				 jsrr r1
				 
				 
				 and r1, r1, x0
				 add r1, r1, r0
				 
				 
				 ld r2, print_ptr
				 jsrr r2
				 
				 ld r4, backup_r4_x3600
				 ld r5, backup_r5_x3600
				 ld r7, backup_r7_x3600
					ret
					
					zero_check
					and r0, r0, x0
					and r1, r1, x0
					add r1, r1, r0
					br return
;-----------------------------------------------------------------------------------------------
; SUB_RPN_MULTIPLY local data
pop_ptr .fill x3400
push_ptr .fill x3200
backup_r3_temp .blkw #1
backup_r4_x3600 .blkw #1
backup_r5_x3600	.blkw #1
backup_r7_x3600 .blkw #1
print_ptr .fill x3800



;===============================================================================================

	

.orig x3800
;subroutine print_number_ascii
;parameter (r1): value desired to print 
;postcondition: value is printed into console
;output: none
st r1, backup_r1_x3800
st r7, backup_r7_x3800

add r1, r1, #0
brp begin
add r1, r1, #0
brz zero_case

ld r0, minussign
out

not r1, r1
add r1, r1, #1
br begin

zero_case
	ld r0, ascii_zero
	add r0, r0, r1
	out
	br end_lmao
begin

ld r2, counter
and r3, r3, x0
add r4, r1, #0


ten_thousands
	ld r5, neg_10000
	add r1, r1, r5
	BRzp ten_thousands_count
	ld r0, ascii_zero
	add r0, r0, r2
	ld r6, neg_48_x3600
	and r7, r7, x0
	add r1, r4, #0
	add r7, r0, r6
	brz thousands
	out
	ld r2, counter
	br thousands
	
ten_thousands_count
	add r3, r3, #1
	add r4, r1, #0
	add r2, r2, #1
	br ten_thousands
	
thousands
	ld r5, neg_1000
	add r1, r1, r5
	BRzp thousands_count
	ld r0, ascii_zero
	add r0, r0, r2
	ld r6, neg_48_x3600
	and r7, r7, x0
	add r1, r4, #0
	
	add r3, r3, #0
	brp NEGATED_THOUSANDS
	add r7, r0, r6
	brz hundreds
	NEGATED_THOUSANDS
	out
	
	ld r2, counter
	br hundreds

thousands_count
	add r3, r3, #1
	add r4, r1, #0
	add r2, r2, #1
	br thousands
	
hundreds
	ld r5, neg_100
	add r1, r1, r5
	BRzp hundreds_count
	ld r0, ascii_zero
	add r0, r0, r2
	ld r6, neg_48_x3600
	and r7, r7, x0
	add r1, r4, #0
	add r3, r3, #0
	brp NEGATED_HUNDREDS
	add r7, r0, r6
	brz tens
	NEGATED_HUNDREDS
	out
	ld r2, counter
	br tens

hundreds_count
	add r3, r3, #1
	add r4, r1, #0
	add r2, r2, #1
	br hundreds
	
tens
	ld r5, neg_10
	add r1, r1, r5
	BRzp tens_count
	ld r0, ascii_zero
	add r0, r0, r2
	ld r6, neg_48_x3600
	and r7, r7,x0
	add r1, r4, #0
	add r3, r3, #0
	brp NEGATED_TENS
	add r7, r0, r6
	brz ones_place
	NEGATED_TENS
	out
	ld r2, counter
	br ones_place
	
tens_count
	add r3, r3, #1
	add r4, r1, #0
	add r2, r2, #1
	br tens
	
ones_place
	ld r0, ascii_zero
	add r0, r0, r1
	out

end_lmao
ld r0, newewewewline
out

ld r1, backup_r1_x3800
ld r7, backup_r7_x3800
ret
;x3600 data
backup_r1_x3800 .blkw #1
backup_r7_x3800 .blkw #1
neg_10000 .fill #-10000
neg_1000 .fill #-1000
neg_100 .fill #-100
neg_10 .fill #-10
ascii_zero .fill #48
neg_48_x3600 .fill #-48
minussign .fill #45
counter .fill #0
newewewewline .fill #10


.orig xA000
stack .blkw #6	
.end


