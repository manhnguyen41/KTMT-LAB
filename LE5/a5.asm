#Laboratory Exercise 5, Assignment 5
.data 
	string: .space   50
	rstring: .space 50
	Message1: .asciiz "Input a string: ” 
	Message2: .asciiz "Reverse string: " 
.text 
main: 
get_string:   
	li $v0, 54
	la $a0, Message1
	la $a1, string
	li $a2, 50
	syscall     
get_length:   
	la $s0, string # s0 = Address(string[0]) 
check_char:   
	add $t0, $s0, $t1 # t0 = s0 + t1  
	#= Address(string[0]+i)  
	lb   $t2, 0($t0) # t2 = string[i] 
	beq  $t2, $zero, end_of_str # Is null char?        
	addi $t1, $t1, 1 # t0=t0+1->i = i + 1 
	j check_char 
end_of_str:                              
end_of_get_length: 
get_reverse_string:
	la $s1, rstring # s1 = Address(rstring[0])
	subi $t1, $t1, 1 # i = i - 1
	add $t0, $s0, $t1 # t0 = s0 + t1
	# = Address(string[0] + i)
	lb $t2, 0($t0) # t2 = string[i]
	add $t3, $s1, $t4 # t3 = s1 + t4
	# = Address(rstring[0] + j)
	sb $t2, 0($t3) # s1 = rstring[j] = t2 = string[length-1-j])
	addi $t4, $t4, 1 # j = j + 1
	bne $t1, $zero, get_reverse_string # Is copy string[0] ?
print_reverse_string:
	li $v0, 59
	la $a0, Message2
	la $a1, rstring
	syscall
	