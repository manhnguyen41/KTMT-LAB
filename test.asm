.data
a: .word 
.text
    lui $t0, 0x1234
    ori $t0, $t0, 0x5678
    la  $t1, a
    sw $t0, 0($t1)