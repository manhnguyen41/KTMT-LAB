#Laboratory Exercise 5, Assignment 2
.data
	result: .asciiz "The sum of (s0) and (s1) is "
.text
	#Load value into registres $s0 and $s1
	li $s0, 22
	li $s1, 10
	
	#Calculate sum of $s0 and $s1
	add $t0, $s0, $s1
	
	#Print
	li $v0, 56
	la $a0, result
	move $a1, $t0
	syscall
	
	 