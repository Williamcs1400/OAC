.data

	end: .word 0x100400fc	#ultima coluna
	end1: .word 0x10043ffc	#ultima linha e ultima coluna
	end2: .word 0x10040000
	end3: .word 0x10043f00	#Ultima linha do Bitmap
	
.text

	lw t0, end
	li t1, 0x00ffd700
	sw t1, 0(t0)

	lw t0, end1
	li t1, 0x0000ff00
	sw t1, 0(t0)
	
	lw t0, end2
	li t1, 0x000000ff
	sw t1, 0(t0)
	
	lw t0, end3
	li t1, 0x00ff00ff
	sw t1, 0(t0)