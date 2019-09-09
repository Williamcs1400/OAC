.data
	menu:	.asciz "\nDigite a opcao desejada:\n	1. Obtem ponto\n	2. Desenha ponto\n	3.Desenha retângulo com preenchimento\n	4.Desenha retângulo sem preenchimento\n	5.Converte para negativo da imagem\n	6.Converte imagem para tons de vermelho\n	7.Carrega imagem\n	8.Encerra\n"
	cor_base: .word 0x00000000	#Para inserir a cor desejada pelo o usuario
	endereco_base: .word 0x10043f00	#Ultima linha e primeira coluna do bitmap
	interacao_x: .asciz "Escreva o valor de x: "
	interacao_y: .asciz "Escreva o valor de y: "
	interacao_x1: .asciz "Escreva o valor de x1: "
	interacao_y1: .asciz "Escreva o valor de y1: "
	interacao_x2: .asciz "Escreva o valor de x2: " 
	interacao_y2: .asciz "Escreva o valor de y2: "
	
	interacao_r: .asciz "Escreva um valor entre 0 e 255 para Red: "
	interacao_g: .asciz "Escreva um valor entre 0 e 255 para Gree: "
	interacao_b: .asciz "Escreva um valor entre 0 e 255 para Blue: "
.text
INICIO:
	#Mostra menu no console
	li a7, 4
	la a0, menu
	ecall
	
	#Le a operacao desejada
	li a7, 5
	ecall
	
	#Testando se eh igual a 1
	addi t0, x0, 1	#t0 = 1
	beq a0, t0, OBTEMPONTOCOMECO	#if(a0 == 1) PC = OBTEMPONTO
	
	#Testando se eh igual a 2
	addi t0, x0, 2
	beq a0, t0, DESENHAPONTOCOMECO	#if(a0 == 2) PC = DESENHAPONTO
	
	#Testando se eh igual a 3
	addi t0, x0, 3
	beq a0, t0, REGANTULOFULL	#if(a0 == 3) PC = RETANGULOFULL
	
	#Testando se eh igual a 8
	addi t0, x0, 8
	beq a0, t0, ENCERRA #if(a0 == 8) Encerra o programa
	
##################################################################

OBTEMPONTOCOMECO: 
	jal ra, LE_X_Y_SIMPLES	#ra = PC, PC = LE_X_Y_SIMPLES
	
	#Operacoes aritmeticas para mostrar no bitmap
	addi t2, x0, 4	#t2 = 4
	mul t0, t0, t2	#Multiplica o valor de x por 4
	addi t2, x0, 256#t2 = 256
	mul t1, t1, t2	#Multiplica o valor de y por 256
	
	addi t2, x0, -1	#t2 = -1
	mul t1, t1, t2	#Faz o valor de y ficar negativo
	
	lw t3, endereco_base	#t3 = endereco_base
	add t3, t3, t0	#t3 += t0 ou x
	add t3, t3, t1	#t3 -= t1 ou y
	
	lw s0, 0(t3)	#Le a cor da posicao do endereco de t3
	
	#Instrucoes para imprimir o valor rgb na tela
	li a7, 1
	add a0, x0, s0
	ecall
	
	beq x0, x0, INICIO	#Volta para o menu incial

##################################################################

DESENHAPONTOCOMECO:

	jal ra, LE_X_Y_SIMPLES	#ra = PC, PC = LE_X_Y_SIMPLES
	
	jal ra, LE_RGB	#ra = PC, PC = LE_RGB
	
	jal ra, DESENHAPONTO	#Para saber que eh pra voltar para o menu
	
	beq x0, x0, INICIO	#Volta para o menu incial
	
DESENHAPONTO:	#Para quando nao precisar ler as informacoes acima

	#Operacoes aritmeticas para mostrar no bitmap
	addi t2, x0, 4	#t2 = 4
	mul t0, t0, t2	#Multiplica o valor de x por 4
	addi t2, x0, 256#t2 = 256
	mul t1, t1, t2	#Multiplica o valor de y por 256
	
	addi t2, x0, -1	#t2 = -1
	mul t1, t1, t2	#Faz o valor de y ficar negativo
	
	lw t3, endereco_base	#t3 = endereco_base
	add t3, t3, t0	#t3 += t0 ou x
	add t3, t3, t1	#t3 -= t1 ou y
	
	#Instrucao para mostrar no bitmap
	sw s0, 0(t3)
	
	jr ra	#Retorna para a funcao que a chamou

##################################################################

REGANTULOFULL:

	jal ra, LE_X_Y_COMPOSTO	#ra = PC, PC = LE_X_Y_COMPOSTO
	
	jal ra, LE_RGB	#ra = PC, PC = LE_RGB
	
	add s11, x0, t0	#Salva o valor incial de x1
	
LOOP_RET_FULL:
	
	jal ra, DESENHAPONTO	#ra = PC, PC = DESENHAPONTO
	addi t0, t0, 1
	blt t0, s11, LOOP_RET_FULL
	
	
##################################################################	

LE_X_Y_SIMPLES:	#Le as cordenadas X e Y 
	
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
	
	jr ra	#Retorna para a funcao que a chamou
	
##################################################################
	
LE_X_Y_COMPOSTO:
	
	#Printa para o usuario inserir x1
	li a7, 4
	la a0, interacao_x1
	ecall
	
	#Le um numero inteiro e salva em t0
	li a7, 5
	ecall
	add t0, a0, x0
	
	#Printa para o usuario inserir y1
	li a7, 4
	la a0, interacao_y1
	ecall
	
	#Le um numero inteiro e salva em t1
	li a7, 5
	ecall
	add t1, a0, x0
	
	#Printa para o usuario inserir x2
	li a7, 4
	la a0, interacao_x2
	ecall
	
	#Le um numero inteiro e salva em s0
	li a7, 5
	ecall
	add s10, a0, x0
	
	#Printa para o usuario inserir y2
	li a7, 4
	la a0, interacao_y2
	ecall
	
	#Le um numero inteiro e salva em s1
	li a7, 5
	ecall
	add s1, a0, x0
	
	jr ra	#Retorna para a funcao que a chamou
	
##################################################################

LE_RGB:	#Le 3 numeros de 0 a 255 para e retorna uma cor RGB
	
	lw t3, cor_base	#t3 = cor_base
	
	li a7, 4
	la a0, interacao_r
	ecall
	
	li a7, 5
	ecall
	
	add t4, a0, x0	#t4 = valor de red
	slli t4, t4, 16	#Desloca o valor de t4 16 bits para a esquerda
	add t3, t3, t4	#t3 += t4
	
	li a7, 4
	la a0, interacao_g
	ecall
	
	li a7, 5
	ecall
	
	add t5, a0, x0	#t5 = valor de gree
	slli t5, t5, 8	#Desloca o valor de t5 8 bits para esquerda
	add t3, t3, t5	#t3 += t5
	
	li a7, 4
	la a0, interacao_b
	ecall
	
	li a7, 5
	ecall
	add t6, a0, x0	#t6 = valor de blue
	add s0, t3, t6 #s0 = t3 + t6
	
	jr ra	#Retorna para a funcao que a chamou
	
ENCERRA:
	li a7, 10
	ecall
