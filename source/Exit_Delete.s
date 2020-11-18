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

nextaddress:
	ldr	r1, [r0, #4]	@get next address
	mov r3, r1			@move next node to r3
	
	push	{r1-r8, r10, r11}       @ preserved registers
	bl		free					@ frees the memory at the address in r0 (node to delete)
	pop		{r1-r8, r10, r11}       @ pop registers
	
	mov	r0, r3						@ restore next node
	cmp	r0, #0						@ check if nullptr
	bne nextaddress					@ loop
	
end:
	pop	{lr}					@preservs the link register for recursion
	pop	{sp}                    @ pop stack pointer
	pop	{r4-r8, r10, r11}       @ pop the preserved regiesters for aapcs

	bx      lr    	            @ back to the main where it is called

    .end
