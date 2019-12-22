Include Irvine32.inc

.data
str1 byte "These are the 10 numbers that are input, and the grade given: ", 0  ;initiate str1		
str2 byte ": ",0			;initiate str2

.code
main PROC				
mov ecx, 10						;set loop iterator
mov edx, offset str1			; set edx to str1
call WriteString				; print str1
call Crlf					; space
L1:							;start loop
mov eax, 101				;set the range for RandomRange
call RandomRange			;call RandomRange

call WriteInt				;print random int
mov edx, offset str2		;set edx to str2
call WriteString			;print out str2
call CalcGrade				;call CalcGrade to get letter grade
call WriteChar				; print letter grade
call Crlf					; space

Loop L1					; loop if not = 0

exit
main ENDP

;CalcGrade takes the random number in eax and find the letter grade assosiated with it
CalcGrade PROC
;if eax >= 90 dl = A
mov dl,'A'
cmp eax, 90
jae L2  ;jump to end

;if eax >= 80 dl = B
mov dl,'B'
cmp eax,80
jae L2;jump to end

;if eax >= 70 dl = C
mov dl,'C'
cmp eax,70
jae L2;jump to end

;if eax >= 60 dl = D
mov dl,'D'
cmp eax,60
jae L2 ;jump to end

; if no jump taken dl = F
mov dl,'F'


L2: mov al,dl ;place letter in al
ret

CalcGrade ENDP
END main