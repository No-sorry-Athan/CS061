;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Athan Chu
; Email: achu046@ucr.edu
; 
; Assignment name: Assignment 2
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

;----------------------------------------------
;output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

GETC 
OUT 

;fill R0 with val in R0
ST R0, temptemp
LD R1, temptemp	

LD R0, newline
OUT

GETC
OUT

;fill R2 with val in R0
ST R0, temptemp
LD R2, temptemp

LD R0, newline
OUT

AND R0, R0, x0
ADD R0, R0, R1
OUT

LEA R0, inbetween
PUTS

AND R0, R0, x0
ADD R0, R0, R2
OUT

LEA R0, after
PUTS

LD R3, DEC48
FourtyEightLoop 
	ADD R1, R1, #-1
	ADD R2, R2, #-1
	ADD R3, R3, #-1
	BRp FourtyEightLoop
	
ST R2, temptemp
ADD R2, R2, #0
BRz GOHEREINSTEAD
LD R4, temptemp
subtrackk
	ADD R1, R1, #-1
	ADD R4, R4, #-1
	BRp subtrackk

ST R1, temptemp

ADD R1, R1, #0

BRzp GOHEREINSTEAD
LD R6, numLoops
ST R1, currentNum
LD R7, currentNum

MAKEPOSITIVEMOVE
	DIFFERENTNAME
		ADD R1, R1, #1
		ADD R7, R7, #1
		BRn DIFFERENTNAME
	LD R7, currentNum
	ADD R6, R6, #-1
	BRp MAKEPOSITIVEMOVE
	
LD R0, negative
OUT

GOHEREINSTEAD
ST R1, temptemp	
LD R0, temptemp

LD R3, DEC48
HEREWEGOAGAIN
	ADD R0, R0, #1
	ADD R3, R3, #-1
	BRp HEREWEGOAGAIN

OUT
LD R0, newline
OUT

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------





HALT				; Stop execution of program
;------	
;Data
;------
; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
newline .FILL '\n'	; newline character - use with LD followed by OUT
inbetween .STRINGZ " - "
after .STRINGZ " = "
negative .FILL '-'

temptemp .FILL #-1
currentNum .FILL #-1
numLoops .FILL #2
DEC48 .FILL x30


;---------------	
;END of PROGRAM
;---------------	
.END

