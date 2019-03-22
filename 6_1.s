#Normalization

.data

num1: .word 0, 513, 0 



.text
.globl main
.ent main
main:

la $t1, num1 	#address of num1

li $t2, 2    	#index of access of fraction
add $t2, $t2, $t2    # double the index
add $t2, $t2, $t2    # double the index again (now 4x)
add $t3, $t2, $t1
lw $t4, 0($t3)

li $s2, 1    	#index of access of integer
add $s2, $s2, $s2    # double the index 
add $s2, $s2, $s2    # double the index again (now 4x)
add $s3, $s2, $t1
lw $s4, 0($s3)

li $t0, 0
li $s0, 1
sll $s0, $s0, 31

loop:

beq $s4, 1, end_loop

andi $s7, $s4, 1
srl $s4, $s4, 1
srl $t4, $t4, 1
addi, $t0, $t0, 1

bgtz $s7, go

j loop

go:
add $t4, $t4, $s0

j loop


end_loop:

sw $t0, 0($s3)
sw $t4, 0($t3)



li $v0, 10
syscall

.end main
