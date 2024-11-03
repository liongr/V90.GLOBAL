
INCLUDE	equs.h

codesg5	segment	public

	 assume	cs:codesg5,ds:datas1,es:datana

ekt_Spain	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	

	cmp	WhatPrinter,@EPSONLQ590
	je	IsEpsonLQ590_1
	jmp	IsNot1

;**************************************************************
IsEpsonLQ590_1:	
	call	far ptr ekt_stand_riumisi
	mov	cx,8
espan1:	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	loop	espan1	
	call	far ptr ekt_plirof

	mov	ax,kena_info_plr
	call	far ptr do_proouisi
;**************************************************************
IsNot1:

	xor	si,si
	
	cmp	WhatPrinter,@EPSONLQ870
	je	IsEpsonLQ870_1
	jmp	IsNot2

;**************************************************************	
IsEpsonLQ870_1:
	mov	cx,SHMEIA_STHLHS
	mov	ax,STHLES_DELTIOU
	mul	cx
	mov	cx,3
	mul	cx
	mov	si,ax
	dec	si
;**************************************************************
IsNot2:
	mov	cx,SHMEIA_STHLHS
t4_lop34:
	push	si
	push	cx

	call	far ptr ekt_stand_riumisi

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


	cmp	WhatPrinter,@EPSONLQ590
	je	IsEpsonLQ590_2
	jmp	IsNot3

;**************************************************************
IsEpsonLQ590_2:	
	add	si,SHMEIA_STHLHS
	loop	t4_lop13
	pop	cx
	pop	si
	inc	si
	call	far ptr make_kaueti_riumisi_printer
	loop	t4_lop349

;------------------------------------------------ SPAIN 15
	call	far ptr ekt_stand_riumisi
;	mov	dl,extra_sim15
;	cmp	dl,'1'
;	jne	isnoex_1
;	mov	cx,11
;	jmp	simex_ok
;isnoex_1:
;	cmp	dl,'2'
;	jne	isnoex_2
;	mov	cx,15
;	jmp	simex_ok
;isnoex_2:
;	cmp	dl,'X'
;	jne	isnoex_X
;	mov	cx,13
;	jmp	simex_ok
;isnoex_X:
;	jmp	isexsim_nogood
;simex_ok:
;bale_kena:
;	call	far ptr make_orizontia_riumisi_printer
;	@LPRINTCHR	" ",lpt_number,cs:print_stack5
;	loop	bale_kena
;	@LPRINTCHR	prchar_plr,lpt_number,cs:print_stack5ENDIF
;**************************************************************
IsNot3:

	cmp	WhatPrinter,@EPSONLQ870
	je	IsEpsonLQ870_3
	jmp	IsNot4

t4_lop13_jmp:
	jmp	t4_lop13

;**************************************************************
IsEpsonLQ870_3:	
	sub	si,SHMEIA_STHLHS
	loop	t4_lop13_jmp
	pop	cx
	pop	si
	dec	si
	call	far ptr make_kaueti_riumisi_printer
	loop	t4_lop349


	mov	ax,kena_info_plr
	call	far ptr do_proouisi

	call	far ptr ekt_stand_riumisi
	mov	cx,8
espan2:	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	loop	espan2
	call	far ptr ekt_plirof
;**************************************************************
IsNot4:

isexsim_nogood:
	@POP
	clc
	retf
ekt_Spain	endp

codesg5	ends
	end
