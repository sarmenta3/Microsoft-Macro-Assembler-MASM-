INCLUDE Irvine32.inc


.data

arr dword 12, 123, 567, 8987
ind dword 20 dup (?)
.code

main PROC
mov edi, ind
mov edi, arr
mov esi, OFFSET ind
mov ecx, LENGTHOF ind

print:
mov eax, [edi[ecx]]
call writeInt
add esi,4
loop print

exit
main ENDP
END main