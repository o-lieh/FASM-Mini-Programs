;a program that takes a number n as input, followed by a list of n
;    numbers b_1, b_2, ... b_n. You may assume that 0x0 <= b_i <= 0xff for every
;    1 <= i <= n.
;
;    The program will output the most common number.
;
;    Example:
;
;    Assume that the input was n=7, followed by the list: 1,5,1,3,5,5,2.
;    The program will output 5, because this is the most common number.
;
;    Note that if there is more than one most common number, the program will
;    just print one of the most common numbers.


format PE console
entry hail

include 'win32a.inc'

;llllllllllllllllllllllllllllllllll

section 'bss' readable writeable
;data itself
dts	dd	11d	dup	(?)

;llllllllllllllllllllllllllllllllll

section 'data' data readable writeable
;itarations
itr	dd	11d	dup	(1)

;lllllllllllllllllllllllllllllllll

section 'code' code readable executable

hail:
	mov	ecx, 10d

readata:
	call	read_hex
	mov	dword [dts+4*ecx], eax
	loop	readata
	mov	ecx, 10d
nextdata:
	mov	eax, dword [dts+4*ecx]
	mov	esi, ecx
	dec	esi
saminess:
	cmp	eax, dword [dts+4*esi]
	jnz	notsame
	
	mov	ebx, dword [itr+4*ecx]
	inc	ebx
	mov	dword [itr+4*ecx], ebx

	mov	ebx, dword [itr+4*esi]
	inc	ebx
	mov	dword [itr+4*esi], ebx
notsame:
	dec	esi
	cmp	esi,0
	jge	saminess

	loop	nextdata
	
;finding max in itarations

	xor	esi, esi
	mov	ecx, 11d
maxi:
	mov	eax, dword [itr+4*esi]
	cmp	eax, dword [itr+4*ecx]
	jae	nochanges
	mov	esi, ecx
nochanges:
	loop	maxi

	mov	eax, dword [dts+4*esi]
	call	print_eax
	push	0
	call	[ExitProcess]
;llllllllllllllllllllllllllllllllllllllllllllll
include 'training.inc'



