;=================================================
; Name: Athan Chu
; Email: achu046
; 
; Lab: lab 6, ex 3
; Lab section: 24
; TA: David Feng
; 
;=================================================
.orig x3000
ld r1, array_ptr
ld r6, dec_10
and r5, r5, x0

LD R1, array_ptr
LD r2, input_x3600
JSRR r2

ld r1, array_ptr
ld r2, sub_routine_ptr_x34
jsrr r2


halt
;local data
dec_10 .fill #10
sub_routine_ptr .fill x3200
sub_routine_ptr_x34 .fill x3400
input_x3600 .fill x3600
array_ptr .fill x4000



;subroutine: sub_to_upper
;parameter(r1):starting address of nullt-erimated string
; postcondition: subroutine has converted the string to upper class inplace (upper case replaces
; orignal string
; no return value, no output (but r1 contains array adddress)

.orig x3200
st r1, backup_r1
st r7, backup_r7_x3200
ld r2, mask

converting_to_upper	
	ldr r0, r1, #0
	and r0, r0, r2
	str r0, r1, #0
	
	add r1, r1, #1
	
	ldr r0, r1, #0
	add r0, r0, #0
	
	brz end_arr
	br converting_to_upper

end_arr

ld r1, backup_r1
ld r7, backup_r7_x3200
ret


backup_r7_x3200 .blkw #1
backup_r1  .blkw #1
mask .fill x005f

;subroutine: sub_is_palindrome
;parameter (r1): the starting address of a null-terminated string
;parameter (r5): the number of characters in the array
;post condition: the subroutine has determined whether the string at (r1) is a 
; 				 palindrome or not, and returned a flag to that effect
; return value: r4 (1 if palindrome, 0 otherwise)
.orig x3400

st r1, backup_r1_x3400
st r5, backup_r5
st r7, backup_r7

ld r2, ptr_ptr	
jsrr r2

and r2,r2,x0
add r2, r2, r1
add r2, r2, r5
add r2, r2, #-1

palindrome_check
	ldr r0, r1, #0
	ldr r6, r2, #0
	
	;add r5, r5, #-1
	add r3, r1, #0
	add r5, r2, #0
	
	
	not r3, r3
	add r3, r3, #1
	add r3, r3, r5
	brnz naming_conventions
					
	add r1, r1, #1
	add r2, r2, #-1
						   
	not r6, r6
	add r6, r6, #1
	add r0, r0, r6
	brz palindrome_check
	brnp failed

naming_conventions
and r4, r4, #0
add r4, r4, #1

ld r1, backup_r1_x3400

and r0 ,r0, x0
add r0, r0, r1
puts

add r4, r4, #0
brz not_pali

lea r0, pali
puts

br go_to_end

not_pali
lea r0, not_plai
puts

go_to_end
end_x3400

ld r5, backup_r5
ld r7, backup_r7
ret

failed 
	and r4, r4, #0
	br go_to_end

backup_r1_x3400 .blkw #1
backup_r5 .blkw #1
backup_r7 .blkw #1
pali .stringz " is a palindrome\n"
not_plai .stringz " is not a palindrome\n"
ptr_ptr .fill x3200

;subroutine: SUB_GET_STRING
;paramter (r1): starting address of the chracter array
;post condition: subroutine prompted user to enter a string
;terminated by the enter key
;Return value (R5): the number of non-setinal characters
.orig x3600
st r1, backup_r1_x3600
st r7, backup_r7_x3600

lea r0, intro_promt
PUTS

ld r6, dec_10_x3600
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


ld r1, backup_r1_x3600
ld r7, backup_r7_x3600
ret

intro_promt .stringz "Enter a string with its ending verified by an enter press\n"
newline .fill #10
dec_10_x3600 .fill #10
backup_r1_x3600 .blkw #1
backup_r7_x3600 .blkw #1

.orig x4000
array .blkw #100
