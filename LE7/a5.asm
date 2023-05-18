.data
A: .word 0, 0, 0, 0, 0, 0, 0, 0
message: .asciiz "\nThe max value is "
message1: .asciiz " and it's address is "
message2: .asciiz "\nThe min value is "
message3: .asciiz " and it's address is "
.text
main:
	la $a0, A
	li $s0, 4
	li $s1, 3
	li $s2, 2
	li $s3, 1
	li $s4, 8
	li $s5, 7
	li $s6, 6
	li $s7, 5
	jal MAXMIN
	j loop
print:
	li $v0, 4
	la $a0, message
	syscall
	li $v0, 1
	add $a0, $zero, $t0
	syscall
	li $v0, 4
	la $a0, message1
	syscall
	li $v0, 1
	add $a0, $zero, $t1
	syscall
	li $v0, 4
	la $a0, message2
	syscall
	li $v0, 1
	add $a0, $zero, $t2
	syscall
	li $v0, 4
	la $a0, message3
	syscall
	li $v0, 1
	add $a0, $zero, $t3
	syscall
quit:
	j done
end_main:

#---------------------------------------------------------------------- 
#Procedure MAXMIN
#---------------------------------------------------------------------- 

MAXMIN:
	add $t0, $s0, $zero
	li $t1, 1
	add $t2, $s0, $zero
	li $t3, 1
	sw $s0, 0($a0)
	sw $s1, 4($a0)
	sw $s2, 8($a0)
	sw $s3, 12($a0)
	sw $s4, 16($a0)
	sw $s5, 20($a0)
	sw $s6, 24($a0)
	sw $s7, 28($a0)
	li $t4, 7
	jr $ra

loop:
	beqz $t4, print
	add $t7, $t4, $t4
	add $t7, $t7, $t7
	add $a1, $a0, $t7
	lw $t6, 0($a1)
	jal max
	jal min
	addi $t4, $t4, -1
	j loop
max:
	slt $t5, $t0, $t6 #$t5 = 1 if $t6 > max
	beq $t5, $zero, ifnot
ifmax:
	add $t0, $zero, $t6
	addi $t1, $t4, 0
	jr $ra
	
min:
	slt $t5, $t6, $t2 #$t5 = 1 if $t6 < min
	beq $t5, $zero, ifnot
ifmin:
	add $t2, $zero, $t6
	addi $t3, $t4, 0
	jr $ra
ifnot:
	jr $ra
done:
	
	
