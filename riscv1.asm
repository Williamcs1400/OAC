.data
	endereco_base: .word 0x10043f00	#Ultima linha e primeira coluna do bitmap
	interacao_x: .asciz "Escreva o valor de x"
	interacao_y: .asciz "Escreva o valor de y"

.text
	#Printa para o usuario inserir x
	li a7, 4
	la a0, interacao_x
	ecall
	
	#Le um numero inteiro
	li a7, 5	
	ecall
	
	add t0, a0, x0	#Salva o valor de x em t0
	
	#Printa para o usuario inserir y
	li a7, 4
	la a0, interacao_y
	ecall
	
	#Le um numero inteiro
	li a7, 5	
	ecall
	
	add t1, a0, x0	#Salva o valor de y em t1
	
	addi t2, x0, 4	#t2 = 4
	mul t0, t0, t2	#Multiplica o valor de x por 4
	mul t1, t1, t2	#Multiplica o valor de y por 4
		
	addi t2, x0, -1	#t2 = -1
	mul t1, t1, t2	#Faz o valor de y ficar negativo
	
	la t3, endereco_base	
	lw t3, 0(t0)	#t3 = 0x10043f00
	
	add t3, t3, t1
	
	
	li a7, 1
	la a0, endereco_base
	ecall