Include Irvine32.inc

CountNearMatch PROTO,arr1:PTR sdword, arr2: PTR sdword, arrSize:dword, diff:dword   
Cout PROTO, array1: PTR sdword, sizeA:dword


.data 
str0 byte "THE NUMBERS WE ARE CHECKING ARE:",0													;first string to tell numes that are checked
str1 byte "THE AMOUNT OF NUMBERS THAT WERE LESS THAN OR equal TO THE DIFFRENCE ALLOWED: ", 0	;second string inform the amount that was differnet
str2 byte "THE DIFFERENCED ALLOWED IS: ",0

;=============== START OF ARRAY INITIALIZATION==============
firstArr sdword 1, 2, 3, 4, 5, 6	
secArr   sdword 6,5,4,3,2,1

thirdArr sdword 34,0,-4,200,-5,-2,9,200
fourthArr sdword 100,4,98,3,4,56,-1,0

fifArr sdword 4,6,7,8,9
sixArr sdword 5,7,10,5,5
;==============================================================

arrSize1 dword ?   ;VARIABLE FOR SIZE OF ARRAY
allow dword ?		;VARIABLE FOR THE DIFFERENCED ALLOWED

.code
Main PROC

mov arrSize1, LENGTHOF firstArr			;INITIALIZE WITH THE SIZE OF THE ARRAY
mov allow,3								; INITIALIZE WITH THE DIFFERENC

Mov edx, OFFSET str0   ;SET REGISTER TO PRINT FIRST STRING
call WriteString		;PRINT STRING
call Crlf				;SPACE

INVOKE Cout, ADDR firstArr, arrSize1	;PRINT NUMBERS THAT ARE CHECKED
INVOKE Cout, ADDR secArr, arrSize1		;PRINT NUMBERS THAT ARE CHECKED

INVOKE CountNearMatch, ADDR firstArr, ADDR secArr, arrSize1, allow ;CHECK NUMBERS

;=================


mov arrSize1, LENGTHOF thirdArr      ;INITIALIZE WITH THE SIZE OF THE ARRAY
mov allow,20						 ;INITIALIZE WITH THE DIFFERENC

Mov edx, OFFSET str0   ;SET REGISTER TO PRINT FIRST STRING
call WriteString		;PRINT STRING
call Crlf				;SPACE
INVOKE Cout, ADDR thirdArr, arrSize1  ;PRINT NUMBERS THAT ARE CHECKED
INVOKE Cout, ADDR fourthArr, arrSize1 ;PRINT NUMBERS THAT ARE CHECKED

INVOKE CountNearMatch, ADDR thirdArr, ADDR fourthArr, arrSize1, allow  ;CHECK NUMBERS

;=================


mov arrSize1, LENGTHOF fifArr			;INITIALIZE WITH THE SIZE OF THE ARRAY
mov allow,1								;INITIALIZE WITH THE DIFFERENC

Mov edx, OFFSET str0			;SET REGISTER TO PRINT FIRST STRING
call WriteString			;PRINT STRING
call Crlf					;SPACE

INVOKE Cout, ADDR fifArr, arrSize1  ;PRINT NUMBERS THAT ARE CHECKED
INVOKE Cout, ADDR sixArr, arrSize1  ;PRINT NUMBERS THAT ARE CHECKED

INVOKE CountNearMatch, ADDR fifArr, ADDR sixArr, arrSize1, allow  ;CHECK NUMBERS


exit
main ENDP

;===============
;PROCEDURE: TAKE IN TWO PERAMATERS. ONE: A POINTER TO AN ARRAY. TWO: THE SIZE OF AN ARRAY
;IT PRINTS THE NUMBERS OF AN ARRAY

Cout PROC USES esi ecx, array1: PTR sdword, sizeA:dword    
mov ecx, sizeA		;MOVE SIZE OF ARRAY IN ECX TO ITERATE THROUGH THE LOOP
mov esi, array1		;MOVE ARRAY ADDRESS TO ESI
			
L5:
mov eax,[esi]		;MOVE NUMBER TO EAX
call WriteInt		;PRINT NUMBER IN EAX
add esi,4			; MOVE ESI TO NEXT NUMBER
Loop L5				;LOOP WHILE ECX IS NOT 0
call Crlf			;SPACE
ret					;RETURN TO STACK
Cout ENDP		
;===============

;PROCEDURE: TAES IN 4 PERAMITERS. ONE:POINTER TO ARRAY. TWO: POINTER TO ARRAY. THREE: SIZE OF ARRAY. FOUR: DIFFERENCED ALLOWED
;THIS PROCEDURE TAKES IN 2 ARRAYS, SUBTRACTS THE FIRST ELEMENT AND SEES IF THE DIFFERENCE IS GREATER THAN ALLOWED. 
;AND DOES THE SAME FOR THE REST OF THE ELEMENTS. 
CountNearMatch PROC USES esi ebx ecx edx, arr1:PTR sdword, arr2: PTR sdword, arrSize:dword, diff:dword

mov edx, OFFSET str2	;SET REGISTER TO PRINT SECOND STRING
call WriteString		;PRINT SECIND STRING
mov eax,diff			; move diff to eax to print out
call WriteInt			;PRINT THE NUMBER OF DIFFERENCE
call Crlf				;SPACE

mov esi, arr1		;MOVE FIRST ARRAY ADDRESS TO ESI	
mov ebx, arr2		;MOVE SECOND ARRAY ADDRESS TO EBX

mov ecx, arrSize	;MOVE ARRAY SIZE TO ECX FOR ITERATION OF THE LOOP
mov eax, 0			; SET EAX TO 0, INITIALIZE

L2:
mov edx, [esi]	;PLACE CURRENT ELEMENT IN EDX
sub edx, [ebx]	;SUBTRACT CURRET FIRST ARRAY ELEMENT WITH CURRENT SECOND ARRAY ELEMENT 

cmp edx,diff	; COMARE THE DIFFERENCE WITH THE DIFFERNCED ALLOWED
jg L3			; IF ARRAY DIFFERENCE IS BIGGER MAKE A JUMP

inc eax			; IF DIFFERENCE IF BIGGER INCREMENT EAX

L3: 
add esi,4		; MOVE NEXT NUMBER IN ARRAY 1
add ebx,4		; MOVE TO NEXT NUMBER IN ARRAY 2

loop L2			;LOOP TILL ECX IS 0
mov edx, OFFSET str1	;SET REGISTER TO PRINT SECOND STRING
call WriteString		;PRINT SECIND STRING
call WriteInt			;PRINT THE NUMBER OF DIFFERENCE
call Crlf				;SPACE
call Crlf

ret				;RETURN TO STACK

CountNearMatch ENDP


END main






