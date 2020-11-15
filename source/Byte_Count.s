@ Byte_Count function
@ Inputs:	r0 = Address of head node
@ Outputs:      r0 = number of bytes in the linked list
@ Purpose:      counts the number of bytes in the linked list

	.data
						
	.global			Byte_Count		
																											
	.text

Byte_Count:
    
	push	{r4-r8, r10, r11}      @ push preserved registers for aapcs
	push 	{sp}                   @ push stack pointer
	push	{lr}			@preserve the link register for recursion

	mov	r5, #0		@setting byte count to 0
nextnode:

	add r0, r0, #4		@offset the address by 4 to access the start of next

	ldr	r1, [r0]	@loads the next address from node

	cmp	r1, #0		@compare address to 00000000
	beq	end		@if equal then jump to end

	add	r0, r1, #8	@add 8 to r1 to get to the string address

	push	{r4-r8, r10, r11}      @ push preserved registers for aapcs
	bl	String_Length		@calling string length
	pop	{r4-r8, r10, r11}       @ pop the preserved regiesters for aapcs

	add	r0, #9		@add 9 to string length
	add	r5, r0		@adding byte total to count	

	mov	r0, r1		@move address into r1
	b	nextnode	@jump to next node

end:
	mov	r0, r5		@move byte count into r0

	pop	{lr}			@preservs the link register for recursion
	pop	{sp}                    @ pop stack pointer
	pop	{r4-r8, r10, r11}       @ pop the preserved regiesters for aapcs

	bx      lr    	            	@ back to the main where it is called

    .end
