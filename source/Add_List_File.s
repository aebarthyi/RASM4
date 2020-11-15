@ Add_List_File function
@ Inputs       r0 = address of first node in linked list
@ 	           r1 = asciz string to store in the linked list
@ Outputs      r0 = address of first node in linked list
@	           r1 = number of nodes in the linked list

	.data
						
	.global		    Add_List_File		
																											
	.text

Add_List_File: 
    
    
    push {r4-r8, r10, r11}      @ push preserved registers for aapcs
    push {sp}                   @ push stack pointer
    
    

    pop	{sp}                    @ pop stack pointer
    pop	{r4-r8, r10, r11}       @ pop the preserved regiesters for aapcs
    
    bx      lr    	            @ back to the main where it is called

    .end
