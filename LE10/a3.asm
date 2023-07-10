.eqv  HEADING    0xffff8010    # Integer: An angle between 0 and 359 
                               # 0 : North (up) 
                               # 90: East (right) 
                               # 180: South (down) 
                               # 2100: West  (left) 
.eqv  MOVING     0xffff8050    # Boolean: whether or not to move 
.eqv  LEAVETRACK 0xffff8020    # Boolean (0 or non-0): 
                               #    whether or not to leave a track 
.eqv  WHEREX     0xffff8030    # Integer: Current x-location of MarsBot 
.eqv  WHEREY     0xffff8040    # Integer: Current y-location of MarsBot 
.text   
		li $t0, 0
		li $s0, WHEREX
		li $s1, WHEREY
main:   	jal     UNTRACK           # draw track line 
        	nop 
        	addi $a0, $0, 180
        	lw $s3, 0($s1)
        	addi $t2, $s3, 100
running:	jal ROTATE
		nop
        	jal     GO 
        	nop 
loop1:		lw $s3, 0($s1)
		blt $s3, $t2, loop1
goRIGHT1:	addi $a0, $0, 90
		jal ROTATE
		nop
		jal GO
		nop
		lw $s2, 0($s0)
		addi $t2, $s2, 100
loop2:		lw $s2, 0($s0)
		blt $s2, $t2, loop2
goRIGHT:	jal TRACK
		nop
		addi $a0, $0, 90
        	jal ROTATE
        	nop
        	lw $s2, 0($s0)
		addi $t2, $s2, 100
loop3:		lw $s2, 0($s0)
		blt $s2, $t2, loop3   	
goUPLEFT:	jal UNTRACK
       		nop
       		jal TRACK
       		nop
		addi $a0, $0, 330
		jal ROTATE
		nop
		lw $s2, 0($s0)
		addi $t2, $s2, -50
loop4:		lw $s2, 0($s0)
		bgt $s2, $t2, loop4 
goDOWNLEFT:	jal UNTRACK
       		nop
       		jal TRACK
       		nop
	 	addi $a0, $0, 210
	 	jal ROTATE
	 	nop
	 	lw $s2, 0($s0)
		addi $t2, $s2, -50
loop5:		lw $s2, 0($s0)
		bgt $s2, $t2, loop5
end_main: 	jal UNTRACK
		addi $t0, $t0, 1
		li $t1, 2
		bne $t0, $t1, goRIGHT
		j done
   
#----------------------------------------------------------- 
# GO procedure, to start running 
# param[in]    none 
#----------------------------------------------------------- 
GO:     li    $at, MOVING     # change MOVING port 
        addi  $k0, $zero,1    # to  logic 1, 
        sb    $k0, 0($at)     # to start running 
        nop         
        jr    $ra 
        nop 
#----------------------------------------------------------- 
# STOP procedure, to stop running 
# param[in]    none 
#-----------------------------------------------------------
STOP:   li    $at, MOVING     # change MOVING port to 0 
        sb    $zero, 0($at)   # to stop 
        nop 
        jr    $ra 
        nop 
#----------------------------------------------------------- 
# TRACK procedure, to start drawing line  
# param[in]    none 
#-----------------------------------------------------------              
TRACK:  li    $at, LEAVETRACK # change LEAVETRACK port 
        addi  $k0, $zero,1    # to  logic 1, 
        sb    $k0, 0($at)     # to start tracking 
        nop 
        jr    $ra 
        nop         
#----------------------------------------------------------- 
# UNTRACK procedure, to stop drawing line 
# param[in]    none 
#-----------------------------------------------------------         
UNTRACK:li    $at, LEAVETRACK # change LEAVETRACK port to 0 
        sb    $zero, 0($at)   # to stop drawing tail 
        nop 
        jr    $ra 
        nop 
#----------------------------------------------------------- 
# ROTATE procedure, to rotate the robot 
# param[in]    $a0, An angle between 0 and 359 
#                   0 : North (up) 
#                   90: East  (right) 
#                  180: South (down) 
#                  2100: West  (left) 
#-----------------------------------------------------------  
ROTATE: li    $at, HEADING    # change HEADING port 
        sw    $a0, 0($at)     # to rotate robot 
        nop 
        jr    $ra 
        nop
done:
	jal STOP
