.text
main:
	li $s0, 2 		#load value into register $s0->$s7
	li $s1, 3
	li $s2, 4
	li $s3, 10
	li $s4, -10
	li $s5, -100
	li $s6, 5
	li $s7, 9

	li $t1,1		# load default value to register $t1
	li $t2,1
	li $t3,1
	jal init		# jump to init
	nop
	li $t4,9		
	sub $a0,$t4,$t2		# a0= t4-t2
	sub $a1,$t4,$t3		# a1 = t4-t3
	j end
	nop
endmain:
init:
	add $v0,$s7,$zero
	add $v1,$s7,$zero
push:				# push into stack
	addi $sp,$sp,-32	
	sw $s0,28($sp)		# put turn value of $s0->$ s7 into stack
	sw $s1,24($sp)
	sw $s2,20($sp)
	sw $s3,16($sp)
	sw $s4,12($sp)
	sw $s5,8($sp)
	sw $s6,4($sp)
	sw $s7,0($sp)
pop:				# pop out of stack
	addi $sp,$sp,4
	lw $a1,0($sp)
	addi $t1,$t1,1		# loop for
	sub $t0,$a1,$v0		# t1 = a1-v0
	bltz $t0,pare1		# branch if less than zero(if  t1 <0)
	nop
	add $v0,$a1,$zero	
	add $t2,$t1,$zero
pare1:
	sub $t0,$a1,$v1		# continue compare
	bgtz $t0,pare2
	nop
	add $v1,$a1,$zero
	add $t3,$t1,$zero
pare2:
	bne $a1,$s0,pop		# branch if not equal
	nop
done:
	jr $ra
				# Largest: $v0,$a0
				# Smallest: $v1,$a1
end:
