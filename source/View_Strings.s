@ View_Strings function
@ Inputs:	r0 = Address of head node
@ Outputs:      none
@ Purpose:      outputs all strings to the console

	.data

crCr: .byte 10		@byte for carrage return
empStr: .skip 8		@empty variable for intasc32
crTab:	.byte 9		@tab character
						
	.global			View_Strings		
																											
	.text

View_Strings:
    
	push	{r4-r8, r10, r11}      @ push preserved registers for aapcs
	push 	{sp}                   @ push stack pointer
	push	{lr}			@preserve the link register for recursion
	
	mov r5, #1				@setup line number counter
	
nextaddress:
	ldr		r0, [r0, #4]	@get next address

	cmp	r0, #0	@compare address to 0
	beq	end		@if equal then jump to end

	add	r4, r0, #8	@add 8 to r0 to get to the string address
	mov r3, r0		@move our current next address to r3
	
print:
	mov	r0, r5		@get line number
	
	ldr	r1, =empStr	@get empty string
	bl	intasc32	@turn int into asciz
	mov	r0, r1		@put int string into r0
	bl	putstring	@display line number
	
	ldr r0, =crTab	@get tab character
	bl	putch		@print tab
	
	mov	r0, r4		@moving address into r0
	bl	putstring	@call putstring to display

	mov	r0, r3		@move address into r0
	add r5, #1		@increment line number
	b	nextaddress	@jump to next node

end:
	pop	{lr}			@preservs the link register for recursion
	pop	{sp}                    @ pop stack pointer
	pop	{r4-r8, r10, r11}       @ pop the preserved regiesters for aapcs

	bx      lr    	            	@ back to the main where it is called

    .end
