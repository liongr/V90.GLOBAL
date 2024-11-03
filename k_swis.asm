
INCLUDE	equs.h

codesg5	segment	public

	 assume	cs:codesg5,ds:datas1,es:datana

ekt_Swiss	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	call	far ptr ekt_stand_riumisi
	
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	@LPRINTCHR	" ",lpt_number,cs:print_stack5

	call	far ptr ekt_plirof
	mov	ax,kena_info_plr
	call	far ptr do_proouisi


	mov	cs:mkeno,0
	mov	cx,SHMEIA_STHLHS
	mov	ax,STHLES_DELTIOU
	mul	cx
	mov	cx,3
	mul	cx
	mov	si,ax
	dec	si
	

	xor	si,si		
	mov	cx,SHMEIA_STHLHS
t4_lop34:
	push	si
	push	cx

	call	far ptr ekt_stand_riumisi

	mov	ax,STHLES_DELTIOU
	mov	cx,3
	mul	cx
	mov	cx,ax
	mov	cs:_tokeno,0
	
t4_lop13:
	inc	cs:_tokeno
	cmp	cs:_tokeno,6
	jbe	parat
	jmp	keno_ana_6

parat:
	call	far ptr make_orizontia_riumisi_printer
	mov	dl,deltio2prn[si]
	cmp	dl,1
	je	t4_isone
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	jmp	t4_tokana
t4_isone:
	@LPRINTCHR	prchar_plr,lpt_number,cs:print_stack5
t4_tokana:
	add	si,SHMEIA_STHLHS
	loop	t4_lop13

	pop	cx
	pop	si
	inc	si
	call	far ptr make_kaueti_riumisi_printer
	loop	t4_lop349
	jmp	kora_1

t4_lop349:
	jmp	t4_lop34

_tokeno	dw	0

kora_1:	
;----------------------------------------
	mov	ax,12
	call	far ptr do_proouisi
;----------------------------------------
	mov	cx,5
	mov	bx,0
pirat5:
	call	far ptr ekt_stand_riumisi

 	push	cx
	mov	cx,6
pirat6:	push	cx
	mov	cx,2

pirat2:	call	lmoveA
	mov	dl,0
	cmp	bx,swiss_1	;0-5
	jne	noido1
	mov	dl,1

noido1:	call	lprintme

	call	lmoveA
	mov	dl,0
	cmp	bx,swiss_2	;0-5
	jne	noido2
	mov	dl,1

noido2:	call	lprintme

	call	lmoveB
	loop	pirat2

	call	lmoveC
	pop	cx	
	loop	pirat6
	pop	cx
	call	far ptr make_kaueti_riumisi_printer
	inc	bx
	loop	pirat5

	@POP
	clc
	retf

lprintme:
	cmp	dl,1
	je	isastro
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	ret

isastro:
	@LPRINTCHR	"*",lpt_number,cs:print_stack5
	ret


lmoveA:	@LPRINTCHR	27,lpt_number,cs:print_stack5
	@LPRINTCHR	"\",lpt_number,cs:print_stack5
	@LPRINTCHR	6,lpt_number,cs:print_stack5
	@LPRINTCHR	0,lpt_number,cs:print_stack5
	ret

lmoveB:	@LPRINTCHR	27,lpt_number,cs:print_stack5
	@LPRINTCHR	"\",lpt_number,cs:print_stack5
	@LPRINTCHR	4,lpt_number,cs:print_stack5
	@LPRINTCHR	0,lpt_number,cs:print_stack5
	ret

lmoveC:	@LPRINTCHR	27,lpt_number,cs:print_stack5
	@LPRINTCHR	"\",lpt_number,cs:print_stack5
	@LPRINTCHR	8,lpt_number,cs:print_stack5
	@LPRINTCHR	0,lpt_number,cs:print_stack5
	ret

keno_ana_6:
	mov	cs:_tokeno,1
	inc	cs:mkeno
	@LPRINTCHR	27,lpt_number,cs:print_stack5
	@LPRINTCHR	"\",lpt_number,cs:print_stack5
	cmp	cs:mkeno,3
	jne	nok3
	@LPRINTCHR	9,lpt_number,cs:print_stack5
	@LPRINTCHR	0,lpt_number,cs:print_stack5
	jmp	parat

nok3:	@LPRINTCHR	8,lpt_number,cs:print_stack5
	@LPRINTCHR	0,lpt_number,cs:print_stack5
	jmp	parat

mkeno	dw	0

ekt_Swiss	endp

codesg5	ends
	end
