SYS_SALIDA equ 1
SYS_LEE equ 3
SYS_PRINT equ 4
STDIN equ 0
STDOUT equ 1

%macro imprime 2 
 	mov eax, SYS_PRINT
	mov ebx, STDOUT
	mov ecx, %1
	mov edx, %2
	int 0x80
%endmacro 

segment .data
	msg1 db "La conjetura Collatz de: ", 0xA,0xD
	len1 equ $- msg1

	msg2 db " ", 0xA,0xD  ;solo es un salto de linea
	len2 equ $- msg2

	msg3 db " "  ;solo es un espacio blanco
	len3 equ $- msg3

segment .bss
	num resb 2

section .text
	global _start  
_start:  

;imprime mensaje de informacion 
	imprime msg1,len1  ; llamada a macro

;---- valor inicial del ejercicio----	
mov eax, 9 
;----------------------------------

;imprime el primer valor
	mov edi, eax
	add eax, '0'
	mov [num], eax
	imprime num, 2  ; llamada a macro
	

;imprime un salto de linea
	imprime msg2,len2 

	mov eax, edi ; regresa el valor original a eax

; empieza el programaga
while:
	cmp eax, 1

;jbe bandera de menor o igual
jbe salir 	

	;asignar dos para la division
	mov edi, 2
	;varible momentanea de apoyo
	mov esi, eax;

	;hace la divicion entre de 2   
	mov edx, 0
	div edi

	;compara si es igual a 0 el residuo
	cmp edx, 0

	;salta a la estiqueta espar si se cumple
	je espar
	
	;si no es par hace lo siguiente ...
    mov eax, esi ; esto es solo por que valor original se altero anteriormente
	mov ecx, 3
	; mul toma por defecto a eax
	mul ecx 
	add eax, 1
	jmp impresion
	
	
espar:
	;salta directo a impresion ya que ya se hizo la divicion entre 2
	jmp impresion
 

impresion: 
	mov edi, eax

	;esto imprime
	add eax, '0'
	mov [num], eax
	imprime num, 2

	;imprimi espacio en blaco despues del numero
	imprime msg3,len3
	mov eax, edi	
	
jmp while


salir:
    
	mov eax, SYS_SALIDA
	xor ebx, ebx
	int 0x80