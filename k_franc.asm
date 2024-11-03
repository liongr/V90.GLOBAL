
INCLUDE	equs.h

codesg5	segment	public

	 assume	cs:codesg5,ds:datas1,es:datana

ekt_France	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	
	cmp	WhatPrinter,@EPSONLQ870
	je	IsEpsonLQ870_1
	jmp	IsNot1

;**************************************************************	
IsEpsonLQ870_1:
	mov	cx,17
franc11:
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	loop	franc11

	call	far ptr ekt_plirof
	mov	ax,kena_info_plr
	call	far ptr do_proouisi
;**************************************************************	

IsNot1:
	mov	cx,SHMEIA_STHLHS
	xor	si,si
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
	cmp	cs:_tokeno,3
	jbe	no_tokeno
	mov	cs:_tokeno,1
 	call	lmoveA
no_tokeno:
	mov	dl,deltio2prn[si]
	cmp	dl,1
	je	t4_isone
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	jmp	t4_tokana

t4_lop139:	jmp	t4_lop13

t4_isone:
	@LPRINTCHR	prchar_plr,lpt_number,cs:print_stack5
t4_tokana:
	add	si,SHMEIA_STHLHS
	loop	t4_lop139

	pop	cx
	pop	si
	inc	si
	call	far ptr make_kaueti_riumisi_printer
	loop	t4_lop349
	jmp	fran
t4_lop349:
	jmp	t4_lop34
;---------------------------------
fran:	
	cmp	WhatPrinter,@EPSONLQ590
	je	IsEpsonLQ590_1
	jmp	IsNot2

;**************************************************************
IsEpsonLQ590_1:
	mov	ax,kena_info_plr
	call	far ptr do_proouisi

	mov	cx,20
franc12:
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	loop	franc12

	call	far ptr ekt_plirof
;**************************************************************
IsNot2:
	@POP
	retf
_tokeno	dw	0

lmoveA:	@LPRINTCHR	27,lpt_number,cs:print_stack5
	@LPRINTCHR	"\",lpt_number,cs:print_stack5
	@LPRINTCHR	kena_oriz_end_plr,lpt_number,cs:print_stack5
	@LPRINTCHR	0,lpt_number,cs:print_stack5
	ret
ekt_France	endp

codesg5	ends
	end
