.data
	endereco_base: .word 0x10043f00	#Ultima linha e primeira coluna do bitmap
	interacao_x: .asciz "Digite o valor da coordenada x:"
	interacao_y: .asciz "Digite o valor da coordenada y:"

.text
	li a7, 4
	la a0, interacao_x
	ecall
	
	li a7, 5	#Le um numero inteiro
	ecall
	
	add t0, a0, x0	#Armazena o x em t0
	
	li a7, 4
	la a0, interacao_y
	ecall
	
	li a7, 5	#Le um numero inteiro
	ecall
	
	add t1, a0, x0	#Armazena o y em t1
	
	li a7, 1
	la a0, endereco_base
	ecall