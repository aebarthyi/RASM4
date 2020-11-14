@ Open_File function
@ Requirements: r0 = address of name of file in asciz .txt form, if it doesn't exist, creates one
@ Outputs: 	r0 = file descriptor, if could not open, -1
@ Purpose: opens the file and returns file handle 

.global Open_File			@ Provide program starting address to linker

Open_File:

	push	{r4-r8, r10, r11} 	@ preserve registers
	push	{sp}				@ preserve stack pointer

	mov		r1, #0102			@ set flag to create file and read/write
	ldr		r2, =0644			@ set permissions for program to read and write
	mov		r7, #5				@ put 5 in the syscall register to set status to OPEN
	svc		0					@ call to linux to read in the file and return a handle to the file
	cmp		r0, #0				@ compare file descriptor to 0, if negative, an error has occured
	movlt	r0, -1				@ if error found, return -1 to main call
	
	pop		{sp}				@ preserve stack pointer
	pop		{r4-r8, r10, r11}	@ preserve registers
	
	bx 		lr					@ branch back to call
	
	.end
~
~
