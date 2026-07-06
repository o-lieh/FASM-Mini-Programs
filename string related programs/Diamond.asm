;a program that asks the user for a number n, and then prints a
;    "diamond" of size n, made of ASCII stars.
;
;   Example:
;      For n = 1 the expected result is:
;
;       *
;      ***
;       *
;
;      For n = 2 the expected result is:
;
;        *
;       ***
;      *****
;       ***
;        *

format PE console
entry start

include 'win32a.inc'

section '.data' readable data writable

text	db	'Enter n: ', 0
star	db	'*',0
space	db	' ',0
nl	db	0xa, 0xd, 0

section '.code' readable executable code

start:
	mov	esi, text
	call	print_str
	call	read_hex
	mov	ebx, eax
	mov	edx, 1
uptri:
	mov	ecx, eax
	mov     esi, space

	test	ecx, ecx
	jz	nospace
prspu:
	call	print_str
	loop	prspu
nospace:
	mov	ecx, edx
	mov	esi, star

	test	ecx, ecx
	jz	nostar
prstu:
	call	print_str
	loop	prstu
nostar:
	mov	esi, nl
	call	print_str
;if
	test	ebx, ebx
	jns	first    ;first cycle
	
	inc	eax
	sub	edx, 2
	jns	uptri
	jmp	bye
first:
	add	edx, 2
	dec	eax
	jns	uptri

	mov	eax, 1

	mov	edx, ebx   ;2n-1=edx(stars after first tri)
	add	edx, edx
	dec	edx

	neg	ebx
	js	uptri

bye:	
	push	0
	call	[ExitProcess]

include 'training.inc'
