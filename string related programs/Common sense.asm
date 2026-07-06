;Write a program that reads a string from the user, and then finds out the
;    most common character in the string. (Don't count spaces).
;    
;    Finally the program prints that character back to the user, together with
;    its number of occurrences in the string.
;    
;    Example:
;
;      Input:  The summer is the place where all things find their winter
;
;      Output: The character e is the most common character on the string.
;              Amount of occurrences: 8
;

format PE console
entry start

include 'win32a.inc' 

max= 20
section '.data' data readable writable

input	db	'show me your sentence:'
output	db	'the charecter'
char	db	'x'
outputt	db	'is the most commen.', 0xa, 0xd, 'itterate number:'
source	db	'abcdefghijklnmopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
itr	dd	2	dup	(0)

section '.bss' readable	writeable
sentense	db	max	dup(?)
size		dd	?

start:
	mov	esi, input
	call	print_str

	mov	edi, sentense
	mov	ecx, max
	call	read_line

;finds the length of sentence
	mov	ecx, max
	mov	edi, sentense
	xor	al, al
	repnz	scasb
	sub	ecx, max
	neg	ecx
	dec	ecx
	
;scans all the sentece for a
	xor	edx, edx
	dec	edx
	mov	edi, sentense
next_char:
	xor	ebx, ebx
	inc	edx
	mov	ecx, dword[size]
	mov	al, byte[source+edx]
next_stop:
	repnz	scasb
	
	jecxz	next_char
	inc	ebx
	jmp	next_stop
	mov	byte[itr+edx],bl
	cmp	edx, 51
	jnz	next_char
	
	mov	esi, itr
	call	print_str	
	;adds one each time its out of repnz
	;go to next char after the size of sentence is done
	;put b in al and add one to arr

include 'training.inc'
