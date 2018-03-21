SYS_SALIDA equ 1

SYS_LEE equ 3

SYS_PRINT equ 4

STDIN equ 0

STDOUT equ 1




segment .data

	

segment .bss
	
res1 resb 1


res2 resb 1
res3 resb 1
res4 resb 1

section  .text
	
	global _start 
_start:

;---1

mov eax,2
mov ebx,4
mul ebx
add eax, 48

mov [res1], eax

;--2
mov eax,2 
mov ebx,2
mov ecx,3
mul ebx
mul ecx
div ebx

add eax,48
mov [res2], eax

;--3
mov eax, 2
mov ebx, 2
mov ecx, 3
mul ebx 
mul ebx
mul ecx 
div ecx

add eax,48
mov [res3],eax

;--Proceso para calcular el resultado final
mov eax, [res1]  ;--Se mueven todas los valores calculados para la operacion final
mov ebx,[res2]
mov ecx,[res3]

add eax,ebx
sub eax,ecx
mov [res4], eax

mov eax, SYS_PRINT
 ;--operacion para poder imprimir un caracter	
mov edx, STDOUT
	
mov ecx, res4	
mov ebx, 1
	
int 0x80





salir:
mov eax, SYS_SALIDA
xor ebx,ebx
int 0x80