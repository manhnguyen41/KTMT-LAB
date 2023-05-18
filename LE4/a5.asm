#Laboratory Exercise 4, Assignment 5
.data
	N: .word 5
.text
	li $s0, 22 #s0 = 22
	la $t0, N
	lw $t1, 0($t0) #t1 = N
	sllv $s1, $s0, $t1 #s1 = s0 * 2^N
