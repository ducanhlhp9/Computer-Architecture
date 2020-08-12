.data

A:  .word 1,2,3, -5,5

.text

addi $s1, $zero, 0

la $s2, A

addi $s3, $zero, 5
addi $s4, $zero, 1
addi $s5, $zero, 0
loop:
slt $t2, $s1, $s3
beq $t2, $zero, endloop
add $t1, $s1, $s1
add $t1, $t1, $t1
add $t1, $t1, $s2
lw $t0, 0($t1)
abs $t0, $t0
slt $t6, $s5, $t0
beq $t6, $zero, endif
add $s5, $zero, $t0
endif:
add $s1, $s1, $s4
j loop
endloop: