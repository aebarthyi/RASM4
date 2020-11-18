@ Exit_Delete function
@ Inputs:	r0 = Address of head node
@
@ Purpose:      deletes the linked list for exit

	.data
						
	.global			Exit_Delete		
																											
	.text

Exit_Delete:
    
	push	{r4-r8, r10, r11}      @ push preserved registers for aapcs
	push 	{sp}                   @ push stack pointer
	push	{lr}			@preserve the link register for recursion

	mov	r8, r0		@copy the head node to r8
loop:
	mov	r1, #1		@setting node to delete to 1
	mov	r0, r8		@mov head node into r0

	bl	Delete_String	@calls delete string
	cmp	r1, #1		@compare if last node was deleted
	beq	end		@jump to end

	cmp	r0, #0		@compare if the delete string was ran
	beq	end		@jump to end

	b	loop		@jump back to loop
		
end:
	
	pop	{lr}					@preservs the link register for recursion
	pop	{sp}                    @ pop stack pointer
	pop	{r4-r8, r10, r11}       @ pop the preserved regiesters for aapcs

	bx      lr    	            @ back to the main where it is called

    .end
