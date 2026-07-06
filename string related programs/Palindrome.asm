;A palindrome is a sequence of symbols which is interpreted the same if read in
;    the usual order, or in reverse order.
;    
;    Examples:
;
;      1234k4321   is a palindrome.
;      5665        is a palindrome.
;
;      za1221at    is not a palindrome.
;
;this is a program that takes a string as input, and decides whether it is a
;palindrome or not. It then prints an appropriate message to the user.

format PE console
entry start


include 'win32a.inc' 

;constants

maxseq=20

section '.data' data readable writeable

text	db	'Enter the sequence: ', 0
no	db	'your string is not a panda',0
yes	db	'your string is a panda',0

section '.bss' readable writable

seq	db	maxseq	dup(?)
size	dd	?



section '.code' code readable executable

start:
	mov	ecx, maxseq
	mov	edi, seq
	call	read_line
;finding size
	mov	edi, seq
	mov	ecx,maxseq
	xor	al, al
	repnz	scasb
	sub	ecx, maxseq
	neg	ecx
	dec	ecx
	mov	dword [size], ecx
;comparing chars
	;doing loop for size/2 times
	mov	eax, dword[size]
	xor	edx, edx
	mov	ecx, 2
	div	ecx
	mov	ecx, eax
	;beginning of string in esi and 
	;the end in edi
	mov	esi, seq
	mov	edi, seq
	add	edi, dword[size]
	dec	edi
next_char:
	cmpsb	
	lea	edi, [edi-2]
	jnz	not_panda
	loop	next_char
	mov	esi, yes
	call	print_str
	jmp	ending
not_panda:
	mov	esi, no
	call	print_str
ending:
	push	0
	call	[ExitProcess]


include 'training.inc'
	
	
	
	
