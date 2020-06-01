;=================================================
; Name: Athan Chu	
; Email: achu046@ucr.edu
; 
; Lab: lab 3, ex 1
; Lab section: 24	
; TA: David Feng
; 
;=================================================
.ORIG x3000
;INSTRUCTIONS
LD R5, DATA_PTR
LD R6, DATA_PTR
ADD R6, R6, #1

LDR R3, R5, #0
LDR R4, R6, #0

ADD R3, R3, #1
ADD R4, R4, #1

STR R3, R5, #0
STR R4, R6, #0

HALT

;;LOCAL DATA
DATA_PTR .FILL x4000

;; REMOTE DATA
.orig x4000
NEW_DEC_65 .FILL #65
NEW_HEX_41 .FILL x41

.END
