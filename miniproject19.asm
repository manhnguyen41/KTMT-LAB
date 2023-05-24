.data
variable: .space 100
message: .asciiz "Input some variable names:"
message1: .asciiz "variableName("
message2: .asciiz ") = false\n"
message3: .asciiz ") = true\n"

.text
input_variable_name: # Nhap ten bien can check
	addi $t8, $zero, 1
	li $v0, 54
	la $a0, message
	la $a1, variable
	la $a2, 100
	syscall
	j check_first_char
	
check_word:
	slti $t2, $t1, 65 #$t2 = 1 if $t1 < 65
	not $t2, $t2 #$t2 = 1 if $t1 >= 65
	slti $t3, $t1, 91 #$t3 = 1 if $t1 <= 90
	and $t2, $t2, $t3 #$t2 = 1 if $t2 == 1 and $t3 == 1
	andi $t2, $t2, 0x00000001
	
	slti $t4, $t1, 97 #$t4 = 1 if $t1 < 97
	not $t4, $t4 #$t4 = 1 if $t1 >= 97
	slti $t5, $t1, 123 #$t5 = 1 if $t1 <= 122
	and $t4, $t4, $t5 #$t4 = 1 if $t4 == 1 and $t5 == 1
	andi $t4, $t4, 0x00000001
	
	or $t2, $t2, $t4 #$t2 = 1 if $t2 == 1 or $t4 == 1
	
	jr $ra
	
check_digit:
	slti $t3, $t1, 48 #$t3 = 1 if $t1 < 48
	not $t3, $t3 #$t3 = 1 if $t1 >= 48
	slti $t4, $t1, 58 #$t4 = 1 if $t1 <= 57
	and $t3, $t3, $t4 #$t3 = 1 if $t3 == 1 and $t4 == 1
	andi $t3, $t3, 0x00000001
	
	jr $ra
	
check_under:
	li $t7, 95
	beq $t1, $t7, under #if $t1 == 95 then go to under
	li $t4, 0
	
	jr $ra
	
under:
	li $t4, 1
	
	jr $ra
	
check_end:
	li $t7, 10
	beq $t1, $t7, end #if $t1 == 95 then go to end
	li $t6, 0
	
	jr $ra
	
end:
	li $t6, 1
	
	jr $ra
				
check_first_char:
	la $a0, variable
	lb $t1, 0($a0)
	jal check_end
	bne $t6, $zero, false
	jal check_word
	jal check_digit
	jal check_under
	jal check_false1
	or $t5, $t2, $t4 #$t5 = 1 if $t2 == 1 or $t4 == 1
	jal check_false
	
check_char:
	addi $a0, $a0, 1
	
	lb $t1, 0($a0)
	jal check_end
	bne $t6, $zero, end_proc
	jal check_word
	jal check_digit
	jal check_under
	or $t5, $t2, $t3 #$t5 = 1 if $t2 == 1 or $t3 == 1
	or $t5, $t4, $t5 #$t5 = 1 if $t2 == 1 or $t3 == 1 or $t4 == 1
	jal check_false
	
	j check_char
	
check_false1:
	beq $t3, $zero, not_false
	add $t8, $zero, $t3
	
	jr $ra
	
check_false:

	bne $t5, $zero, not_false
	add $t8, $zero, $t5
	
	jr $ra
	
not_false:

	jr $ra
	
end_proc:
	li $s1, 0
	sb $t0, 0($a0)
	bne $t8, $zero, true
	j false
	
true:
	li $v0, 4
	la $a0, message1
	syscall
	li $v0, 4
	la $a0, variable
	syscall
	li $v0, 4
	la $a0, message3
	syscall
	
	j done

false:
	li $v0, 4
	la $a0, message1
	syscall
	li $v0, 4
	la $a0, variable
	syscall
	li $v0, 4
	la $a0, message2
	syscall
done:
