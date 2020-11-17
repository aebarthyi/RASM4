@ Add_String_keyboard function
@ Inputs:	r0 = file descriptor to file to read from
@		r1 = Address of last node
@ Outputs:      r0 = Address of the new node in linked list
@ Purpose:      creates an empty linked list head 

	.data
						
	.global			Add_String_File		
																											
	.text

Add_String_File:
    
	push	{r4-r8, r10, r11}      @ push preserved registers for aapcs
	push 	{sp}                   @ push stack pointer
	push	{lr}			@preserve the link register for recursion
	mov	r8, r0			@ save file descriptor
	
Read:
	bl	Read_File		@ read a line from file
	cmp	r0, #0			@ check if end of file
	beq	exit			@ finish if end of file
	bl	Add_String_keyboard	@ add string from keyboard
	mov	r1, r0			@ update last node
	
	b	Read		@read next line

exit:
	pop	{lr}			@preservs the link register for recursion
	pop	{sp}                    @ pop stack pointer
	pop	{r4-r8, r10, r11}       @ pop the preserved regiesters for aapcs

	bx      lr    	            @ back to the main where it is called

    .end
