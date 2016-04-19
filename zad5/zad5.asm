.model small
.386
.stack 100h
.code
start:
	mov ax, 0
	mov bh, 10
	mov al, 4
	
	mov cx, 3
	dziesietne_licz:
		div bh
		mov bl, ah	
		add bl, 30h
		mov dl, bl
		push bx
		mov dl, al
		mov ax, 0
		mov al, dl
		dec cx
		jnz dziesietne_licz
	
	mov cx, 3
	dziesietne_wysw:	
		mov ax, 0
		pop bx
		mov al, bl
		mov ah, 0Eh
		int 10h
		dec cx
		jnz dziesietne_wysw
	
	mov ah, 4Ch
	int 21h 
 	
end start