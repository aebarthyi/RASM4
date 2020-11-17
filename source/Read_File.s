@ Read_File function
@ Requirements: r0 = File descriptor
@ Outputs: 	r0 = address to String of a line
@ Purpose: reads in a line from the file

.data

szEmp:	.skip	128		@file input buffer
szByte: .byte	1		@character buffer

.global Read_File			@ Provide program starting address to linker

Read_File:

	push	{r4-r8, r10, r11} 	@ preserve registers
	push	{sp}				@ preserve stack pointer

	mov		r1, =szByte			@ load character buffer
	mov		r2, #1				@ set bytes to read to 1
	mov		r4, #0				@ set our counter up
	
CharCheck:
	svc		0					@ call to read in one character
	cmp		r0, #1				@ check if a byte was read or not
	blt		ReadIn				@ go to read in if end of file found
	cmp		r1, #10				@ check if newline character found
	addne	r4, #1				@ increment counter if not found
	bne		CharCheck			@ back to top of loop
	
ReadIn:
	mov		r1, =szEmp			@ move buffer to be read into
	mov		r2, r4				@ put our line length into r2
	svc  	0					@ call to read into the buffer
	
	ldr		r0, =szEmp			@ get our address to read in line
	
	pop		{sp}				@ preserve stack pointer
	pop		{r4-r8, r10, r11}	@ preserve registers
	
	bx 		lr					@ branch back to call
	
	.end
~
~
