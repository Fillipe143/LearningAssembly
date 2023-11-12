section .data
	msg_maior db "n1 é maior que n2", 0xA, 0
	msg_maior_len equ $- msg_maior

	msg_menor db "n1 é menor que n2", 0xA, 0
	msg_menor_len equ $- msg_menor
	
	msg_igual db "n1 é igual a n2", 0xA, 0
	msg_igual_len equ $- msg_igual

	n1 dd 0x2
	n2 dd 0x1

section .text
global _start
_start:
	mov eax, DWORD [n1]
	mov ebx, DWORD [n2]

	cmp eax, ebx
	
	jg maior
	jl menor
	je igual

maior:
	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, msg_maior
	mov edx, msg_maior_len
	int 0x80

	jmp exit
menor:
	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, msg_menor
	mov edx, msg_menor_len
	int 0x80

	jmp exit
igual:
	mov eax, 0x4
	mov ebx, 0x1
	mov ecx, msg_igual
	mov edx, msg_igual_len
	int 0x80

	jmp exit

exit:
	mov eax, 0x1
	xor ebx, ebx
	int 0x80
