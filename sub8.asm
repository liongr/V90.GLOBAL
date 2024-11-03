
INCLUDE equs.h

codesg	segment public

	assume	cs:codesg,ds:datas1,es:datana

arxeia	proc	 near
	@PUSH
	@SETWIND	warxeia

arxh:	@WAITL
	@UPPERAX
	cmp	al,13
	je	fifi
	cmp	al,"T"
	je	fifi
	cmp	al,27
	jne	nesc
fifi:	@DELWIND	warxeia
	@POP
	clc
	ret

nesc:	cmp	al,"1"
	jne	no1i
	call	savesys
	jmp	arxh

no1i:	cmp	al,"2"
	jne	no2i
	call	loadsys
	jmp	arxh

no2i:	cmp	al,"3"
	jne	no3i
	call	mergesys
	jmp	arxh

no3i:	cmp	al,"5"
	jne	no5i
	call	loadasci
	jmp	arxh

no5i:	cmp	al,"6"
	jne	no6i
	call	loadStlAscii
	call	do_scr
	jmp	arxh

no6i:	cmp	al,"X"
	jne	noxi
	call	neosys
	jmp	arxh

noxi:	cmp	al,"P"
	jne	nopi
	call	sbyssys
	jmp	arxh

nopi:	cmp	al,"M"
	jne	nomi
	call	sbysor
	jmp	arxh

nomi:
noai:	cmp	al,"*"
	jne	no0i
	cmp	arxascii,0
	jne	no0i
	cmp	exomnimi,0
	jne	no0i
	mov	strbuf,0
	@NAIOXI	34,6,strbuf,mejodos,msigor
	jnc	noas
	jmp	no0i
noas:	@POP
	stc
	ret

no0i:	jmp	arxh

arxeia	endp

loadasci	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
aslod2:	@TESTDRIVE	disk_asc
	jnc	aslod5
	@POP
	ret
aslod5:	@TAKEWIND
	push	ax
	@DISKDIR	asciiname,disk_asc,mascii
	mov	bx,offset asciiname
	call	addext_TLK
	cmp	asciiname,"."
	je	aslod3
	jmp	aslod4
aslod3:	pop	dx
	@SELECTWI	dl
	@POP
	ret
bite	dw	0
aslod4:	mov	fatal_stack,sp
	@OPEN_HANDLE	asciidisk,I_READ
	mov	cs:handlef,ax
	@READ_HANDLE	cs:handlef,strbuf,16
	@MOVEFP		cs:handlef,0,0,I_BEG
	mov	cs:bite,13
	cmp	strbuf[13]," "
	ja	ascalo
	inc	cs:bite
	cmp	strbuf[14]," "
	ja	ascalo
	inc	cs:bite
	cmp	strbuf[15]," "
	ja	ascalo
	@POP
	ret	
ascalo:	@READ_HANDLE	cs:handlef,strbuf,cs:bite
	jc	telasc
	mov	cx,13
	xor	bx,bx
asc12:	mov	al,strbuf[bx]
	call	ascicode
	mov	pinsthl[bx],al
	inc	bx
	loop	asc12
	call	mnimi2basikes
	jmp	ascalo
telasc:	call	do_scr
	pop	dx
	@SELECTWI	dl
	@POP
	ret
loadasci	endp

loadStlAscii	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	cmp	arxascii,0
	je	staslod2
	@POP
	ret
staslod2:
	@TESTDRIVE	disk_asc
	jnc	staslod5
	@POP
	ret
staslod5:
	@TAKEWIND
	push	ax
	@DISKDIR	asciiname,disk_asc,mascii
	mov	bx,offset asciiname
	call	addext_TLK
	cmp	asciiname,"."
	je	staslod3
	jmp	staslod4
staslod3:
	pop	dx
	@SELECTWI	dl
	@POP
	ret
staslod4:
	mov	metraAscii,1
	@STRCOPY	asciidisk,FileMetraAscii,25
	pop	dx
	@SELECTWI	dl
	@POP
	ret
loadStlAscii	endp

ascicode	proc	near
	cmp	al,3
	ja	noal3
	ret
noal3:	cmp	al,"1"
	jne	noal1
	mov	al,1
	ret
noal1:	cmp	al,"X"
	jne	noalx
	mov	al,2
	ret
noalx:	cmp	al,"2"
	jne	noal2
	mov	al,3
	ret
noal2:	mov	al,0
	ret
ascicode	endp

is_there	proc	near
	@PUSH
	mov	al,0
	@TESTDRIVE	al
	@POP
	ret
is_there	endp

savesys	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	cmp	errorpl,0
	je	sav1
	@POP
	stc
	ret
sav1:	cmp	memory,1
	je	sav2
	cmp	arxascii,0
	jne	sav2
	@POP
	stc
	ret
sav2:	@TAKEWIND
	push	ax
;**************************************** set version
	mov	mversion[0],YEAR
	mov	mversion[2],VNUM
;****************************************
	@SETWIND	wsave
sav7:	@SELECTWIND	wsave
	@FILLSTR	filename," ",8
	@WINPUT	22,3,filename
	jnc	sav4
	jmp	sav8
sav4:	mov	bx,offset filename
	call	addext_V99
	cmp	filename,"."
	jne	sav6
	jmp	sav8
sav6:	@TESTDRIVE	disk
	jnc	sav21
	jmp	sav8
sav21:	@TESTFILE	filedisk
	jc	sav5
	mov	byte ptr strbuf,0
	@NAIOXI	34,6,strbuf,myparx1,myparx2
	jnc	sav5
	cmp	ax,0
	je	sav71
	jmp	sav8
sav71:	jmp	sav7

sav5:	mov	ax,cound
	mov	dx,cound[2]
	call	tajin121
	mov	cound,ax
	mov	cound[2],dx

	call	get_plirof
	@CREATE_HANDLE	filedisk,0
	mov	cs:handlef,ax
	call	saving
	@DELWIND	wsave
	pop	dx
	@SELECTWI	dl
	@POP
	clc
	ret
sav8:	@DELWIND	wsave
	pop	dx
	@SELECTWI	dl
	@POP
	stc
	ret
handlef	dw	0
_bytes	dw	0
savesys	endp

saving	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@WRITE_HANDLE	cs:handlef,saveheader,207
	@WRITE_HANDLE	cs:handlef,mversion,4
	@WRITE_HANDLE	cs:handlef,auristikos,840
	@WRITE_HANDLE	cs:handlef,saveinf,300
	@WRITE_HANDLE	cs:handlef,strbuf,94		;;;;kena gia beltioseis
	@WRITE_HANDLE	cs:handlef,PaketOroStiles,2
	@WRITE_HANDLE	cs:handlef,PaketOroApo,2
	@WRITE_HANDLE	cs:handlef,PaketOroEos,2
	@WRITE_HANDLE	cs:handlef,savestart,1040

	@CHANGESEGM	ds,DATASC
	@WRITE_HANDLE	cs:handlef,klioma,34
	@WRITE_HANDLE	cs:handlef,kliype,4		
	@WRITE_HANDLE	cs:handlef,klioro,1350		
	@CHANGESEGM	ds,DATAS1
	mov	cx,arxascii
	@CHANGESEGM	ds,DATASC
	@WRITE_HANDLE	cs:handlef,arxasc,cx
	@CHANGESEGM	ds,DATAS1
	cmp	memory,0
	je	sav11
	cmp	exomnimi,0
	je	sav11
	call	check_mnhmh
	call	save_mnhmh

sav11:  cmp	PaketOroStiles,0
	je	noPaketsave
	mov	cx,PaketOroStiles
	@CHANGESEGM	ds,PAKETOR
	@WRITE_HANDLE	cs:handlef,paketo_oron,cx
	@CHANGESEGM	ds,DATAS1

noPaketsave:
	@CLOSE_HANDLE	cs:handlef
	@POP
	ret
saving	endp

get_plirof	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@TAKEWIND
	push	ax
	@SETWIND	wplirof
	@SELECTWIND	wplirof
	mov	cx,5
	mov	si,offset saveinf
	mov	dl,3
	mov	dh,3
plr1:	@WPRINTSI	dl,dh
	add	si,60
	inc	dh
	loop	plr1
plr21:	mov	cx,5
	mov	bx,offset saveinf
	mov	dl,3
	mov	dh,3
plr2:	@WINPUFGREEK	dl,dh,bx
	jc	plr3
	add	bx,60
	inc	dh
	loop	plr2
	jmp	plr21
plr3:	@DELWIND	wplirof
	pop	ax
	@SELECTWI	al
	@POP
	ret
get_plirof	endp

prn_plirof	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@TAKEWIND
	push	ax
	@SETWIND	wplirof
	@SELECTWIND	wplirof
	mov	cx,5
	mov	si,offset saveinf
	mov	dl,3
	mov	dh,3
pplr:	@WPRINTSI	dl,dh
	add	si,60
	inc	dh
	loop	pplr
	@CPLR	27
	@DELWIND	wplirof
	pop	ax
	@SELECTWI	al
	@POP
	ret
prn_plirof	endp

savetmp	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
;**************************************** set version
	mov	mversion[0],YEAR
	mov	mversion[2],VNUM
;****************************************
	cmp	arxascii,0
	jne	savt2
	@POP
	stc
	ret
savt2:	@CREATE_HANDLE	filetemp,0
	mov	cs:handlef,ax
	call	saving
	@POP
	ret
savetmp	endp

loadsys	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	cmp	memory,0
	jne	lod1
	cmp	metraAscii,0
	jne	lod1
	cmp	arxascii,0
	je	lod2
lod1:	@POP
	ret
lod2:	@TESTDRIVE	disk
	jnc	lod21
	jmp	lod2
lod21:	@TAKEWIND
	push	ax
	@DISKDIR	filename,disk,mload
	mov	bx,offset filename
	call	addext_V99
	cmp	filename,"."
	je	lod3
	jmp	lod4
lod3:	pop	dx
	@SELECTWI	dl
	@POP
	ret

lod4:	call	loading
	call	do_scr
	call	prn_plirof
	pop	dx
	@SELECTWI	dl
	@POP
	ret
loadsys	endp

loading	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@OPEN_HANDLE	filedisk,I_READ
	mov	cs:handlef,ax
	@MOVEFP		cs:handlef,0,207,I_BEG
	@READ_HANDLE	cs:handlef,mversion,4
	@READ_HANDLE	cs:handlef,auristikos,840
	@READ_HANDLE	cs:handlef,saveinf,300
	@READ_HANDLE	cs:handlef,strbuf,94		;;;;kena gia beltioseis
	@READ_HANDLE	cs:handlef,PaketOroStiles,2
	@READ_HANDLE	cs:handlef,PaketOroApo,2
	@READ_HANDLE	cs:handlef,PaketOroEos,2
	cmp	mversion[2],12
	jae	isnew0
	mov	PaketOroApo,0
	mov	PaketOroEos,0
	mov	PaketOroStiles,0
isnew0:	@READ_HANDLE	cs:handlef,savestart,1040
;******************************************************************
	@CHANGESEGM	ds,DATASC
	@READ_HANDLE	cs:handlef,klioma,34
	@READ_HANDLE	cs:handlef,kliype,4		
;----------------------------------------------
	@CHANGESEGM	ds,DATAS1
	cmp	mversion[2],12
	jae	isnew1
	@CHANGESEGM	ds,DATASC
	@READ_HANDLE	cs:handlef,klioro,1270
	jmp	isold1
;----------------------------------------------
isnew1:	@CHANGESEGM	ds,DATASC
	@READ_HANDLE	cs:handlef,klioro,1350
isold1:
;*************************************************
	@CHANGESEGM	ds,DATAS1
	mov	cx,arxascii
	@CHANGESEGM	ds,DATASC
	@READ_HANDLE	cs:handlef,arxasc,cx
	@CHANGESEGM	ds,DATAS1
	cmp	memory,1
	jne	lod11
	call	load_mnhmh
	jnc	lod11
	call	clear_sthl_buf
	mov	memory,0
	mov	exomnimi,0
	call	klidvma_oxi
lod11:
	cmp	PaketOroStiles,0
	je	noPaketload
	mov	cx,PaketOroStiles
	@CHANGESEGM	ds,PAKETOR
	@READ_HANDLE	cs:handlef,paketo_oron,cx
	@CHANGESEGM	ds,DATAS1
	@WPRINTCH	1,0,"P"
	xor	dx,dx
	mov	ax,PaketOroStiles
	mov	cx,13
	div	cx
	@ITOA	strbuf,4
	@WPRINT	5,2,strbuf
noPaketload:
	@CLOSE_HANDLE	cs:handlef
	@POP
	ret
loading	endp

mergesys	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	call	tajin121
mrg2:	@TESTDRIVE	disk
	jnc	mrg21
mrg1:	@POP
	ret
mrg21:	@TAKEWIND
	push	ax
	@DISKDIR	filename,disk,mload
	mov	bx,offset filename
	call	addext_V99
	cmp	filename,"."
	je	mrg3
	jmp	mrg4
mrg3:	pop	dx
	@SELECTWI	dl
	@POP
	ret
mrg4:	@OPEN_HANDLE	filedisk,I_READ
	mov	cs:handlef,ax
	@MOVEFP		cs:handlef,0,207,I_BEG
	@READ_HANDLE	cs:handlef,mversion,4
	@MOVEFP		cs:handlef,0,840,I_CUR
	@MOVEFP		cs:handlef,0,300,I_CUR
	@MOVEFP		cs:handlef,0,100,I_CUR
	@READ_HANDLE	cs:handlef,pinmet,1040
	@MOVEFP		cs:handlef,0,34,I_CUR
	@MOVEFP		cs:handlef,0,4,I_CUR
	@MOVEFP		cs:handlef,0,1350,I_CUR
;****************************************************************************************
;;	cmp	mversion[2],13
;;	jae	isnew99
;;------------------------------------------------ ELEGXOS GIA PALIOYS OROYS
;;	@PUSH
;;
;;
;;	@POP
;;	jmp	mrgoj
;;isnew99:
;------------------------------------------------
	mov	cs:exi_plires,0
	call	chk_merge
	jc	mrgoj

	mov	ax,cs:exi_plires
	mov	cx,48
	xor	dx,dx
	mul	cx
	push	ax
	@MOVEFP	cs:handlef,0,ax,I_CUR
	pop	ax
	mov	cx,word ptr pinmet[1032]
	sub	cx,ax
	mov	word ptr pinmet[1032],cx

	mov	si,arxascii
	@CHANGESEGM	ds,DATASC
	lea	dx,arxasc[si]
	@READ_MEM	cs:handlef,dx,cx
	@CHANGESEGM	ds,DATAS1
	call	do_merge
mrgoj:	@CLOSE_HANDLE	cs:handlef
	call	do_scr
	pop	dx
	@SELECTWI	dl
	@POP
	ret
mergesys	endp

chk_merge	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	mov	si,arxascii
	mov	ax,BUFASCII
	sub	ax,si
	cmp	ax,0
	jne	snex
	call	toobig
	@POP
	stc
	ret
snex:	mov	dx,word ptr pinmet[1032]
	cmp	dx,ax
	jbe	snex1
	call	toobig
	@POP
	stc
	ret
snex1:	cmp	metraAscii,1
	je 	frm_ascii
	cmp	memory,0
	je	mrg20
	cmp	exomnimi,0
	je	mrg20
frm_ascii:
	mov	cs:exi_plires,0
kara:	mov	gen_buf,0
	@READ_HANDLE	cs:handlef,gen_buf,48
	cmp	gen_buf,"0"
	jne	mrg22
	inc	cs:exi_plires
	jmp	kara

exi_plires	dw	0

mrg20:	jmp	mrg201

mrg22:	@MOVEFP		cs:handlef,0,207,I_BEG
	@MOVEFP		cs:handlef,0,4,I_CUR
	@MOVEFP		cs:handlef,0,840,I_CUR
	@MOVEFP		cs:handlef,0,300,I_CUR
	@MOVEFP		cs:handlef,0,100,I_CUR
	@MOVEFP		cs:handlef,0,1040,I_CUR
	@MOVEFP		cs:handlef,0,34,I_CUR
	@MOVEFP		cs:handlef,0,4,I_CUR
	@MOVEFP		cs:handlef,0,1350,I_CUR
;*************************************************
mrg201:	mov	cx,34
	mov	bx,12
	mov	si,776
chkm2:	cmp	word ptr pinmet[si],0
	je	chkm1
	cmp	word ptr pinak1[bx],0
	je	chkm1
	call	isidio
	@POP
	stc
	ret
chkm1:	add	bx,6
	add	si,6
	loop	chkm2

	mov	cx,4		;oria yperomadvn
	mov	si,0
	mov	bx,1014
chk13:	cmp	pinak3[si],0
	je	chk12
	cmp	pinmet[bx],0
	je	chk12
	call	isidio
	@POP
	stc
	ret
chk12:	add	bx,3
	add	si,3
	loop	chk13
	
	@POP
	clc
	ret
chk_merge	endp

do_merge	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1

;*************************************************************
IFDEF	@PROTASI
	cmp	pinmet," "		;protasis
	jne	exprot
	jmp	chkm5
ELSE
	jmp	chkm5
ENDIF
;*************************************************************

exprot:	mov	cx,15	
	mov	bx,0
	mov	si,0
chkm4:	cmp	buf_protasi[bx]," "
	je	chkm3
	add	bx,40
chkm7:	loop	chkm4
	jmp	chkm5

chkm3:	push	cx
	mov	cx,40
chkm6:	mov	al,pinmet[si]
	mov	buf_protasi[bx],al
	inc	si
	inc	bx
	loop	chkm6
	pop	cx
	loop	chkm4

chkm5:	mov	cx,34		;oria omadvn
	mov	si,12
	mov	bx,776
chkm9:	cmp	word ptr pinak1[si],0
	jne	chkm8
	mov	ax,word ptr pinmet[bx+2]
	mov	word ptr pinak1[si+2],ax
	mov	ax,word ptr pinmet[bx+4]
	mov	word ptr pinak1[si+4],ax
chkm8:	add	bx,6
	add	si,6
	loop	chkm9

	mov	cx,34		;eidos omadvn
	mov	si,0
	mov	bx,980
chkm11:	cmp	pinak2[si],"*"
	jne	chkm10
	mov	al,pinmet[bx]
	mov	pinak2[si],al
chkm10:	inc	bx
	inc	si
	loop	chkm11

	mov	cx,4		;oria yperomadvn
	mov	si,0
	mov	bx,1014
chkm13:	cmp	pinak3[si],0
	jne	chkm12
	mov	al,pinmet[bx+1]
	mov	pinak3[si+1],al
	mov	al,pinmet[bx+2]
	mov	pinak3[si+2],al
chkm12:	add	bx,3
	add	si,3
	loop	chkm13
	
	mov	ax,word ptr pinmet[1032]
	add	arxascii,ax
	mov	ax,arxascii
	xor	dx,dx
	mov	bx,48
	div	bx
	mov	bx,14
	div	bx
	mov	bselida,ax
	mov	ax,dx
	xor	dx,dx
	mov	cx,4
	mul	cx
	add	ax,23
	mov	asthlh,al
	@POP
	clc
	ret
do_merge	endp

neosys	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	cmp	exomnimi,1
	je	prox
	cmp	metraAscii,1
	je	prox
	cmp	arxascii,0
	je	ojoet
prox:	mov	byte ptr strbuf,0
	@NAIOXI	34,6,strbuf,mypmnimi,mnaapou
	jnc	nai1
	cmp	ax,0
	jne	ojoet
	jmp	ojoet1

nai1:	call	savesys
	jc	ojoet

ojoet1:	call	sbyse_sys
	call	do_scr

ojoet:	@POP
	ret
neosys	endp

do_scr	proc	near
	@PUSH
	@DELWIND	warxeia
	call	screen
	call	prbuf
	call	putsthles
	@SETWIND	warxeia
	@POP
	ret
do_scr	endp

sbysor	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	cmp	arxascii,0
	je	denes
	cmp	exomnimi,0
	je	denes
	mov	strbuf,0
	@NAIOXI	34,12,strbuf,mmetatr2,msigor
	jc	denes
	call	sbise_orous
	call	do_scr
denes:	@POP
	ret
sbysor	endp

sbyssys	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@STRCOPY	filedisk,strbuf[10],13
allod:	@SELECT_DRIVE	disk
	@DISKDIR	filename,disk,mdelsys
	@STRCOPY	filename,mdelm[19],8
	mov	bx,offset filename
	call	addext_V99
	cmp	filename,"."
	je	nodel
	mov	byte ptr strbuf,0
	@NAIOXI	34,6,mdelsys,strbuf,mdelm
	jnc	dkit1
	cmp	ax,0
	je	allod
	jmp	nodel
dkit1:	mov	ax,offset filedisk
	call	delfile
	jmp	allod
nodel:	@STRCOPY	strbuf[10],filedisk,13
	@POP
	ret
sbyssys	endp

delfile	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@GETDTA
	@FINDFIRSTFILE	ax,0
	jc	errer
	cmp	ax,18
	je	errer
	mov	ax,es
	mov	ds,ax
	mov	dx,bx
	add	dx,30
	@DELETE_FILE
errer:	@POP
	ret
delfile	endp

addext_V99	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
jana:	cmp	byte ptr [bx],0
	je	endit
	cmp	byte ptr [bx]," "
	je	endit
	inc	bx
	jmp	jana
endit:	mov	byte ptr [bx],"."
	mov	byte ptr [bx+1],"V"
	mov	byte ptr [bx+2],"9"
	mov	byte ptr [bx+3],"9"
	mov	byte ptr [bx+4],0
	@POP
	ret
addext_V99	endp


addext_TLK	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
ajana:	cmp	byte ptr [bx],0
	je	aendit
	cmp	byte ptr [bx]," "
	je	aendit
	inc	bx
	jmp	ajana
aendit:	mov	byte ptr [bx],"."
	mov	byte ptr [bx+1],"T"
	mov	byte ptr [bx+2],"L"
	mov	byte ptr [bx+3],"K"
	mov	byte ptr [bx+4],0
	@POP
	ret
addext_TLK	endp

addext_TXT	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
ajanatt:
	cmp	byte ptr [bx],0
	je	aendittt
	cmp	byte ptr [bx]," "
	je	aendittt
	inc	bx
	jmp	ajanatt
aendittt:
	mov	byte ptr [bx],"."
	mov	byte ptr [bx+1],"T"
	mov	byte ptr [bx+2],"X"
	mov	byte ptr [bx+3],"T"
	mov	byte ptr [bx+4],0
	@POP
	ret
addext_TXT	endp

save_mnhmh	proc	near
	@PUSH
	@CHANGESEGM	ds,CODESG
	@WRITE_HANDLE	cs:handlef,mem_segm,4
	@CHANGESEGM	ds,MAST1
	mov	si,word ptr cs:mem_segm
sgepom:	cmp	si,0
	ja	sgmsav
	jmp	bytsav
sgmsav:	@WRITE_MEM	cs:handlef,0,65498
	dec	si
	mov	ax,ds
	add	ax,4094
	mov	ds,ax
	jmp	sgepom
bytsav:	mov	ax,word ptr cs:mem_byte
	@WRITE_MEM	cs:handlef,0,cs:mem_byte
	@POP
	ret
save_mnhmh	endp
;
check_mnhmh	proc	near
	@PUSH
	@CHANGESEGM	ds,MAST1
	xor	bx,bx
	xor	dx,dx
	xor	si,si
c_allo:	cmp	byte ptr [bx],0
	jne	c_pom
	inc	dx
	cmp	dx,20
	jae	cut_of
	jmp	ckk
c_pom:	xor	dx,dx
ckk:	inc	bx
	cmp	bx,65498
	jb	c_allo
	mov	ax,ds
	add	ax,4094
	mov	ds,ax
	xor	bx,bx
	inc	si
	jmp	c_allo
cut_of:	mov	word ptr cs:mem_segm,si
	mov	word ptr cs:mem_byte,bx
	@POP
	ret
mem_segm	dw	0
mem_byte	dw	0
check_mnhmh	endp

load_mnhmh	proc	near
	@PUSH
	@CHANGESEGM	ds,CODESG
	@READ_HANDLE	cs:handlef,mem_segm,4
	@CHANGESEGM	ds,MAST1
	mov	si,word ptr cs:mem_segm
sgeplo:	cmp	si,0
	ja	sgmlod
	jmp	bytlod
sgmlod:	@READ_MEM	cs:handlef,0,65498
	jnc	mnmok1
	@POP
	stc
	ret
mnmok1:	dec	si
	mov	ax,ds
	add	ax,4094
	mov	ds,ax
	jmp	sgeplo
bytlod:	mov	ax,word ptr cs:mem_byte
	@READ_MEM	cs:handlef,0,cs:mem_byte
	jnc	mnmok2
	@POP
	stc
	ret
mnmok2:	@POP
	clc
	ret
load_mnhmh	endp

tajin121	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	call	kauarisma_metab
	@SETWIND	wtajin
	call	tajinom
	@DELWIND	wtajin
	call	prometr
	call	metrima
	call	editomr
	call	tajasc
	@POP
	ret
tajin121	endp

;************************************ NEO SYSTHMA
sbyse_sys	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@CHANGESEGM	es,DATASC

	call	sbise_orous

	@OPEN_HANDLE	fileSaveMetablites,I_READ
	mov	cs:handlef,ax
	mov	ax,offset Metablites4SaveEnd
	sub	ax,offset Metablites4SaveStart
	@READ_HANDLE 	cs:handlef,Metablites4SaveStart,ax
	@CLOSE_HANDLE 	cs:handlef

	@POP
	ret
sbyse_sys	endp

sbise_orous	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@CHANGESEGM	es,DATASC
	
	call	klidvma_oxi
	
	@ZEROBBUF	es:arxasc,BUFASCII

	mov	cx,19
	mov	bx,0
ll10:	push	cx
	mov	cx,39
ll75:	mov	buf_protasi[bx]," "
	inc	bx
	loop	ll75
	pop	cx
	mov	buf_protasi[bx],0
	inc	bx
	loop	ll10

	mov	selida,0
	mov	bselida,0
	mov	arxascii,0
	mov	asthlh,23
	mov	cx,262
	mov	bx,0
pp41:	mov	pinak1[bx],0
	inc	bx
	loop	pp41
	mov	cx,34
	mov	bx,0
pp42:	mov	pinak2[bx],"*"
	inc	bx
	loop	pp42

	mov	klidoma_prot,0
	call	kauarisma_metab
	call	tajinom
	call	prometr
	call	metrima
	call	editomr
	@POP
	ret
sbise_orous	endp

load_inf	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@OPEN_HANDLE	prnfile,I_READ
	jnc	iparx1
	jmp	infof

iparx1:	mov	cs:handlef,ax
	@READ_HANDLE	cs:handlef,ektip_save,780 ;(30x13word)
	@CLOSE_HANDLE	cs:handlef

infof:	@OPEN_HANDLE	infofile,I_READ
	jnc	iparx2
	@POP
	ret
iparx2:	mov	cs:handlef,ax
	@READ_HANDLE	cs:handlef,pindial,13
	@CLOSE_HANDLE	cs:handlef
	@POP
	ret
load_inf	endp
;
save_inf	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@CREATE_HANDLE	prnfile,0
	mov	cs:handlef,ax
	@WRITE_HANDLE	cs:handlef,ektip_save,780 ;(30x13word)
	@CLOSE_HANDLE	cs:handlef

	@CREATE_HANDLE	infofile,0
	mov	cs:handlef,ax
	@WRITE_HANDLE	cs:handlef,pindial,13
	@CLOSE_HANDLE	cs:handlef
	@POP
	ret
save_inf	endp

saveMetablites	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@CREATE_HANDLE	fileSaveMetablites,0
	mov	cs:handlef,ax
	mov	ax,offset Metablites4SaveEnd
	sub	ax,offset Metablites4SaveStart
	@WRITE_HANDLE 	cs:handlef,Metablites4SaveStart,ax
	@CLOSE_HANDLE 	cs:handlef
	@POP
	ret
saveMetablites	endp

codesg	ends
	end

