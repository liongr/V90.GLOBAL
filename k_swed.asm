
INCLUDE	equs.h

codesg5	segment	public

	 assume	cs:codesg5,ds:datas1,es:datana

ekt_Sweden	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1

	mov	cx,SHMEIA_STHLHS
	xor	si,si
t4_lop34:
	push	si
	push	cx

	call	far ptr ekt_stand_riumisi

	cmp	cx,6
	jne	no_veckas
	@LPRINTCHR	prchar_plr,lpt_number,cs:print_stack5
	jmp	veckas
no_veckas:
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
veckas:	
        @LPRINTCHR	27,lpt_number,cs:print_stack5
	@LPRINTCHR	"\",lpt_number,cs:print_stack5
	@LPRINTCHR	35,lpt_number,cs:print_stack5
	@LPRINTCHR	0,lpt_number,cs:print_stack5

	mov	ax,STHLES_DELTIOU
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

	mov	ax,kena_info_plr
	call	far ptr do_proouisi

	call	far ptr ekt_stand_riumisi
;-------------------------------------------------------- NEIN
	mov	cx,9
swed1:	call	far ptr make_orizontia_riumisi_printer
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	loop	swed1

	@LPRINTCHR	27,lpt_number,cs:print_stack5
	@LPRINTCHR	"\",lpt_number,cs:print_stack5
	@LPRINTCHR	1,lpt_number,cs:print_stack5
	@LPRINTCHR	0,lpt_number,cs:print_stack5
	@LPRINTCHR	prchar_plr,lpt_number,cs:print_stack5

	mov	ax,kena_info1_plr
	call	far ptr do_proouisi

	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	@LPRINTCHR	" ",lpt_number,cs:print_stack5

	call	far ptr ekt_plirof

	@POP
	retf
ekt_Sweden	endp

codesg5	ends
	end