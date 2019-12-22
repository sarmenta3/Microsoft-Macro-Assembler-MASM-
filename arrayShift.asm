
include irvine32.inc

.data
array dword  10, 20, 30, 40 ; initialize an array with 4 double work intigers
str1 byte "The array befor swap: ", 0
str2 byte "The array after swap: ", 0
.code
main PROC

mov edx, OFFSET str1
call WriteString
mov ecx, LENGTHOF array		; create a counter for loop
mov edi, OFFSET array		;move array to register
l0: 
mov eax, [edi]				; move num in array in eax
call WriteInt				; print the number in eax
add edi,4					; move to next number 
LOOP l0
call crlf

mov edi, OFFSET array ; points register edi to the first address of "array"
mov ebx, OFFSET array
mov ecx, 3	; initialize ecx with 3 so loop with repeat 3 times

L1:							; sart loop
mov eax,[edi+4] 	       ; hold integer that will be moved to 0

mov edx, [ebx]				; hold the number in position "0" in edx

mov [edi+4], edx			; move number in the zero position to the updated position 

mov [ebx], eax				; move the updated intiger to the "0" position 

add edi, 4					; add 4 to num to look at the next updated position 

loop L1						; chec that exc is greater that '0'

mov edx, OFFSET str2
call WriteString
mov ecx, LENGTHOF array		; create a counter for loop
mov edi, OFFSET array		;move array to register
l2: 
mov eax, [edi]				; move num in array in eax
call WriteInt				; print the number in eax
add edi,4					; move to next number 
LOOP l2

EXIT
main ENDP
END main
