.orig x3000
LDI R3, pointer
BRp pos
;LDI R3, pointer
BRn neg
;LDI R3, pointer
BRz zer

lea r0, None
puts

return


halt

pos
	lea r0, positive
	puts
	br return

neg
	lea r0, negative
	puts
	br return
	
zer
	lea r0, Zero
	puts
	br return



pointer .fill x6000
positive .stringz "Pos\n"
negative .stringz "Neg\n"
Zero	 .stringz "Zero\n"

None .stringz "None\n"
.orig x6000
	.fill xA429

.orig xA429
	.fill x0FFF
	
	.end
