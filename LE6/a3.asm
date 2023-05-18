.data
	A: .word 7, -2, 5, 1, 5, 6, 7, 3, 6, 8, 8, 59, 5
	Aend: .word
.text
main:
	la $a0, A #a0 = Address(A[0])
	la $a1, Aend 
	addi $a1, $a1, -4 #a1 = Address(A[n-1]) 
sort:
	beq $a0, $a1, done #single element list is sorted 
bubble:
	addi $v0, $a0, 0 #init A[j] pointer
	lw $v1, 0($v0) #init A[j]
	addi $t0, $a0, 4 #init A[j + 1] pointer
	lw $t1, 0($t0) #init A[j + 1]
loop:
	lw $v1, 0($v0) #A[j]
	lw $t1, 0($t0) #A[j + 1]
	slt $t2, $t1, $v1 #t2 = 1 if A[j + 1] < A[j]
	bne $t2, $zero, swap #if A[j + 1] < A[j] then swap
	addi $v0, $v0, 4 #next A[j] pointer
	beq $v0, $a1, end_loop #if A[j] = A[n - 1] then end loop
	addi $t0, $t0, 4 #nex A[j + 1] pointer
	j loop
swap:
	sw $v1, 0($t0) #A[j + 1] = A[j]
	sw $t1, 0($v0) #A[j] = A[j + 1]
	j loop
end_loop:
	addi $a1, $a1, -4 #n = n - 1
	j sort
done:

	 
	

	
