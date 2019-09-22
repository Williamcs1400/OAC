#-------------------------------------------------------------------------
#		Organizacao e Arquitetura de Computadores - Turma C 
#			Trabalho 1 - Assembly RISC-V
#
# Nome: William Coelho da Silva		Matricula: 180029274
# Nome: Douglas Samuel Thomazi Azevedo	Matricula: 180119109
# Nome: 				Matricula: 

.data
	menu:	       .asciz "\nMENU:\n	1.Obtem ponto\n	2.Desenha ponto\n	3.Desenha retangulo com preenchimento\n	4.Desenha retangulo sem preenchimento\n	5.Converte para negativo da imagem\n	6.Converte imagem para tons de vermelho\n	7.Carrega imagem\n	8.Encerra\n\nDigite a opcao desejada:\n"
	cor_base:      .word 0x0000000	#Para inserir a cor desejada pelo o usuario
	endereco_base: .word 0x10043f00	#Ultima linha e primeira coluna do bitmap
	endereco_base2: .word 0x10040000 #Primeira linha e primeira coluna
	interacao_x:   .asciz "Escreva o valor entre 0 e 63 para X: "
	interacao_y:   .asciz "Escreva o valor entre 0 e 63 para Y: "
	interacao_x1:  .asciz "Escreva o valor entre 0 e 63 para X1: "
	interacao_y1:  .asciz "Escreva o valor entre 0 e 63 para Y1: "
	interacao_x2:  .asciz "Escreva o valor entre 0 e 63 para X2: " 
	interacao_y2:  .asciz "Escreva o valor enrte 0 e 63 para Y2: "
	
	interacao_r:   .asciz "Escreva um valor entre 0 e 255 para Red: "
	interacao_g:   .asciz "Escreva um valor entre 0 e 255 para Green: "
	interacao_b:   .asciz "Escreva um valor entre 0 e 255 para Blue: "
	
	interacao_err: .asciz "\nERRO! Por favor, digite um valor valido! \n\n"
.text
INICIO:
	############################
	## Mostra menu no console ##
	############################
	li a7, 4
	la a0, menu
	ecall
	
	############################
	## Le a operacao desejada ##
	############################
	li a7, 5
	ecall
	
	############################
	## Testa validacao da op  ##
	############################
	addi t0, x0, 1	
	bge a0, t0, CONTINUA
	
ERRO_MENU:	
	li a7, 4
	la a0, interacao_err			#Imprime mensagem de erro
	ecall
	j INICIO
	
CONTINUA:	
	addi t0, x0, 9
	bge a0, t0, ERRO_MENU
		
	##############################
	## Testando se eh igual a 1 ##
	##############################
	addi t0, x0, 1				#t0 = 1
	beq a0, t0, OBTEMPONTOCOMECO		#if(a0 == 1) PC = OBTEMPONTO
	
	##############################
	## Testando se eh igual a 2 ##
	##############################
	addi t0, x0, 2
	beq a0, t0, DESENHAPONTOCOMECO		#if(a0 == 2) PC = DESENHAPONTO
	
	##############################
	## Testando se eh igual a 3 ##
	##############################
	addi t0, x0, 3
	beq a0, t0, RETANGULOFULL		#if(a0 == 3) PC = RETANGULOFULL
	
	##############################
	## Testando se eh igual a 4 ##
	##############################
	addi t0, x0, 4
	beq a0, t0, RETANGULO_S_PREENC		#if(a0 == 4) PC = RETANGULO_S_PREENC
	
	##############################
	## Testando se eh igual a 5 ##
	##############################
	addi t0, x0, 5
	beq a0, t0, NEGATIVA_IMAGEM		#if(a0 == 5) PC = NEGATIVA_IMAGEM

	##############################
	## Testando se eh igual a 5 ##
	##############################
	addi t0, x0, 6
	beq a0, t0, IMAGEM_VERMELHA		#if(a0 == 6) PC = IMAGEM_VERMELHA
			
	##############################
	## Testando se eh igual a 8 ##
	##############################
	addi t0, x0, 8
	beq a0, t0, ENCERRA 			#if(a0 == 8) Encerra o programa
	
################################################################################
################################################################################
###################					     ###################
###################                FUNCOES                   ###################
###################                                          ###################
################################################################################
################################################################################

################################################################################
# Funcao ObtemPonto: Carrega uma cordenada do bitmap no registraor e mostar o valor em decimal da cor no terminal
#
#Parametros:
# t0 : Valor de X digitado pelo o usuario
# t1 : Valor de Y digitado pelo o usuario
################################################################################
OBTEMPONTOCOMECO: 
	jal ra, LE_X_Y_SIMPLES			#ra = PC, PC = LE_X_Y_SIMPLES
	
	#Operacoes aritmeticas para mostrar no bitmap
	
	addi t2, x0, 4				#t2 = 4
	mul t0, t0, t2				#Multiplica o valor de x por 4
	addi t2, x0, 256			#t2 = 256
	mul t1, t1, t2				#Multiplica o valor de y por 256
	
	addi t2, x0, -1				#t2 = -1
	mul t1, t1, t2				#Faz o valor de y ficar negativo
		
	lw t3, endereco_base			#t3 = endereco_base
	add t3, t3, t0				#t3 += t0 ou x
	add t3, t3, t1				#t3 -= t1 ou y
	
	lw s0, 0(t3)				#Le a cor da posicao do endereco de t3
	
	#Instrucoes para imprimir o valor RGB na tela
	li a7, 34
	add a0, x0, s0
	ecall
	
	beq x0, x0, INICIO			#Volta para o menu incial

################################################################################
# Funcao DesenhaPonto: Carrega a cordenada e a cor e desenha no bitmap
#
#Parametros:
# t0 : Valor de X digitado pelo o usuario
# t1 : Valor de Y digitado pelo o usuario
# s0 : Valor da cor digitada pelo o usuario
################################################################################

DESENHAPONTOCOMECO:

	jal ra, LE_X_Y_SIMPLES			#ra = PC, PC = LE_X_Y_SIMPLES
	
	jal ra, LE_RGB				#ra = PC, PC = LE_RGB
	
	jal ra, DESENHAPONTO			#Para saber que eh pra voltar para o menu
	
	beq x0, x0, INICIO			#Volta para o menu incial

################################################################################
################################################################################
################################################################################
	
DESENHAPONTO:					#Para quando nao precisar ler as informacoes acima

	#Operacoes aritmeticas para mostrar no bitmap
	
	addi t2, x0, 4				#t2 = 4
	mul t0, t0, t2				#Multiplica o valor de x por 4
	addi t2, x0, 256			#t2 = 256
	mul t1, t1, t2				#Multiplica o valor de y por 256
	
	addi t2, x0, -1				#t2 = -1
	mul t1, t1, t2				#Faz o valor de y ficar negativo
	
	lw t3, endereco_base			#t3 = endereco_base
	add t3, t3, t0				#t3 += t0 ou x
	add t3, t3, t1				#t3 -= t1 ou y
	
	
	sw s0, 0(t3)				#Printa para o usuario inserir x1
		
	jr ra					#Retorna para a funcao que a chamou

################################################################################
# Funcao ReganguloComPreenchimento: Carrega as cordenadas x0, x1, y0, y1 e a cor e desenha um regangulo completo no bitmap
#
#Parametros:
# t0 : Valor de X1 digitado pelo o usuario
# t1 : Valor de Y1 digitado pelo o usuario
# s10: Valor de X2 digitado pelo o usuario
# s1 : Valor de Y2 digitado pelo o usuario
# s0: Cor desejada
################################################################################

RETANGULOFULL:

	jal ra, LE_X_Y_COMPOSTO			#ra = PC, PC = LE_X_Y_COMPOSTO
	
	#Funcoes para ver se x1 e y2 < x2 e y2, caso contrario trocam
	jal ra, VE_X				#ra = PC, PC = VE_X
	jal ra, VE_Y				#ra = PC, PC = VE_Y
	
	jal ra, LE_RGB				#ra = PC, PC = LE_RGB

	add s7, x0, t1				#Salva a posicao inicial de y1
	add s11, x0, t0				#Salva a posicao inicial de x1
	
	
LOOP_RET_FULL_Y:				#Linhas	

	LOOP_RET_FULL_X:			#Colunas
	
		jal ra, DESENHAPONTO		#ra = PC, PC = DESENHAPONTO
		srli t0, t0, 2			#Divide x1 por 4
		addi t0, t0, 1			#Pula para o proximo valor de x
		neg t1, t1			#t1 *= -1
		srli t1, t1, 8			#Divide x1 por 256
		ble t0, s10, LOOP_RET_FULL_X	
		add t0, x0, s11			#Reseta o valor incial de x1
		addi t1, t1, 1			#y1 += 1
		ble t1, s1, LOOP_RET_FULL_Y
		
		j INICIO
	
################################################################################
# Funcao ReganguloSemPreenchimento: Carrega as cordenadas x0, x1, y0, y1 e a cor e desenha as bordas de um retangulo no bitmap
#
#Parametros:
# t0 : Valor de X1 digitado pelo o usuario
# t1 : Valor de Y1 digitado pelo o usuario
# s10: Valor de X2 digitado pelo o usuario
# s1 : Valor de Y2 digitado pelo o usuario
# s0: Cor desejada
################################################################################

RETANGULO_S_PREENC:

	jal ra, LE_X_Y_COMPOSTO			#ra = PC, PC = LE_X_Y_COMPOSTO
	
	#Funcoes para ver se x1 e y2 < x2 e y2, caso contrario trocam
	jal ra, VE_X				#ra = PC, PC = VE_X
	jal ra, VE_Y				#ra = PC, PC = VE_Y
	
	jal ra, LE_RGB				#ra = PC, PC = LE_RGB

	add s7, x0, t1
	add s11, x0, t0				#Salva a posicao inicial de x1
	
LOOP_RET_S_Y:					#Linhas

	LOOP_RET_S_X:				#Colunas
	
		jal ra, DESENHAPONTO		#ra = PC, PC = DESENHAPONTO
		srli t0, t0, 2			#Divide x1 por 4
		addi t0, t0, 1			#Pula para o proximo valor de x
		neg t1, t1			#t1 *= -1
		srli t1, t1, 8			#Divide x1 por 256
		ble t0, s10, LOOP_RET_S_X
		add t0, x0, s11
		addi t1, t1, 1
		ble t1, s1, LOOP_RET_S_Y
	
	#redefinição das posicoes para pintar de preto dentro do retangulo 
	addi t0, s11, 1				#x1 += 1
	addi t1, s7, 1				#y1 += 1
	addi s10, s10, -1			#x2 -= 1
	addi s1, s1, -1				#y2 -= 1
	add s11, t0, x0				#Salva a posicao inicial de x1
	li s0, 0x00000000			#Pinta de preto a parte de dentro do retangulo
	
LOOP_RET_S1_Y:					#Linhas 
	
	LOOP_RET_S1_X:				#Colunas
	
		jal ra, DESENHAPONTO		#ra = PC, PC = DESENHAPONTO
		srli t0, t0, 2			#Divide x1 por 4
		addi t0, t0, 1			#Pula para o proximo valor de x
		neg t1, t1			#t1 *= -1
		srli t1, t1, 8			#Divide x1 por 256
		ble t0, s10, LOOP_RET_S1_X
		add t0, x0, s11			#Reseta o valor de X1
		addi t1, t1, 1			#y1 += 1
		ble t1, s1, LOOP_RET_S1_Y
		j INICIO

################################################################################
################################################################################
################################################################################

NEGATIVA_IMAGEM:

	li s3, 4096					#Coloca em s3 64x64
	li t0, 0					#Redefine o x para 0
	li t1, 0					#Redefine o y para 0
	li s2, 0x00ffffff				##coloca em s2 o valor RGB ffffff
	lw t3, endereco_base2				#t3 = endereco_base2
	LOOP:	
		lw s0, 0(t3)				#Le a cor da posicao do endereco de t3
		sub s0, s2, s0 				#Subtrai s0 de s2 para negativar o s0
		sw s0, 0(t3)				#Imprime a cor no bitmap
		addi t0, t0, 1 				#incrementa t0
		addi t3, t3, 4				#Incrementa o endere?o base
		blt t0, s3, LOOP			#verifica se t0 == 4096
	j INICIO

################################################################################
################################################################################
################################################################################

IMAGEM_VERMELHA:
	
	li s3, 4096					#Coloca em s3 64x64
	li t0, 0					#Redefine o x para 0
	li t1, 0					#Redefine o y para 0
	li s2, 0x0000ffff				#coloca em s2 o valor RGB 00ffff
	lw t3, endereco_base2				#t3 = endereco_base2
	LOOP2:	
		lw s0, 0(t3)				#Le a cor da posicao do endereco de t3
		lw s2, 0(t3)				#Le a cor da posicao do endereco de t3
		slli s2, s2, 16				#Move s2 4 casas para a esquerda
		srli s2, s2, 16				#Move s2 4 casas para a direita
		sub s0, s0, s2				#Subtrai s2 de s0 para zerar o GB
		sw s0, 0(t3)				#Imprime a cor no bitmap
		addi t0, t0, 1 				#incrementa t0
		addi t3, t3, 4				#Incrementa o endere?o base
		blt t0, s3, LOOP2			#verifica se t0 == 4096
	j INICIO

################################################################################
################################################################################
################################################################################

ERRO_COORD_SIMPLES:
	li a7, 4
	la a0, interacao_err			#Imprime mensagem de erro
	ecall
	j LE_X_Y_SIMPLES

################################################################################
# Funcao Le X e Y simples: Le apenas x1 e y1 e armazena em t0 e t1
################################################################################

LE_X_Y_SIMPLES:					#Le as cordenadas X e Y 
	
	#Printa para o usuario inserir x
	li a7, 4
	la a0, interacao_x
	ecall
	
	#Le um numero inteiro
	li a7, 5	
	ecall
	
	#Verifica os valor da coordena X
	blt a0, x0, ERRO_COORD_SIMPLES 		#Se x < 0, ERRO
	addi t0, x0, 64				#t0 = 64
	bge a0, t0, ERRO_COORD_SIMPLES		#Se x > t0, ERRO
	
	add t0, a0, x0				#Salva o valor de x em t0
	
	#Printa para o usuario inserir y
	li a7, 4
	la a0, interacao_y
	ecall
	
	#Le um numero inteiro
	li a7, 5	
	ecall
	
	#Verifica os valor da coordena Y
	blt a0, x0, ERRO_COORD_SIMPLES		#Se y < 0, ERRO
	addi t1, x0, 64				#t1 = 64
	bge a0, t1, ERRO_COORD_SIMPLES		#Se y > t1, ERRO
	
	add t1, a0, x0				#Salva o valor de y em t1
	
	jr ra					#Retorna para a funcao que a chamou
	
################################################################################
################################################################################
################################################################################

ERRO_COORD_COMPOSTO:
	li a7, 4
	la a0, interacao_err			#Imprime mensagem de erro
	ecall
	j LE_X_Y_COMPOSTO

################################################################################
# Funcao Le X e Y composto: Le apenas x1, y1, x2, y2 e armazena em t0, t1, s10 e s1
################################################################################

LE_X_Y_COMPOSTO:
	
	#Printa para o usuario inserir x1
	li a7, 4
	la a0, interacao_x1
	ecall
	
	#Le um numero inteiro e salva em t0
	li a7, 5
	ecall
	
	#Verifica os valor da coordena X1
	blt a0, x0, ERRO_COORD_COMPOSTO		#Se x1 < 0, ERRO
	addi t0, x0, 64				#t0 = 64
	bge a0, t0, ERRO_COORD_COMPOSTO		#Se x1 > t0, ERRO
	
	add t0, a0, x0
	
	#Printa para o usuario inserir y1
	li a7, 4
	la a0, interacao_y1
	ecall
	
	#Le um numero inteiro e salva em t1
	li a7, 5
	ecall
	
	#Verifica os valor da coordena Y1
	blt a0, x0, ERRO_COORD_COMPOSTO		#Se y1 < 0, ERRO
	addi t1, x0, 64				#t1 = 64
	bge a0, t1, ERRO_COORD_COMPOSTO		#Se y1 > t1, ERRO
	
	add t1, a0, x0
	
	#Printa para o usuario inserir x2
	li a7, 4
	la a0, interacao_x2
	ecall
	
	#Le um numero inteiro e salva em s10
	li a7, 5
	ecall
	
	#Verifica os valor da coordena X2
	blt a0, x0, ERRO_COORD_COMPOSTO		#Se x2 < 0, ERRO
	addi s10, x0, 64			#s10 = 64
	bge a0, s10, ERRO_COORD_COMPOSTO	#Se x2 > s10, ERRO
	
	add s10, a0, x0
	
	#Printa para o usuario inserir y2
	li a7, 4
	la a0, interacao_y2
	ecall
	
	#Le um numero inteiro e salva em s1
	li a7, 5
	ecall
	
	#Verifica os valor da coordena Y2
	blt a0, x0, ERRO_COORD_COMPOSTO		#Se y2 < 0, ERRO
	addi s1, x0, 64				#s1 = 64
	bge a0, s1, ERRO_COORD_COMPOSTO		#Se y2 > s1, ERRO
	
	add s1, a0, x0
	
	jr ra					#Retorna para a funcao que a chamou
	
################################################################################
# Funcao LeRGB: Le as tres cores primarias e salva em s0
################################################################################

LE_RGB:					
	#Le 3 numeros de 0 a 255 para e retorna uma cor RGB
	lw t3, cor_base				#t3 = cor_base
	
	#Printa para o usuario inserir o vermelho
	li a7, 4
	la a0, interacao_r	
	ecall
	
	#Le um numero inteiro e salva em t4
	li a7, 5
	ecall
	
	#Verifica os valor do Vermelho
	blt a0, x0, ERRO_RGB			#Se a0 < 0, ERRO
	addi t4, x0, 256			#t4 = 256
	bge a0, t4, ERRO_RGB			#Se a0 > t4, ERRO
	
	add t4, a0, x0				#t4 = valor de red
	slli t4, t4, 16				#Desloca o valor de t4 16 bits para a esquerda
	add t3, t3, t4				#t3 += t4
	
	#Printa para o usuario inserir o verde
	li a7, 4
	la a0, interacao_g
	ecall
	
	#Le um numero inteiro e salva em t5
	li a7, 5
	ecall
	
	#Verifica os valor do Verde
	blt a0, x0, ERRO_RGB			#Se a0 < 0, ERRO
	addi t5, x0, 256			#t5 = 256
	bge a0, t5, ERRO_RGB			#Se a0 > t5, ERRO
	
	add t5, a0, x0				#t5 = valor de gree
	slli t5, t5, 8				#Desloca o valor de t5 8 bits para esquerda
	add t3, t3, t5				#t3 += t5
	
	#Printa para o usuario inserir o azul
	li a7, 4
	la a0, interacao_b
	ecall
	
	#Le um numero inteiro e salva em t6
	li a7, 5
	ecall
	
	#Verifica os valor do Verde
	blt a0, x0, ERRO_RGB			#Se a0 < 0, ERRO
	addi t6, x0, 256			#t6 = 256
	bge a0, t6, ERRO_RGB			#Se a0 > t6, ERRO

	add t6, a0, x0				#t6 = valor de blue
	add s0, t3, t6				#s0 = t3 + t6
	
	jr ra					#Retorna para a funcao que a chamou
	
################################################################################
################################################################################
################################################################################

ERRO_RGB:
	li a7, 4
	la a0, interacao_err			#Imprime mensagem de erro
	ecall
	j LE_RGB

################################################################################
# Funcoes para arrumar a ordem das coordenas evitando erros
################################################################################

VE_X:

	blt s10, t0, TROCA_X			#Se x1 < x2 chama a funcao de trocar
	
	jr ra					#Retorna para a funcao que a chamou
	
TROCA_X:
	
	add t3, t0, x0				#t3 = t0
	mv t0, s10				#t0 = s10
	mv s10, t3				#t1 = t3
	
	jr ra					#Retorna para a funcao que a chamou
	
VE_Y:
	
	blt s1, t1, TROCA_Y			#Se y1 < y2 chama a funcao de trocar
	
	jr ra					#Retorna para a funcao que a chamou
	
TROCA_Y:
	
	add t3, t1, x0				#t3 = t1
	mv t1, s1				#t1 = s1
	mv s1, t3				#s1 = t3
	
	jr ra					#Retorna para a funcao que a chamou
	
				
################################################################################
################################################################################
################################################################################

ENCERRA:
	li a7, 10
	ecall
