.data
input: .asciiz "Nhap n: "
input2: .asciiz "Nhap gioi han duoi m= "
input3: .asciiz "Nhap gioi han tren M= "
Open: .asciiz "[ "
Close: .asciiz " ] = "
output: .asciiz "\nMang da nhap: "
output2: .asciiz "\nMax="
output3: .asciiz "\nCount = "
array: .word 0:100 # int array[100]

.text
main:
# nhap n
	la $a0, input
	addi $v0, $0, 4
	syscall
	addi $v0, $0, 5
	syscall
	addi $s0, $v0, 0 # $s0 = n
	
	la $a0, input2
	addi $v0, $0, 4
	syscall
	addi $v0, $0, 5
	syscall
	addi $s1, $v0, 0 # $s1 = m
	
	la $a0, input3
	addi $v0, $0, 4
	syscall
	addi $v0, $0, 5
	syscall
	addi $s2, $v0, 0 # $s2 = M
	addi $t6,$zero,0
	jal NhapMang
	jal XuatMang
	jal Max
	jal Count_Element
	addi $v0, $0, 10
	syscall
end_main:
NhapMang:
# khoi tao
	addi $t1, $zero, 0 # $t1 = 0
	la $a1, array # $a1 = &array
	NhapPhanTu:
		# kiem tra so lan lap
		slt $t2, $t1, $s0
		beq $t2, $zero, KetThucNhap

		# xuat dau nhac nhap
		la $a0, Open
		addi $v0, $zero, 4
		syscall

		addi $a0, $t1, 0
		addi $v0, $zero, 1
		syscall

		la $a0, Close
		addi $v0, $zero, 4
		syscall

		# nhap so nguyen va luu vao array[i]
		addi $v0, $zero, 5
		syscall
		sw $v0, ($a1)
		lw $s6,($a1)
		slt $t2,$s6,$s1
		beq $t2,$zero,Max1			  
		# tang chi so
		addi $t1, $t1, 1
		addi $a1, $a1, 4

		j NhapPhanTu

KetThucNhap:	jr $ra
Max1:
	slt $t2,$s6,$s2
	bne $t2,$zero,cou
	addi $t1, $t1, 1
	addi $a1, $a1, 4
	j NhapPhanTu
cou:
	addi $t6,$t6,1	
	addi $t1, $t1, 1
	addi $a1, $a1, 4
	j NhapPhanTu
# Xuat
XuatMang:
	la $a0, output
	addi $v0, $zero, 4
	syscall
	la $a1, array
	addi $t1, $0, 0

XuatPhanTu:
	# kiem tra so lan lap
	slt $t2, $t1, $s0
	beq $t2, $0, Exit

	# xuat phan tu array[i]
	lw $a0, ($a1)
	addi $v0, $zero, 1
	syscall

	# xuat khoang trang
	addi $a0, $0, 0x20
	addi $v0, $0, 11
	syscall

	# tang i
	addi $t1, $t1, 1
	addi $a1, $a1, 4

	j XuatPhanTu
Exit: jr $ra

Max: # $t0 luu so luong phan tu
     #$t1 chi so index
     #$a1 dia chi co so
     # kiem tra so lan lap
     la $a1, array # $a1 = &array
     lw $a0, ($a1)
     addi $t7,$zero,0
     addi $t3,$a0,0 #max = arrayaa
   
     	search_max:
	slt $t2, $t7, $s0
	beq $t2, $zero, end_search_max
	lw $a0, ($a1)
	slt $t2,$a0,$t3
	bne $t2,$zero,continue
	add $t3,$a0,$zero
	addi $t7, $t7, 1
	addi $a1, $a1, 4
	j search_max
	continue:
	   addi $t7, $t7, 1
	   addi $a1, $a1, 4
	   j search_max
	end_search_max:
		
end_Max:	la $a0, output2
		addi $v0, $0, 4
		syscall
		addi $a0,$t3,0
		addi $v0, $zero, 1
	        syscall
		jr $ra
Count_Element:
	addi $t4,$0,0  #khoi tao count = 0
	addi $t2,$s2,1
	sub $t4,$t2,$s1
	la $a0, output3
	addi $v0, $0, 4
	syscall
	addi $a0,$t6,0
	addi $v0, $zero, 1
	syscall
        jr $ra
 end_Count:
	
