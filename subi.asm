INCLUDE	equs.h

print	macro	ch
	mov	al,ch
	mov	ah,0eh
	int	10h
	endm

biosprint macro	
	mov	al,dl		;routina bios
	mov	ah,0eh
	int	10h
	endm

codesg	segment public
public	screen,x21,apo_evs,naoxi,bbuf,prbuf,clr_scr,lprint
public	setcurs,plhktro,dispmhn,bin_dec,dosdisp
public	dec_bin,apou2,apou3,predit,bbuffer,capo,metrpr
public	tajinom,xarakt,asteri,edast,omades,metrima,edomad,putsthles
public	editq,editr,editomr,editot,sbyse,cersor,biosdisp
public	tend,editor,editor1,editor2,dioru,tselid,tchar,kauar
public	edtomr1,deltyp,eisagvgh_dialoghs,getkey,dosdisp

	ASSUME	CS:CODESG,DS:DATAS1,ES:DATANA
;
dosdisp	proc	near
	push	ax
	biosprint
	pop	ax
	ret
dosdisp	endp

;
biosdisp	proc	near
	push	ax
	biosprint
	pop	ax
	ret
biosdisp	endp

putsthles	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@SELECTWI	0
	@FILLSTR	strbuf," ",11
	@WPRINT	4,0,strbuf
	@LTOA	cound,cound[2],strbuf
	@USING	strbuf,8
	@WPRINT	6,0,strbuf
	@POP
	ret
putsthles	endp

tend	proc	near
	call	kauar
	cmp	shmea4,0
	je	blab
	mov	shmea4,0
	cmp	shmea5,1
	je	smea52
	ret
blab:	cmp	shmea5,1
	je	edvp
	mov	ax,bselida
	cmp	selida,ax
	je	edvp
	mov	selida,ax
	call	apou2
	call	prbuf
	call	apou3
edvp:	cmp	asthlh,77
	ja	sbyse1
	jmp	kouts
sbyse1:	cmp	bselida,89
	jae	kouts
	call	sbyse
	inc	selida
	inc	bselida
kouts:	call	bbuf
	cmp	mastos,1
	je	cam1
	call	tselid
cam1:	mov	mastos,0
	ret
smea52:	mov	shmea5,2
	ret
tend	endp
;
dioru	proc	near
	mov	dh,0
	mov	dl,23
koita:	call	setcurs
	push	dx
	mov	dl,219
	call	dosdisp
	mov	dl,8
	call	dosdisp
	call	getkey
	cmp	al,0
	jne	kolaraki
	cmp	ah,4dh
	je	koita1
	cmp	ah,4bh
	jne	kolaraki
	jmp	kratv2
kolaraki:
	cmp	al,"-"
	jne	kifa
	jmp	kratv2
kifa:	cmp	al,13
	je	koita2
	cmp	al,"]"
	je	koita1
	cmp	al,"+"
	je	koita1
	cmp	al,27
	jne	nokoit
	jmp	kissa
nokoit:	pop	dx
	jmp	koita
koita1:	mov	dl,32
	call	dosdisp
	pop	dx
	cmp	dl,74
	ja	maxim
	add	dl,4
	jmp	koita
koita2:	pop	dx
	mov	sthlh,dl
	mov	stili,dl
	sub	dl,23
	xor	ax,ax
	mov	al,dl
	xor	dx,dx
	mov	cx,4
	div	cx
	mov	cx,48
	mul	cx
	push	ax
	mov	ax,selida
	mov	cx,672
	mul	cx
	pop	cx
	add	ax,cx
	xor	dx,dx
;------------------------------ klidoma
	push	ax
	mov	bx,48
	div	bx
	mov	bx,ax
	pop	ax
	@CHANGESEGM	ds,DATASC
	mov	dl,klioro[bx]
	@CHANGESEGM	ds,DATAS1
	cmp	dl,1
	jne	tdk1
	mov	ax,65535
	jmp	tdk
tdk1:	call	bbuffer
	call	predit
tdk:	ret
maxim:	mov	dl,23
	jmp	koita
kissa:	pop	dx
	mov	sthlh,dl
	mov	stili,dl
	sub	dl,23
	xor	ax,ax
	mov	al,dl
	xor	dx,dx
	mov	cx,4
	div	cx
	mov	cx,48
	mul	cx
	push	ax
	mov	ax,selida
	mov	cx,672
	mul	cx
	pop	cx
	add	ax,cx
	xor	dx,dx
	mov	ax,65535
	ret
kratv2:	mov	dl,32
	call	dosdisp
	pop	dx
	cmp	dl,23
	jbe	minim
	sub	dl,4
	jmp	koita
minim:	mov	dl,75
	jmp	koita
dioru	endp
;
tselid	proc	near
	mov	dl,asthlh
	mov	sthlh,dl
	mov	bx,0
	mov	dh,0
	mov	dl,sthlh
	inc	dl
	call	setcurs
	add	sthlh,3
	mov	dl,buffers[bx]
	call	tchar
	mov	grammh,2
	mov	cx,13
aqub:	push	cx
	dec	sthlh
	dec	sthlh
	dec	sthlh
	cmp	cx,10
	je	incr
	cmp	cx,7
	je	incr
	cmp	cx,4
	je	incr
	jmp	beba
incr:	inc	grammh
beba:	mov	cx,3
aqua:	push	cx
	mov	dh,grammh
	mov	dl,sthlh
	call	setcurs
	mov	dl,buffers[bx]
	call	tchar
	inc	sthlh
	pop	cx
	loop	aqua
	pop	cx
	inc	grammh
	loop	aqub
	inc	grammh
	dec	sthlh
	dec	sthlh
	dec	sthlh
	call	cersor
	mov	dl,buffers[bx]
	call	tchar
	mov	dl,buffers[bx]
	call	tchar
	inc	grammh
	call	cersor
	mov	dl,buffers[bx]
	call	tchar
	mov	dl,buffers[bx]
	call	tchar
	inc	grammh
	call	cersor
	mov	dl,buffers[bx]
	call	tchar
	inc	grammh
	inc	grammh
	call	cersor
	mov	dl,buffers[bx]
	call	tchar
	cmp	buffers[bx+1],2
	jb	pyr0
	mov	dl,buffers[bx]
	call	tchar
	jmp	pyr1
pyr0:	mov	dl," "
	call	tchar
pyr1:	mov	cx,48
	mov	bx,0
again:	mov	buffers[bx]," "
	inc	bx
	loop	again
	cmp	shmea5,1
	je	mvro
	add	asthlh,4
mvro:	ret
tselid	endp

sbyse	proc	near
	mov	sthlh,23
	mov	cx,14
babe:	push	cx
	mov	cx,0
baba:	cmp	cx,22
	je	decr
	cmp	cx,18
	je	decr
	cmp	cx,13
	je	decr
	cmp	cx,9
	je	decr
	cmp	cx,5
	je	decr
	cmp	cx,1
	je	decr
	jmp	edvm
decr:	inc	cx
edvm:	mov	dh,cl
	mov	dl,sthlh
	call	setcurs
	print	32
	print	32
	print	32
	inc	cx
	cmp	cx,24
	jl	baba
	add	sthlh,4
	pop	cx
	loop	babe
	mov	asthlh,23
	ret
sbyse	endp

cersor	proc	near
	push	dx
	push	ax
	push	bx
	mov	dh,grammh
	mov	dl,sthlh
	mov	ah,02
	mov	bh,00
	int	10h
	pop	bx
	pop	ax
	pop	dx
	ret
cersor	endp

tchar	proc	near
	biosprint
	inc	bx
	ret
tchar	endp

kauar	proc	near
	push	ax
	mov	al,shmeat
	mov	shmeat,0
	mov	shmea2,1
	call	editor1
	mov	shmea2,0
	mov	dl,18
	mov	dh,0
	call	setcurs
	print	32
	mov	dl,17
	mov	dh,19
	call	setcurs
	print	32
	print	32
	inc	dh
	call	setcurs
	print	32
	print	32
	inc	dh
	call	setcurs
	print	32
	inc	dh
	inc	dh
	call	setcurs
	print	32
	print	32
	mov	shmeat,al
	pop	ax
	ret
kauar	endp

editor	proc	near
	mov	shmea1,1
	mov	shmea3,0
	cmp	shmea8,1
	je	shm81
	mov	shmeat,0
shm81:	call	editor1
	call	editor2
	ret
editor	endp

editor2	proc	near
	cmp	shmeat,1
	jne	edit5
	ret
edit5:	call	posa_shmeia
	mov	sthlh,17
	mov	grammh,19
	mov	bx,40
	call	apo_evs
	cmp	shmea6,0
	je	edit3
	mov	shmea6,0
	jmp	edit4
edit3:	inc	grammh
	mov	bx,42
	call	apo_evs
	cmp	shmea6,0
	je	edit6
	mov	shmea6,0
	jmp	edit4
edit6:	call	naoxi
	cmp	shmea6,0
	je	edit7
	mov	shmea6,0
	jmp	edit4
edit7:	jmp	edit5
edit4:	cmp	buffers[44],32
	jne	pll41
	mov	buffers[44],78
pll41:	cmp	shmeat,1
	jne	tiptis
	cmp	buffers[45],32
	je	tipt1
	ret
tiptis:	mov	grammh,23
	mov	bx,45
	call	apo_evs
	cmp	buffers[45],32
	jne	edit8
tipt1:	mov	buffers[45],49
	mov	buffers[46]," "
	mov	buffers[47],1
	mov	shmea6,0
	ret
edit8:	mov	shmea6,0
	mov	ax,bin
	cmp	al,0
	jne	deneinai0
	mov	al,1
	mov	buffers[45],49
deneinai0:
	cmp	al,35
	ja	tiptis
;------------------------------- klidoma
	mov	di,ax
	dec	di
	dec	di
	@CHANGESEGM	ds,DATASC
	mov	dl,klioma[di]
	@CHANGESEGM	ds,DATAS1
	cmp	dl,1
	je	tiptis
	mov	buffers[47],al
	ret
editor2	endp

editor1	proc	near
	cmp	shmeat,1
	jne	arxh
	ret
arxh:	mov	bx,1
	cmp	shmea8,0
	je	edll1
	mov	dl,19
	mov	bx,3
	jmp	seb1
edll1:	mov	dl,17

seb1:	mov	dh,2
	call	x21
	jnc	seb2

	mov	bx,37
	cmp	shmea8,0
	je	seb13
	mov	bx,39
	jmp	seb13

seb2:	mov	dh,3
	call	x21
	jc	seb1
seb3:	mov	dh,4
	call	x21
	jc	seb2
seb4:	mov	dh,6
	call	x21
	jc	seb3
seb5:	mov	dh,7
	call	x21
	jc	seb4
seb6:	mov	dh,8
	call	x21
	jc	seb5
seb7:	mov	dh,10
	call	x21
	jc	seb6
seb8:	mov	dh,11
	call	x21
	jc	seb7
seb9:	mov	dh,12
	call	x21
	jc	seb8
seb10:	mov	dh,14
	call	x21
	jc	seb9
seb11:	mov	dh,15
	call	x21
	jc	seb10
seb12:	mov	dh,16
	call	x21
	jc	seb11
seb13:	mov	dh,17
	call	x21
	jc	seb12
	cmp	shmea1,0
	je	reta
	cmp	shmea2,1
	je	reta
	jmp	arxh
reta:	ret
editor1	endp

x21	proc	near
	cmp	shmea2,0
	je	x21x
	mov	dl,17
	call	setcurs
	print	32
	print	32
	print	32
	clc
	ret
x21x:	cmp	shmea3,0
	je	poyli
	mov	shmea1,0
	clc
	ret

poyli:	push	bx
	call	setcurs
	call	getkey
	pop	bx
	cmp	al,0
	jne	kokain
	cmp	ah,48h
	jne	kokais
	sub	bx,3
	stc
	ret

kokais:	cmp	ah,50h
	jne	kokain
	jmp	returnt
kokain:	
	cmp	al,"."
	jne	gke
	mov	shmea1,1
	mov	shmea3,1
	inc	bx
	clc
	ret

gke:	cmp	al,"T"
	jne	pirou
_taf:	mov	shmea1,1
	mov	shmea3,1
	mov	shmeat,1
	inc	bx
	clc
	ret

pirou:	cmp	al,"/"
	je	_taf
	cmp	al,13
	je	returnt
	cmp	al,8
	je	_as
	cmp	al,81
	jne	dttl
_as:	jmp	dlt
dttl:	cmp	shmea_diplh,1
	je	oxi_mona_shmeia
	cmp	al,"1"
	jz	q11
	cmp	al,"2"
	jz	q22
	cmp	al,"3"
	jz	qxx
	cmp	al,"*"
	jnz	nasteraki
	jmp	isasteraki
nasteraki:
	cmp	shmea8,1
	je	pll30
	cmp	shmea7,0
	jne	pll28
	cmp	shmea11,0
	jne	pll28
	cmp	al,"7"
	je	q12x
pll28:	cmp	shmea7,2
	je	pll30
oxi_mona_shmeia:
	cmp	al,"4"
	jz	q12
	cmp	al,"5"
	jz	q2x
	cmp	al,"6"
	jnz	pll30
	jmp	q1x

pll30:	jmp	x21x

returnt:
	add	bx,3
	clc
	ret

dlt:	jmp	bdlt
q11:	jmp	b11
q22:	jmp	b22
qxx:	jmp	bxx
q12x:	jmp	b12x
q12:	jmp	b12
q2x:	jmp	b2x
q1x:	jmp	b1x

goepomeno:
	push	dx
	mov	dl,buffers[bx]
	@DOSPRINT dl
	mov	dl,buffers[bx+1]
	@DOSPRINT dl
	mov	dl,buffers[bx+2]
	@DOSPRINT dl
	pop	dx
	add	bx,3
	clc
	ret

b12x:	mov	buffers[bx],31h
	mov	buffers[bx+1],58h
	mov	buffers[bx+2],32h
	jmp	goepomeno

b1x:	mov	buffers[bx],31h
	mov	buffers[bx+1],58h
	mov	buffers[bx+2],32
	jmp	goepomeno

b12:	mov	buffers[bx],31h
	mov	buffers[bx+1],32h
	mov	buffers[bx+2],32
	jmp	goepomeno

b2x:	mov	buffers[bx],58h
	mov	buffers[bx+1],32h
	mov	buffers[bx+2],32
	jmp	goepomeno

b11:	mov	buffers[bx],31h
	cmp	shmea8,1
	jne	edll10
	jmp	goepom_sim8

b22:	mov	buffers[bx],32h
	cmp	shmea8,1
	jne	edll4
	jmp	goepom_sim8
edll4:	cmp	shmea8,2
	jne	edll10
	jmp	goepom_sim8

bxx:	mov	buffers[bx],58h
	cmp	shmea8,1
	jne	edll10
	jmp	goepom_sim8

edll10:	mov	buffers[bx+1],32
	mov	buffers[bx+2],32
	jmp	goepomeno

bdlt:	mov	buffers[bx],32
	cmp	shmea8,1
	je	goepom_sim8
	mov	buffers[bx+1],32
	mov	buffers[bx+2],32
	jmp	goepomeno
	
qasterk:	@MBELL

goepom_sim8:
;------------------------------------------------
;	push	dx
;	mov	dh,1
;	mov	dl,1
;	call	setcurs
;	mov	dl,buffers[bx]
;	@DOSPRINT 	dl
;	pop	dx
;------------------------------------------------

	call	setcurs
	push	dx
	mov	dl,buffers[bx]
	@DOSPRINT dl
	pop	dx

	add	bx,3
	clc
	ret
x21	endp

apo_evs	proc	near
	mov	al,buffers[bx]
	mov	chfioa,al
	inc	bx
	mov	al,buffers[bx]
	mov	chfiob,al
	mov	bin,0
pali1:	dec	bx
pali:	mov	dh,grammh
	mov	dl,sthlh
	call	setcurs
	call	plhktro
	cmp	al,13
	jne	_rita
	jmp	ejv
_rita:	cmp	al,46
	jne	rrter
	jmp	ejva1
rrter:	cmp	al,"T"
	jne	frot
_tafi:	mov	shmeat,1
	jmp	ejva1
frot:	cmp	al,"/"
	je	_tafi
	cmp	al,30h
	jb	pali
	cmp	al,39h
	ja	pali
	mov	buffers[bx],al
	mov	chfioa,al
	inc	bx
	mov	buffers[bx],32
	mov	chfiob,0
	mov	dl,al
	call	dosdisp
	print	32
	print	8
palia:	mov	dh,grammh
	mov	dl,sthlh
	inc	dl
	call	setcurs
	call	plhktro
	cmp	al,13
	je	ejv
	cmp	al,"T"
	jne	froto
_tafi1:	mov	shmeat,1
	jmp	ejva1
froto:	cmp	al,"/"
	je	_tafi1
	cmp	al,46
	je	ejva1
	cmp	al,30h
	jb	palia
	cmp	al,39h
	ja	palia
	mov	buffers[bx],al
	mov	chfiob,al
	mov	dl,al
	call	dosdisp
	jmp	pali1
ejva1:	mov	shmea6,1
ejv:	mov	al,chfioa
	call	dec_bin
	mov	al,chfiob
	call	dec_bin
	ret
apo_evs	endp
;
naoxi	proc	near
	mov	bx,44
	mov	dh,21
	mov	dl,17
pll:	call	setcurs
	call	plhktro
	cmp	al,13
	je	rete
	cmp	al,46
	je	rete1
	cmp	al,"T"
	jne	frot2
_tafi2:	mov	shmeat,1
	jmp	rete1
frot2:	cmp	al,"/"
	je	_tafi2
	cmp	al,4fh
	je	oxi
	cmp	al,6fh
	je	oxi
	print	4eh
	mov	buffers[bx],78
	jmp	pll
oxi:	print	4fh
	mov	buffers[bx],79
	jmp	pll
rete1:	mov	shmea6,1
rete:	inc	bx
	ret
	
isasteraki:
	cmp	buffers[0],"!"
	je	todexomai
	cmp	buffers[0],"$"
	je	todexomai
	cmp	buffers[0],"~"
	je	todexomai
	cmp	buffers[0],"I"
	je	todexomai
	cmp	buffers[0],"/"
	je	todexomai
	cmp	buffers[0],"@"
	je	todexomai
	jmp	nasteraki
todexomai:
	mov	buffers[bx],"*"
	mov	buffers[bx+1],32
	mov	buffers[bx+2],32
	jmp	goepomeno
naoxi	endp

bbuf	proc	near
	mov	bx,0
	mov	si,arxascii
	cmp	si,BUFASCII
	jb	xese
	mov	dl,7
	call	dosdisp
	mov	asthlh,79
	mov	mastos,1
	ret
xese:	mov	cx,48
jump:	mov	dl,buffers[bx]
	@CHANGESEGM	ds,DATASC
	mov	arxasc[si],dl
	@CHANGESEGM	ds,DATAS1
	inc	si
	inc	bx
	loop	jump
	cmp	shmea5,1
	je	smea51
	add	arxascii,48
smea51:	ret
bbuf	endp

prbuf	proc	near
	cmp	arxascii,0
	jne	prb88
	call	screen
	ret
prb88:	mov	ah,0
	mov	al,asthlh
	push	ax
	mov	asthlh,23
	mov	ax,selida
	mov	cx,672
	mul	cx
	mov	si,ax
	mov	cx,14
tira:	push	cx
	mov	bx,0
	mov	cx,48
tirb:	@CHANGESEGM	ds,DATASC
	mov	dl,arxasc[si]
	@CHANGESEGM	ds,DATAS1
	mov	buffers[bx],dl
	inc	si
	inc	bx
	loop	tirb
	push	si
	call	tselid
	pop	si
	pop	cx
	loop	tira
	pop	dx
	mov	asthlh,dl
	ret
prbuf	endp

clr_scr	proc	near
	@FILLSCR	" ",70h
	ret
clr_scr	endp

setcurs	proc	near		;routina toy bios
	push	bx
	push	ax
	mov	ah,02
	mov	bh,00
	int	10h
	pop	ax
	pop	bx
	ret
setcurs	endp

plhktro	proc	near
	@WAITL
	@UPPERAX
	ret
plhktro	endp

dispmhn	proc	near
	push	ax
	push	bx
	push	si
	xor	bx,bx
	mov	si,dx
mhn:	mov	dl,[si]
	cmp	dl,0
	je	endmhn
	biosprint
	inc	si
	jmp	mhn
endmhn:	pop	si
	pop	bx
	pop	ax
	ret
dispmhn	endp

bin_dec	proc	near
	push	ax
	push	dx
	push	cx
	push	di
	sub	cx,cx
	xor	di,di
nextdig:	push	cx
	mov	ax,dx
	xor	dx,dx
	mov	cx,10
	div	cx
	xchg	ax,dx
	add	al,30h
	mov	cs:ascbuf[di],al
	inc	di
	pop	cx
	inc	cx
	cmp	dx,0
	jnz	nextdig
emptbuf:	dec	di
	mov	dl,cs:ascbuf[di]
	call	biosdisp
	mov	cs:ascbuf[di],0
	loop	emptbuf
	pop	di
	pop	cx
	pop	dx
	pop	ax
	ret
ascbuf	db	10 dup(0)
bin_dec	endp

dec_bin	proc	near
	push	ax
	push	dx
	push	cx
	push	bx
	sub	al,30h		;	 mov	al,chfioa
	jl	exit99		;	 call	dec_bin
	cmp	al,9		;	 mov	al,chfiob
	jg	exit99		;	 call	dec_bin
	cbw			;	 to apotelesma sthn [bin]
	xchg	ax,bin
	mov	cx,10
	mul	cx
	xchg	ax,bin
	add	bin,ax
exit99:
	pop	bx
	pop	cx
	pop	dx
	pop	ax
	ret
dec_bin	endp

apou2	proc	near
	mov	cx,48
	mov	bx,0
edvc:	mov	dl,buffers[bx]
	mov	buffer[bx],dl
	inc	bx
	loop	edvc
	ret
apou2	endp

apou3	proc	near
	mov	cx,48
	mov	bx,0
edvd:	mov	dl,buffer[bx]
	mov	buffers[bx],dl
	inc	bx
	loop	edvd
	ret
apou3	endp

predit	proc	near
	push	ax
	mov	bx,ax
	mov	dh,0
	mov	dl,18
	call	setcurs
	@CHANGESEGM	ds,DATASC
	mov	dl,arxasc[bx]
	@CHANGESEGM	ds,DATAS1
	call	tchar
	inc	dh
	mov	cx,13
pred2:	push	cx
	inc	dh
	cmp	dh,5
	je	incr1
	cmp	dh,9
	je	incr1
	cmp	dh,13
	je	incr1
	mov	dl,17
	mov	cx,3
	jmp	pred1
incr1:	inc	dh
	mov	dl,17
	mov	cx,3
pred1:	call	setcurs
	push	dx
	@CHANGESEGM	ds,DATASC
	mov	dl,arxasc[bx]
	@CHANGESEGM	ds,DATAS1
	call	tchar
	pop	dx
	inc	dl
	loop	pred1
	pop	cx
	loop	pred2
	inc	dh
	inc	dh
	sub	dl,3
	call	setcurs
	inc	dl
	push	dx
	@CHANGESEGM	ds,DATASC
	mov	dl,arxasc[bx]
	@CHANGESEGM	ds,DATAS1
	call	tchar
	pop	dx
	call	setcurs
	inc	dh
	dec	dl
	push	dx
	@CHANGESEGM	ds,DATASC
	mov	dl,arxasc[bx]
	@CHANGESEGM	ds,DATAS1
	call	tchar
	pop	dx
	call	setcurs
	inc	dl
	push	dx
	@CHANGESEGM	ds,DATASC
	mov	dl,arxasc[bx]
	@CHANGESEGM	ds,DATAS1
	call	tchar
	pop	dx
	call	setcurs
	inc	dh
	dec	dl
	push	dx
	@CHANGESEGM	ds,DATASC
	mov	dl,arxasc[bx]
	@CHANGESEGM	ds,DATAS1
	call	tchar
	pop	dx
	call	setcurs
	inc	dh
	inc	dh
	push	dx
	@CHANGESEGM	ds,DATASC
	mov	dl,arxasc[bx]
	@CHANGESEGM	ds,DATAS1
	call	tchar
	pop	dx
	call	setcurs
	inc	dl
	push	dx
	@CHANGESEGM	ds,DATASC
	mov	dl,arxasc[bx]
	@CHANGESEGM	ds,DATAS1
	call	tchar
	pop	dx
	call	setcurs
	@CHANGESEGM	ds,DATASC
	mov	al,arxasc[bx+1]
	@CHANGESEGM	ds,DATAS1
	cmp	al,1
	jne	b7
	mov	dl," "
	call	biosdisp
	jmp	b8
b7:	@CHANGESEGM	ds,DATASC
	mov	dl,arxasc[bx]
	@CHANGESEGM	ds,DATAS1
	call	tchar
b8:	pop	ax
	ret
predit	endp

bbuffer	proc	near
	mov	si,ax
	mov	bx,0
	mov	cx,48
lopa:	@CHANGESEGM	ds,DATASC
	mov	dl,arxasc[si]
	@CHANGESEGM	ds,DATAS1
	mov	buffers[bx],dl
	inc	bx
	inc	si
	loop	lopa
	ret
bbuffer	endp

pintaj	proc	near
	@PUSH
	mov	bx,47
	xor	si,si
	mov	ah,0
pint2:	@CHANGESEGM	ds,DATASC
	mov	al,arxasc[bx]
	@CHANGESEGM	ds,DATAS1
	cmp	al,1
	jbe	pint3
	cmp	al,ah
	jne	pint1
pint3:	add	bx,48
	cmp	bx,arxascii
	jbe	pint2
	@POP
	ret

pint1:	xor	dx,dx
	mov	dl,al
	mov	di,dx
	dec	di
	dec	di
	cmp	pinak2[di],"*"
	jne	pint3
	mov	ah,al
	mov	elepin[si],al
	inc	si
	jmp	pint3
pintaj	endp

tajinom	proc	near
	mov	ax,arxascii
	cmp	ax,49
	jb	yptaj
	xor	dx,dx
	mov	cx,48
	div	cx
	dec	ax
	mov	tajin,ax
taji1:	mov	bx,47
	mov	klitaj,0
	mov	cx,tajin
taji2:	@CHANGESEGM	ds,DATASC
	mov	ah,arxasc[bx]
	add	bx,48
	mov	al,arxasc[bx]
	@CHANGESEGM	ds,DATAS1
	cmp	al,ah
	jb	taji3
taji7:	inc	klitaj
	loop	taji2
	dec	tajin
	cmp	tajin,0
	jne	taji1
yptaj:	call	pintaj
	ret
;
taji3:	push	bx
	push	cx
	sub	bx,95
	mov	cx,48
	mov	si,0
taji4:	@CHANGESEGM	ds,DATASC
	mov	al,arxasc[bx]
	@CHANGESEGM	ds,DATAS1
	mov	buffers[si],al
	inc	bx
	inc	si
	loop	taji4
	mov	si,bx
	sub	bx,48
	@CHANGESEGM	ds,DATASC
	mov	cx,48
taji5:	mov	al,arxasc[si]
	mov	arxasc[bx],al
	inc	si
	inc	bx
	loop	taji5
	@CHANGESEGM	ds,DATAS1
	mov	si,0
	mov	cx,48
taji6:	mov	al,buffers[si]
	@CHANGESEGM	ds,DATASC
	mov	arxasc[bx],al
	@CHANGESEGM	ds,DATAS1
	inc	si
	inc	bx
	loop	taji6
	mov	bx,klitaj
	@CHANGESEGM	ds,DATASC
	mov	dl,klioro[bx]
	mov	dh,klioro[bx+1]
	mov	klioro[bx],dh
	mov	klioro[bx+1],dl
	@CHANGESEGM	ds,DATAS1
	pop	cx
	pop	bx
	jmp	taji7
tajinom	endp

xarakt	proc	near
	mov	buffers[0],al
	mov	bx,0
xar1:	mov	dl,leonid[bx]
	cmp	dl,0
	je	xar99
	cmp	al,dl
	je	xar2
	add	bx,14
	jmp	xar1
xar99:	ret
xar2:	inc	bx
	mov	si,2
	mov	cx,13
	mov	dh,2
xar4:	mov	dl,18
	cmp	dh,5
	je	xari
	cmp	dh,9
	je	xari
	cmp	dh,13
	je	xari
	jmp	xar3
xari:	inc	dh
xar3:	call	setcurs
	mov	dl,leonid[bx]
	call	tchar
	mov	buffers[si],dl
	add	si,3
	inc	dh
	loop	xar4
	ret
xarakt	endp

asteri	proc	near
	mov	dh,2
	mov	dl,17
	mov	bx,1
	mov	cx,13
ast2:	call	setcurs
	print	42
	mov	buffers[bx],42
	add	bx,3
	inc	dh
	cmp	dh,5
	je	ast1
	cmp	dh,9
	je	ast1
	cmp	dh,13
	je	ast1
ast3:	loop	ast2
	ret
ast1:	inc	dh
	jmp	ast3
asteri	endp

edast	proc	near
	mov	bx,1
	mov	dh,2
	mov	dl,17
ast8:	call	setcurs
	call	getkey
	cmp	al,0
	jne	kerea
	cmp	ah,48h
	jne	kere1
_panc:	dec	dh
	cmp	bx,2
	jbe	notelec
	sub	bx,3
	jmp	telecame
notelec:
	mov	bx,37
	mov	dh,17
	jmp	telecame
kere1:	cmp	ah,50h
	je	ast6
kerea:	cmp	al,"+"
	je	_panc
	cmp	al,13
	je	ast6
	cmp	al,42
	je	ast7
	cmp	al,"/"
	je	_tafw
	cmp	al,"T"
	jne	krokd
_tafw:	mov	shmeat,1
	jmp	ast12
krokd:	cmp	al,8
	je	ast11
	cmp	al,81
	je	ast11
	cmp	al,"-"
	je	ast11
	cmp	al,46
	je	ast12
	jmp	ast8
ast6:	inc	dh
	add	bx,3
	cmp	dh,5
	je	ast9
	cmp	dh,9
	je	ast9
	cmp	dh,13
	je	ast9
	cmp	dh,18
	je	ast10
	jmp	ast8
ast9:	inc	dh
	jmp	ast8
ast10:	mov	dh,2
	mov	bx,1
	jmp	ast8
ast7:	print	42
	mov	buffers[bx],42
	jmp	ast8
ast11:	print	32
	mov	buffers[bx],32
	jmp	ast8
ast12:	ret
telecame:
	cmp	dh,5
	je	ast9w
	cmp	dh,9
	je	ast9w
	cmp	dh,13
	je	ast9w
	jmp	ast8
ast9w:	dec	dh
	jmp	ast8
edast	endp

capo	proc	near
	cmp	shmeat,1
	jne	shmt
	ret
shmt:	mov	bx,44
	mov	grammh,21
	mov	sthlh,17
	call	naoxi
	cmp	buffers[44],32
	jne	pll56
	mov	buffers[44],78
pll56:	mov	shmea6,0
	cmp	shmeat,1
	jne	capo4
	ret
capo4:	mov	bx,45
	mov	grammh,23
	call	apo_evs
	cmp	buffers[45],32
	jne	capo8
	mov	buffers[45],49
	mov	buffers[47],1
	mov	shmea6,0
	ret
capo8:	mov	shmea6,0
	mov	ax,bin
;-------------------------------- klidoma
	cmp	ax,0
	je	capo4
	cmp	al,35
	ja	capo4
	mov	di,ax
	dec	di
	dec	di
	@CHANGESEGM	ds,DATASC
	mov	dl,klioma[di]
	@CHANGESEGM	ds,DATAS1
	cmp	dl,1
	je	capo4
	mov	buffers[47],al
	ret
capo	endp

omades	proc	near
	call	clr_scr
	mov	bx,arxascii
	cmp	bx,0
	je	kratis
	@CHANGESEGM	ds,DATASC
	mov	dl,arxasc[bx-48]
	@CHANGESEGM	ds,DATAS1
	cmp	dl,"M"
	jne	kratis
	xor	dx,dx
	mov	dl,60
	call	setcurs
	lea	dx,mesfor12
	call	dispmhn
	@CHANGESEGM	ds,DATASC
	mov	dl,arxasc[bx-6]
	mov	al,arxasc[bx-5]
	@CHANGESEGM	ds,DATAS1
	push	ax
	call	biosdisp
	pop	ax
	mov	dl,al
	call	biosdisp
kratis:	xor	dx,dx
	call	setcurs
	lea	dx,omadea
	call	dispmhn
	mov	cx,80
	mov	dh,1
	mov	dl,0
	call	setcurs
omo2:	print	223
	loop	omo2
	mov	dh,2
	mov	dl,0
	call	setcurs
	lea	dx,mhnplhr
	call	dispmhn
	mov	cx,17
	mov	dh,3
omo1:	mov	dl,0
	push	dx
	call	setcurs
	lea	dx,omada
	call	dispmhn
	pop	dx
	inc	dh
	loop	omo1
	mov	dh,21
	mov	dl,0
	call	setcurs
	lea	dx,omadeb
	call	dispmhn
	mov	cx,80
	mov	dh,22
	mov	dl,0
	call	setcurs
omo3:	print	223
	loop	omo3
	mov	cx,4
	mov	bx,0
	mov	dh,23
	mov	dl,0
omo5:	push	dx
	call	setcurs
	lea	dx,omadb
	call	dispmhn
	pop	dx
	add	dl,8
	call	setcurs
	push	dx
	mov	dl,bl
	add	dl,65
	call	dosdisp
	inc	bx
	pop	dx
	add	dl,32
	cmp	dl,78
	ja	omo4
omo6:	loop	omo5
	jmp	omo7
omo4:	inc	dh
	mov	dl,0
	jmp	omo6
omo7:	ret
omades	endp

metrima	proc	near
	mov	cx,36
	mov	bx,0
kolos:	mov	pinak1[bx],0
	add	bx,6
	loop	kolos
	mov	bx,arxascii
	@CHANGESEGM	ds,DATASC
	mov	arxasc[bx+47],99
	@CHANGESEGM	ds,DATAS1
	mov	bx,47
	mov	synor,0
metr5:	mov	ayjhse,0
	@CHANGESEGM	ds,DATASC
	mov	dl,arxasc[bx]
	@CHANGESEGM	ds,DATAS1
	cmp	dl,99
	jne	metr11
	jmp	metr10
metr11:	cmp	ayjhse,0
	jne	metr3
	mov	ayjhse,1
metr3:	add	bx,48
	@CHANGESEGM	ds,DATASC
	mov	dh,arxasc[bx]
	@CHANGESEGM	ds,DATAS1
	cmp	dh,dl
	jne	metr4
	inc	ayjhse
	jmp	metr3
metr4:	xor	ax,ax
	mov	al,dl
	mov	cx,6
	mul	cx
	mov	si,ax
	mov	dx,ayjhse
	add	synor,dx
	mov	pinak1[si],dx
	jmp	metr5
metr10:	mov	cx,34
	mov	bx,12
mitr2:	mov	dx,pinak1[bx]
	cmp	dx,0
	je	mitr1
mitr3:	add	bx,6
	loop	mitr2
	ret
mitr1:	mov	pinak1[bx+2],0
	mov	pinak1[bx+4],0
	mov	ax,bx
	xor	dx,dx
	push	cx
	mov	cx,6
	div	cx
	pop	cx
	mov	si,ax
	sub	si,2
	mov	pinak2[si],42
	jmp	mitr3
metrima	endp

edomad	proc	near
	mov	shmea13,0
edom34:	mov	cx,34
	mov	bx,12
edom2:	mov	dx,pinak1[bx]
	cmp	dx,0
	jne	edom1
edom5:	add	bx,6
	loop	edom2
	cmp	shmea13,1
	je	trtr
	call	edtomr1
	call	plhktro
	ret
trtr:	jmp	edom34
;------------------------------- klidoma
edom1:	mov	ax,bx
	xor	dx,dx
	push	cx
	mov	cx,6
	div	cx
	pop	cx
	dec	ax
	dec	ax
	mov	si,ax
	@CHANGESEGM	ds,DATASC
	mov	al,klioma[si]
	@CHANGESEGM	ds,DATAS1
	cmp	al,1
	je	edom5
	mov	shmea13,1
	push	cx
	mov	ax,bx
	xor	dx,dx
	mov	pinak,ax
	mov	cx,6
	div	cx
	xor	dx,dx
	mov	cx,2
	div	cx
	cmp	dx,0
	jne	edom3
	mov	dh,al
	add	dh,2
	mov	dl,24
edom4:	mov	grammh,dh
	mov	sthlh,dl
	call	setcurs
	call	editq
	pop	cx
	cmp	shmea12,2
	je	edom33
	jmp	edom5
edom3:	mov	dl,64
	mov	dh,al
	add	dh,2
	jmp	edom4
edom33:	mov	shmea12,0
	ret
edomad	endp

editq	proc	near
	push	bx
	mov	bx,0
	mov	si,pinak
	add	si,2
	mov	shmea9,0
	mov	dh,grammh
	mov	dl,sthlh
	push	dx
edq5:	call	cersor
edq13:	call	plhktro
	cmp	al,46
	jne	edq1
	call	edq8
	pop	dx
	pop	bx
	ret
edq1:	cmp	al,84
	jne	edq2
	call	edq8
	pop	dx
	pop	bx
	mov	shmea12,2
	ret
edq2:	cmp	al,13
	jne	edq4
	mov	bx,0
	call	edq8
edq7:	cmp	shmea9,0
	jne	edq3
	add	sthlh,8
	pop	dx
	mov	dl,sthlh
	push	dx
	add	si,2
	mov	shmea9,1
	jmp	edq5
edq3:	sub	sthlh,8
	pop	dx
	mov	dl,sthlh
	push	dx
	sub	si,2
	mov	shmea9,0
	jmp	edq5
edq4:	cmp	al,48
	jb	edq6
	cmp	al,57
	ja	edq6
	mov	shmea12,1
	mov	dl,al
	call	dosdisp
	mov	chfioc[bx],dl
	pop	dx
	inc	dl
	push	dx
	cmp	bx,0
	je	edq11
	cmp	bx,1
	je	edq12
edq9:	inc	bx
	cmp	bx,3
	jne	edq6
	mov	bx,0
	pop	dx
	mov	dl,sthlh
	push	dx
edq6:	call	setcurs
	jmp	edq13
edq11:	mov	chfioc[1],32
	print	32
edq12:	mov	chfioc[2],32
	print	32
	jmp	edq9
edq8:	cmp	shmea12,1
	jne	edq15
	mov	bin,0
	mov	al,chfioc[0]
	call	dec_bin
	mov	al,chfioc[1]
	call	dec_bin
	mov	al,chfioc[2]
	call	dec_bin
	mov	ax,bin
	mov	pinak1[si],ax
	mov	shmea12,0
edq15:	ret
editq	endp

editr	proc	near
	mov	shmea13,0
edtr42:	mov	si,0
	mov	cx,34
	mov	bx,12
edtr21:	cmp	pinak2[si],80
	je	edtr25
	mov	dx,pinak1[bx]
	cmp	dx,0
	jne	edtr22
edtr25:	add	bx,6
	inc	si
	loop	edtr21
	cmp	shmea13,1
	je	rtrt
	ret
rtrt:	jmp	edtr42
;-------------------------------- klidoma
edtr22:	@CHANGESEGM	ds,DATASC
	mov	dl,klioma[si]
	@CHANGESEGM	ds,DATAS1
	cmp	dl,1
	je	edtr25
stor1:	mov	shmea13,1
	push	cx
	mov	ax,bx
	xor	dx,dx
	mov	cx,6
	div	cx
	xor	dx,dx
	mov	cx,2
	div	cx
	cmp	dx,0
	jne	edtr23
	mov	dh,al
	add	dh,2
	mov	dl,0
	jmp	edtr28
edtr23:	mov	dl,40
	mov	dh,al
	add	dh,2
edtr28:	push	dx
edtr24:	pop	dx
	call	setcurs
	push	dx
	call	plhktro
	cmp	al,81
	je	edtr2
	cmp	al,8
	je	edtr2
	cmp	al,13
	jne	edtr31
	pop	dx
	pop	cx
	jmp	edtr25
edtr31:	cmp	al,46
	jne	edtr32
	pop	dx
	pop	cx
	jmp	edtr25
edtr32:	cmp	al,84
	jne	edtr4
	pop	dx
	pop	cx
	ret
edtr4:	cmp	al,65
	jb	edtr1
	cmp	al,69
	ja	edtr1
	push	ax
	xor	ah,ah
	sub	ax,65
	mov	di,ax
	pop	ax
	@CHANGESEGM	ds,DATASC
	mov	dl,kliype[di]
	@CHANGESEGM	ds,DATAS1
	cmp	dl,1
	je	edtr24
	mov	dl,al
	call	dosdisp
	mov	pinak2[si],al
edtr1:	jmp	edtr24
edtr2:	print	42
	mov	pinak2[si],42
	jmp	edtr24
editr	endp

editomr	proc	near
	mov	shmea13,0
	mov	dh,65
edtm3:	mov	ayjhse,0
	mov	cx,34
	mov	bx,0
edtm2:	mov	dl,pinak2[bx]
	cmp	dl,80
	je	edtm4
	cmp	dl,dh
	jne	edtm4
	inc	ayjhse
edtm4:	inc	bx
	loop	edtm2
	push	dx
	sub	dh,65
	mov	al,dh
	mov	dl,3
	mul	dl
	mov	ah,0
	mov	si,ax
	mov	dx,ayjhse
	mov	pinak3[si],dl
	pop	dx
	inc	dh
	cmp	dh,69
	jb	edtm3
	jmp	edtm5
edtm5:	mov	cx,4
	mov	bx,0
edrmt:	cmp	pinak3[bx],0
	je	edtrm
edtmr:	add	bx,3
	loop	edrmt
	ret
edtrm:	mov	pinak3[bx+1],0
	mov	pinak3[bx+2],0
	jmp	edtmr
editomr	endp

edtomr1	proc	near
	mov	shmea13,0
	mov	cx,12
	mov	dh,23
	mov	dl,17
	mov	bx,0
edtm51:	call	setcurs
	push	dx
	cmp	dl,40
	jb	edtm59
	sub	dl,40
edtm59:	cmp	dl,17
	jne	edtm52
	pop	dx
	dec	dl
	push	dx
edtm52:	mov	dl,pinak3[bx]
	mov	dh,0
	call	bin_dec
	mov	dl,32
	call	dosdisp
	inc	bx
	pop	dx
	add	dl,8
	cmp	dl,32
	ja	edtm61
	jmp	edtm62
edtm61:	cmp	dl,41
	jb	edtm54
edtm62:	cmp	dl,72
	ja	edtm55
edtm53:	loop	edtm51
	ret
edtm54:	mov	dl,57
	jmp	edtm53
edtm55:	mov	dl,17
	mov	dh,24
	jmp	edtm53
edtomr1	endp

editot	proc	near
	mov	cx,4
	mov	bx,0
eddtd:	cmp	pinak3[bx],0
	jne	eddtt
eddtdr:	add	bx,3
	loop	eddtd
	ret
;------------------------------ klidoma
eddtt:	mov	ax,bx
	xor	dx,dx
	push	cx
	mov	cx,3
	div	cx
	pop	cx
	mov	si,ax
	@CHANGESEGM	ds,DATASC
	mov	dl,kliype[si]
	@CHANGESEGM	ds,DATAS1
	cmp	dl,1
	je	eddtdr
	mov	shmea13,0
edttq:	@CHANGESEGM	ds,DATASC
	mov	dl,kliype[0]
	@CHANGESEGM	ds,DATAS1
	cmp	dl,1
	je	dl1
	mov	dh,23
	mov	dl,24
	mov	bx,1
	call	edtti
	cmp	shmea13,1
	je	tois
dl1:	@CHANGESEGM	ds,DATASC
	mov	dl,kliype[1]
	@CHANGESEGM	ds,DATAS1
	cmp	dl,1
	je	dl2
	mov	dh,23
	mov	dl,64
	mov	bx,4
	call	edtti
	cmp	shmea13,1
	je	tois
dl2:	@CHANGESEGM	ds,DATASC
	mov	dl,kliype[2]
	@CHANGESEGM	ds,DATAS1
	cmp	dl,1
	je	dl3
	mov	dh,24
	mov	dl,24
	mov	bx,7
	call	edtti
	cmp	shmea13,1
	je	tois
dl3:	@CHANGESEGM	ds,DATASC
	mov	dl,kliype[3]
	@CHANGESEGM	ds,DATAS1
	cmp	dl,1
	je	dl4
	mov	dh,24
	mov	dl,64
	mov	bx,10
	call	edtti
	cmp	shmea13,1
	je	tois
	jmp	edttq
dl4:
tois:	mov	shmea13,0
	ret
edtti:	mov	si,0
	call	setcurs
	push	dx
edtt1:	call	plhktro
	cmp	al,84
	jne	edtt3
	pop	dx
	mov	shmea13,1
	call	edttk
	ret
edtt3:	cmp	al,13
	je	edtt4
	cmp	al,46
	je	edtt5
	cmp	al,48
	jb	edtt1
	cmp	al,57
	ja	edtt1
	mov	shmea12,1
	mov	dl,al
	call	dosdisp
	cmp	si,0
	je	edtt6
	cmp	si,1
	je	edtt7
edtt6:	print	32
	print	8
	mov	chfioc[0],dl
	mov	chfioc[1],32
	inc	si
	jmp	edtt1
edtt7:	mov	chfioc[1],dl
	dec	si
	print	8
	print	8
	jmp	edtt1
edtt5:	pop	dx
	call	edttk
	ret
edtt4:	pop	dx
	call	edttk
	cmp	dl,40
	ja	edtt8
	cmp	dl,24
	je	edtt9
	mov	dl,24
	dec	bx
	jmp	edtti
edtt9:	mov	dl,32
	inc	bx
	jmp	edtti
edtt8:	cmp	dl,64
	je	edtt10
	mov	dl,64
	dec	bx
	jmp	edtti
edtt10:	mov	dl,72
	inc	bx
	jmp	edtti
edttk:	cmp	shmea12,1
	je	edtt11
	ret
edtt11:	push	dx
	push	bx
	mov	bin,0
	mov	al,chfioc[0]
	call	dec_bin
	mov	al,chfioc[1]
	call	dec_bin
	mov	dx,bin
	pop	bx
	mov	pinak3[bx],dl
	pop	dx
	mov	shmea12,0
	ret
editot	endp

getkey	proc	near
	@WAITL
	@UPPERAX
	ret
getkey	endp

metrpr	proc	near
metr6:	mov	dh,0
	mov	dl,13
	call	setcurs
	mov	dx,synor
	mov	ax,pinak1
	sub	dx,ax
	call	bin_dec
	mov	dh,2
	mov	dl,16
	call	setcurs
	mov	dx,pinak1[0]
	cmp	dx,0
	je	metr15
	call	bin_dec
metr15:	mov	dh,2
	mov	dl,56
	call	setcurs
	mov	dx,pinak1[6]
	cmp	dx,0
	je	metr14
	call	bin_dec
	mov	dh,2
	mov	dl,48
	call	setcurs
	print	49
metr14:	mov	cx,34
	mov	bx,2
	mov	dh,3
	mov	dl,16
metr8:	call	setcurs
	push	dx
	mov	al,bl
	mov	ah,0
	mov	dl,6
	mul	dl
	mov	si,ax
	mov	dx,pinak1[si]
	cmp	dx,0
	je	metr13
	call	bin_dec
	pop	dx
	push	dx
	add	dl,8
	call	setcurs
	mov	dx,pinak1[si+2]
	call	bin_dec
	pop	dx
	push	dx
	add	dl,16
	call	setcurs
	mov	dx,pinak1[si+4]
	call	bin_dec
	pop	dx
	push	dx
	sub	dl,8
	call	setcurs
	mov	dl,bl
	mov	dh,0
	call	bin_dec
	pop	dx
	push	dx
	sub	dl,16
	call	setcurs
	mov	dl,pinak2[bx-2]
	push	ax
	call	dosdisp
	pop	ax
metr13:	pop	dx
	add	dl,40
	cmp	dl,80
	ja	metr7
metr9:	inc	bx
	loop	metr8
	jmp	metr10
metr7:	mov	dl,16
	inc	dh
	jmp	metr9
metrpr	endp
;
mysound	proc	near
	@PUSH
	mov	cx,10
sond1:	push	cx
	mov	cx,100
	mov	ax,cx
sond:	@SOUND	3,ax
	dec	ax
	loop	sond
	pop	cx
	loop	sond1
sond3:	@POP
	ret
mysound	endp
;
eisagvgh_dialoghs	proc	near
	mov	cx,13
	mov	bx,3
bobi:	mov	buffers[bx],0
	add	bx,3
	loop	bobi

	mov	dh,1
	mov	dl,19
	mov	cx,13
	mov	bx,0
epred2:	inc	dh
	cmp	dh,5
	je	eincr1
	cmp	dh,9
	je	eincr1
	cmp	dh,13
	je	eincr1
	jmp	epred1
eincr1:	inc	dh
epred1:	call	setcurs
	push	dx
	mov	dl,pindial[bx]
	call	apokod1
	call	biosdisp
	pop	dx
	inc	bx
	loop	epred2


	mov	shmea1,1
	mov	shmea3,0
	mov	shmea8,1
	call	editor1
	mov	shmea8,0
	mov	cx,13
	mov	bx,3
	mov	di,0
edvpera:
	mov	dl,buffers[bx]
	cmp	dl,0
	je	moyz
	call	apokod
	mov	pindial[di],dl
moyz:	add	bx,3
	inc	di
	loop	edvpera
	call	kauar
	mov	cx,48
	mov	bx,0
agg:	mov	buffers[bx],32
	inc	bx
	loop	agg
	ret
apokod:	cmp	dl,"1"
	je	ena
	cmp	dl,"2"
	je	diplo
	cmp	dl,"X"
	je	xire
	mov	dl,0
	ret
ena:	mov	dl,1
	ret
diplo:	mov	dl,3
	ret
xire:	mov	dl,2
	ret
apokod1:
	cmp	dl,1
	je	aena
	cmp	dl,2
	je	axi
	cmp	dl,3
	je	adio
	mov	dl," "
	ret
aena:	mov	dl,"1"
	ret
adio:	mov	dl,"2"
	ret
axi:	mov	dl,"X"
	ret
eisagvgh_dialoghs	endp
;
posa_shmeia	proc	near
	cmp	buffers[40]," "
	jne	p_ret
	cmp	buffers[42]," "
	jne	p_ret
	jmp	p_ok
p_ret:	ret
p_ok:	cmp	buffers[0],"W"
	je	p_1
	cmp	buffers[0],"X"
	je	p_1
	cmp	buffers[0],"Y"
	je	p_1
	jmp	p_allo
p_1:	push	ax
	push	bx
	push	cx
	mov	cx,13
	mov	bx,1
	xor	ax,ax
p_next:	cmp	buffers[bx]," "
	je	p_oxi
	inc	ax
p_oxi:	add	bx,3
	loop	p_next
p_ekt:	mov	buffers[40],"0"
	mov	buffers[41]," "
	mov	sthlh,17
	mov	grammh,19
	call	cersor
	mov	dl,"0"
	call	biosdisp
	mov	dl," "
	call	biosdisp
	mov	cl,10
	div	cl
	cmp	al,0
	jne	exei_prvto
	add	ah,30h
	mov	buffers[42],ah
	mov	buffers[43]," "
	jmp	kokoko
exei_prvto:
	add	al,30h
	mov	buffers[42],al
	add	ah,30h
	mov	buffers[43],ah
kokoko:	inc	grammh
	call	cersor
	mov	dl,buffers[42]
	call	biosdisp
	mov	dl,buffers[43]
	call	biosdisp
	pop	cx
	pop	bx
	pop	ax
	ret
p_allo:	ret
	push	ax
	push	bx
	push	cx
	cmp	buffers[0],"Q"
	jne	p_2
	mov	ax,6
	jmp	p_ekt
p_2:	cmp	buffers[0],"P"
	je	p_3
	cmp	buffers[0],"H"
	je	p_3
	cmp	buffers[0],"B"
	je	p_3
	cmp	buffers[0],"I"
	je	p_3
	jmp	p_4
p_3:	mov	ax,12
	jmp	p_ekt
p_4:	cmp	buffers[0],"A"
	je	p_5
	cmp	buffers[0],"S"
	je	p_5
	cmp	buffers[0],"D"
	je	p_5
	jmp	p_6
p_5:	mov	ax,26
	jmp	p_ekt
p_6:	cmp	buffers[0],"R"
	je	p_7
	cmp	buffers[0],"O"
	je	p_7
	cmp	buffers[0],"U"
	je	p_7
	cmp	buffers[0],"4"
	je	p_7
	jmp	p_8
p_7:	mov	ax,7
	jmp	p_ekt
p_8:	pop	cx
	pop	bx
	pop	ax
	ret	
posa_shmeia	endp
;
screen	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@SELECTWI	0
	@FILLSCR	" ",07h

	mov	ax,1
	mov	cx,13
	mov	dh,2
	mov	bx,0
tsonta:	cmp	bx,3
	jb	okep
	cmp	cx,3
	jb	okep
	mov	bx,0
	inc	dh
okep:	@ITOA	strbuf,2
	@WPRINT	13,dh,strbuf
	inc	dh
	inc	ax
	inc	bx
	loop	tsonta

	@WPRINT	7,19,mhnhm
	@WPRINT	7,20,mhnhm[4]
	@WPRINT	7,21,mhnhm[8]
	@WPRINT	5,23,mhnhm[12]

	call	putsthles

	mov	cx,78	;grammes
	mov	dx,0

edv:	@WPRINTCH	dl,1,205
	cmp	dl,13
	jb	p198
	@WPRINTCH	dl,5,196
	@WPRINTCH	dl,9,196
	@WPRINTCH	dl,13,196
p198:	@WPRINTCH	dl,18,196
	@WPRINTCH	dl,22,196
	inc	dl
	loop	edv

	mov	cx,24	;sthles
	mov	dh,0
edva:	@WPRINTCH	3,dh,179
	@WPRINTCH	15,dh,179
	@WPRINTCH	21,dh,219
	inc	dh
	loop	edva

	mov	sthlh,26
	mov	cx,13
papara:	push	cx
	mov	cx,24
papari:	mov	dh,cl
	dec	dh
	@WPRINTCH	sthlh,dh,179
	loop	papari
	add	sthlh,4
	pop	cx
	loop	papara

	@WPRINTCH	12,1,209
	mov	cx,16
	mov	dh,2
	mov	dl,1
	mov	bx,0
p179:	push	dx
	@WPRINTCH	1,dh,cprgt0[bx]
	@WPRINTCH	5,dh,cprgt1[bx]
	@WPRINTCH	12,dh,179
	pop	dx
	inc	dh
	inc	bx
	loop	p179
	cmp	PaketOroStiles,0
	je	noPaket
	@PUSH
	@WPRINTCH	1,0,"P"
	xor	dx,dx
	mov	ax,PaketOroStiles
	mov	cx,13
	div	cx
	@ITOA	strbuf,4
	@WPRINT	5,2,strbuf
	@POP
noPaket:
	
	@WPRINTCH	12,dh,193
	cmp	memory,1
	jne	lina
	call	grmon
	@POP
	ret
lina:	call	sbmon
	cmp	metraAscii,1
	je	lina01
	@POP
	ret
lina01:	call	grAscii
	@POP
	ret
screen	endp

grAscii	proc	near
	@PUSH
	@TAKEWIND
	push	ax
	@SELECTWI	0
	@WPRINTCH	1,19,"S"
	@WPRINTCH	1,20,"T"
	@WPRINTCH	1,21,"L"
	pop	ax
	@SELECTWI	al
	@POP
	ret
grAscii	endp

stl2ouoni	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	cmp	fatal_stack,0
	jne	stou4
	@POP
	ret
stou4:	xor	si,si
	xor	bx,bx
	mov	dl,2
	mov	cx,24
stou2:	push	cx
	mov	dh,2
	mov	cx,12
	mov	cs:pidametora,0
stou1:	mov	bl,buf24[si]
	cmp	bl,4
	jb	kakala

	mov	ax,1201
	call	fatal_error
pidametora	db	0

kakala:	mov	al,antist_screen[bx]
	@WPRINTCH	dl,dh,al
	inc	dh
	inc	si
	inc	cs:pidametora
	cmp	cs:pidametora,3
	jb	mimepidas
	inc	dh
	mov	cs:pidametora,0

mimepidas:
	loop	stou1
	dec	dh
	mov	bl,buf24[si]
	mov	al,antist_screen[bx]
	@WPRINTCH	dl,dh,al
	inc	si
	pop	cx
	inc	dl
	loop	stou2
	xor	dx,dx
	mov	ax,pointp
	mov	cx,13
	div	cx
	add	cound,ax
	adc	cound,0
	@LTOAN	cound,strbuf
	@WPRINT	2,0,strbuf
	@PLHKTRO
	@UPPERAX
	cmp	al,"T"
	jne	stou3
	mov	sp,fatal_stack
	mov	fatal_stack,0
stou3:	@POP
	ret
stl2ouoni	endp

deltyp	proc	near
	ret
deltyp	endp

clr_buf24	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	xor	bx,bx
	mov	cx,312
clrb24:	mov	buf24[bx],0
	inc	bx
	loop	clrb24
	@POP
	ret
clr_buf24	endp

clr_standar	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	mov	cx,13
	mov	bx,0
std1:	mov	stand[bx],0
	inc	bx
	loop	std1
	@POP
	ret
clr_standar	endp

apocode	proc	near
	push	bx
	cmp	dl,4
	jbe	apc45

	mov	ax,1202
	call	fatal_error

apc45:	xor	bx,bx
	mov	bl,dl
	mov	dl,antist[bx]
	pop	bx
	ret
apocode	endp

nai_oxi	proc	near
	cmp	ax,0
	je	foxi
	mov	strbuf[0],"N"
	mov	strbuf[1],"A"
	mov	strbuf[2],"I"
	mov	strbuf[3],0
	ret
foxi:	mov	strbuf[0],"O"
	mov	strbuf[1],"X"
	mov	strbuf[2],"I"
	mov	strbuf[3],0
	ret
nai_oxi	endp

lprint	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@LPRINTCHR	dl,lpt_number,cs:print_stack
	@POP
	ret
lprint	endp

pane_deltio	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@TAKEWIND
	push	ax
	@SETWIND	wpane
	@SELECTWIND	wpane
	@FILLSTR	strbuf," ",10
	@WINPUTNUMBER	16,2,strbuf
	@ATOL	strbuf
	mov	ardel,ax
	mov	ardel[2],dx
	@DELWIND	wpane
	pop	ax
	@SELECTWI	al
	@POP
	ret
pane_deltio	endp

codesg	ends
	end
