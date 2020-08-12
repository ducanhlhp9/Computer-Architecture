.data
string: 		.space 50
Message1:	.asciiz "nhap xau "
Message2:	.asciiz "do dai xau la "
.text
main:
get_string:	
	li $v0, 54
	la $a0, Message1
	la $a1, string
	li $a2, 22
	syscall
get_length:
	la $a0, string
	add $t0, $zero, $zero
check_char:
	add $t1, $a0, $t0
	lb $t2, 0($t1)
	beq $t2, $zero, end_of_str
	addi $t0, $t0,1
	j check_char
end_of_str:
end_of_get_length:
print_length:
	li $v0, 56
	la $a0, Message2
	add $a1, $t0,-1
	syscall
	