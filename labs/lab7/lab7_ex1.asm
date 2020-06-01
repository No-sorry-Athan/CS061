;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Athan Chu	
; Email: achu046@ucr.edu
; 
; Lab: lab 7, ex 1
; Lab section: 24
; TA: David Feng
.orig x3000
ld r2, subroutine_1_ptr
jsrr r2

add r1, r1, #1

ld r2, subroutine_2_ptr
jsrr r2

HALT
;local data
subroutine_1_ptr .fill x3200
subroutine_2_ptr .fill x3600


.ORIG x3200		
;subroutine SUB_LOAD_VALUE
;parameter: none?
;postcondition: subroutine takes entered value and stores in register (r1)
;no return value
st r7, backup_r7
ld r1, value

ld r7, backup_r7
ret
rerun
; output intro prompt
LD R0, introPromptPtr
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
	BRz minus_char

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
	LD R0, errorMessagePtr
	PUTS
	BRnzp rerun
	
	
endOfLoop
ADD R4, R4, #-1
BRn end

NOT R1, R1
ADD R1, R1, #1
		
end
LD R0, newline
out

ld r6, value

ld r7, backup_r7
ret
			
;---------------	
; Program Data
;---------------
introPromptPtr		.FILL xA800
errorMessagePtr		.FILL xA900
dec_5				.FILL #5
dec_1 .fill #1
neg_newline .fill #-10
newline .fill #10
neg_48 .fill #-48
neg_57 .fill #-57
ascii_neg_plus .FILL #-43
ascii_neg_minus	.FILL #-45
backup_r7 .blkw #1


value .fill #32767




;------------
; Remote data
;------------
.ORIG xA800			; intro prompt
introPrompt .STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
					
					
.ORIG xA900			; error message
errorMessage .STRINGZ	"ERROR! invalid input\n"


.orig x3600
;subroutine print_number_ascii
;parameter (r1): value desired to print 
;postcondition: value is printed into console
;output: none
st r1, backup_r1_x3600
st r7, backup_r7_x3600

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

ld r1, backup_r1_x3600
ld r7, backup_r7_x3600
ret
;x3600 data
backup_r1_x3600 .blkw #1
backup_r7_x3600 .blkw #1
neg_10000 .fill #-10000
neg_1000 .fill #-1000
neg_100 .fill #-100
neg_10 .fill #-10
ascii_zero .fill #48
neg_48_x3600 .fill #-48
minussign .fill #45
counter .fill #0
newewewewline .fill #10




;---------------
; END of PROGRAM
;---------------
.END
