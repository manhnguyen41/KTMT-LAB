.data 
	m1: .asciiz "i\tPower(2,i)\tSquare(i)\tHexadecimal(i)\n"	# Chuỗi thông điệp cho bảng
	tab: .asciiz "\t"		# Chuỗi ký tự tab
	overflow: .asciiz "overflow"		# Chuỗi thông báo tràn số
	A: .asciiz "A"
	B: .asciiz "B"
	C: .asciiz "C"
	D: .asciiz "D"
	E: .asciiz "E"
	F: .asciiz "F"
.text
main:	
	li $s4, 1		# Gán giá trị 1 vào thanh ghi $s4 (1 bit dùng để tính pow)
	
	la $a0, m1		# Địa chỉ của chuỗi thông điệp cho bảng
	li $v0, 4	
	syscall 
 
	jal Calculator		# Gọi hàm Calculator để thực hiện tính toán và in bảng
exit:
	li	$v0, 10	
	syscall	
	
Calculator:
	move $s1, $ra		# Sao chép giá trị con trỏ lưu trạng thái của hàm gọi trước đó (trả về địa chỉ của hàm gọi)
	li   $v0, 5		# Đặt $v0 = 5 để đọc một số từ người dùng
  	syscall   
  	
  	move $s2, $v0 		# Lưu giá trị số nguyên đọc được vào thanh ghi $s2
  	
  	move $a0, $s2			# In giá trị i
	li $v0, 1
	syscall 
	la $a0, tab
	li $v0, 4
	syscall 
	
	jal power		# Gọi hàm power để tính pow(2,i)
	la $a0, tab
	li $v0, 4
	syscall
	
	jal square		# Gọi hàm square để tính bình phương của i
	la $a0, tab
	li $v0, 4
	syscall	
	
	jal hex			# Gọi hàm hex để in giá trị i dưới dạng số hệ thập lục phân
	
	li $a0, 10		# In ký tự xuống dòng
	li $v0, 11
	syscall
	j Calculator		# Quay lại vòng lặp của hàm Calculator
Calculator_end:
	move $ra, $s1		# Sao chép giá trị con trỏ lưu trạng thái của hàm gọi trước đó (trả về địa chỉ của hàm gọi)
	jr $ra			# Trả về địa chỉ của hàm gọi

# Tính pow(2,i)
power:
	bltz $s2, powerO	# Nếu i<0, nhảy đến nhãn powerO xử lý tràn số
	move $t1, $s2
power_loop:
	bltz $s4, powerO	# Xử lý tràn số
    	beqz $t1, power_done   	# Nếu i == 0, thoát khỏi vòng lặp
    	sll $s4, $s4, 1        	# Dịch trái kết quả của pow(2, i) (nhân cho 2)
    	subi $t1, $t1, 1      	# Giảm giá trị của biến đếm i
    	j power_loop  
    	
power_done:
	move $a0, $s4		# In giá trị của pow(2,i)
	li $v0, 1
	syscall 
	j power_end
powerO:
	la $a0, overflow	# In thông báo tràn số
	li $v0, 4
	syscall	
power_end:
	li $s4, 1		# Đặt lại giá trị ban đầu của $s4
	jr $ra			# Trả về địa chỉ của hàm gọi
	
# Tính bình phương
square:	
	move $t1, $s2			# Sao chép giá trị của i vào $t1
	bgtz $t1, square_cal		# Kiểm tra nếu i<0, gán t1 = 0 - i
	sub $t1, $zero, $t1
square_cal:
	mul $s3, $t1, $t1		# Tính bình phương của i
	bltz $s3, squareO		# Xử lý tràn số
	move $a0, $s3			# In giá trị bình phương của i
	li $v0, 1
	syscall 
	j square_end
squareO:
	la $a0, overflow		# In thông báo tràn số
	li $v0, 4
	syscall	
square_end:
    	jr $ra			# Trả về địa chỉ của hàm gọi
    	
# Chuyển đổi thành số hệ thập lục phân
hex:
	move $t0, $s2
hex_loop:
	andi $t2, $t0, 0xf0000000
	srl $t2, $t2, 28
	slti $t3, $t2, 10
	beq $t3, $zero, hex_greater_than_9
	li $v0, 1
	move $a0, $t2
	syscall
	sll $t0, $t0, 4
	beq $t0, $zero, hex_end
	j hex_loop
hex_greater_than_9:
	li $t4, 0xa
	li $v0, 4
	beq $t2, $t4, caseA
	li $t4, 0xb
	li $v0, 4
	beq $t2, $t4, caseB
	li $t4, 0xc
	li $v0, 4
	beq $t2, $t4, caseC
	li $t4, 0xd
	li $v0, 4
	beq $t2, $t4, caseD
	li $t4, 0xe
	li $v0, 4
	beq $t2, $t4, caseE
	li $t4, 0xf
	li $v0, 4
	beq $t2, $t4, caseF
caseA:
	la $a0, A
	syscall
	sll $t0, $t0, 4
	beq $t0, $zero, hex_end
	j hex_loop
caseB:
	la $a0, B
	syscall
	sll $t0, $t0, 4
	beq $t0, $zero, hex_end
	j hex_loop
caseC:
	la $a0, C
	syscall
	sll $t0, $t0, 4
	beq $t0, $zero, hex_end
	j hex_loop
caseD:
	la $a0, D
	syscall
	sll $t0, $t0, 4
	beq $t0, $zero, hex_end
	j hex_loop
caseE:
	la $a0, E
	syscall
	sll $t0, $t0, 4
	beq $t0, $zero, hex_end
	j hex_loop
caseF:
	la $a0, F
	syscall
	sll $t0, $t0, 4
	beq $t0, $zero, hex_end
	j hex_loop
hex_end:
	jr $ra			# Trả về địa chỉ của hàm gọi
