
INCLUDE	equs.h

codesg5	segment	public

	 assume	cs:codesg5,ds:datas1,es:datana

ekt_Print_N_ades	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1

	call	far ptr ekt_stand_riumisi

	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	@LPRINTCHR	" ",lpt_number,cs:print_stack5

	call	far ptr ekt_plirof

	mov	ax,kena_info_plr
	call	far ptr do_proouisi

	xor	si,si
	mov	cx,SHMEIA_STHLHS
t4_lop34:
	push	si        
	push	cx
	call	far ptr ekt_stand_riumisi

	mov	cx,STHLES_DELTIOU
t4_lop13:
	call	far ptr make_orizontia_riumisi_printer
	mov	dl,deltio2prn[si]
	@LPRINTCHR	dl,lpt_number,cs:print_stack5
	add	si,SHMEIA_STHLHS
	loop	t4_lop13

	pop	cx
	pop	si
	inc	si
	call	far ptr make_kaueti_riumisi_printer
	loop	t4_lop349

	@POP
	clc
	retf
t4_lop349:
	jmp	t4_lop34
ekt_Print_N_ades	endp

codesg5	ends
	end
