@ Delete_String function
@ Inputs:	r0 = Address of head node
@			r1 = node # to delete
@ Outputs:      none
@ Purpose:      deletes the string at the specified node

	.data
						
	.global			Delete_String		
																											
	.text

Delete_String:
    
	push	{r4-r8, r10, r11}      @ push preserved registers for aapcs
	push 	{sp}                   @ push stack pointer
	push	{lr}			@preserve the link register for recursion

	mov	r4, r1		@setting node to delete into r4
	mov	r5, #0		@setting node count to 0

nextaddress:
	ldr		r0, [r0, #4]	@get next address

	add	r5, #1		@increment node counter by 1
	cmp	r5, r4		@compare the node count to the node # to delete
	blt	nextaddress	@jump to next node if less than node #
	
	mov	r7, r0		@move current address into r7
	
	ldr r3, [r7]	@ current address prev pointer
	add r3, #4		@ prev nodes next address
	str r4, [r3, #4]	@ store next for the prev node
	
	ldr r4, [r7, #4]	@ current address next pointer
	cmp	r4, #0			@ check if null next 
	beq		free		@ branch to free if null next 
	
	str r3, [r4]		@ store prev for the next node
	

free:

	mov r0, r7		@ get our current node into r0
	
	push	{r1-r8, r10, r11}      @ push preserved registers for aapcs
	bl		free					@ free up current node
	pop		{r1-r8, r10, r11}       @ pop the preserved regiesters for aapcs

end:
	pop	{lr}					@preservs the link register for recursion
	pop	{sp}                    @ pop stack pointer
	pop	{r4-r8, r10, r11}       @ pop the preserved regiesters for aapcs

	bx      lr    	            	@ back to the main where it is called

    .end
