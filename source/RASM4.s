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

szMsgByte: .asciz "bytes\n"

szTop: 	.asciz 	"Group: Rasm 4|Andrew Barth-Yi|Alex Au|\nClass: CS 3B\nLab: RASM3\nDate: 11/15/2020\n\n"	@ title card
szEmp:	.skip 512
szMsgS: .asciz	"                " @16 byte string for intasc
szFile:	.asciz 	"input.txt"			@file name
szKeyb:	.asciz	"\nEnter string: "		@menu line 1

szMsg1:	.asciz	"               MASM4 TEXT EDITOR\n"			@menu line 1
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
	mov	r0, r8			@move head to r0
	bl	View_Strings		@calls view strings

addString:

	ldr 	r0, =szMsg6		@ load szMsg6
	bl 	putstring		@ display title card

	ldr 	r0, =szMsg7		@ load szMsg7
	bl 	putstring		@ display title card

	ldr	r0, =kbBuf	@ load into r0 address of kbBuf
	mov	r1, #KBSIZE	@ store KBSIZE

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

	bl	getstring	@calls getstring, stores user input address into r0
	mov	r1, r7

	bl	Add_String_keyboard	@calls add string from keyboard
	mov	r7, r0			@move last node into r7

	b	menu

file:
	@file function!!!!!!!!!!!!!!!!!!!!

	b	menu

delete:
	@delete function!!!!!!!!!!!!!!!!!

	b	menu

edit:
	@edit function!!!!!!!!!!!!!!!!!!!!!!

	b	menu

search:
	@search function!!!!!!!!!!!!!!!!!!!

	b	menu

save:
	@save function!!!!!!!!!!!!!!!!!!
	
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
