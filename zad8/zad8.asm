.model tiny
.386 
.data
	kolorkontur db 14
	kolorwypelnienie db 1
	starty dw 20				; max 99
	startx dw 40				; max 219
	tryb db 2
.stack 200h
.code

; wielokąt /osmiokat/ w kształcie litery U
; kolory: 1 niebieski, 14 zolty, 15 bialy, 16 czarny, 

zad8:
	mov ax, @data
	mov ds, ax

	cmp tryb, 1
	je prawodol
	jmp statycznie
	
	prawodol:
		mov bp, 1200
		ruchprawodol:		
			call grafika
			
			call boka
			call bokb
			call bokc
			call bokd
			call boke
			call bokf
			call bokg
			call bokh
			
			call wypelnienie1
			call wypelnienie2
			call wypelnienie3
					
			inc startx
			inc starty
			cmp startx, 219
			cmp starty, 99
			je wstecz
			
			dec bp
		jnz ruchprawodol
	
	wstecz:	
		mov bp, 1200
		ruchlewo:		
			call grafika
			
			call boka
			call bokb
			call bokc
			call bokd
			call boke
			call bokf
			call bokg
			call bokh
			
			call wypelnienie1
			call wypelnienie2
			call wypelnienie3
					
			dec startx
			dec starty
			cmp startx, 0		
			cmp starty, 0
			je prawodol
			
			dec bp
		jnz ruchlewo
	
	statycznie:
		call grafika
			
		call boka
		call bokb
		call bokc
		call bokd
		call boke
		call bokf
		call bokg
		call bokh
			
		call wypelnienie1
		call wypelnienie2
		call wypelnienie3
			
	koniec:
	xor ax, ax
	int 16h					; oczekiwanie na naciśnięcie dowolnego klawisza

	mov ah, 00h				; powrót do trybu tekstowego
	mov al, 03h				
	int 10h					
	mov ah, 4ch
	int 21h					; zakończenie działania program	
	
; --- procedury ----------	

grafika proc
; ---- uruchamianie trybu grafiki 13h
	mov al,13h
	mov ah,00h
	int 10h

	mov ax,0A000h
	mov es,ax
	ret
grafika endp

boka proc	
; ---- bok a, linia pozioma 
	mov ax, startx			; początkowy X (od lewej)
	mov cx, startx			; końcowy X (również od lewej) / 200 /
	add cx, 35				; szeroki na 35 pikseli
	mov dx, starty			; os Y / liczac od gory

	push ax
	sub cx, ax
	inc cx
	
	mov bx, dx
	
	shl dx, 6				;Y*64
	shl bx, 8				;Y*256
	add bx, dx				;Y*64 + Y*256 = Y*320
	pop ax					;w AX mamy teraz X
	add bx, ax				;Y*320 + X czyli to co chcieliśmy :-)
	xor di, di				;na wszelki wypadek ustawiamy sie w lewym górnym rogu ekranu
	add di, bx				;całe przesunięcie umieszczamy w DI
	
	mov al, kolorkontur				;wybieramy kolor linii
	rep stosb				;rysujemy
	ret
boka endp

bokb proc	
; ---- bok b, linia pozioma
	mov ax, startx			; początkowy X (od lewej)
	add ax, 35
	mov cx, startx			; końcowy X (również od lewej) / 200 /
	add cx, 65
	mov dx, starty			; Y (od góry)
	add dx, 70

	push ax
	sub cx, ax
	inc cx
	
	mov bx, dx
	
	shl dx, 6				;Y*64
	shl bx, 8				;Y*256
	add bx, dx				;Y*64 + Y*256 = Y*320
	pop ax					;w AX mamy teraz X
	add bx, ax				;Y*320 + X czyli to co chcieliśmy :-)
	xor di, di				;na wszelki wypadek ustawiamy sie w lewym górnym rogu ekranu
	add di, bx				;całe przesunięcie umieszczamy w DI
	
	mov al, kolorkontur				;wybieramy kolor linii
	rep stosb				;rysujemy
	ret
bokb endp

bokc proc	
; ---- bok c, linia pozioma 
	mov ax, startx			;początkowy X (od lewej)
	add ax, 65
	mov cx, startx			;końcowy X (również od lewej) / 200 /
	add cx, 100
	mov dx, starty			;Y (od góry)

	push ax
	sub cx, ax
	inc cx
	
	mov bx, dx
	
	shl dx, 6				;Y*64
	shl bx, 8				;Y*256
	add bx, dx				;Y*64 + Y*256 = Y*320
	pop ax					;w AX mamy teraz X
	add bx, ax				;Y*320 + X czyli to co chcieliśmy :-)
	xor di, di				;na wszelki wypadek ustawiamy sie w lewym górnym rogu ekranu
	add di, bx				;całe przesunięcie umieszczamy w DI
	
	mov al, kolorkontur		;wybieramy kolor linii
	rep stosb				;rysujemy
	ret
bokc endp

bokd proc	
; ---- bok d, linia pionowa
	mov di, startx			;przesunięcie X lini (od lewej)
	add di, 100
	mov ax, starty			;przesunięcie Y lini (od góry)
	shl ax, 6				;50*64=3200 :-)
	add di, ax				;jesteśmy na środku 10 wiersza (3200:320=10 :-) )
	shl ax, 2				;w ax bedzie teraz 12800 co daje 40 wierszy
	add di, ax				;razem o zadeklarowane 50 :-), wykorzystanie przesunięc logicznych
							;jest znacznie wydajniejsze od mnożenia przesunięcia Y przez 320 wykorzystując
							;instrukcję MUL
	mov cx, 100				;długość lini
	mov al, kolorkontur		;kolor lini

	rysujbokd:				;pętla rysująca linię
	mov es:[di], al			;rysujemy pixel
	add di, 320				;przeskakujemy wiersz niżej
	dec cx					;zmniejszamy licznik
	jnz rysujbokd			;rysujamy dopóki CX nie osiągnie zera
	ret
bokd endp

boke proc	
; ---- bok e, linia pozioma 
	mov ax, startx			;początkowy X (od lewej)
	mov cx, startx			;końcowy X (również od lewej) / 200 /
	add cx, 100
	mov dx, starty			;Y (od góry)
	add dx, 100

	push ax
	sub cx, ax
	inc cx
	
	mov bx, dx
	
	shl dx, 6				;Y*64
	shl bx, 8				;Y*256
	add bx, dx				;Y*64 + Y*256 = Y*320
	pop ax					;w AX mamy teraz X
	add bx, ax				;Y*320 + X czyli to co chcieliśmy :-)
	xor di, di				;na wszelki wypadek ustawiamy sie w lewym górnym rogu ekranu
	add di, bx				;całe przesunięcie umieszczamy w DI
	
	mov al, kolorkontur		;wybieramy kolor linii
	rep stosb				;rysujemy
	ret
boke endp

bokf proc	
; ---- bok f, linia pionowa
	mov di, startx			;przesunięcie X lini (od lewej)
	mov ax, starty			;przesunięcie Y lini (od góry)
	shl ax, 6				;50*64=3200 :-)
	add di, ax				;jesteśmy na środku 10 wiersza (3200:320=10 :-) )
	shl ax, 2				;w ax bedzie teraz 12800 co daje 40 wierszy
	add di, ax				;razem o zadeklarowane 50 :-), wykorzystanie przesunięc logicznych
							;jest znacznie wydajniejsze od mnożenia przesunięcia Y przez 320 wykorzystując
							;instrukcję MUL
	mov cx, 100				;długość lini
	mov al, kolorkontur		;kolor lini

	rysujbokf:				;pętla rysująca linię
	mov es:[di],al			;rysujemy pixel
	add di,320				;przeskakujemy wiersz niżej
	dec cx					;zmniejszamy licznik
	jnz rysujbokf			;rysujamy dopóki CX nie osiągnie zera
	ret
bokf endp

bokg proc	
; ---- bok g, linia pionowa
	mov di, startx			;przesunięcie X lini (od lewej)
	add di, 35
	mov ax, starty			;przesunięcie Y lini (od góry)
	shl ax, 6				;50*64=3200 :-)
	add di, ax				;jesteśmy na środku 10 wiersza (3200:320=10 :-) )
	shl ax, 2				;w ax bedzie teraz 12800 co daje 40 wierszy
	add di, ax				;razem o zadeklarowane 50 :-), wykorzystanie przesunięc logicznych
							;jest znacznie wydajniejsze od mnożenia przesunięcia Y przez 320 wykorzystując
							;instrukcję MUL
	mov cx, 70				;długość lini
	mov al, kolorkontur		;kolor lini

	rysujbokg:				;pętla rysująca linię
	mov es:[di], al			;rysujemy pixel
	add di, 320				;przeskakujemy wiersz niżej
	dec cx					;zmniejszamy licznik
	jnz rysujbokg			;rysujamy dopóki CX nie osiągnie zera
	ret
bokg endp

bokh proc	
; ---- bok h, linia pionowa
	mov di, startx			;przesunięcie X lini (od lewej)
	add di, 65
	mov ax, starty			;przesunięcie Y lini (od góry)
	shl ax, 6				;50*64=3200 :-)
	add di, ax				;jesteśmy na środku 10 wiersza (3200:320=10 :-) )
	shl ax, 2				;w ax bedzie teraz 12800 co daje 40 wierszy
	add di, ax				;razem o zadeklarowane 50 :-), wykorzystanie przesunięc logicznych
							;jest znacznie wydajniejsze od mnożenia przesunięcia Y przez 320 wykorzystując
							;instrukcję MUL
	mov cx, 70				;długość lini
	mov al, kolorkontur		;kolor lini

	rysujbokh:				;pętla rysująca linię
	mov es:[di], al			;rysujemy pixel
	add di, 320				;przeskakujemy wiersz niżej
	dec cx					;zmniejszamy licznik
	jnz rysujbokh			;rysujamy dopóki CX nie osiągnie zera
	ret
bokh endp		

wypelnienie1 proc
	mov bx, 34
	wypelnij1:	
	mov di, startx			;przesunięcie X lini (od lewej)
	add di, 35
	sub di, bx
	mov ax, starty			;przesunięcie Y lini (od góry)
	add ax, 1
	shl ax, 6				;50*64=3200 :-)
	add di, ax				;jesteśmy na środku 10 wiersza (3200:320=10 :-) )
	shl ax, 2				;w ax bedzie teraz 12800 co daje 40 wierszy
	add di, ax				;razem o zadeklarowane 50 :-), wykorzystanie przesunięc logicznych
							;jest znacznie wydajniejsze od mnożenia przesunięcia Y przez 320 wykorzystując
							;instrukcję MUL
	mov cx, 99				;długość lini
	mov al, kolorwypelnienie				;kolor lini
	
	wypelnijpion1:					;pętla rysująca linię
			mov es:[di], al			;rysujemy pixel
			add di, 320				;przeskakujemy wiersz niżej
			dec cx					;zmniejszamy licznik
			jnz wypelnijpion1		;rysujamy dopóki CX nie osiągnie zera
	dec bx	
	jnz wypelnij1
	ret
wypelnienie1 endp

wypelnienie2 proc
	mov bx, 34
	wypelnij2:	
	mov di, startx			;przesunięcie X lini (od lewej)
	add di, 100
	sub di, bx
	mov ax, starty			;przesunięcie Y lini (od góry)
	add ax, 1
	shl ax, 6				;50*64=3200 :-)
	add di, ax				;jesteśmy na środku 10 wiersza (3200:320=10 :-) )
	shl ax, 2				;w ax bedzie teraz 12800 co daje 40 wierszy
	add di, ax				;razem o zadeklarowane 50 :-), wykorzystanie przesunięc logicznych
							;jest znacznie wydajniejsze od mnożenia przesunięcia Y przez 320 wykorzystując
							;instrukcję MUL
	mov cx, 99				;długość lini
	mov al, kolorwypelnienie				;kolor lini
	
	wypelnijpion2:					;pętla rysująca linię
			mov es:[di], al			;rysujemy pixel
			add di, 320				;przeskakujemy wiersz niżej
			dec cx					;zmniejszamy licznik
			jnz wypelnijpion2		;rysujamy dopóki CX nie osiągnie zera
	dec bx	
	jnz wypelnij2
	ret
wypelnienie2 endp

wypelnienie3 proc
	mov bx, 31				; szerokosc wypelnienia
	wypelnij3:	
	mov di, startx				;przesunięcie X lini (od lewej)
	add di, 66
	sub di, bx				
	mov ax, starty				;przesunięcie Y lini (od góry)
	add ax, 71
	shl ax, 6				;50*64=3200 :-)
	add di, ax				;jesteśmy na środku 10 wiersza (3200:320=10 :-) )
	shl ax, 2				;w ax bedzie teraz 12800 co daje 40 wierszy
	add di, ax				;razem o zadeklarowane 50 :-), wykorzystanie przesunięc logicznych
							;jest znacznie wydajniejsze od mnożenia przesunięcia Y przez 320 wykorzystując
							;instrukcję MUL
	mov cx, 29				;długość lini
	mov al, kolorwypelnienie				;kolor lini
	
	wypelnijpion3:					;pętla rysująca linię
			mov es:[di], al			;rysujemy pixel
			add di, 320				;przeskakujemy wiersz niżej
			dec cx					;zmniejszamy licznik
			jnz wypelnijpion3		;rysujamy dopóki CX nie osiągnie zera	
	dec bx	
	jnz wypelnij3
	ret
wypelnienie3 endp

end zad8