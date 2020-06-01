;=================================================
; Name: Athan Chu
; Email: achu046
; 
; Lab: lab 6, ex 1
; Lab section: 24
; TA: David Feng
; 
;=================================================
.orig x3000

LD R1, array_ptr
LD r2, sub_routine_ptr
JSRR r2


and r0, r0, x0
add r0, r0, r1
puts

HALT
;local data
dec_48 .fill #48
dec_ten .fill #10
sub_routine_ptr .fill x3200
array_ptr .fill x4000


;subroutine: SUB_GET_STRING
;paramter (r1): starting address of the chracter array
;post condition: subroutine prompted user to enter a string
;terminated by the enter key
;Return value (R5): the number of non-setinal characters
.orig x3200
st r1, backup_r1
st r7, backup_r7

lea r0, intro_promt
PUTS

ld r6, dec_10
and r5, r5, x0
input_loop
	getc
	out
	add r4, r0, #0
	not r0, r0
	add R0, r0, #1
	add r0, r0, r6
	brz end
	str r4, r1, #0
	
	
	add r5, r5, #1
	add r1, r1, #1
	br input_loop	
	
end


ld r1, backup_r1
ld r7, backup_r7
ret

intro_promt .stringz "Enter a string with its ending verified by an enter press\n"
newline .fill #10
array_ptr_x3200 .fill x4000
dec_10 .fill #10
backup_r1 .blkw #1
backup_r7 .blkw #1
.orig x4000
array .blkw #100
.END
