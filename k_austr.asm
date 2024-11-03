
INCLUDE	equs.h

codesg5	segment	public

	 assume	cs:codesg5,ds:datas1

ekt_Austria	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1

;-------------------------------------------------------- NEIN
	call	far ptr ekt_stand_riumisi

	mov	cx,16
dusan78:
	call	far ptr make_orizontia_riumisi_printer
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	loop	dusan78
	@LPRINTCHR	prchar_plr,lpt_number,cs:print_stack5
;--------------------------------------------------------------
	call	far ptr make_kaueti_riumisi_printer
	call	far ptr make_kaueti_riumisi_printer
;----------------------------------------------------------
	call	far ptr make_kaueti_riumisi_printer
	mov	cx,7
dusan781:
	call	far ptr make_orizontia_riumisi_printer
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	loop	dusan781
;----------------------------------------------------------
       	call	far ptr ekt_plirof
;--------------------------------------------------------------

	mov	ax,kena_info_plr
	call	far ptr do_proouisi
	call	far ptr make_kaueti_riumisi_printer

	mov	cx,SHMEIA_STHLHS
	mov	ax,STHLES_DELTIOU
	mul	cx
	mov	cx,3
	mul	cx
	mov	si,ax
	dec	si
		
	mov	cx,18	;SHMEIA_STHLHS
	mov	di,17
t4_lop34:
	cmp	Austria_uesi_onoff[di],0
	ja	position_ok
	jmp	position_pida

position_ok:
	push	si
	push	cx
	call	far ptr ekt_stand_riumisi
	mov	ax,STHLES_DELTIOU
	mov	cx,3
	mul	cx
	mov	cx,ax
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
		
t4_lop13:
	call	far ptr make_orizontia_riumisi_printer
	mov	dl,deltio2prn[si]
	cmp	dl,1
	je	t4_isone
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	jmp	t4_tokana
t4_isone:
	@LPRINTCHR	prchar_plr,lpt_number,cs:print_stack5
t4_tokana:
	sub	si,SHMEIA_STHLHS
	loop	t4_lop13

	pop	cx
	pop	si
	dec	si
position_pida:
	dec	di
	call	far ptr make_kaueti_riumisi_printer
	loop	t4_lop349

	@POP
	clc
	retf
t4_lop349:
	jmp	t4_lop34
ekt_Austria	endp

codesg5	ends
	end
