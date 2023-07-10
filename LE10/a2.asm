.eqv MONITOR_SCREEN 0x10010000   #Dia chi bat dau cua bo nho man hinh
.eqv RED            0x00FF0000   #Cac gia tri mau thuong su dung
.eqv GREEN          0x0000FF00
.eqv BLUE           0x000000FF
.eqv WHITE          0x00FFFFFF
.eqv YELLOW         0x00FFFF00
.eqv BLACK	     0x00000000
.text
main:
	li $k0, MONITOR_SCREEN      #Nap dia chi bat dau cua man hinh
 	li $t0, RED
 	li $t1, 0
 	addi $k0, $k0, 196
 	addi $k1, $k0, 0
	sw  $t0, 0($k0)
	nop
	li $s0, 5
	addi $v0, $0, 32
	li $a0, 500
	syscall
loop1:	li $t0, BLACK
	sw $t0, 0($k1)
	addi $t1, $t1, 1
	sll $t2, $t1, 2
	add $k1, $k0, $t2
	li $t0, RED
	sw $t0, 0($k1)
	nop 
	beq $t1, $s0, start_loop2
sleep1:	addi $v0, $0, 32
	li $a0, 500
	syscall
	j loop1
start_loop2:
	addi $v0, $0, 32
	li $a0, 500
	syscall
	li $t1, 0
	move $k0, $k1
	li $s0, -5
loop2:	li $t0, BLACK
	sw $t0, 0($k1)
	addi $t1, $t1, -1
	sll $t2, $t1, 5
	add $k1, $k0, $t2
	li $t0, RED
	sw $t0, 0($k1)
	nop 
	beq $t1, $s0, start_loop3
sleep2:	addi $v0, $0, 32
	li $a0, 500
	syscall
	j loop2
start_loop3:
	addi $v0, $0, 32
	li $a0, 500
	syscall
	li $t1, 0
	move $k0, $k1
	li $s0, -5
loop3:	li $t0, BLACK
	sw $t0, 0($k1)
	addi $t1, $t1, -1
	sll $t2, $t1, 2
	add $k1, $k0, $t2
	li $t0, RED
	sw $t0, 0($k1)
	nop 
	beq $t1, $s0, start_loop4
sleep3:	addi $v0, $0, 32
	li $a0, 500
	syscall
	j loop3
start_loop4:
	addi $v0, $0, 32
	li $a0, 500
	syscall
	li $t1, 0
	move $k0, $k1
	li $s0, 5
loop4:	li $t0, BLACK
	sw $t0, 0($k1)
	addi $t1, $t1, 1
	sll $t2, $t1, 5
	add $k1, $k0, $t2
	li $t0, RED
	sw $t0, 0($k1)
	nop 
	beq $t1, $s0, main
sleep4:	addi $v0, $0, 32
	li $a0, 500
	syscall
	j loop4