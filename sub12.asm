
INCLUDE equs.h

codesg	segment public

	assume	cs:codesg,ds:datas1

;*************************************	metatropi se basikes ana triades 3-3-3-4
mnimi2triades3334	proc	near
	@PUSH
	mov	cs:_cx,3
	mov	cs:_di,0
	mov	cs:_omada,32
	mov	cs:_om1,"3"
	mov	cs:_om2,"2"
	mov	cs:_apoeos,"3"
	call	chk_if_jana
	jc	alo1
	call	mnimi2triad
alo1:	mov	cs:_cx,3
	mov	cs:_di,3
	mov	cs:_omada,33
	mov	cs:_om1,"3"
	mov	cs:_om2,"3"
	mov	cs:_apoeos,"3"
	call	chk_if_jana
	jc	alo2
	call	mnimi2triad
alo2:	mov	cs:_cx,3
	mov	cs:_di,6
	mov	cs:_omada,34
	mov	cs:_om1,"3"
	mov	cs:_om2,"4"
	mov	cs:_apoeos,"3"
	call	chk_if_jana
	jc	alo3
	call	mnimi2triad
alo3:	mov	cs:_cx,4
	mov	cs:_di,9
	mov	cs:_omada,35
	mov	cs:_om1,"3"
	mov	cs:_om2,"5"
	mov	cs:_apoeos,"4"
	call	chk_if_jana
	jc	alo4
	call	mnimi2triad
alo4:	@POP
	ret
_cx	dw	0
_di	dw	0
_omada	db	0
_om1	db	0
_om2	db	0
_apoeos	db	" "
mnimi2triades3334	endp


;*************************************	metatropi se basikes ana triades 3442
mnimi2triades3442	proc	near
	@PUSH
	mov	cs:_cx,3
	mov	cs:_di,0
	mov	cs:_omada,32
	mov	cs:_om1,"3"
	mov	cs:_om2,"2"
	mov	cs:_apoeos,"3"
	call	chk_if_jana
	jc	aloT1
	call	mnimi2triad
aloT1:	mov	cs:_cx,4
	mov	cs:_di,3
	mov	cs:_omada,33
	mov	cs:_om1,"3"
	mov	cs:_om2,"3"
	mov	cs:_apoeos,"4"
	call	chk_if_jana
	jc	aloT2
	call	mnimi2triad
aloT2:	mov	cs:_cx,4
	mov	cs:_di,7
	mov	cs:_omada,34
	mov	cs:_om1,"3"
	mov	cs:_om2,"4"
	mov	cs:_apoeos,"4"
	call	chk_if_jana
	jc	aloT3
	call	mnimi2triad
aloT3:	mov	cs:_cx,2
	mov	cs:_di,11
	mov	cs:_omada,35
	mov	cs:_om1,"3"
	mov	cs:_om2,"5"
	mov	cs:_apoeos,"2"
	call	chk_if_jana
	jc	aloT4
	call	mnimi2triad
aloT4:	@POP
	ret
mnimi2triades3442	endp


;*************************************	metatropi se basikes ana triades 4441
mnimi2triades4441	proc	near
	@PUSH
	mov	cs:_cx,4
	mov	cs:_di,0
	mov	cs:_omada,32
	mov	cs:_om1,"3"
	mov	cs:_om2,"2"
	mov	cs:_apoeos,"4"
	call	chk_if_jana
	jc	aloTT1
	call	mnimi2triad
aloTT1:	mov	cs:_cx,4
	mov	cs:_di,4
	mov	cs:_omada,33
	mov	cs:_om1,"3"
	mov	cs:_om2,"3"
	mov	cs:_apoeos,"4"
	call	chk_if_jana
	jc	aloTT2
	call	mnimi2triad
aloTT2:	mov	cs:_cx,4
	mov	cs:_di,8
	mov	cs:_omada,34
	mov	cs:_om1,"3"
	mov	cs:_om2,"4"
	mov	cs:_apoeos,"4"
	call	chk_if_jana
	jc	aloTT3
	call	mnimi2triad
aloTT3:	mov	cs:_cx,1
	mov	cs:_di,12
	mov	cs:_omada,35
	mov	cs:_om1,"3"
	mov	cs:_om2,"5"
	mov	cs:_apoeos,"1"
	call	chk_if_jana
	jc	aloTT4
	call	mnimi2triad
aloTT4:	@POP
	ret
mnimi2triades4441	endp


chk_if_jana	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	xor	bx,bx
chk2:	push	bx
	mov	cx,cs:_cx
	mov	di,cs:_di
	mov	dx,di
	add	dx,10
	cmp	axbpin[bx],dl
	jne	ali
chk1:	mov	al,pinsthl[di]
	cmp	al,axbpin[bx][1]
	jne	ali
	inc	bx
	inc	di
	loop	chk1
	pop	bx
	@POP
	stc
	ret
ali:	pop	bx
	add	bx,5
	cmp	bx,axbp
	jb	chk2
	mov	bx,axbp
	mov	cx,cs:_cx
	mov	di,cs:_di
	mov	ax,di
	add	ax,10
	mov	axbpin[bx],al
	inc	bx
chk3:	mov	al,pinsthl[di]
	mov	axbpin[bx],al
	inc	bx
	inc	di
	loop	chk3
	add	axbp,5
	@POP
	clc
	ret
chk_if_jana	endp

mnimi2triad	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@CHANGESEGM	es,DATASC
	mov	si,arxascii
	cmp	si,BUFASCII-96
	jb	conio
	@POP
	ret

conio:	push	si
	inc	si
	mov	di,cs:_di
	xor	bx,bx
	xor	ax,ax
	mov	cx,cs:_cx
bas:	mov	al,antistixia[di]
	cmp	al,0
	je	bas12
	dec	ax
	mov	bx,ax
	add	bx,ax
	add	bx,ax
	mov	dl,pinsthl[di]
	call	apocode
	mov	es:arxasc[si][bx],dl
	mov	es:arxasc[si][bx][1]," "
	mov	es:arxasc[si][bx][2]," "
bas12:	inc	di
	loop	bas
	pop	si

stand131:
	mov	al,tipos_orou
	mov	es:arxasc[si],al
	mov	al,cs:_apoeos
	mov	es:arxasc[si+40],al
	mov	es:arxasc[si+41]," "
	mov	es:arxasc[si+42],al
	mov	es:arxasc[si+43]," "
	mov	es:arxasc[si+44],"N"

	mov	al,cs:_omada
	mov	es:arxasc[si+47],al
	mov	al,cs:_om1
	mov	es:arxasc[si+45],al
	mov	al,cs:_om2
	mov	es:arxasc[si+46],al

	add	arxascii,48
	mov	bx,arxascii
	mov	es:arxasc[bx+47],"c"
	mov	ax,bx
	xor	dx,dx
	mov	bx,48
	div	bx
	mov	bx,14
	div	bx
	mov	bl,dl
	mov	bselida,ax
	mov	al,bl
	mov	dl,4
	mul	dl
	add	ax,23
	mov	asthlh,al
	@POP
	ret
mnimi2triad	endp

codesg	ends
	end
