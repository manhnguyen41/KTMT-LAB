.data
variable: .space 1000
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
	
check_word: # check xem $t1 co phai la ki tu trong bang chu cai khong, $t2 bang 1 neu phai va bang 0 neu khong phai
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
	
check_digit: # check xem $t1 co phai so hay khong, $t3 bang 1 neu phai va bang 0 neu khong phai
	slti $t3, $t1, 48 #$t3 = 1 if $t1 < 48
	not $t3, $t3 #$t3 = 1 if $t1 >= 48
	slti $t4, $t1, 58 #$t4 = 1 if $t1 <= 57
	and $t3, $t3, $t4 #$t3 = 1 if $t3 == 1 and $t4 == 1
	andi $t3, $t3, 0x00000001
	
	jr $ra
	
check_under: # check xem $t1 co phai _ hay khong, $t4 bang 1 neu phai va bang 0 neu khong phai
	li $t7, 95
	beq $t1, $t7, under #if $t1 == 95 then go to under
	li $t4, 0
	
	jr $ra
	
under: # gan $t4 bang 1 
	li $t4, 1
	
	jr $ra
	
check_end: # check xem $t1 co phai ki tu ket thuc xau hay khong, $t6 bang 1 neu phai va bang 0 neu khong phai
	li $t7, 10
	beq $t1, $t7, end #if $t1 == 95 then go to end
	li $t6, 0
	
	jr $ra
	
end: # gan $t6 bang 1
	li $t6, 1
	
	jr $ra
				
check_first_char: # check ki tu dau tien, neu no la so thi ket qua cua chuong trinh la false
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
	
check_char: # vong lap check tung ki tu mot, neu ki tu khong hop le thi ket qua cua chuong trinh la false
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
	
check_false1: # check xem ki tu co phai la so hay khong
	or $s7, $t3, $t4
	beq $s7, $zero, not_false
	li $t8, 0
	
	jr $ra
	
check_false: # check xem ki tu co hop le hay khong

	bne $t5, $zero, not_false
	li $t8, 0
	jr $ra
	
not_false:

	jr $ra
	
end_proc: # xoa dau xuong dong cuoi xau
	li $s1, 0
	sb $s1, 0($a0)
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