.data

	end: .word 0x10040000
	end1: .word 0x10040004
	end2: .word 0x10040008
	end3: .word 0x1004000c
	
.text

	lw t0, end
	li t1, 0x00ff0000
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