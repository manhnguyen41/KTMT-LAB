#Laboratory Exercise 4, Assignment 4
.text
start: 
	li $s1, 0x33333333 # s1 = 0x33333333
	li $s2, 0x55555555 # s2 = 0x55555555
	li  $t0,0   #No Overflow is default status 
 	addu  $s3,$s1,$s2       # s3 = s1 + s2 
 	xor  $t1,$s1,$s2       #Test if $s1 and $s2 have the same sign
  	bltz  $t1,EXIT  #If not, exit 
 	xor $t1,$s1,$s3 #Test if $s1 and $s3 have the same sign
 	bltz $t1, OVERFLOW #If not, overflow
 	j EXIT      
OVERFLOW: 
 	li $t0,1   #the result is overflow 
EXIT: 
