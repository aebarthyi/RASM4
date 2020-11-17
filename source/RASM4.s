@*****************************************************************************
@Group: Rasm 4|Andrew Barth-Yi|Alex Au|
@Program: RASM4.s
@Class:   CS 3B
@Lab:     RASM4
@Date:    November 13, 2020
@Purpose:
@	Demonstrate external string manipulation functions
@*****************************************************************************

.equ 	KBSIZE, 512 	@ Keyboard input size max

	.data

kbBuf:	.skip	KBSIZE		@ Keyboard buffer

szMsgByte: .asciz " bytes\n"

szTop: 	.asciz 	"Group: Rasm 4|Andrew Barth-Yi|Alex Au|\nClass: CS 3B\nLab: RASM3\nDate: 11/15/2020"	@ title card
szEmp:	.skip 512
szMsgS: .asciz	"                " @16 byte string for intasc
szFile:	.asciz 	"input.txt"			@file name
szKeyb:	.asciz	"\nEnter string: "		@menu line 1
szDel:	.asciz 	"\nEnter a line number: " 	@menu delete function
szEdit:	.asciz 	"\nEnter a new string: "  	@input prompt for edit function
szEdtR:	.asciz 	"\nError, node does not exist"  @error prompt for edit function
szSerc:	.asciz 	"\nEnter the substring to search for: "  @input prompt for search function
szSerN:	.asciz 	"\nNumber of Search results: "  	@output for search function
szSerE:	.asciz 	"\nNo strings were found containing: "  @output for search function

szMsg1:	.asciz	"\n\n               MASM4 TEXT EDITOR\n"			@menu line 1
szMsg2:	.asciz	"        Data Structure Heap Memory Consumption: "	@menu line 2
szMsg3:	.asciz	"        Number of Nodes: "				@menu line 3
szMsg4:	.asciz	"<1> View all strings  \n\n"				@menu line 4
szMsg5:	.asciz	"<2> Add string        \n\n"				@menu line 5
szMsg6:	.asciz	"    <a> from keyboard   \n"				@menu line 6
szMsg7:	.asciz	"    <b> from File     \n\n"				@menu line 7
szMsg8:	.asciz	"<3> Delete string     \n\n"				@menu line 8
szMsg9:	.asciz	"<4> Edit string       \n\n"				@menu line 9
szMsg10:.asciz	"<5> String search     \n\n"				@menu line 10
szMsg11:.asciz	"<6> Save File         \n\n"				@menu line 11
szMsg12:.asciz	"<7> Quit              \n\n"				@menu line 12

crCr: .byte 10			@byte nuber for carrage return
																			@ empty string for output
	.text

	.global main		@ Provide program starting address to linker

main:
	bl	Create_List		@calls create list to start the head of the linked list
	mov	r8, r0			@moves the begining of the head to r8(head)
	mov	r7, r0			@move the head into r7(last node)

	ldr 	r0, =szTop		@ load title card
	bl 	putstring		@ display title card
	
menu:
	ldr 	r0, =szMsg1		@ load szMsg1
	bl 	putstring		@ display title card

	ldr 	r0, =szMsg2		@ load szMsg2
	bl 	putstring		@ display title card

	mov	r0, r8			@move head to r0
	bl	Byte_Count		@call bytecount

	ldr	r1, =szMsgS		@point r1 to blank string
	bl	intasc32		@call intasc32 to convert r0 to ascii
	mov	r0, r1			@move ascii in r1 to r0
	bl	putstring		@print r0

	ldr 	r0, =szMsgByte		@ load szMsgByte
	bl 	putstring		@ display title card

	ldr 	r0, =szMsg3		@ load szMsg3
	bl 	putstring		@ display title card

	mov	r0, r8			@move head to r0
	bl	Node_Count		@call node count

	ldr	r1, =szMsgS		@point r1 to blank string
	bl	intasc32		@call intasc32 to convert r0 to ascii
	mov	r0, r1			@move ascii in r1 to r0
	bl	putstring		@print r0

	@new line
	ldr	r0, =crCr		@load into r0 address of crCr
	bl	putch			@call putstring (external fn) to print the character 'carriage return'

	ldr 	r0, =szMsg4		@ load szMsg4
	bl 	putstring		@ display title card

	ldr 	r0, =szMsg5		@ load szMsg5
	bl 	putstring		@ display title card

	ldr 	r0, =szMsg8		@ load szMsg8
	bl 	putstring		@ display title card

	ldr 	r0, =szMsg9		@ load szMsg9
	bl 	putstring		@ display title card

	ldr 	r0, =szMsg10		@ load szMsg10
	bl 	putstring		@ display title card

	ldr 	r0, =szMsg11		@ load szMsg11
	bl 	putstring		@ display title card

	ldr 	r0, =szMsg12		@ load szMsg12
	bl 	putstring		@ display title card

@input check
	ldr	r0, =kbBuf	@ load into r0 address of kbBuf
	mov	r1, #KBSIZE	@ store KBSIZE

	mov	r6, #0		@moving 0 into r6
	str	r6, [r0]	@setting r0 to 0

	bl	getstring	@calls getstring, stores user input into kbBuf
	bl	ascint32	@calling ascint32(converts szX to a 32 bit integer

	cmp	r0, #1		@compares if the input is less than 1
	blt	error

	cmp	r0, #2		@compares if the input is less than 2
	blt	view

	cmp	r0, #3		@compares if the input is less than 3
	blt	addString

	cmp	r0, #4		@compares if the input is less than 4
	blt	delete

	cmp	r0, #5		@compares if the input is less than 5
	blt	edit

	cmp	r0, #6		@compares if the input is less than 6
	blt	search

	cmp	r0, #7		@compares if the input is less than 7
	blt	save

	cmp	r0, #8		@compares if the input is less than 8
	blt	quit
	
	b	error

view:
	ldr	r0, =crCr		@load carriage return
	bl	putch			@display return

	mov	r0, r8			@move head to r0
	bl	View_Strings		@calls view strings

	b	menu

addString:

	ldr 	r0, =szMsg6		@ load szMsg6
	bl 	putstring		@ display title card

	ldr 	r0, =szMsg7		@ load szMsg7
	bl 	putstring		@ display title card

	ldr	r0, =kbBuf	@ load into r0 address of kbBuf
	mov	r1, #KBSIZE	@ store KBSIZE

	mov	r6, #0		@moving 0 into r6
	str	r6, [r0]	@setting r0 to 0

	bl	getstring	@calls getstring, stores user input into kbBuf
	ldr	r0, [r0]

	cmp	r0, #98		@compare if the input if less that 98 ascii
	blt	keyboard

	b	file

keyboard:
	ldr 	r0, =szKeyb	@ load szKeyb
	bl 	putstring	@ display keyboard enter msg

	ldr	r0, =kbBuf	@ load into r0 address of kbBuf
	mov	r1, #KBSIZE	@ store KBSIZE

	mov	r6, #0		@moving 0 into r6
	str	r6, [r0]	@setting r0 to 0

	bl	getstring	@calls getstring, stores user input address into r0
	mov	r1, r7

	bl	Add_String_keyboard	@calls add string from keyboard
	mov	r7, r0			@move last node into r7

	b	menu

file:
	ldr	r0, =szFile		@get address to file name
	bl	Open_File		@open the file
	mov	r1, r7			@last node
	bl	Add_String_File
	mov	r7, r0			@update last node added
	push	{r7}		@preserve r7 
	bl	Close_File		@close the file and reset the cursor
	pop		{r7}		@pop r7
	b	menu

delete:

	ldr 	r0, =szDel	@ load szDel
	bl 	putstring	@ display keyboard enter msg
	
	ldr	r0, =kbBuf	@ load into r0 address of kbBuf
	mov	r1, #KBSIZE	@ store KBSIZE
	
	mov	r6, #0		@moving 0 into r6
	str	r6, [r0]	@setting r0 to 0
	
	bl	getstring	@calls getstring, stores user input address into r0
	bl	ascint32	@calls ascint32, stores number given by the user
	
	mov	r1, r0		@set arguments for the delete function
	mov 	r0, r8		@set head for delete function
	bl	Delete_String	@call delete string to delete given line number

	cmp	r0, #0		@compare r0 to 0
	beq	delError

	cmp	r1, #1		@compares if last node was deleted
	beq	lastNodeChange

	b	menu

lastNodeChange:
	mov	r7, r2		@resetting last node since last was deleted
	b	menu

delError:
	ldr 	r0, =szEdtR	@ load szDel to "enter a line number:"
	bl 	putstring	@ display keyboard enter msg
	b	menu

edit:
	ldr 	r0, =szDel	@ load szDel to "enter a line number:"
	bl 	putstring	@ display keyboard enter msg

	ldr	r0, =kbBuf	@ load into r0 address of kbBuf
	mov	r1, #KBSIZE	@ store KBSIZE

	mov	r6, #0		@moving 0 into r6
	str	r6, [r0]	@setting r0 to 0

	bl	getstring	@calls getstring, stores user input address into r0
	bl	ascint32	@calling ascint32(converts szX to a 32 bit integer
	mov	r4, r0		@move node # into r4

	ldr 	r0, =szEdit	@ load szEdit
	bl 	putstring	@ display keyboard enter msg

	ldr	r0, =kbBuf	@ load into r0 address of kbBuf
	mov	r1, #KBSIZE	@ store KBSIZE

	mov	r6, #0		@moving 0 into r6
	str	r6, [r0]	@setting r0 to 0

	bl	getstring	@calls getstring, stores user input address into r0
	mov	r1, r0		@move address of string to overwrite into r1
	mov	r2, r8		@moving head into r2
	mov	r0, r4		@move node # back into r0

	bl	Edit_String	@call edit string
	cmp	r0, #0		@compare r0 to 0
	beq	editError

	b	menu

editError:
	ldr 	r0, =szEdtR	@ load szDel to "enter a line number:"
	bl 	putstring	@ display keyboard enter msg
	b	menu

search:
	ldr 	r0, =szSerc	@ load szSerc
	bl 	putstring	@ display keyboard enter msg
	
	ldr	r0, =kbBuf	@ load into r0 address of kbBuf
	mov	r1, #KBSIZE	@ store KBSIZE

	mov	r6, #0		@moving 0 into r6
	str	r6, [r0]	@setting r0 to 0

	bl	getstring	@calls getstring, stores user input address into r0
	mov	r1, r0		@moving substring to search into r1
	mov	r4, r0		@moving substring to search into r4 for back up
	mov	r0, r8		@moving head into r0

	bl	Search_String	@calls search string
	cmp	r0, #0		@compares if r0 is 0
	beq	noResults	@if r0 is 0 then branch to no results

	mov	r4, r0		@mov #of search results into r4
	ldr	r0, =szSerN	@move the search result msg into r0
	bl	putstring	@print the string in r0
	mov	r0, r4		@move the search result back into r0

	ldr	r1, =szMsgS		@point r1 to blank string
	bl	intasc32		@call intasc32 to convert r0 to ascii
	mov	r0, r1			@move ascii in r1 to r0
	bl	putstring		@print r0

	b	menu

noResults:
	ldr 	r0, =szSerE	@ load szSerE
	bl 	putstring	@ display keyboard enter msg

	mov	r0, r4		@mov thestring back into r0 for output
	bl 	putstring	@ display keyboard enter msg

	b	menu

save:
	ldr	r0, =szFile	@load file name
	bl	Open_File	@Open the file again to save
	mov	r1, r0		@file descriptor in r1
	mov	r0, r8		@move head address into r0
	bl	Write_File	@write to file
	
	bl	Close_File	@close the file
	
	b	menu
error:
	b	menu
	@--------------------------------------------------------
quit:
	mov 	r0, #0 		@ set exit status to 0
	mov 	r7, #1		@ service command code to 1

	svc	0 		@ call to linux
	.end
~
~
