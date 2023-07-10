.eqv KEY_CODE   0xFFFF0004       # ASCII code from keyboard, 1 byte
.eqv KEY_READY  0xFFFF0000       # =1 if has a new keycode ?
				  # Auto clear after lw
.eqv DISPLAY_CODE   0xFFFF000C   # ASCII code to show, 1 byte
.eqv DISPLAY_READY  0xFFFF0008   # =1 if the display has already to do
 				  # Auto clear after sw
.text
 	li   $k0,  KEY_CODE
 	li   $k1,  KEY_READY
 	li   $s0, DISPLAY_CODE
 	li   $s1, DISPLAY_READY
 	li   $s2, 0
loop:        nop
WaitForKey:  lw   $t1, 0($k1)            # $t1 = [$k1] = KEY_READY
 	     nop
 	     beq  $t1, $zero, WaitForKey # if $t1 == 0 then Polling
 	     nop
#----------------------------------------------------
ReadKey:     lw   $t0, 0($k0)            # $t0 = [$k0] = KEY_CODE
	     li $t9, 0x00000065
	     beq $t0, $t9, e
	     li $t9, 0x00000078
	     beq $t0, $t9, x
	     li $t9, 0x00000069
	     beq $t0, $t9, i
	     li $t9, 0x00000074
	     beq $t0, $t9, t
	     j reset
 	     nop
#----------------------------------------------------
WaitForDis:  lw   $t2, 0($s1)            # $t2 = [$s1] = DISPLAY_READY
             nop
	     beq  $t2, $zero, WaitForDis # if $t2 == 0 then Polling             
	     nop             
#----------------------------------------------------
ShowKey:     sw $t0, 0($s0)              # show key
 	     nop               
#----------------------------------------------------
continue: j loop
	  nop
reset:		li $s2, 0
		j WaitForDis
e:		li $s3, 0
		bne $s2, $s3, reset
		addi $s2, $s2, 1
		j WaitForDis
x:		li $s3, 1
		bne $s2, $s3, reset
		addi $s2, $s2, 1
		j WaitForDis
i:		li $s3, 2
		bne $s2, $s3, reset
		addi $s2, $s2, 1
		j WaitForDis
t:		li $s3, 3
		bne $s2, $s3, reset
done:
