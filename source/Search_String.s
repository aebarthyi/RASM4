@ Search_String function
@ Inputs:	r0 = Address of head node
@		r1 = address of substring to search
@ Outputs:      r0 = 0 if a string was not outputed
@ Purpose:      outputs all matching strings to the console

	.data

empStr: .skip 8		@empty variable for intasc32
crTab:	.byte 9		@tab character
						
	.global			Search_String		
																											
	.text

Search_String:
    
	push	{r4-r8, r10, r11}      	@push preserved registers for aapcs
	push 	{sp}                   	@push stack pointer
	push	{lr}			@preserve the link register for recursion
	
	mov	r5, #0		@setup line number counter
	mov	r8, r1		@save string address into r8
	mov	r6, #0		@setting number of strings outputed to 0
	
nextaddress:
	ldr	r0, [r0, #4]	@get next address

	cmp	r0, #0		@compare address to 0
	beq	end		@if equal then jump to end

	mov 	r3, r0		@move our current next address to r3
	add	r0, r0, #8	@add 8 to r0 to get to the string address
	add 	r5, #1		@increment line number

@comparing substring 
	mov	r1, r8		@move address of substring into r2
	mov	r7, r0		@copy address of string into r0
	push	{r2-r8, r10, r11}      	@push preserved registers for aapcs
	bl	String_Comp		@calls string comp to compare string
	pop	{r2-r8, r10, r11}     	@pop preserved registers for aapcs

	cmp	r0, #1		@compares the output against 1 if true
	beq	print		@if the string contains a substring, print
	
	mov	r0, r3		@move address back into r0
	b	nextaddress	@if not then next address
	
print:
	mov	r0, r5		@get line number
	
	ldr	r1, =empStr	@get empty string
	bl	intasc32	@turn int into asciz
	mov	r0, r1		@put int string into r0
	bl	putstring	@display line number
	
	ldr r0, =crTab		@get tab character
	bl	putch		@print tab
	
	mov	r0, r7		@moving address into r0
	bl	putstring	@call putstring to display

	mov	r0, r3		@move address into r0
	add	r6, #1		@increment r6 by 1 
	b	nextaddress	@jump to next node

end:
	mov	r0, r6		@returns how many strings were outputed
	
	pop	{lr}			@preservs the link register for recursion
	pop	{sp}                    @ pop stack pointer
	pop	{r4-r8, r10, r11}       @ pop the preserved regiesters for aapcs

	bx      lr    	            	@ back to the main where it is called

    .end
