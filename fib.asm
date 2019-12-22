
include irvine32.inc

.data 
fibArr dword 8 dup(0)			;initialize an array with 0
str1 byte "These are the first 7 fibonacci numbers: ", 0   ; set string

.code
main PROC
mov ecx,7		; set counter to 7
mov ebx,1		;ebx = 1
mov esi, OFFSET fibArr ; set esi to fibArray
mov edx, offset str1
call writestring

L1:

mov edx, [esi]		;edx = current fib number
mov [esi], ebx		; add edx to current fib number
add ebx, edx		; add curent fib number and edx
mov eax, [esi]		; move current integer to eax
call WriteInt		;print current integer
add esi, 4			; move to next integer
mov edx, [esi-4]	; move last number in fib array to edx
mov [esi], edx		; set last fib array number to next fib array number

loop L1

exit
main ENDP
END main