;Name of student: Samuel Armenta
;Class: CISC 310
;Date: 12/1/18
;description: have main call a procedure that passws an array and and size of array
;and returns the largest number in array
;+++++++=====+++++=======
;.386
;.model flat, stdcall           this section not needed with library 
;.stack 4096
;+++++++=========+++++++

;ExitProcess PROTO, dwExitCode:DWORD		no longer needed
 
INCLUDE Irvine32.inc				;include irvine library
FindLargest PROTO, arrP:PTR sdword, iter:dword  ;prototype of procedure
Cout PROTO, arrPrint: PTR SDWORD, iter: dword

.data
firstArr sdword 1,5,100,-70							; initialize arrays
secondArr sdword -300, 30,-2, 400,1, -400
thirdArr sdword 1,-1,2,-2, 700, 3,-3,100,-100
arrSize dword ?										; variable for array size
str1 byte "The Largest Value in the array is: ", 0					; string for each array
str2 byte "Array that is searched: ", 0

.code
main PROC
mov arrSize, LENGTHOF firstArr				;initialize array size
Invoke Cout, ADDR firstArr, arrSize
INVOKE FindLargest, ADDR firstArr, arrSize  ;pass in array and its size
mov edx,OFFSET str1							;pass string to register 
call WriteString							;library precedure to print string
call WriteInt								;library procedure to write int in eax
call Crlf									;endl or \n

mov arrSize, LENGTHOF secondArr				;initialize array size
Invoke Cout, ADDR secondArr, arrSize
INVOKE FindLargest, ADDR secondArr, arrSize ;pass in array and its size
mov edx,OFFSET str1							;pass string to register 
call WriteString							;library precedure to print string
call WriteInt								;library procedure to write int in eax
call Crlf									;endl or \n

mov arrSize, LENGTHOF thirdArr				;initialize array size
Invoke Cout, ADDR thirdArr, arrSize
INVOKE FindLargest, ADDR thirdArr, arrSize  ;pass in array and its size
mov edx,OFFSET str1							;pass string to register 
call WriteString							;library precedure to print string							
call WriteInt								;library procedure to write int in eax
call Crlf									;endl or \n

;invoke ExitProcess, 0
exit
main ENDP

;PROCEDURE: TAKES TWO PARAMETERS. ONE: ARRAY TWO: SIZE OR ARRAY
;PROCEDURE RETURNS THE LARGEST NUMBER IN THE ARRAY
FindLargest PROC USES esi ecx edx, arrP: PTR sdword, iter:dword

mov esi, arrP  ;pass array address to esi
mov ecx, iter	;pas the size of array to ecx, itterater of loop
mov eax, [esi] ;move first value to eax, default value

l1:						;begin loop
	mov edx, [esi]		;move value to edx
	cmp edx, eax		;compare the last high value with next number in array
	jg foundNew			; (JG)->jump (ifleft op > right op)pg235
	jmp iterate			;if not greater jump to iterate esi
	foundNew:			;if next number is bigger jump here
		mov eax, edx	;move new largest number to eax

	iterate:			
		add esi, 4		;iterate to next number
loop l1					;if ecx not 0 loop

ret						;return to start
FindLargest ENDP		

Cout PROC USES ecx esi, arrPrint: PTR SDWORD, iter: dword
mov edx, OFFSET STR2
CALL WriteString
mov esi, arrPrint ; point to array that needs to be printed
mov ecx, iter		;set interater for count
PrintArray:
mov eax, [esi]		;move number in array to eax
call WriteInt		;print number
add esi, 4			;move to next number in array
Loop PrintArray		;
call Crlf

ret
Cout ENDP

END main
