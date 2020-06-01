;=================================================
; Name: Athan Chu
; Email: achu046
; 
; Lab: lab 7, ex 2
; Lab section: 24
; TA: David Feng
; 
;=================================================
.orig x3000
lea r0, introPrompt
puts

getc
out

add r1, r0, #0

ld r0, newline
out

ld r2, sub_one
jsrr r2

lea r0, output
puts

and r0, r0, x0
add r0, r1, #0
out

lea r0, output2
puts

ld r0, ascii_zero
add r0, r0, r5
out

halt
;local data
introPrompt .stringz "Enter any single character: "
output .stringz "The number of 1's in '"
output2 .stringz "' is: "
ascii_zero .fill #48
newline .fill #10
sub_one .fill x3200



.orig x3200
;subroutine count_ones
;input(r1): register stored with value that we want to find num of ones in
;postcondition (num ones stored in r5)
;output: num of one's in value
st r7, backup_r7
st r1, backup_r1
ld r3, dec_16
and r5, r5, x0

one_or_zero
	add r1, r1, #0
	brn one
	add r1, r1, #0
	brzp zero

one
	add r1, r1, r1
	add r5, r5, #1
	add r3, r3, #-1
	brp one_or_zero
	add r3, r3, #0
	brz end

zero
	add r1, r1, r1
	add r3, r3, #-1
	brp one_or_zero
	add r3, r3, #0
	brz end
	
end

ld r1, backup_r1
ld r7, backup_r7
ret
;3200 data
backup_r1 .blkw #1
backup_r7 .blkw #1
dec_16 .fill #16


.end
