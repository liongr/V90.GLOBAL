
INCLUDE	equs.h

codesg	segment public

	assume	cs:codesg,ds:datas1

plirakia_dialogi	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1

	xor	si,si
arxhek:	@INCL	ar_deltiou

	mov	epig[0],0	;13
	mov	epig[1],0	;12
	mov	epig[2],0	;11
	mov	epig[3],0	;10
	mov	epig[4],0	;9
	mov	epig[5],0	;5 epano
	mov	epig[6],0	;7 epano
	mov	epig[7],0	;9 epano

	mov	cx,STHLES_DELTIOU
plrt99:	push	cx
	push	si

	mov	epitixies,0
	mov	cx,5
	xor	bx,bx
plrt5:	mov	dl,axbpin[si][bx]
	mov	dh,pindial[bx]
	call	check
	jc	kiss5
	inc	epitixies
kiss5:	inc	bx
	loop	plrt5
;--------------------------------------------------
	cmp	epitixies,5
	jne	oxi5ari
	inc	epig[5]		;;;; 5aria!!!

oxi5ari:
	mov	cx,2
plrt7:	mov	dl,axbpin[si][bx]
	mov	dh,pindial[bx]
	call	check
	jc	kiss7
	inc	epitixies
kiss7:	inc	bx
	loop	plrt7

	cmp	epitixies,7
	jne	oxi7ari
	inc	epig[6]		;;;; 7aria!!!

oxi7ari:
	mov	cx,2
plrt9:	mov	dl,axbpin[si][bx]
	mov	dh,pindial[bx]
	call	check
	jc	kiss9
	inc	epitixies
kiss9:	inc	bx
	loop	plrt9

	cmp	epitixies,9
	jne	oxi9ari
	inc	epig[7]		;;;; 9aria!!!

oxi9ari:
;--------------------------------------------------
	mov	cx,4
plrt01:	mov	dl,axbpin[si][bx]
	mov	dh,pindial[bx]
	call	check
	jc	kiss0
	inc	epitixies
kiss0:	inc	bx
	loop	plrt01

	mov	bx,13
	sub	bl,epitixies
	cmp	bx,4
	ja	nometr8
	inc	epig[bx]

nometr8:
	pop	si
	add	si,13
	pop	cx
	cmp	si,axbp
	jae	plrt0
	loop	plrt999
	
plrt0:	call	dialogi_diaxr
	mov	cx,1000
	xor	bx,bx
plrtc:	mov	axbpin[bx],0
	inc	bx
	loop	plrtc
	@POP
	ret
plrt999:	jmp	plrt99
plirakia_dialogi	endp

check	proc	near
	cmp	dl,9	;tripli
	je	krak9
	cmp	dl,5	;diples
	jae	krak1
	dec	dl
	cmp	dh,dl
	je	krak9
	stc
	ret
krak9:	clc
	ret
krak1:	cmp	dh,1	;"1"
	jne	krak2
	cmp	dl,7
	jne	krak9
	stc
	ret
krak2:	cmp	dh,2	;"X"
	jne	krak3
	cmp	dl,6
	jne	krak9
	stc
	ret
krak3:	cmp	dl,5
	jne	krak9
	stc
	ret
check	endp

dialogi_diaxr	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	call	dialogi_geniki
	call	dialogi_ekt_alla
	mov	cx,7
	mov	bx,0
dild7:	cmp	epig[bx],0
	jne	dild8
	inc	bx
	loop	dild7	
	@POP
	ret

dild8:	call	dialogi_ekt_deltia
	@POP 
	ret
dialogi_diaxr	endp
;
dialogi_geniki	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	mov	cx,8	;;;(13,12,11,10,9,^5,^7,^9)
	xor	bx,bx
	xor	si,si
dilge1: 	xor	dx,dx
	mov	dl,epig[bx]
	add	sepig[si],dx
	inc	bx
	add	si,2
	loop	dilge1
	@POP
	ret
dialogi_geniki	endp
;
dialogi_ekt_deltia	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1

	cmp	clr_win,0
	je	dilek2
	@CLSWIND	wclr_dial
	mov	clr_win,0

dilek2:	@SELECTWIND	wdial1
	@LTOAN	ar_deltiou,strbuf
	@WPRINT	3,grammh,strbuf

	xor	ax,ax
	mov	al,epig[0]
	@ITOA	strbuf,4
	@WPRINT	11,grammh,strbuf

	xor	ax,ax
	mov	al,epig[1]
	@ITOA	strbuf,4
	@WPRINT	17,grammh,strbuf

	xor	ax,ax
	mov	al,epig[2]
	@ITOA	strbuf,4
	@WPRINT	23,grammh,strbuf

	xor	ax,ax
	mov	al,epig[3]
	@ITOA	strbuf,4
	@WPRINT	29,grammh,strbuf

	xor	ax,ax
	mov	al,epig[4]
	@ITOA	strbuf,4
	@WPRINT	35,grammh,strbuf

	xor	ax,ax
	mov	al,epig[5]
	@ITOA	strbuf,4
	@WPRINT	41,grammh,strbuf

	xor	ax,ax
	mov	al,epig[6]
	@ITOA	strbuf,4
	@WPRINT	47,grammh,strbuf

	xor	ax,ax
	mov	al,epig[7]
	@ITOA	strbuf,4
	@WPRINT	53,grammh,strbuf

	cmp	epig[0],0
	je	no13ari
	@INVERSE	1,grammh,54
no13ari:
	inc	grammh
	cmp	grammh,16
	jb	dilek3
	@WPRINT	3,17,mpatapl
	
	@WAITL
	cmp	al,@ESCAPE
	jne	nescp
	call	diakopi

nescp:	mov	grammh,3
	mov	clr_win,1
	@FILLSTR	strbuf," ",40
	@WPRINT	3,17,strbuf
	@WPRINT	3,17,mypolog
dilek3:	@POP
	ret
dialogi_ekt_deltia	endp
;
dialogi_ekt_alla	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@SELECTWIND	wdial2
	@LTOAN	ar_deltiou,strbuf
	@WPRINT	3,3,strbuf
	@LTOAN	mexri_tora,strbuf
	@WPRINT	3,5,strbuf
	mov	ax,sepig[0]	;13
	@ITOA	strbuf
	@WPRINT	7,7,strbuf
	mov	ax,sepig[2]	;12
	@ITOA	strbuf
	@WPRINT	7,8,strbuf
	mov	ax,sepig[4]     ;11
	@ITOA	strbuf
	@WPRINT	7,9,strbuf
	mov	ax,sepig[6]     ;10
	@ITOA	strbuf
	@WPRINT	7,10,strbuf
	mov	ax,sepig[8]     ;9
	@ITOA	strbuf
	@WPRINT	7,11,strbuf
	mov	ax,sepig[10]    ;^5
	@ITOA	strbuf
	@WPRINT	7,13,strbuf
	mov	ax,sepig[12]    ;^7
	@ITOA	strbuf
	@WPRINT	7,14,strbuf
	mov	ax,sepig[14]    ;^9
	@ITOA	strbuf
	@WPRINT	7,15,strbuf
	@POP
	ret
dialogi_ekt_alla	endp
;
codesg	ends
	end