;=================================================
; Name:  Athan Chu
; Email: achu046@ucr.edu
; 
; Lab: lab 1, ex 0
; Lab section: 24
; TA: David Feng
; 
;=================================================

.orig x3000
;--------------
; Instruction
;--------------
LEA R0, MSG_TO_PRINT ;R0 <-- location of label: MSG_TO_PRINT
PUTS                 ;prints string defined at MSG_TO_PRINT

HALT			     ;terminate program

;--------------
; Local Data
;--------------
MSG_TO_PRINT .STRINGZ "Hello World!!!\n"
.end
