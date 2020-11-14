@ Insert_List function
@ Inputs       r0 = address of first node in linked list
@ 	       r1 = asciz string to store in the linked list
@ Outputs      r0 = address of first node in linked list
@	       r1 = number of nodes in the linked list

	.data
						
	.global			Insert_List		
																											
	.text

Insert_Line: @@@@@@@ UNFINISHED @@@@@@@
    
    mov	r4, r0			@ save first node in r4 for returning
    push {r4-r8, r10, r11}      @ push preserved registers for aapcs
    push {sp}                   @ push stack pointer
    
    mov	r3, #0			@ setup counter for nodes traversed
    
loop:
    add r0, #4			@ add offset of 4 bytes to get next address
    ldr	r0, [r0]		@ load next node address
    cmp r0, #0x00000000		@ check if nullptr
    movne r3, r0		@ copy address if not the end, so we keep track of previous nodes
    bne loop			@ if not end of list loop again
    
    mov	r3, r0			@ store address of current node
    mov r0, r1			@ move string into r0 register
    bl	String_Length		@ get length of string
    mov	r2, r0			@ keep track of string length
    add r0, #8			@ add 8 to the length to account for prev and next pointers
    bl 	malloc			@ allocate memory and get address to it
    
    str	r3, [r0]		@ store prev pointer
    add r0, #8			@ add 8 bytes to get to data section
    str	r1, 
    

    pop	{sp}                    @ pop stack pointer
    pop	{r4-r8, r10, r11}       @ pop the preserved regiesters for aapcs
    mov	r0, r4			@ get head address for returning
    bx      lr    	        @ back to the main where it is called

    .end
