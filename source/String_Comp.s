@ String_Comp function
@ Requirements: r0 = address of string
@		r1 = address of sub string
@ Outputs: 	r0 = 1 / 0 if strings are equal
@ Purpose: to compare a sub string against a string ignoring case
@	   and return a bool if there is a match
	
	.global String_Comp	@provide program starting address to linker

	.text

String_Comp:
	push	{r4-r8, r10, r11} 	@preserve registers
	push	{sp}			@preserve stack pointer
	push	{lr}			@preserve the link register for recursion

	mov	r5, r0		@back up string address
	mov	r6, r1		@back up substring address

	mov	r0, r6		@move address of substring into r0

	bl	String_Length	@call string length to check the length of the substring

	mov	r2, r0		@setting counter to length of substring
	mov	r3, #0		@setting string counter to 0

	cmp	r2, #0		@compare the substring length to 0
	beq	true		@if 0 then branch to true

	mov	r8, #0		@set if in innerloop or not

firstPass:
	cmp	r8, #0		@compare if r8 is 0
	beq	skipCount	@if equal skip reseting count
	mov	r3, r7		@reset count from r7
	
skipCount:
	mov	r8, #0		@set if in innerloop or not
	ldrb	r0, [r5, r3]	@loading the character at address r4 + r2 into r0
	ldrb	r1, [r6]	@loading the first substring character

	add	r3, #1		@increment string counter

	cmp	r0, #0		@compare the string character to 0
	beq	false		@jump to false
	
	cmp	r0, r1		@comparing the characters to each other
	beq	loop		@if equal jump to loop

	cmp	r0, #64		@checking if alpha character
	blt	firstPass	@if not less that 64 jump back

	cmp	r0, #122	@check if alpha character
	bgt	firstPass	@if greater than 122 jump back	

@checking the 6
	cmp	r0, #91		@compare if it is a special character
	beq	firstPass	@if it is, then jump

	cmp	r0, #92		@compare if it is a special character
	beq	firstPass	@if it is, then jump

	cmp	r0, #93		@compare if it is a special character
	beq	firstPass	@if it is, then jump

	cmp	r0, #94		@compare if it is a special character
	beq	firstPass	@if it is, then jump

	cmp	r0, #95		@compare if it is a special character
	beq	firstPass	@if it is, then jump

	cmp	r0, #96		@compare if it is a special character
	beq	firstPass	@if it is, then jump

@checking for upper or lower case
	bgt	lowercase
	blt	uppercase

loop:
	mov	r4, #1		@setting substring counter to 1
	mov	r7, r3		@saving the string counter
	mov	r8, #1		@move 1 into r8 indicating that inner loop has started

innerLoop:
	cmp	r4, r2		@compares the substring count to the length
	beq	true		@if reached the end of substring then jump to true

	ldrb	r0, [r5, r3]	@loading the character at address r4 + r2 into r0
	ldrb	r1, [r6, r4]	@loading the first substring character

	add	r3, #1		@increment string counter by 1
	add	r4, #1		@increment substring counter by 1

	cmp	r0, r1		@comparing the characters to each other
	beq	innerLoop	@if equal jump to loop

	cmp	r0, #64		@checking if alpha character
	blt	firstPass	@if not less that 64 jump back

	cmp	r0, #122	@check if alpha character
	bgt	firstPass	@if greater than 122 jump back	

@checking the 6
	cmp	r0, #91		@compare if it is a special character
	beq	firstPass	@if it is, then jump

	cmp	r0, #92		@compare if it is a special character
	beq	firstPass	@if it is, then jump

	cmp	r0, #93		@compare if it is a special character
	beq	firstPass	@if it is, then jump

	cmp	r0, #94		@compare if it is a special character
	beq	firstPass	@if it is, then jump

	cmp	r0, #95		@compare if it is a special character
	beq	firstPass	@if it is, then jump

	cmp	r0, #96		@compare if it is a special character
	beq	firstPass	@if it is, then jump

@checking for upper or lower case
	bgt	lowercase
	blt	uppercase
	
lowercase:
	sub	r0, #32		@subtract 32 to change to uppercase
	cmp	r0, r1		@compare back to substring
	bne	firstPass	@if not equal jump back

	cmp	r8, #0		@if first loop
	beq	loop		@jump to loop

	b	innerLoop	@else jump to innerloop

uppercase:
	add	r0, #32		@subtract 32 to change to lowercase
	cmp	r0, r1		@compare back to substring
	bne	firstPass	@if not equal jump back

	cmp	r8, #0		@if first loop
	beq	loop		@jump to loop

	b	innerLoop	@else jump to innerloop

false:
	mov 	r0, #0		@setting the bool answer to 0
	b	end		@jumping to the end
true:
	mov	r0, #1		@setting the bool answer to 1

end:
	pop	{lr}			@preservs the link register for recursion
	pop	{sp}			@preserve stack pointer
	pop	{r4-r8, r10, r11}	@preserve registers

	bx lr				@end of function
	.end