section .data
	msg1 db "Informe o primeiro número: ", 0x0
	msg1_len equ $- msg1

	msg2 db "Informe o segundo número: ", 0x0
	msg2_len equ $- msg2

	result db "Resultado da soma: ", 0x0
	result_len equ $- result

	lf db 0xA

section .bss
	n1 resb 0xA
	n2 resb 0xA
	
section .text
global _start
_start:
	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, msg1
	mov edx, msg1_len
	int 0x80

	mov eax, 0x3
	xor ebx, ebx
	mov ecx, n1
	mov edx, 0xA
	int 0x80

	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, msg2
	mov edx, msg2_len
	int 0x80

	mov eax, 0x3
	xor ebx, ebx
	mov ecx, n2
	mov edx, 0xA
	int 0x80

	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, result
	mov edx, result_len
	int 0x80

	mov esi, n1
	call string_to_int

	mov ebx, eax

	mov esi, n2
	call string_to_int

	add eax, ebx

	call int_to_string
	mov ecx, esi

	mov eax, 0x4
	mov ebx, 0x1
	mov edx, 0xA
	int 0x80

	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, lf
	mov edx, 0x1
	int 0x80

	mov eax, 0x1
	xor ebx, ebx
	int 0x80

string_to_int:
	xor eax, eax

	.next_digit:
		mov dl, byte[esi]
		inc esi

		cmp dl, 0x30
		jl .end

		cmp dl, 0x39
		jg .end

		sub dl, 0x30
		imul eax, 0xA
		add eax, edx

		jmp .next_digit
	.end:
		ret

int_to_string:
	mov ebx, 0xA

	.next_digit:
		xor edx, edx
		
		div ebx
		add dl, 0x30 
		
		dec esi
		mov [esi], dl
		
		cmp eax, 0x0
		jnz .next_digit

		ret
