;=================================================
; Name: Athan Chu	
; Email:  achu046@ucr.edu
; 
; Lab: lab 1, ex 1
; Lab section: 24
; TA: David Feng
; 
;=================================================

.orig x3000

;--------------
; Instruction
;--------------
;LD R1, DEC0
AND R1, R1, x0
LD R2, DEC12
LD R3, DEC6

LOOP    			  ;while r3 is positive
ADD R1, R1, R2        ; r1 = r1 + r2, r3 number of times == r1 = r2 * r3
ADD R3, R3, #-1       ; r3 = r3 + (-1) == r3 = r3 - 1, decrement by 1
BRp LOOP 			  ; if most recent operation is still positive (r3 > 0), run back again starting from loop
END_LOOP  			  ;if R3 is no longer positive, exit loop

HALT
;--------------
; Local Data
;--------------
;DEC0 .FILL  #0
DEC6 .FILL  #6
DEC12 .FILL #12

.end
