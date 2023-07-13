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
main:
	li $t6, 0x1
	li $t3, 0x81 		# check row 4 and re-enable bit 7
get_cod:li $t1, IN_ADDRESS_HEXA_KEYBOARD
	bgt $t3, 0x88, reset
	sb $t3, 0($t1) 		# must reassign expected row
	li $t1, OUT_ADDRESS_HEXA_KEYBOARD
	lb $a0, 0($t1)
	bnez $a0, prn_cod
	mul $t6, $t6, 2
	add $t3, $t6, 0x80
	j get_cod
prn_cod:li $v0,34
	syscall
	li $v0,11
	li $a0,'\n' 		# print end-of-line
	syscall
	j main
reset:	li $t3, 0x81
	li $t6, 0x1
	j get_cod

		
