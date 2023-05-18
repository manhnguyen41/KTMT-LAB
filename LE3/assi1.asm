#Laboratory Exercise 3, Home Assignment 1 
.text        
     	li    $s1, 1
     	li    $s2, 1
start: 
 slt $t0,$s1,$s2  # i<j
 beq $t0,$zero,else # branch to else if j>=i  
 addi $t1,$t1,1  #  then part: x=x+1 
 addi $t3,$zero,1  # z=1 
 j endif   # skip “else” part 
else: addi $t2,$t2,-1  # begin else part: y=y-1 
 add $t3,$t3,$t3  # z=2*z 
endif: 
