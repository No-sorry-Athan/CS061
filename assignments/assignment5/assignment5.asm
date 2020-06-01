;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Athan Chu
; Email: achu046@ucr.edu
; 
; Assignment name: Assignment 5
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
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
menu_loop
	ld r4, sub_menu
	jsrr r4
	
	add r5, r1, #0
	add r5, r5, #-1
	brz all_busy
	
	add r5, r1, #0
	add r5, r5, #-2
	brz all_free
	
	add r5, r1, #0
	add r5, r5, #-3
	brz num_busy
	
	add r5, r1, #0
	add r5, r5, #-4
	brz num_free
	
	add r5, r1, #0
	add r5, r5, #-5
	brz machine_status
	
	add r5, r1, #0
	add r5, r5, #-6
	brz first_free
	
	add r5, r1, #0
	add r5, r5, #-7
	brz endend
	
	
	br menu_loop

all_busy
	ld r4, sub_all_busy
	jsrr r4
	add r2, r2, #0
	brz not_all_busy
	lea r0, allbusy
	puts
	br menu_loop
	

not_all_busy
	lea r0, allnotbusy
	puts
	br menu_loop

all_free
	ld r4, sub_all_free
	jsrr r4
	add r2, r2, #0
	brz not_all_free
	lea r0, allfree
	puts
	br menu_loop
	
not_all_free
	lea r0,allnotfree
	puts
	br menu_loop
	
num_busy
	ld r4, sub_num_busy
	jsrr r4
	lea r0, busymachine1
	puts
	ld r4, sub_print_num
	jsrr r4
	lea r0, busymachine2
	puts
	br menu_loop
	
num_free 
	ld r4, sub_num_free
	jsrr r4
	lea r0, freemachine1
	puts
	ld r4, sub_print_num
	jsrr r4
	lea r0, freemachine2
	puts
	br menu_loop
	
machine_status
	ld r4, sub_get_input
	jsrr r4
	ld r4, sub_machine_status
	jsrr r4
	lea r0, status1
	puts
	st r2, tempstatus
	
	add r2, r1, #0
	ld r4, sub_print_num
	jsrr r4
	
	ld r2, tempstatus
	brp status_free
	lea r0, status2
	puts
	br menu_loop


status_free
	lea r0, status3
	puts
	br menu_loop
	
	
first_free
	ld r4, sub_first_free
	jsrr r4
	and r0, r0, x0
	add r0, r1, #-16
	brz none_free
	
	and r0, r0, x0
	lea r0, firstfree1
	puts
	
	ld r4, sub_print_num
	jsrr r4
	
	lea r0, newline_ori
	puts
	
	br menu_loop
	
none_free
	lea r0, firstfree2
	puts
	br menu_loop
	
	
endend
lea r0, goodbye
puts


HALT
;---------------	
;Data
;---------------
;Subroutine pointers



;Other data 
newline_ori .stringz "\n"
; Strings for reports from menu subroutines:
sub_menu .fill x3200
tempstatus .fill #0
sub_all_busy .fill x3400
sub_all_free .fill x3600
sub_num_busy .fill x3800
sub_num_free .fill x4000
sub_machine_status .fill x4200
sub_first_free .fill x4400
sub_get_input .fill x4600
sub_print_num .fill x4800

goodbye         .stringz "Goodbye!\n"
allbusy         .stringz "All machines are busy\n"
allnotbusy      .stringz "Not all machines are busy\n"
allfree         .stringz "All machines are free\n"
allnotfree		.stringz "Not all machines are free\n"
busymachine1    .stringz "There are "
busymachine2    .stringz " busy machines\n"
freemachine1    .stringz "There are "
freemachine2    .stringz " free machines\n"
status1         .stringz "Machine "
status2		    .stringz " is busy\n"
status3		    .stringz " is free\n"
firstfree1      .stringz "The first available machine is number "
firstfree2      .stringz "No machines are free\n"

.orig x3200
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, invited the
;                user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7 (as a number, not a character)
;                    no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
st r7, backup_r7_x4000
st r3, backup_r3_x4000
menu_sub
	ld r0, Menu_string_addr
	puts
	
	getc
	out
	add r1, r0, #0
	
	ld r0, newline_x4000
	out
	
	and r3, r3, x0
	and r4, r4, x0
	
	add r3, r3, r1
	add r4, r4, r1
	
	ld r2, neg_48_x4000
	add r3, r3, r2
	brn menu_error
	
	ld r2, neg_55_x4000
	add r4, r1, r2
	brp menu_error
	
	ld r2, neg_48_x4000
	add r1, r1, r2
	
	br menu_end	


menu_error
	lea r0, Error_msg_1
	puts
	
	br menu_sub
	
menu_end
	and r0, r0, x0
	and r2, r2, x0
	and r3, r3, x0
	and r4, r4, x0
	ld r3, backup_r3_x4000
	ld r7, backup_r7_x4000
	
ret
;--------------------------------
;Data for subroutine MENU
;--------------------------------
Error_msg_1	      .STRINGZ "INVALID INPUT\n"
Menu_string_addr  .FILL x6400
backup_r7_x4000 .blkw #1
newline_x4000 .fill #10
neg_48_x4000 .fill #-48
neg_55_x4000 .fill #-55
backup_r3_x4000 .blkw #1


.orig x3400
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY (#1)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
st r7, backup_r7_x4100
st r3, backup_r3_x4100
ld r5, BUSYNESS_ADDR_ALL_MACHINES_BUSY
ldr r1, r5, #0
ld r3, dec_16_x4100
and r2, r2, x0

busy_loop
	add r1, r1, #0
	brn not_busy
	add r1, r1, r1
	add r3, r3, #-1
	brp busy_loop

add r2, r2, #1
br final

not_busy
	and r2, r2, x0
	br final

final
and r1, r1, x0
and r3, r3, x0
and r5, r5, x0
ld r3, backup_r3_x4100
ld r7, backup_r7_x4100
ret
;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xB200
backup_r7_x4100 .blkw #1
dec_16_x4100 .fill #16
backup_r3_x4100 .blkw #1

.orig x3600
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE (#2)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
st r7, backup_r7_x4200
st r3, backup_r3_x4200
ld r5, BUSYNESS_ADDR_ALL_MACHINES_FREE
ldr r1, r5, #0
ld r3, dec_16_x4200
and r2, r2, x0

busy_loop_here
	add r1, r1, #0
	brzp busy
	add r1, r1, r1
	add r3, r3, #-1
	brp busy_loop_here

add r2, r2, #1
br final1

busy
	and r2, r2, x0
	br final1

final1
and r1, r1, x0
and r3, r3, x0
and r6, r6, x0
ld r3, backup_r3_x4200
ld r7, backup_r7_x4200
ret
;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xB200
backup_r7_x4200 .blkw #1
dec_16_x4200 .fill #16
backup_r3_x4200 .blkw #1

.orig x3800
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES (#3)
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R1): The number of machines that are busy (0)
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
st r7, backup_r7_x4300
and r1, r1, x0
ld r5, BUSYNESS_ADDR_NUM_BUSY_MACHINES
ldr r2, r5, #0
ld r3, dec_16_x4300	

num_busy_count
	add r2, r2, #0
	brzp is_busy_4300
	return
	add r2, r2, r2
	add r3, r3, #-1
	brp num_busy_count

and r2, r2, x0
and r3, r3, x0
and r5, r5, x0
ld r7, backup_r7_x4300
ret

is_busy_4300
	add r1, r1, #1
	br return
	
;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xB200
backup_r7_x4300 .blkw #1
dec_16_x4300 .fill #16 
backup_r3_x4300 .blkw #1

.orig x4000
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES (#4)
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R1): The number of machines that are free (1)
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
st r7, backup_r7_x4400
st r3, backup_r3_x4400
and r1, r1, x0
ld r5, BUSYNESS_ADDR_NUM_FREE_MACHINES
ldr r2, r5, #0
ld r3, dec_16_x4400	

num_busy_count_here
	add r2, r2, #0
	brn is_free_4400
	return_spot
	add r2, r2, r2
	add r3, r3, #-1
	brp num_busy_count_here

and r2, r2, x0
and r3, r3, x0
and r5, r5, x0
ld r7, backup_r7_x4400
ld r3, backup_r3_x4400
ret

is_free_4400
	add r1, r1, #1
	br return_spot
	
;--------------------------------
;Data for subroutine NUM_FREE_MACHINES 
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xB200
backup_r7_x4400 .blkw #1
dec_16_x4400	.fill #16
backup_r3_x4400 .blkw #1

.orig x4200
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS (#5)
; Input (R1): Which machine to check, guaranteed in range {0,15}
; Postcondition: The subroutine has returned a value indicating whether
;                the selected machine (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;              (R1) unchanged
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
st r7, backup_r7_x4500
st r3, backup_r3_x4500
add r5, r1, #0
not r5, r5
add r5, r5, #1

ld r3, dec_15_x4500
ld r6, BUSYNESS_ADDR_MACHINE_STATUS
ldr r4, r6, #0

add r3, r3, r5
add r3, r3, #0
brz status_check

left_shift
add r4, r4, r4
add r3, r3, #-1
brp left_shift

status_check
	add r4, r4, #0
	brzp is_busy_x4500
	
	and r2, r2, x0
	add r2, r2, #1
	br return_status


is_busy_x4500
	and r2, r2, x0


return_status
and r3, r3, x0
and r4, r4, x0
and r5, r5, x0
and r6, r6, x0
ld r3, backup_r3_x4500
ld r7, backup_r7_x4500
ret
;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BUSYNESS_ADDR_MACHINE_STATUS .Fill xB200

backup_r7_x4500 .blkw #1
dec_15_x4500 .fill #15
backup_r3_x4500 .blkw #1

.orig x4400
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE (#6)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R1): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
st r7, backup_r7_x4600
st r3, backup_r3_x4600
ld r6, BUSYNESS_ADDR_FIRST_FREE
and r1, r1, x0
add r1, r1, #8
add r1, r1, #8
ldr r2, r6, #0

ld r3, dec_16_x4600

check_loop
	add r2, r2, #0
	brn free_location
	ret_Loc
	add r2, r2, r2
	add r3, r3, #-1
	brp check_loop
	
	br end2

free_location
	and r1, r1, #0
	add r1, r1, r3
	add r1, r1, #-1
	br ret_Loc

end2
and r2, r2, x0
and r6, r6, x0
and r3, r3, x0
ld r7, backup_r7_x4600
ld r3, backup_r3_x4600
ret
;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
BUSYNESS_ADDR_FIRST_FREE .Fill xB200
backup_r7_x4600 .blkw #1
dec_16_x4600 .fill #16
backup_r3_x4600 .blkw #1

.orig x4600
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: GET_MACHINE_NUM
; Inputs: None
; Postcondition: The number entered by the user at the keyboard has been converted into binary,
;                and stored in R1. The number has been validated to be in the range {0,15}
; Return Value (R1): The binary equivalent of the numeric keyboard entry
; NOTE: You can use your code from assignment 4 for this subroutine, changing the prompt, 
;       and with the addition of validation to restrict acceptable values to the range {0,15}
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
st r7, backup_r7
st r3, backup_r3
rerun
; output intro prompt
Lea R0, prompt
PUTS

LD R3, dec_5
LD R5, dec_1

AND R1, R1, x0	
AND R4, R4, x0 
	
; Set up flags, counters, accumulators as needed

; Get first character, test for '\n', '+', '-', digit/non-digit: 	
startOfLoop
	GETC
	ADD R2, R0, #0
	LD R6, neg_newline
	ADD R2, R2, R6
	BRz endOfLoop
	BRnp output
	

output
	OUT
	ADD R5, R5, #-1
	BRz first_run
	BR after_first

first_run
	ADD R2, R0, #0
	LD R6, ascii_neg_minus
	ADD R2, R2, R6
	BRz error_case

	ADD R2, R0, #0
	LD R6, ascii_neg_plus
	ADD R2, R2, R6
	BRz pos_char
	
	ADD R2, R0, #0
	LD R6, neg_48
	ADD R2, R2, R6
	BRn invalid_char
	
	ADD R2, R0, #0
	LD R6, neg_57
	ADD R2, R2, R6
	BRp invalid_char
	
	ADD R1, R1, R1
	ADD R7, R1, R1
	ADD R7, R7, R7
	ADD R1, R1, R7
	
	LD R6, neg_48
	ADD R0, R0, R6
	ADD R1, R1, R0
	
	ADD R3, R3, #-1
	BRp startOfLoop

after_first
	ADD R2, R0, #0
	LD R6, neg_48
	ADD R2, R2, R6
	BRn invalid_char
	
	ADD R2, R0, #0
	LD R6, neg_57
	ADD R2, R2, R6
	BRp invalid_char
	
	ADD R1, R1, R1
	ADD R7, R1, R1
	ADD R7, R7, R7
	ADD R1, R1, R7 ; mult current val by itself 10x
	
	LD R6, neg_48
	ADD R0, R0, R6
	ADD R1, R1, R0
	
	
	ADD R3, R3, #-1
	BRp startOfLoop
	
	BRz endOfLoop
	
minus_char
	ADD R4, R4, #1
	BRnzp startOfLoop

pos_char
	ADD R4, R4, #0
	BRnzp startOfLoop

invalid_char
	LD R0, newline
	OUT
	lea R0, Error_msg_2
	PUTS
	BRnzp rerun
	
	
endOfLoop
ADD R4, R4, #-1
BRn end

NOT R1, R1
ADD R1, R1, #1
		
end
add r5, r5, #0
brp beep_boop
LD R0, newline
out

add r1, r1, #0
brn error_case

add r3, r1, #0
add r3, r3, #-8
add r3, r3, #-8
brzp error_case

ld r7, backup_r7
ld r3, backup_r3
ret

beep_boop
ld r0, newline
out
			
error_case
	ld r0, newline
	out
	lea r0, Error_msg_2
	puts
	br rerun


;---------------	
; Program Data
;---------------
dec_5				.FILL #5
dec_1 .fill #1
neg_newline .fill #-10
newline .fill #10
neg_48 .fill #-48
neg_57 .fill #-57
ascii_neg_plus .FILL #-43
ascii_neg_minus	.FILL #-45
backup_r7 .blkw #1
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_msg_2 .STRINGZ "ERROR INVALID INPUT\n"
backup_r3 .blkw #1

.orig x4800	
;-----------------------------------------------------------------------------------------------------------------
; Subroutine: PRINT_NUM
; Inputs: R1, which is guaranteed to be in range {0,16}
; Postcondition: The subroutine has output the number in R1 as a decimal ascii string, 
;                WITHOUT leading 0's, a leading sign, or a trailing newline.
; Return Value: None; the value in R1 is unchanged
;-----------------------------------------------------------------------------------------------------------------
st r1, backup_r1_x4800
st r7, backup_r7_x4800
st r3, backup_r3_x4800

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
;ld r0, newewewewline
;out

ld r1, backup_r1_x4800
ld r7, backup_r7_x4800
ld r3, backup_r3_x4800
ret
;x4800 data
backup_r1_x4800 .blkw #1
backup_r7_x4800 .blkw #1
neg_10000 .fill #-10000
neg_1000 .fill #-1000
neg_100 .fill #-100
neg_10 .fill #-10
ascii_zero .fill #48
neg_48_x3600 .fill #-48
minussign .fill #45
counter .fill #0
newewewewline .fill #10
backup_r3_x4800 .blkw #1



.ORIG x6400
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xB200			; Remote data
BUSYNESS .FILL x0000		; <----!!!BUSYNESS VECTOR!!! Change this value to test your program.

;---------------	
;END of PROGRAM
;---------------	
.END
