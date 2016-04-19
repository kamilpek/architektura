.model small
.386
.data
	bufor db 0
	msg_dzie db "d=","$"
	msg_dwoj db "b=","$"
	msg_osem db "o","$"
.stack 100h
.code
start:
	mov ax, @data
	mov ds, ax
	mov ax, 0	
	mov al, 234
	mov bufor, al
	
	mov cx, 3
	dziesietny_licz:					; dziesietny
		mov bh, 10
		div bh
		mov bl, ah	
		add bl, 30h
		mov dl, bl
		push bx
		mov dl, al
		mov ax, 0
		mov al, dl
		dec cx
		jnz dziesietny_licz
	
	mov cx, 3
	dziesietny_wysw:	
		mov ax, 0
		pop bx
		mov al, bl
		mov ah, 0Eh
		int 10h
		dec cx
		jnz dziesietny_wysw		

	mov dx, offset msg_dzie
	mov ah, 09h
	int 21h	
	mov ax, 0
	mov al, bufor
	
	mov cx, 8
	dwojkowy_licz:						; dwojkowy
		mov bh, 2
		div bh
		mov bl, ah	
		add bl, 30h
		mov dl, bl
		push bx
		mov dl, al
		mov ax, 0
		mov al, dl
		dec cx
		jnz dwojkowy_licz
		
	mov cx, 8
	dwojkowy_wysw:	
		mov ax, 0
		pop bx
		mov al, bl
		mov ah, 0Eh
		int 10h
		dec cx
		jnz dwojkowy_wysw		
	
	mov dx, offset msg_dwoj
	mov ah, 09h
	int 21h	
	mov ax, 0	
	mov al, bufor
	
	mov cx, 3
	osemkowy_licz:					; ósemkowy
		mov bh, 8
		div bh
		mov bl, ah	
		add bl, 30h
		mov dl, bl
		push bx
		mov dl, al
		mov ax, 0
		mov al, dl
		dec cx
		jnz osemkowy_licz
	
	mov cx, 3
	osemkowy_wysw:	
		mov ax, 0
		pop bx
		mov al, bl
		mov ah, 0Eh
		int 10h
		dec cx
		jnz osemkowy_wysw
	
	mov dx, offset msg_osem
	mov ah, 09h
	int 21h	
	mov ax, 0
	mov al, bufor
	
	mov ah, 4Ch
	int 21h  	
	
end start