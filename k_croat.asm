
INCLUDE	equs.h

codesg5	segment	public

	 assume	cs:codesg5,ds:datas1,es:datana

ekt_Croatia	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1

	mov	cx,SHMEIA_STHLHS
	xor	si,si
t4_lop34:
	push	si
	push	cx

	call	far ptr ekt_stand_riumisi

	;;mov	ax,STHLES_DELTIOU
	mov	ax,5
	mov	cx,3
	mul	cx
	mov	cx,ax
		
t4_lop13:
	call	far ptr make_orizontia_riumisi_printer
	mov	dl,deltio2prn[si]
	cmp	dl,1
	je	t4_isone
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	jmp	t4_tokana

t4_lop349:
	jmp	t4_lop34

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
	
	call	far ptr make_kaueti_riumisi_printer	;;; 1 keno
	
;------------------------------------------------------------------------	
	mov	cx,SHMEIA_STHLHS
	mov	si,195 ; 13x3 *5stiles
t4_lop3422:
	push	si
	push	cx

	call	far ptr ekt_stand_riumisi

	;;mov	ax,STHLES_DELTIOU
	mov	ax,5
	mov	cx,3
	mul	cx
	mov	cx,ax
		
t4_lop1322:
	call	far ptr make_orizontia_riumisi_printer
	mov	dl,deltio2prn[si]
	cmp	dl,1
	je	t4_isone22
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	jmp	t4_tokana22

t4_lop34922:
	jmp	t4_lop3422

t4_isone22:
	@LPRINTCHR	prchar_plr,lpt_number,cs:print_stack5
t4_tokana22:
	add	si,SHMEIA_STHLHS
	loop	t4_lop1322

	pop	cx
	pop	si
	inc	si
	call	far ptr make_kaueti_riumisi_printer
	loop	t4_lop34922
	
	

	mov	ax,kena_info_plr
	call	far ptr do_proouisi

	call	far ptr ekt_plirof

	mov	ax,kena_info1_plr
	call	far ptr do_proouisi

	call	far ptr ekt_stand_riumisi

;	mov	cx,22
;dusan78:
;	call	far ptr make_orizontia_riumisi_printer
;	@LPRINTCHR	" ",lpt_number,cs:print_stack5
;	loop	dusan78
;	@LPRINTCHR	27,lpt_number,cs:print_stack5
;	@LPRINTCHR	"\",lpt_number,cs:print_stack5
;	@LPRINTCHR	2,lpt_number,cs:print_stack5
;	@LPRINTCHR	0,lpt_number,cs:print_stack5
;	@LPRINTCHR	prchar_plr,lpt_number,cs:print_stack5
	@POP
	clc
	retf
ekt_Croatia	endp

codesg5	ends
	end
