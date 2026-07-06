;a program that calculates the sum of all its bytes modulo 0x100.
;    (The program will actually sum itself).
format PE console
entry start

include 'win32a.inc'


;[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[
section 'test' code readable executable

start:
	xor	edi, edi
	mov	ecx, start
loo:
	movzx	eax, byte [ecx]
	add	edi, eax
	inc	ecx
	cmp	ecx, endprog
	jnz	loo
	
	mov	eax, edi
	call	print_eax
	
	push	0
	call	[ExitProcess]
endprog:
;[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[
include	'training.inc'
