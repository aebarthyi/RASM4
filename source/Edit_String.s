@ Edit_String.s function
@ Inputs:	r0 = # of the node to edit
@ 		r1 = address of the string
@		r2 = head node address
@ Outputs:      none
@ Purpose:      edits the given node string

	.data
						
	.global			Edit_String		
																											
	.text

Edit_String:
    
	push	{r4-r8, r10, r11}      @ push preserved registers for aapcs
	push 	{sp}                   @ push stack pointer
	push	{lr}			@preserve the link register for recursion
    
	mov	r7, r0			@ copy node # to r7
	mov	r8, r1			@ copy address of string to r8

	mov	r0, r1			@ move the string address into r0
	push	{r1-r8, r10, r11}       @ preserved registers
	bl	String_Length		@ call string length
	pop	{r1-r8, r10, r11}       @ pop registers
	mov	r6, r0			@moving length into r6
	
	add	r0, r0, #12		@adding 12 to string length

	push	{r1-r8, r10, r11}       @ preserved registers
	bl 	malloc			@ allocate memory to store string and next/prev addresses
	pop	{r1-r8, r10, r11}       @ pop registers
	mov	r5, r0			@moving address of new node to r5

	mov	r0, r2		@setting r0 to the head node
	mov	r4, #0		@setting count to 0

nextaddress:
	mov	r3, r0		@store previous address into r3
	ldr	r0, [r0, #4]	@get next address

	cmp	r0, #0		@compare address to 0
	beq	error		@if equal then jump to end

	add	r4, #1		@increment counter by 1

	cmp	r4, r7		@compare count to node #
	blt	nextaddress	@jump to next node

@moving pointers around
	str	r5, [r3, #4]	@storing 'new node address' into previous node's next

	ldr	r2, [r0]	@loading prev address in node to delete
	str	r2, [r5]	@setting prev address in new node

	ldr	r2, [r0, #4]	@loading 'next address' from 'node to delete' to r2
	str	r2, [r5, #4]	@setting next address in new node

	cmp	r2, #0		@compare if the next address is 0x00000000
	beq	endptr		@skip over setting next pointers

	str	r5, [r2]	@setting the prev address in 'next node' to the new node
endptr:
	push	{r1-r8, r10, r11}       @ preserved registers
	bl	free			@frees the memory at the address in r0 (node to delete)
	pop	{r1-r8, r10, r11}       @ pop registers

	mov	r2, #0		@setting count to 0
	mov 	r4, #8		@setting offset for copy

copy:
	ldrb	r3, [r8, r2]	@loading string byte offset by r2
	strb	r3, [r5, r4]	@storing string byte in new node offset by r4

	add	r2, #1		@increment counter by 1
	add 	r4, #1		@increment offset of node by 1

	cmp	r2, r6		@compare count to total length
	blt	copy		@if less then jump to copy

	mov	r3, #10		@newline character
	strb	r3, [r5, r4]	@store newline

	add	r4, #1		@add for null ptr
	ldrb	r3, [r8, r2]	@loading null ptr
	strb	r3, [r5, r4]	@storing null ptr

	mov	r0, #1		@set r0 to 1, indicate program ran
	b	end

error:
	mov	r0, #0		@set r0 to 0, indicates no node found

end:
	pop	{lr}			@preservs the link register for recursion
	pop	{sp}                    @ pop stack pointer
	pop	{r4-r8, r10, r11}       @ pop the preserved regiesters for aapcs

	bx      lr    	            @ back to the main where it is called

    .end
