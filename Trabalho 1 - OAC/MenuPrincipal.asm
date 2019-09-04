.data
	menu:	.asciz "Digite a opcao desejada:\n	1. Obtem ponto\n	2. Desenha ponto\n	3.Desenha retângulo com preenchimento\n	4.Desenha retângulo sem preenchimento\n	5.Converte para negativo da imagem\n	6.Converte imagem para tons de vermelho\n	7.Carrega imagem\n	8.Encerra"
	
.text
	li a7, 4
	la a0, menu
	ecall
	
	