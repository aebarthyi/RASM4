@ Delete_String function
@ Inputs:	r0 = Address of head node
@		r1 = node # to delete
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

nextnode:
	mov	r2, #0		@setting count to 0

	add 	r0, r0, #4	@offset the address by 4 to access the start of next

nextaddress:
	ldrb	r3, [r0, r2]	@needs HELP fix? -should copy address @r0 into r3
	strb	r3, r1, r2	@next address should be in r1
	
	add	r2, #1		@increment counter by 1
	cmp	r2, #4		@compare counter to 4
	blt	nextaddress	@if the counter is less then branch

	mov	r6, r0		@moving the prev address into r6
	mov	r0, r1		@move address into r1

	add	r5, #1		@increment node counter by 1
	cmp	r5, r4		@compare the node count to the node # to delete
	blt	nextnode	@jump to next node if less than node #
	
	mov	r7, r0		@move current address into r7
	
@cycle through once more
	mov	r2, #0		@setting count to 0
	add 	r0, r0, #4	@offset the address by 4 to access the start of next

loop:
	ldrb	r3, [r0, r2]	@needs HELP fix? -should copy address @r0 into r3
	strb	r3, r1, r2	@next address should be in r1
	
	add	r2, #1		@increment counter by 1
	cmp	r2, #4		@compare counter to 4
	blt	loop		@if the counter is less then branch

	mov	r8, r1		@move next address into r8

@linking addresses
	mov	r2, #0		@setting count to 0
	add 	r0, r6, #4	@offset the address by 4 to access the start of next

first:
	ldrb	r3, r8, r2	@needs HELP fix? -should copy address @r0 into r3
	strb	r3, [r0, r2]	@next address should be in r1
	
	add	r2, #1		@increment counter by 1
	cmp	r2, #4		@compare counter to 4
	blt	first		@if the counter is less then branch

	mov	r2, #0		@setting count to 0

second:
	ldrb	r3, r6, r2	@needs HELP fix? -should copy address @r0 into r3
	strb	r3, [r8, r2]	@next address should be in r1
	
	add	r2, #1		@increment counter by 1
	cmp	r2, #4		@compare counter to 4
	blt	second		@if the counter is less then branch

@freeing memory

	@free memory function here!!!!!!
	@pointer to memory location to free is in r7

end:
	pop	{lr}			@preservs the link register for recursion
	pop	{sp}                    @ pop stack pointer
	pop	{r4-r8, r10, r11}       @ pop the preserved regiesters for aapcs

	bx      lr    	            	@ back to the main where it is called

    .end
