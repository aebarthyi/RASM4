@ Write_File function
@ Requirements: r0 = head node
@ 				r1 = file descriptor
@ Outputs: r0 = file descriptor
@ Purpose: reads in a line from the file

.data

szEmp:	.skip	128		@file input buffer
szByte: .byte	1		@character buffer

.global Write_File			@ Provide program starting address to linker

.text

Write_File:
	push	{lr}				@ preserve link
	push	{r4-r8, r10, r11} 	@ preserve registers
	push	{sp}				@ preserve stack pointer
	mov		r7, #4				@ set write syscall
	mov		r5, r1				@ preserve file descriptor

nextNode:

	ldr		r0, [r0, #4]		@ load next node
	
	add	r4, r0, #8	@add 8 to r0 to get to the string address
	mov r3, r0		@move our current next address to r3

	mov	r0, r4			@ get string start
	bl	String_Length	@ get length of the line
	mov	r1, r4			@ put string into r1 for write
	mov	r2, r0			@ put length into r2 for write
	mov	r0, r5			@ put descriptor in r0 for write
	svc		0			@ call syscall to write the line to file
	
	ldr	r1, [r3, #4]		@ load next node
	cmp	r1, #0				@ if no nodes left
	beq	end
	mov	r0, r3			@ restore next node if not end of list
	b	nextNode		@ go back and keep writing until list empty
	
end:
	mov	r0, r5			@ restore file descriptor
	
	pop		{sp}				@ preserve stack pointer
	pop		{r4-r8, r10, r11}	@ preserve registers
	pop		{lr}				@ preserve link
	bx 		lr					@ branch back to call
	
	.end
~
~
