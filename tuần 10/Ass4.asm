.eqv KEY_CODE 		0xFFFF0004 		# ASCII code from keyboard, 1 byte
.eqv KEY_READY 		0xFFFF0000 		# =1 if has a new keycode ?
# Auto clear after lw
.eqv DISPLAY_CODE	0xFFFF000C 		# ASCII code to show, 1 byte
.eqv DISPLAY_READY 	0xFFFF0008 		# =1 if the display has already to do
# Auto clear after sw
.eqv e_Char	0x65
.eqv x_Char 	0x78
.eqv i_Char	0x69
.eqv t_Char	0x74

.text
		li $k0, KEY_CODE
		li $k1, KEY_READY
		li $s0, DISPLAY_CODE
		li $s1, DISPLAY_READY
loop: 		nop

WaitForKey: 	lw $t1, 0($k1) 			# $t1 = [$k1] = KEY_READY
		beq $t1, $zero, WaitForKey 	# if $t1 == 0 then Polling
ReadKey: 	lw $t0, 0($k0) 			# $t0 = [$k0] = KEY_CODE
		j checkE
WaitForDis: 	lw $t2, 0($s1) 			# $t2 = [$s1] = DISPLAY_READY
		beq $t2, $zero, WaitForDis 	# if $t2 == 0 then Polling
ShowKey: 	sw $t0, 0($s0) 			# show key
		nop
		j loop
checkE: 	beq $t3, e_Char, checkX		# check if exist e in queue, checkX
		bne $t0, e_Char, WaitForDis	# if current char is not e, continue
		add $t3, $t0, $zero		# save 'e' to $t3
		j WaitForDis
checkX: 	beq $t4, x_Char, checkI		# check if exist x in queue, checkI
		bne $t0, x_Char, reset		# if current char is not x, reset then continue
		add $t4, $t0, $zero		# save 'x' to $t4
		j WaitForDis
checkI:		beq $t5, i_Char, checkT		# check if exist i in queue, checkT
		bne $t0, i_Char, reset		# if current char is not i, reset then continue
		add $t5, $t0, $zero		# save 'i' to $t5
		j WaitForDis
checkT:		beq $t0, t_Char, terminate	# check if meet t, terminate (exit word complete)
		j reset				# if current char is not t, reset then continue
reset:		li $t3, 0			# set 'e' to unspecified
		li $t4, 0			# set 'x' to unspecified
		li $t5, 0			# set 'i' to unspecified
		j WaitForDis
terminate:	li $v0, 10
		syscall
		
		
		
