.eqv SEVENSEG_LEFT    0xFFFF0011 # Dia chi cua den led 7 doan trai. 
                                    #     Bit 0 = doan a;  
                                    #     Bit 1 = doan b; ...  
                                    #     Bit 7 = dau . 
.eqv SEVENSEG_RIGHT   0xFFFF0010 # Dia chi cua den led 7 doan phai 
.data
A: .word 0x3F, 0x06, 0x5B, 0x4F, 0x66, 0x6D, 0x7D, 0x07, 0x7F, 0x6F
.text 
main: 	  li $s1, 0 #i = 0
          la $s0, A 
          li $s3, 10
loop:     sll $s5, $s1, 2
	  add $s6, $s0, $s5
	  lw $a0, 0($s6)
	  jal SHOW_7SEG_LEFT
	  nop
	  beq $s1, $s3, main
	  addi $s1, $s1, 1
sleep:    addi $v0, $0, 32
          li $a0, 1000
          syscall
          j loop
exit:     li    $v0, 10 
          syscall 
endmain: 
 
#--------------------------------------------------------------- 
# Function  SHOW_7SEG_LEFT : turn on/off the 7seg 
# param[in]  $a0   value to shown        
# remark     $t0 changed 
#--------------------------------------------------------------- 
SHOW_7SEG_LEFT:  li   $t0,  SEVENSEG_LEFT # assign port's address  
                 sb   $a0,  0($t0)        # assign new value   
                 nop 
                 jr   $ra 
                 nop 
                  
#--------------------------------------------------------------- 
# Function  SHOW_7SEG_RIGHT : turn on/off the 7seg 
# param[in]  $a0   value to shown        
# remark     $t0 changed 
#--------------------------------------------------------------- 
SHOW_7SEG_RIGHT: li   $t0,  SEVENSEG_RIGHT # assign port's address 
                 sb   $a0,  0($t0)         # assign new value  
                 nop 
                 jr   $ra
                 nop
