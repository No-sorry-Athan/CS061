;=================================================
; Name: Athan Chu	
; Email: achu046
; 
; Lab: lab 9, ex 1 & 2
; Lab section: 24
; TA: David Feng
; 
;=================================================

; test harness
					.orig x3000
				 LD r4, BASE	
				 LD r5, MAX
				 LD r6, TOS
				 
				 ld r1, sub_stack_pop_ptr
				 jsrr r1
				 ;Underflow
				 
				 and r0, r0, x0
				 add r0, r0, #1
				 
				 ld r1, sub_stack_push_ptr
				 jsrr r1
				 
				 
				 add r0, r0, #1
				 jsrr r1
				 
				 add r0, r0, #1
				 jsrr r1
				 
				 add r0, r0, #1
				 jsrr r1
				 
				 add r0, r0, #1
				 jsrr r1
				 
				 ;Overflow
				 add r0, r0, #1
				 jsrr r1
				 
				 ;xA000 1 2 3 4 5
				 ld r1, sub_stack_pop_ptr
				 jsrr r1
				 ;xA000 1 2 3 4
				 jsrr r1
				 ;xA000 1 2 3
				 jsrr r1
				 ;xA000 1 2
				 jsrr r1
				 ;xA000 1
				 jsrr r1
				 ;xA000 
				 jsrr r1
				 ;Underflow
				 
				 
					halt
;-----------------------------------------------------------------------------------------------
; test harness local data:
sub_stack_push_ptr .fill x3200
sub_stack_pop_ptr .fill x3400
BASE .fill xA000
TOS .fill xA000
MAX .fill xA005



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
.orig xA000
stack .blkw #5	
.end


