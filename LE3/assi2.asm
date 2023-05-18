#Laboratory 3, Home Assigment 2 
.data
A: .word 0, 0, 0, 0, 1
.text
	li $s4 1 #step = 1
	li $s3 5 #n = 5
	la $s2, A 
loop: 
 add $t1,$t1,$s2  #t1 store the address of A[i] 
 lw $t0,0($t1)  #load value of A[i] in $t0 
 add $s5,$s5,$t0  #sum=sum+A[i] 
 add $s1,$s1,$s4  #i=i+step 
 add $t1,$s1,$s1  #t1=2*s1 
 add $t1,$t1,$t1  #t1=4*s1  
 beq $t0,$zero,loop #if A[i]==0, goto loop 
