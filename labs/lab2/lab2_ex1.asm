;=================================================
; Name: Athan Chu	
; Email: achu046@ucr.edu
; 
; Lab: lab 2. ex 1
; Lab section: 24
; TA: David Feng
; 
;=================================================
.ORIG x3000
;INSTRUCTIONS
LD R3, DEC_65
LD R4, HEX_41

HALT

;DATA
DEC_65 .FILL #65
HEX_41 .FILL x41

.END
