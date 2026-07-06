;this is a program that asks the user for a string. It then flips every letter
;    from lower case to UPPER case and vice versa, and prints back the result to the
;    user.
;
;    Example:
;      Input:  Hello
;      Output: hELLO
;
;    we assumed that the input is only made of letters. (No spaces or
;    other punctuation marks).

format PE console
entry start

include 'win32a.inc'

max=20

section '.data' data readable writeable

text	db	'Enter your text: ',0

section '.bss' readable writeable

user_text	db	max	dup (?)
result		db	max	dup (?)
;size		dd	?

section '.code' code readable executable

start:
	mov	esi, text
	call	print_str

	mov	edi, user_text
	mov	ecx, max
	call	read_line

;finding size of string
	mov	esi, user_text
	mov	ecx, max
	xor	al, al
	repnz	scasb	
	sub	ecx, max
	neg	ecx
	dec	ecx
	;mov	dword[size], ecx

;if char ascii was below 0x60 then add 0x20
	mov	esi, user_text
	mov	edi, result
next_char:
	lodsb	
	cmp	al,0x60
	jb	uppercase
;else sub 0x20
lowercase:
	sub	al, 0x20
	jmp	done
uppercase:
	add	al, 0x20
done:
	stosb	
	loop	next_char	
	
;zero terminator for result
	xor	al, al
	stosb
	
;print resault
	mov	esi, result
	call	print_str

;exit
	push	0
	call	[ExitProcess]


include	'training.inc'
