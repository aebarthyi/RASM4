@ Read_File function
@ Requirements: r0 = File descriptor
@ Outputs: 	r0 = address to String of a line
@ Purpose: reads in a line from the file

.data

szEmp:	.skip	128		@file input buffer
szByte: .byte	1		@character buffer

.global Read_File			@ Provide program starting address to linker

.text

Read_File:

	push	{r4-r8, r10, r11} 	@ preserve registers
	push	{sp}				@ preserve stack pointer
	mov		r6, r0				@ save file descriptor
	ldr		r1, =szByte			@ load character buffer
	mov		r2, #1				@ set bytes to read to 1
	mov		r7, #3				@ set syscall to read
	ldr		r5, =szEmp			@ load empty buffer for line
	mov		r4, #0				@ set our counter up
	
CharCheck:
	svc		0					@ call to read in one character
	cmp		r0, #1				@ check if a byte was read or not
	blt		exit				@ go to read in if end of file found
	mov		r0, r6				@ restore file descriptor
	ldrb	r3, [r1]			@ dereference the byte
	cmp		r3, #10				@ check if newline character found
	strb	r3, [r5, r4]		@ store in the buffer if not newline
	addne	r4, #1				@ increment counter if not found
	bne		CharCheck			@ back to top of loop

exit:
	mov		r0, r5				@ return address of read in line
	pop		{sp}				@ preserve stack pointer
	pop		{r4-r8, r10, r11}	@ preserve registers
	
	bx 		lr					@ branch back to call
	
	.end
~
~
