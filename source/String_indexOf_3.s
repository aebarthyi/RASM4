/* --String_indexOf_3.s */
@ String index function
@ Requirements r0 = address of string to be searched
@	           r1 = address of string to be checked against string
@ Outputs      r0 = integer of the index where the string is found, if not found then -1 is returned
@ 

	.data
						
	.global			String_indexOf_3			
																											
	.text

String_indexOf_3:
    push {r4-r8, r10, r11}      @ push preserved registers for aapcs
    push {sp}                   @ push stack pointer
    
    mov     r2, #0              @ start our counter at 0   
    mov     r6, #0              @ storing counter 
    
loop:
    mov     r4, #0              @ start counter of second string at 0 
    mov     r2, r6              @ move last known index to r2
    ldrb    r3, [r0, r2]        @ load character pointed to by r0
    ldrb    r5, [r1, r4]        @ load character pointed to by r1
    cmp     r5, r3              @ compare character to character passed by user
    beq     firstFound          @ if first character is found jump to first found loop
    cmp     r3, #0	            @ compare to find null termination
    beq	    exitNoSln		    @ go to no findings exit branch
    add     r2, #1              @ increment r2 by 1 
    mov     r6, r2              @ set index storage
    b       loop                @ back to loop

firstFound:
    add     r2, #1              @ increment the string pointer by 1
    add     r4, #1              @ increment the string pointer by 1
    ldrb    r3, [r0, r2]        @ load character pointed to by r0
    ldrb    r5, [r1, r4]        @ load character pointed to by r1
    cmp     r5, #0              @ check if second string is over
    beq     exit                @ if second string finished then exit
    cmp     r3, r5              @ check if character found matches
    addne   r6, #1              @ increment original string pointer for next loop iteration
    bne     loop                @ go back to loop if not found
    b       firstFound          @ back to firstFound loop
    
exit:
    mov     r0, r6               @ move counter to r0
    
    pop	{sp}                    @ pop stack pointer
    pop	{r4-r8, r10, r11}       @ pop the preserved regiesters for aapcs
    bx      lr    		@ back to the main where it is called

exitNoSln:
    mov     r0, #-1		@ move -1 into ouput register for no found index error

    pop	{sp}                    @ pop stack pointer
    pop	{r4-r8, r10, r11}       @ pop the preserved regiesters for aapcs
    bx      lr    		@ back to the main where it is called

    .end
