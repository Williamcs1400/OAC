.data
	endereco_base: .word 0x10043f00	#Ultima linha e primeira coluna do bitmap
	interacao_x: .asciz "Escreva o valor de x: "
	interacao_y: .asciz "Escreva o valor de y: "

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
	addi t2, x0, 256	#t2 = 256
	mul t1, t1, t2	#Multiplica o valor de y por 256
	
	addi t2, x0, -1	#t2 = -1
	mul t1, t1, t2	#Faz o valor de y ficar negativo
	
	lw t3, endereco_base	#t3 = endereco_base
	add t3, t3, t0	#t3 += t0
	add t3, t3, t1
	
	#Instrucoes para mostrar no bitmap
	li t0, 0x00ff0000
	sw t0, 0(t3)
