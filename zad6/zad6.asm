.model small
.386
.data
	bufor dd 0
	msg_dzie db "d=","$"
	msg_dwoj db "b=","$"
	msg_osem db "o","$"
.stack 100h
.code
start:
	mov eax, @data
	mov ds, eax
	mov eax, 0
	mov eax, 65536	; 65536 / 234
	mov bufor, eax
		
	dziesietny_licz:					; dziesietny
		mov eax, bufor
		mov esp, 0
		
		dziesietny_licz_petla:
			mov ebx, 0
			mov edx, 0			
			mov bl, 10
			div ebx					
			add edx, 30h			
			push edx			
			cmp eax, 0
			je dziesietny_wysw
		jmp dziesietny_licz_petla	
			
	dziesietny_wysw:
	
		dziesietny_wysw_petla:
			cmp esp, 0
			je dziesietny_wysw_znak
			pop edx
			mov ah, 0Eh
			mov al, dl
			int 10h
			jmp dziesietny_wysw_petla
	
		dziesietny_wysw_znak:
			mov dx, offset msg_dzie
			mov ah, 09h
			int 21h	
			mov eax, 0
			mov eax, bufor
	
	jmp dwojkowy
	
	dwojkowy:
	
	dwojkowy_licz:					; dwojkowy
		mov eax, bufor
		mov esp, 0
		
		dwojkowy_licz_petla:
			mov ebx, 0
			mov edx, 0			
			mov bl, 2
			div ebx					
			add edx, 30h			
			push edx			
			cmp eax, 0
			je dwojkowy_wysw
		jmp dwojkowy_licz_petla	
			
	dwojkowy_wysw:
	
		dwojkowy_wysw_petla:
			cmp esp, 0
			je dwojkowy_wysw_znak
			pop edx
			mov ah, 0Eh
			mov al, dl
			int 10h
			jmp dwojkowy_wysw_petla
	
		dwojkowy_wysw_znak:
			mov dx, offset msg_dwoj
			mov ah, 09h
			int 21h	
			mov eax, 0
			mov eax, bufor
	
	jmp osemkowy
	
	osemkowy:
	
	osemkowy_licz:					; osemkowy
		mov eax, bufor
		mov esp, 0
		
		osemkowy_licz_petla:
			mov ebx, 0
			mov edx, 0			
			mov bl, 8
			div ebx					
			add edx, 30h			
			push edx			
			cmp eax, 0
			je osemkowy_wysw
		jmp osemkowy_licz_petla	
			
	osemkowy_wysw:
	
		osemkowy_wysw_petla:
			cmp esp, 0
			je osemkowy_wysw_znak
			pop edx
			mov ah, 0Eh
			mov al, dl
			int 10h
			jmp osemkowy_wysw_petla
	
		osemkowy_wysw_znak:
			mov dx, offset msg_osem
			mov ah, 09h
			int 21h	
			mov eax, 0
			mov eax, bufor
	
	mov ah, 4Ch
	int 21h  	
	
end start