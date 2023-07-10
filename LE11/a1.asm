.eqv IN_ADDRESS_HEXA_KEYBOARD	0xFFFF0012
.eqv OUT_ADDRESS_HEXA_KEYBOARD	0xFFFF0014
#------------------------------------------------------
# 		col 0x1 col 0x2 col 0x4 col 0x8
#
# row 0x1 	0 	1 	2 	3
# 		0x11 	0x21 	0x41 	0x81
#
# row 0x2 	4 	5 	6 	7
# 		0x12 	0x22 	0x42 	0x82
#
# row 0x4 	8 	9 	a 	b
# 		0x14 	0x24 	0x44 	0x84
#
# row 0x8 	c 	d 	e 	f
# 		0x18 	0x28 	0x48 	0x88
#------------------------------------------------------
.text
	main:			li $t1, IN_ADDRESS_HEXA_KEYBOARD
				li $t2, OUT_ADDRESS_HEXA_KEYBOARD
	polling_row1:
		li $t3, 0x1 # check row 1 with key C, D, E, F
		sb $t3, 0($t1) # must reassign expected row
		lb $a0, 0($t2) # read scan code of key button
		bne $a0, $zero, print
	polling_row2: 
		li $t3, 0x2 # check row 2 with key C, D, E, F
		sb $t3, 0($t1) # must reassign expected row
		lb $a0, 0($t2) # read scan code of key button
		bne $a0, $zero, print
	polling_row3: 
		li $t3, 0x4 # check row 3 with key C, D, E, F
		sb $t3, 0($t1) # must reassign expected row
		lb $a0, 0($t2) # read scan code of key button
		bne $a0, $zero, print
	polling_row4: 
		li $t3, 0x8 # check row 4 with key C, D, E, F
		sb $t3, 0($t1) # must reassign expected row
		lb $a0, 0($t2) # read scan code of key button
		bne $a0, $zero, print
	print:
		li $v0, 34 # print integer (hexa)
		syscall
	sleep:	
		li $a0, 100 # sleep 100ms 
		li $v0, 32
		syscall
	back_to_polling1:
		j polling_row1 # continue polling
		
