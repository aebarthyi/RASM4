@ Line_Length function
@ Inputs: r0 = file handle
@ Outputs r0 = number of characters in a line not including newline
@ Purpose: to count characters in a file line and return them to r0

	.data
						
	.global			Line_Length			
																											
	.text

Line_Length:
    push {r4-r8, r10, r11}      @ push preserved registers for aapcs
    push {sp}                   @ push stack pointer
    
    mov     r3, #0              @ start our counter at 0
    mov     r2, r0              @ move file handle to r2
    mov     r0, #4              @ move 4 into r0
    bl      malloc              @ allocate 4 bytes as buffer for character checking
    mov     r6, r0              @ save our address for freeing later
    mov     r1, r0              @ move address of allocated memory for reading
    mov     r0, r2              @ move file handle to r0 for reading
    mov     r2, #1              @ set bytes to read to 1
    mov     r7, #3              @ set syscall to read in
    
loop:
    svc     0                   @ syscall to read in a byte from file
    ldr     r4, [r1]            @ load our read in byte
    cmp     r4, #10             @ check for newline
    cmpne   r0, #0              @ check if end of file
    beq     exit                @ branch to exit 
    add     r3, #1              @ increment counter if not newline
    b       loop                @ back to loop if newline not found
    
exit:
    mov     r0, r6              @ get our allocate mem address
    bl      free                @ free up memory used
    mov     r0, r3              @ move counter to r0
    
    pop	{sp}                    @ pop stack pointer
    pop	{r4-r8, r10, r11}       @ pop the preserved regiesters for aapcs
    bx      lr            		@ back to the main where it is called
    
    .end
