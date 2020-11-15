@ Add_String_keyboard function
@ Inputs:	r0 = Address of head node
@ Outputs:      none
@ Purpose:      outputs all strings to the console

	.data

crCr: .byte 10		@byte for carrage return
						
	.global			Add_String_keyboard		
																											
	.text

Add_String_keyboard:
    
	push	{r4-r8, r10, r11}      @ push preserved registers for aapcs
	push 	{sp}                   @ push stack pointer
	push	{lr}			@preserve the link register for recursion

nextnode:
	mov	r2, #0		@setting count to 0

	add r0, r0, #4		@offset the address by 4 to access the start of next

nextaddress:
	ldrb	r3, r0, r2	@needs HELP fix? -should copy address @r0 into r3
	strb	r3, r1, r2	@next address should be in r1
	
	add	r2, #1		@increment counter by 1
	cmp	r2, #4		@compare counter to 4
	blt	nextaddress	@if the counter is less then branch

	cmp	r1, #00000000	@compare address to 00000000
	beq	end		@if equal then jump to end

	add	r4, r1, #8	@add 8 to r1 to get to the string address

	mov	r0, r4		@moving address into r0
	bl	putstring	@call putstring to display

	ldr	r0, =crCr	@move crCr into r0
	bl	putch		@print using putch

	mov	r0, r1		@move address into r1
	b	nextnode	@jump to next node

end:
	pop	{lr}			@preservs the link register for recursion
	pop	{sp}                    @ pop stack pointer
	pop	{r4-r8, r10, r11}       @ pop the preserved regiesters for aapcs

	bx      lr    	            	@ back to the main where it is called

    .end
