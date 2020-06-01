;=================================================
; Name: athan chu
; Email: achu046
; 
; Lab: lab 7, ex 3
; Lab section: 24
; TA: David Feng
; 
;=================================================
.orig x3000
ld r1, testVal

ld r4, sub_ptr
jsrr r4

halt

testVal .fill x000C
sub_ptr .fill x3200

.orig x3200
;subroutine right_shift
;parameter (r1) value desired to be right shifted
;postcondition (r2) is rightshifted value of r1
;output: none
st r1, backup_r1
st r7, backup_r7

and r2, r2, x0
add r1, r1, #0
brp here
and r4, r4, x0
add r4, r4, #1
not r1, r1
add r1, r1, #1
here

add r2, r1, #0


dec_loop
	and r3, r3, x0
	
	add r3, r2, #0
	add r3, r3, r3
	not r3, r3
	add r3, r3, #1
	
	and r5, r5, x0
	add r5, r3, r1
	brz right_shifted
	add r5, r5, #-1
	brz right_shifted
	add r2, r2, #-1
	br dec_loop
	

	
right_shifted
add r4, r4, #0
brnz end
not r2, r2
add r2, r2, #1

end
ld r1, backup_r1
ld r7, backup_r7
ret

;3200 data
backup_r1 .blkw #1
backup_r7 .blkw #1

.end
