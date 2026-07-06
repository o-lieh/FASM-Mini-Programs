;strange sum program 
;without using memory

format PE console
entry rango

include 'win32a.inc'

;-----------------------------
section 'text' code readable executable

rango:

	call	read_hex
	jmp	start
	storage		dd	eax	dup	(?)

start:
	mov	ebx, eax
	mov	ecx, eax
storing:
	call	read_hex
	mov	dword [storage+4*ecx],eax
	loop	storing

	mov	ecx, ebx
	mov	esi, 1
	xor	edi, edi
adding:
	mov	eax,dword [storage+4*ecx]
	mul	esi
	add	edi, eax
	inc	esi
	loop	adding
	

	push 	0
	call	[ExitProcess]
;------------------------------
include 'training.inc'
