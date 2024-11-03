
INCLUDE	equs.h

codesg5	segment	public

	 assume	cs:codesg5,ds:datas1,es:datana

ekt_StilesA4	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@LPRINT_START	lpt_number
	@LPRINTSTR	prn_stilesA4,lpt_number,cs:print_stack5
	@LPRINTSTR	prn_line_feed,lpt_number,cs:print_stack5
	@LPRINTSTR	prn_line_feed,lpt_number,cs:print_stack5
	@LPRINTSTR	prn_line_feed,lpt_number,cs:print_stack5
	xor	si,si
	mov	cx,SHMEIA_STHLHS
t4_lop34:
	mov	ax,SHMEIA_STHLHS
	sub	ax,cx
	inc	ax
	@ITOA	strbuf,2
	@LPRINTSTR	strbuf,lpt_number,cs:print_stack5
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	push	si        
	push	cx

	mov	cx,STHLES_DELTIOU
t4_lop13:
	mov	dl,deltio2prn[si]
	@LPRINTCHR	dl,lpt_number,cs:print_stack5
	add	si,SHMEIA_STHLHS
	cmp	cx,25
	je	stlk
	cmp	cx,13
	je	stlk
	jmp	nstlk

stlk:	@LPRINTCHR	" ",lpt_number,cs:print_stack5

nstlk:	loop	t4_lop13

	pop	cx
	pop	si
	inc	si
	@LPRINTSTR	prn_line_feed,lpt_number,cs:print_stack5
	loop	t4_lop349
	jmp	sntre

t4_lop349:
	jmp	t4_lop34

sntre:	inc	prn_stl_Selida
	cmp	prn_stl_Selida,4
	jae	prits12
	jmp	prits

prits12:
	call	ekt_selid

prits:	@LPRINT_STOP
	@POP
	clc
	retf
ekt_StilesA4	endp

ekt_stlA4_end	proc	near
	@PUSH
	mov	cx,4
	sub	cl,prn_stl_Selida
	cmp	cx,4
	jb	kitr
	@POP
	retf	

kitr:	cmp	cx,0
	ja	t4_lo1
	jmp	nokena

t4_lo1:	mov	ax,SHMEIA_STHLHS	;13
	add	ax,3
	mul	cx
	mov	cx,ax
	@LPRINT_START	lpt_number

	@LPRINTSTR	prn_stilesA4,lpt_number,cs:print_stack5
t4_lo:	@LPRINTSTR	prn_line_feed,lpt_number,cs:print_stack5
	loop	t4_lo

nokena:	call	ekt_selid
	@LPRINT_STOP
	@POP
	retf
ekt_stlA4_end	endp

ekt_selid	proc	near
	@PUSH
	@LPRINTSTR	prn_line_feed,lpt_number,cs:print_stack5
	@LPRINTSTR	prn_line_feed,lpt_number,cs:print_stack5
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
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	@LPRINTCHR	"S",lpt_number,cs:print_stack5
	@LPRINTCHR	"T",lpt_number,cs:print_stack5
	@LPRINTCHR	"R",lpt_number,cs:print_stack5
	@LPRINTCHR	".",lpt_number,cs:print_stack5
	@LPRINTCHR	" ",lpt_number,cs:print_stack5
	mov	ax,prn_str_prsel
	@ITOA	strbuf,4
	@LPRINTSTR	strbuf,lpt_number,cs:print_stack5
	inc	prn_str_prsel
	@LPRINTSTR	prn_formfeed,lpt_number,cs:print_stack5
	mov	prn_stl_Selida,0
	@POP
	ret
ekt_selid	endp

codesg5	ends
	end
