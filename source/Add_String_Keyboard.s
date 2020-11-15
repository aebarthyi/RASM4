@ Add_String_keyboard function
@ Inputs:	r0 = Address of the string to add
@		r1 = Address of last node
@ Outputs:      r0 = Address of the new node in linked list
@ Purpose:      creates an empty linked list head 

	.data
						
	.global			Add_String_keyboard		
																											
	.text

Add_String_keyboard:
    
	push	{r4-r8, r10, r11}      @ push preserved registers for aapcs
	push 	{sp}                   @ push stack pointer
	push	{lr}			@preserve the link register for recursion
    
	mov	r6, r0		@ move address of string into r6
	bl	String_Length	@ call string length
	
	add	r0, r0, #8	@adding 8 to string length
	mov	r5, r0		@moving length into r5

	push	{r1-r8, r10, r11}       @ preserved registers
	bl 	malloc			@ allocate memory to store string and next/prev addresses
	pop	{r1-r8, r10, r11}       @ pop registers

	mov	r2, #0		@setting count to 0
	mov	r4, #0		@setting temp count to 0
	mov	r7, #00		@setting r7 to 00

copyaddressprev:				
	ldrb	r3, r1, r2	@needs HELP fix?
	strb	r3, [r0, r2]	@storing r2 into r5 + r1

	add	r2, #1		@increment counter by 1

	cmp	r2, #4		@compare counter to 4
	blt	copyaddressprev	@if less then jump to copy	

copyaddressnext:				
	ldrb	r3, r0, r4	@needs HELP fix?
	strb	r3, [r1, r2]	@storing r2 into r5 + r1

	strb	r7, [r0, r2]	@writing 0's into current node's next

	add	r2, #1		@increment counter by 1
	add	r4, #1		@increment temp counter by 1

	cmp	r2, #8		@compare counter to 8
	blt	copyaddressnext	@if less then jump to copy

	mov	r4, #0		@reset temp counter to 0

copy:
	ldrb	r3, [r6, r4]	@loading string byte offset by r4
	strb	r3, [r0, r2]	@storing string byte in new node offset by r2

	add	r2, #1		@increment counter by 1
	add	r4, #1		@increment temp counter by 1

	cmp	r2, r5		@compare count to total length
	blt	copy		@if less then jump to copy

	pop	{lr}			@preservs the link register for recursion
	pop	{sp}                    @ pop stack pointer
	pop	{r4-r8, r10, r11}       @ pop the preserved regiesters for aapcs

	bx      lr    	            	@ back to the main where it is called

    .end
