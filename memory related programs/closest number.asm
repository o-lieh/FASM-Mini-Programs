;a program that receives a number x as input, and finds the dword
;    inside the array nums, which is the closest to x. (We define the distance
;    between two numbers to be the absolute value of the difference: |a-b|).
;
;    Example:
;
;    For the input of 100h, the result will be 111h, because 111h is closer to
;    100h than any other number in the nums array. (|100h - 111h| = 11h).
;

format PE console
entry start


include 'win32a.inc'

;----------------------------
section 'data' readable writeable data
nums  dd  23h,75h,111h,0abch,443h,1000h,5h,2213h,433a34h,0deadbeafh

;----------------------------
section 'bss' readable writeable
diff dd 10d dup (?)

;----------------------------
section 'code' code readable executable

start:
	call	read_hex
	mov	edx, eax
;storing differences in diff	
	mov	ecx, 10d

loo:
	dec	ecx
	mov	ebx, edx
	sub	ebx, dword [nums+4*ecx]
	
	jnc	ebx_bigger
	neg	ebx
ebx_bigger:
	mov	dword [diff+4*ecx], ebx
	
	cmp	ecx, 0
	jnz	loo

;finding min in diff array

	xor	esi, esi
	mov	ecx, 9
loo2:
	mov	edx, dword [diff+4*esi] 
	cmp	edx, dword [diff+4*ecx]
	jbe	no_changes
	mov	esi, ecx
no_changes:
	loop	loo2


	mov	eax, dword [nums+4*esi]
	call	print_eax
	push	0
	call	[ExitProcess]

;--------------------------------------
include 'training.inc'
