@ Close_File function
@ Requirements: r0 = file descriptor
@ Outputs: 	none
@ Purpose: closes the file

.global Close_File			@ Provide program starting address to linker

Close_File:

	push	{r4-r8, r10, r11} 	@ preserve registers
	push	{sp}				@ preserve stack pointer

	mov		r7, #6				@ put 5 in the syscall register to set status to CLOSE
	svc		0					@ call to linux to read in the file and return a handle to the file
	
	pop		{sp}				@ preserve stack pointer
	pop		{r4-r8, r10, r11}	@ preserve registers
	
	bx 		lr					@ branch back to call
	
	.end
~
~
