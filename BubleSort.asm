INCLUDE Irvine32.inc

; These are prototypes of the procedures
BubbleSort PROTO pArray:PTR SDWORD, Count:dWord, Ex: byte, check: dword
Cout PROTO arrPrint: PTR SDWORD, iter: dword
BinarySearch PROTO
FillArray PROTO fillArr: PTR sdword, fillSize:DWORD, fillAmount:DWORD

;==============================================data
.data
;All out puts in the progra 
str1 byte "These are the numbers before the sort: ", 0
str2 byte "These are numbers after sort: ", 0
str3 byte "Number of complete pass of array: ", 0 
str4 byte "THe number searched for: ", 0
str5 byte "This is the array: ", 0
yes byte "The number is in the array: ", 0
no byte "The number is not in the array: ",0


arrBub1 sdword 20 dup (?)			;array used to in proram
arrBub2 sdword 1,2,3,4,5,6,7,8,9,10
sizeA sdword ?		;used to store size of array
swapA byte ?		;used to store swap in a procedure
cee dword 0			; hold the amount of times passed in the buble sort proc
s byte 5			;iter for endMain Loop

;===========================start main
.code
main PROC
endMain:		;loop through s -1 times

mov eax, 100		; set number for Ransdom
Call RandomRange		
mov ebp, eax		;move random num to ebp

;======================== print string for rand num and the number
mov edx, offset str4	
call WriteString
call WriteInt
call crlf
;=======================

;=================	fill the array, sort the array and print the array
mov sizeA, LENGTHOF arrBub1
Invoke FillArray, ADDR arrBub1, 101, 20
INVOKE BubbleSort, ADDR arrBub1, sizeA, swapA, cee
INVOKE cout, ADDR arrBub1, sizeA
;==================

;==================	push the info for binary search onto the stack
mov edx, 0
mov edi,0
push OFFSET arrBub1
push ebp
push sizeA
push edx
push edi
;=================

INVOKE BinarySearch  ;call for search

;=================== now that we are back from the binar search pop all info to reg
pop edi
pop edx
pop ebx
pop ebp
pop [esi]
;====================

;======================== print out if the number searched for was in array, 0 = yes, -1 = no
mov edx, offset yes
cmp eax,0
Je Print 
mov edx, offset no
Print: call WriteString
call crlf
call crlf
;=======================

dec s		;=============== s-1 then compare if to loop again
cmp s,0
ja endMain

mov eax,10
mov edx, offset str4	
call WriteString
call WriteInt
call crlf
mov sizeA,  LENGTHOF arrBub2
INVOKE cout, ADDR arrBub2, sizeA
;==================	push the info for binary search onto the stack
mov ebp, 10
mov edx, 0
mov edi,0
push OFFSET arrBub2
push ebp
push sizeA
push edx
push edi
;=================

INVOKE BinarySearch  ;call for search

;=================== now that we are back from the binar search pop all info to reg
pop edi
pop edx
pop ebx
pop ebp
pop [esi]
;====================

;======================== print out if the number searched for was in array, 0 = yes, -1 = no
mov edx, offset yes
cmp eax,0
Je Print1 
mov edx, offset no
Print1: call WriteString
call crlf
call crlf

exit
main ENDP
;========================================================================================end main

;this prcedure takes a pointer to an array, and fills the array with random number
;fillArr:points to array, fillSize: gives highest numbe can be placed in array, fillAmount is the size of the array
FillArray PROC USES EAX ESI ecx, fillArr: PTR sdword, fillSize:DWORD, fillAmount:DWORD

mov ecx, fillAmount		;iter through loop
mov esi, fillArr		; esi takes address of array

fillA:
mov eax, fillSize	;set the highest number that can be set
Call RandomRange	;call for random number
mov [esi],eax		;place random num is array
add esi, 4			;point to next address
Loop fillA			

ret 
FillArray ENDP

;================================================================================  

;This procedure prints out an array. 
;arrPrint: points to the array, iter: aount to iterate through loop
Cout PROC USES ecx esi, arrPrint: PTR SDWORD, iter: dword
mov edx, offset str5
call WriteString
mov esi, arrPrint		;esi points to array
mov ecx, iter			;ecx is set to amount to iterate
PrintArray:		
mov eax, [esi]			;move number in array to eax
call WriteInt			;print the number
add esi, 4				; point to next number
Loop PrintArray
call Crlf

ret
Cout ENDP

;==========================================================================================

;THIS PROCEDURE TAKES AN ARRAY AND ARRANGES THE VALUES IN ASSENDING ORDER
; PaRRAY: POINTER TO ARRAY, COUNT: SIZE OF ARRAY, EX: IF THERE IS A SWAP EX IS SET CHECK: AMOUNT OF TIMES THE ARRAY WAS PROCCESSED
BubbleSort PROC USES eax ecx esi, pArray:PTR SDWORD, Count:dWord, Ex: byte, check: dword

mov ecx, Count			;ECX SET ITERATOR	
dec ecx					

L1: push ecx			;HOLD ECX ORIGINAL VALUE
	mov esi, pArray			; ESI SET TO ARRAY
	mov Ex, 0			
L2: mov eax, [esi]			;PLACE NUMBER IN EAX
	cmp [esi+4], eax		;COMPARE THE LAST NUMBER WIHT THE NEXT NUMBER
	jg L3					; IF NEXT > LAST NO CHANGE
	xchg eax,[esi+4]		;ELSE SWAP NUMBERS
	mov [esi], eax			; PLACE NEXT IN LAST
	mov Ex, 1				;FLAG A MOVE
L3: add esi,4				; POINT TO NEXT NUMBER
	loop L2					; SEND BACK FOR ANOTHER CHECK

	inc check			; KEEP COUNT OF PASSES
	cmp Ex, 1			;IF THERE WAS AN EXCHANGE, LETS CHECK ARRAY AGAIN
	jb L4				;ELSE END THE SORT
	
	pop ecx		;SET ECX TO ORIGINA VALUE 
loop L1

L4: 
;mov edx, OFFSET STR3
;call WriteString
;mov eax, check
;call WriteInt
;call Crlf
ret
BubbleSort ENDP

;====================================================bsearch======================
;this procedue uses the information on the stack to find if there is a number in an array;
;REGISTERS USE:
	;ESI - POINTS TO THE ARAY
	;EBP - POINTS HOLDS THE NUMBER TO LOOK FOR
	;EBX - HOLD THE HIGHEST NUMBER
	;EDX - HOLDS LOWEST NUMBER
	;EDI - HOLDS THE MIDDLE NUMBER
	;ECX - USED FOR A ITERATION
	;EAX - HOLDS 0 FOR FOUND NUMBER/ -1 NUMBER NOT FOUND

BinarySearch PROC
mov esi, [esp+20] ;point to array

mov ebp, [esp+16] ; number to look for

mov ebx, [esp+12] ; high number

mov edx,[esp+8]  ;low number

mov edi,[esp +4]  ;midmov 

L1: 
	cmp edx, ebx		; LETS SEE IF THERE IS ANTHING TO SEARCH FOR 
	je L5

	;mid = last+first / 2			FIND THE MIDDLE NUMER OF THE ARRAY
	mov edi, edx  ; add low
	add edi, ebx  ;add high
	shr edi,1		;div 2
	
	;edx = values[mid]
	mov ecx, edi	;counter	
	
	;==============SET ESI TO THE MIDDLE NUMBER OF THE ARRAY 
setNum:
		add esi, 4		; move esi to num
Loop SetNum
	;==================   ESI=ARRAY[MIDDLE] =========

	;if(edx<searchval)
	cmp [esi],ebp			;cmp arr number and number looking for 
	jge L2					;if <= jump  if > set reg

	;first = mid +1
	mov edx, edi			;	move mid into low
	inc edx					; add 1 to low
	
	;IF NUMBER IS NOT FOUND PUSH INFO ON TO STACK
	push [esp+20]
	push ebp
	push ebx
	push edx
	push edi
	jmp L4

	;(edx > searchVal)
L2:	cmp [esi], ebp          ;cmp arr number and number looking for 
	jle L3					;if found jump L3 else set reg
	
	;last = mid -1
	mov ebx, edi			; move mid to high

	mov edx, 0
	;IF NOT FOUND PUSH INFOR ONTO STACK
	push [esp+20]
	push ebp
	push ebx
	push edx
	push edi
	jmp L4


L4: call BinarySearch	;IF NOT FOUND LETS CALL OURSELF AND ASK FOR HELP

;WOW WHAT A TRIP RET WAS HIT SO LETS CLEAR THE STACK... IN REVERSE ORDER
	pop edi
	pop edx
	pop ebx
	pop ebp
	pop esi

cmp eax,0	
jne L5			;IF EAX IS NOT 0 THEN SET TO -1 AND LETS SEE HOW FAR DOWN WE SEARCHED

L3: mov eax, 0		;IF NUM FOUND SET EAX TO 0 AND LETS GET OUT OF HERE
jmp L9

L5: mov eax, -1		; NUMBER NOT IN ARRAY
	

L9: ret			;BEAM ME UP SCOTTY (AKA POP TO WHERE RTURN ADDRESS IN HELD ON STACK)

BinarySearch ENDP

END main
