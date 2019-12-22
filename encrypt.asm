 INCLUDE Irvine32.inc 

.data 
BUFMAX = 500 
sPrompt BYTE "Enter the plain text:", 0 
sEncrypt BYTE "Cipher text:         ", 0 
sDecrypt BYTE "Decrypted:           ", 0 
buffer BYTE BUFMAX+1 DUP(0) 
bufSize DWORD ?
KEY BYTE "ABXmv#7", 0 
 
.code 
main PROC 
mov ebx,0
L1:
call InputTheString 
call TranslateBuffer 
mov edx, OFFSET sEncrypt 
call DisplayMessage 
call TranslateBuffer 
mov edx, OFFSET sDecrypt 
call DisplayMessage 
inc ebx
cmp ebx,2
jbe L1
exit 
main ENDP 
 
;===================================================================== 
InputTheString PROC 
; Prompts user for a plaintext string. Saves the String and its length 
;pre: nothing 
;post: nothing 
; ==================================================================== 
;pushad 
mov edx, OFFSET sPrompt 
call WriteString 
mov ecx, BUFMAX 
mov edx, OFFSET buffer 
call ReadString 
mov bufSize, eax 
call Crlf 
;popad 
ret 
InputTheString ENDP 
 
; ==================================================================== 
DisplayMessage PROC 
; Displays the encrypted of decrypted message. 
; Receives: EDX points to the message 
; Returns: Nothing 
; ==================================================================== 
;pushad 
call WriteString 
mov edx, OFFSET buffer 
call WriteString 
call Crlf 
call Crlf 
;popad 
ret 
DisplayMessage ENDP 
 
;==================================================================== 
TranslateBuffer PROC 
; Translates the string by exlusive-Oring each byte with ; the encryption key byte. 
; Receives: nothing 
; returns: nothing 
;==================================================================== 

;pushad 
mov ecx, bufSize 
mov esi, 0 
mov edi, 0 
L1: 
cmp Key[edi], 0 
jne reached
mov edi, 0 
reached: mov al, key[edi] 
xor buffer[esi], al 
inc esi 
inc edi 
loop L1 
;popad 
ret 
TranslateBuffer ENDP 

END main 
