;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Athan Chu	
; Email: achu046@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 24
; TA: David Feng
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R1
;=================================================================================

.ORIG x3000		
;-------------
;Instructions
;-------------

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

					; is very first character = '\n'? if so, just quit (no message)!

					; is it = '+'? if so, ignore it, go get digits

					; is it = '-'? if so, set neg flag, go get digits
					
					; is it < '0'? if so, it is not a digit	- o/p error message, start over

					; is it > '9'? if so, it is not a digit	- o/p error message, start over
				
					; if none of the above, first character is first numeric digit - convert it to number & store in target register!
					
; Now get remaining digits (max 5) from user, testing each to see if it is a digit, and build up number in accumulator

					; remember to end with a newline!
		
end
LD R0, newline
out
				
HALT
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



;------------
; Remote data
;------------
.ORIG xA800			; intro prompt
introPrompt .STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
					
					
.ORIG xA900			; error message
errorMessage .STRINGZ	"ERROR! invalid input\n"

;---------------
; END of PROGRAM
;---------------
.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
