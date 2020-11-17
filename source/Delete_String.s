@ Delete_String function
@ Inputs:	r0 = Address of head node
@		r1 = node # to delete
@ Outputs:      r0 = indicates if program ran or not 
@		r1 = indicates if last node was deleted
@		r2 = if last node deleted, r2 contains the previous node address
@ Purpose:      deletes the string at the specified node

	.data
						
	.global			Delete_String		
																											
	.text

Delete_String:
    
	push	{r4-r8, r10, r11}      @ push preserved registers for aapcs
	push 	{sp}                   @ push stack pointer
	push	{lr}			@preserve the link register for recursion

	mov	r7, r1		@setting node # to delete into r4
	mov	r4, #0		@setting node count to 0

nextaddress:
	mov	r3, r0		@store previous address into r3
	ldr	r0, [r0, #4]	@get next address

	cmp	r0, #0		@compare address to 0
	beq	error		@if equal then jump to end

	add	r4, #1		@increment counter by 1

	cmp	r4, r7		@compare count to node #
	blt	nextaddress	@jump to next node

@moving pointers around
	ldr	r2, [r0, #4]	@loading 'next address' from 'node to delete' to r2
	cmp	r2, #0		@compare if the next address is 0x00000000
	beq	lastptr		@skip over setting next pointers

	mov	r1, #0		@move 0 into r1, indicates the last node was not deleted

	str	r2, [r3, #4]	@storing 'next node address' into previous node's next
	str	r3, [r2]	@setting the prev address in "next node's previous address"
	
	b	freemem

lastptr:
	mov	r4, #0x00000000	@setting r4 to a 0 address
	str	r4, [r3, #4]	@setting prev node's 'next node' to 0x00000000

	mov	r1, #1		@mov 1 into r1, indicated the last node was deleted
	mov	r2, r3		@mov prev node address into r2(to keep track of last node)

freemem:
	push	{r1-r8, r10, r11}       @ preserved registers
	bl	free			@frees the memory at the address in r0 (node to delete)
	pop	{r1-r8, r10, r11}       @ pop registers
	
	mov	r0, #1		@move 1 into r0, indicates program ran

	b	end		@jump to end
error:
	mov	r0, #0		@move 0 into r0, indicates no node to delete
end:
	pop	{lr}					@preservs the link register for recursion
	pop	{sp}                    @ pop stack pointer
	pop	{r4-r8, r10, r11}       @ pop the preserved regiesters for aapcs

	bx      lr    	            	@ back to the main where it is called

    .end
