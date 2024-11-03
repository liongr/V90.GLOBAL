 
INCLUDE	equs.h

STACKSG	SEGMENT	STACK
	dw	10000	dup(?)
STACKSG	ENDS

CODESG	segment	public
extrn	x21:near,naoxi:near,edit_copy_0:near,pelexm:near,eisag_edit:near
extrn	bbuf:near,clr_scr:near,setcurs:near,ekdel:near,mettyp:near,binlk:near
extrn	dec_bin:near,apou2:near,apou3:near,predit:near,bbuffer:near
extrn	tajinom:near,xarakt:near,asteri:near,edast:near,capo:near
extrn	omades:near,metrima:near,edomad:near,editq:near,editr:near
extrn	editomr:near,editot:near,cersor:near,dosdisp:near,help:near
extrn	tend:near,dioru:near,tselid:near,editor:near,editor1:near
extrn	editor2:near,tchar:near,kauar:near,prometr:near,plhrak:near
extrn	tajasc:near,plhra:near,ayjhsh:near,metrpr:near,edtomr1:near
extrn	pelex0:near,pelex1:near,pelex2:near,pelex3:near,arxeia:near
extrn	binpr:near,elegxpr:near,pr24s:near,dispmhn:near,bin_dec:near
extrn	axbpr:near,axbmet:near,aepib:near,deltyp:near
extrn	epejergasia:near,telikh_epejergasia:near,taj_metab:near
extrn	dialogh0:near,dialogh1:near,eisagvgh_dialoghs:near,metbl1:near
extrn	sthmnhm:near,sbmon:near,grmon:near,dilpis:near,plhrakia_print:near
extrn	klidvma:near,klidvma_oxi:near,toobig:near,dial_ret:near
extrn	configs:near,kauarisma_metab:near,all_or_basikvn:near,init_code:near
extrn	putsthles:near,getkey:near,copyright:near,chk_crght:near

	ASSUME	CS:CODESG,DS:DATAS1,ES:DATANA

main	proc	far
	@STARTPRG
	@SETWINSEGM	WINSEGM
	@USERW	0,0
	@CHANGESEGM	ds,DATAS1
	@CHANGESEGM	es,DATANA
	@FILLSCR	"╟",07h
	@CLRCURS
	@SETWIND	wstart
	call	far ptr klidi_do_poke
	jmp	klidi_epistrofi
;*****************************************
ojo:	@ENDPRG
	@EXIT
	@POP
	retf
main	endp
;##########################################################################################
;###################################################################### LOAD DLT
;##########################################################################################
loadDeltiaPlirakia	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	mov	fatal_stack,sp
	@TESTDRIVE	disk_Plirakia
	jnc	plrlod5
problema:	@POP
	ret

plrlod5:	call	ti_kuponi_einai
	jc	problema

	cmp	STHLES_DELTIOU,13
	jbe	OK_xorane
	jmp	problema
	
OK_xorane:	@TAKEWIND
	push	ax
	@DISKDIR	Plirakianame,disk_Plirakia,mplirakia
	mov	bx,offset Plirakianame
	call	addext_DLT
	cmp	Plirakianame,"."
	je	plrlod3
	jmp	plrlod4
plrlod3:	pop	dx
	@SELECTWI	dl
	@POP
	ret

plrlod4:	mov	isPlirakiaFULL,1

	@OPEN_HANDLE 	Plirakiadisk,I_READ
	mov	cs:Plirakia_handle,ax
;-----------------------------------------------------------------------
epomPliraki:
	@READ_HANDLE	cs:Plirakia_handle,pinsthl,13
	jnc	exiPliraki
	jmp	telosPliraki

exiPliraki:	xor	si,si
	mov	cx,13
	mov	bx,axbp
	mov	si,0
plr1:	mov	dl,pinsthl[si]
	mov	axbpin[bx][si],dl
	inc	si
	loop	plr1

	add	axbp,13
	mov	ax,STHLES_DELTIOU
	mov	cx,13
	mul	cx
	cmp	axbp,ax	;n sthles x 13
	jb	epomPliraki

	call	buffer_full
	mov	axbp,0
	jmp	epomPliraki
	
telosPliraki:
	call	buffer_full
;-----------------------------------------------------------------------
telosleme:	@CLOSE_HANDLE	cs:Plirakia_handle
	mov	cs:patise_taf,1
	call	genend
	@DELWIND	wdeltio_pliraki
	mov	isPlirakiaFULL,0
	pop	dx
	@SELECTWI	dl
	@POP
	ret
loadDeltiaPlirakia	endp

addext_DLT	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
plrjana:	cmp	byte ptr [bx],0
	je	plrendit
	cmp	byte ptr [bx]," "
	je	plrendit
	inc	bx
	jmp	plrjana
plrendit:	mov	byte ptr [bx],"."
	mov	byte ptr [bx+1],"D"
	mov	byte ptr [bx+2],"L"
	mov	byte ptr [bx+3],"T"
	mov	byte ptr [bx+4],0
	@POP
	ret
addext_DLT	endp

;##########################################################################################
;##########################################################################################
;##########################################################################################


;**************************************************************************
;**********                   EXOYN ELEGXUEI                     **********
;**************************************************************************
input_name_ascii	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@SETWIND	wsaveAscii
sav7:	@SELECTWIND	wsaveAscii
	@FILLSTR	asciiname," ",8
	@WINPUT	22,3,asciiname
	jnc	sav4
	jmp	sav8
sav4:	mov	bx,offset	asciiname
	call	addext_TLK
	cmp	asciiname,"."
	jne	sav6
	jmp	sav8
sav6:	@STRCMP	asciidisk,FileMetraAscii
	jnc	sav7
	@TESTDRIVE	asciidisk
	jnc	sav21
	jmp	sav8
sav21:	@TESTFILE	asciidisk
	jc	sav5
	mov	byte ptr strbuf,0
	@NAIOXI	34,6,strbuf,myparx1,myparx2
	jnc	sav5
	cmp	ax,0
	je	sav71
	jmp	sav8
sav71:	jmp	sav7
sav5:	@DELWIND	wsaveAscii
	@POP
	clc
	ret
sav8:	@DELWIND	wsaveAscii
	@POP
	stc
	ret
input_name_ascii	endp

input_name_txt	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@SETWIND	wsaveAscii
sav7tt:	@SELECTWIND	wsaveAscii
	@FILLSTR	asciiname," ",8
	@WINPUT	22,3,asciiname
	jnc	sav4tt
	jmp	sav8tt
sav4tt:	mov	bx,offset	asciiname
	call	addext_TXT
	cmp	asciiname,"."
	jne	sav6tt
	jmp	sav8tt
sav6tt:	@STRCMP	asciidisk,FileMetraAscii
	jnc	sav7tt
	@TESTDRIVE	asciidisk
	jnc	sav21tt
	jmp	sav8tt
sav21tt:	@TESTFILE	asciidisk
	jc	sav5tt
	mov	byte ptr strbuf,0
	@NAIOXI	34,6,strbuf,myparx1,myparx2
	jnc	sav5tt
	cmp	ax,0
	je	sav71tt
	jmp	sav8tt

sav71tt:	jmp	sav7tt

sav5tt:	@DELWIND	wsaveAscii
	@POP
	clc
	ret
sav8tt:	@DELWIND	wsaveAscii
	@POP
	stc
	ret
input_name_txt	endp

utils	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@TAKEWIND
	push	ax
utiar:	@SETWIND	wutils
	@SELECTWIND	wutils
	@PLHKTRO
	@UPPERAX
	@DELWIND	wutils
	cmp	al,"0"
	jb	chkutno
	cmp	al,"Z"
	ja	chkutno
	cmp	al,"T"
	je	chkutno
	jmp	chkut
chkutno:	pop	ax
	@SELECTWI	al
	@POP
	ret
;****************************
chkut:	cmp	al,"0"
	jne	utin0
	call	save_ascii
	jmp	utiar
utin0:	cmp	al,"1"
	jne	utin1
	call	eidos_oroy
	jmp	utiar

utin1:	cmp	al,"2"
	jne	utin2
	mov	metatropi_se_basikes,1
	call	metatropes
	jmp	utiar
utin2:	cmp	al,"3"
	jne	utin3
	mov	metatropi_se_basikes,2
	call	metatropes
	jmp	utiar
utin3:	cmp	al,"E"
	jne	utin31
	mov	metatropi_se_basikes,3
	call	metatropes
	jmp	utiar
utin31:	cmp	al,"F"
	jne	utin32
	mov	metatropi_se_basikes,4
	call	metatropes
	jmp	utiar
utin32:	cmp	al,"4"
	jne	utin4
	call	allagi_omadas
	jmp	utiar
utin4:	cmp	al,"5"
	jne	utin5
	call	antig_omadas
	jmp	utiar
utin5:	cmp	al,"6"
	jne	utin6
	call	sbisimo_omadas
	jmp	utiar
utin6:	cmp	al,"7"
	jne	utin7
	call	allagi_orion
	jmp	utiar
utin7:	cmp	al,"8"
	jne	utin8
	call	antik_sim
	jmp	utiar
utin8:	cmp	al,"X"
	jne	utinX
	mov	aromad[3],1
	call	xchange_sim
	jmp	utiar
utinX:	cmp	al,"V"
	jne	utinV
	mov	aromad[3],2
	call	xchange_sim
	jmp	utiar
utinV:	cmp	al,"N"
	jne	utinN
	mov	aromad[3],3
	call	xchange_sim
	jmp	utiar
utinN:	cmp	al,"9"
	jne	utin9
	call	geniki_taj
	call	bale_omada
	call	screen
	call	prbuf
	jmp	utiar
utin9:	cmp	al,"A"
	jne	utinA
	call	far ptr auristos
	jmp	utiar
utinA:
utinB:	cmp	al,"C"
	jne	utinC
	call	makeFilterPack
utinC:	cmp	al,"D"
	jne	utinD
	jmp	utiar
utinD:	cmp	al,"G"
	jne	utinE
	call	save_ascii_4_super
	jmp	utiar
utinE:	
utinZ:	jmp	utiar
utils	endp

makeFilterPack	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	call	check_all
	jnc	secam6r1
	@POP
	ret

secam6r1:	mov	ax,casc2oro
	mov	word ptr cs:asc2oro,ax
	mov	PaketOroStiles,0
	call	plhra
	mov	cs:patise_taf,1
	call	genend
	call	sbise_orous
	mov	memory,0
	mov	exomnimi,0
	mov	metraAscii,0
	@POP
	ret
makeFilterPack	endp

ektip	proc near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	call	SelectCupon
	call	take_riumisi_printer
	call	deltia_plirakia
	call	save_riumisi_printer
	call	screen
	@POP
	ret
ektip	endp

SelectCupon	proc	near
	@PUSH
	mov	kuponi_xora,0
	@TAKEWIND
	push	ax
	@SETWIND	wektiposis
	@SELECTWIND	wektiposis
	@PLHKTRO
	@UPPERAX
	@DELWIND	wektiposis
	cmp	al,"A"
	jb	chkektno
	cmp	al,"Z"
	ja	chkektno
	jmp	chkekt
;****************************
chkekt:	mov	kuponi_xora,al
chkektno:	pop	ax
	@SELECTWI	al
	@POP
	ret
SelectCupon	endp

InAsciiOros	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@SETWIND	wasciiOro
seeit:	@SELECTWIND	wasciiOro

	mov	ax,PaketOroApo
	@ITOA	strbuf
	@WPRINT	11,4,strbuf

	mov	ax,PaketOroEos
	@ITOA	strbuf
	@WPRINT	11,5,strbuf

	@WAITL
	cmp	al," "
	jne	seeonly

	mov	ax,PaketOroApo
	@ITOA	strbuf
	@WINPUTNUMBER	11,4,strbuf
	@ATOI	strbuf
	mov	PaketOroApo,ax

	mov	ax,PaketOroEos
	@ITOA	strbuf
	@WINPUTNUMBER	11,5,strbuf
	@ATOI	strbuf
	mov	PaketOroEos,ax
	jmp	seeit

seeonly:	@DELWIND	wasciiOro
	@POP
	ret
InAsciiOros	endp

take_riumisi_printer	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	xor	ax,ax
	mov	al,kuponi_xora
	sub	ax,"A"
	mov	cx,26
	mul	cx
	mov	bx,ax
	xor	si,si
	mov	cx,13
takriu:	mov	ax,ektip_save[bx]
	mov	ektip_plr[si],ax
	inc	bx
	inc	bx
	inc	si
	inc	si
	loop	takriu
	@POP
	ret
take_riumisi_printer	endp

save_riumisi_printer	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	xor	ax,ax
	mov	al,kuponi_xora
	sub	ax,"A"
	mov	cx,26
	mul	cx
	mov	bx,ax
	xor	si,si
	mov	cx,13
savriu:	mov	ax,ektip_plr[si]
	mov	ektip_save[bx],ax
	inc	bx
	inc	bx
	inc	si
	inc	si
	loop	savriu
	call	save_inf
	@POP
	ret
save_riumisi_printer	endp

tajinompr	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@SETWIND	wtajin
	call	tajinom
	@DELWIND	wtajin
	@POP
	ret
tajinompr	endp

check_plhres	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	cmp	arxascii,0
	je	arkas
	mov	bx,0
	@CHANGESEGM	ds,DATASC
allopl:	mov	dl,arxasc[bx]
	cmp	dl,"0"
	jne	arkas
	push	bx
	mov	cx,13
	inc	bx
plq32:	cmp	arxasc[bx]," "
	je	exei_kenol
	cmp	arxasc[bx],0
	je	exei_kenol
	add	bx,3
	loop	plq32
	pop	bx
	add	bx,48
	jmp	allopl
exei_kenol:
	pop	bx
	@POP
	stc
	ret
arkas:	@POP
	clc
	ret
check_plhres	endp

if_plires	proc	near
	@PUSH
	@CHANGESEGM	ds,DATASC
	cmp	arxasc[0],"0"
	je	if_pl1
	@POP
	stc
	ret
if_pl1:	@POP
	clc
	ret
if_plires	endp

if_mnimi_on	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	cmp	memory,1
	je	if_m1
	@POP
	stc
	ret
if_m1:	@POP
	clc
	ret
if_mnimi_on	endp

if_mnimi	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	cmp	memory,1
	je	if_mn1
	@POP
	stc
	ret
if_mn1:	cmp	exomnimi,1
	je	if_mn2
	@POP
	stc
	ret
if_mn2:	@POP
	clc
	ret
if_mnimi	endp

if_ascii	proc	near
	@PUSH
	cmp	metraAscii,1
	je	isasc1	
	@POP
	stc
	ret
isasc1:	@POP
	clc
	ret
if_ascii	endp

genend	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	cmp	cs:patise_taf,1
	je	patataf
	jmp	oxitaf

patataf:	@TAKEWIND
	push	ax
	@SETWIND	wgen
	@SELECTWIND	wgen
	@WPRINT	29,1,mtelos
	@BELL
	@CPLR	"T"
	@DELWIND	wgen
	pop	ax
	@SELECTWI	al
oxitaf:	cmp	fatal_stack,0
	jne	no_diakopi
	mov	ax,coundq
	mov	cound,ax
	mov	ax,coundq[2]
	mov	cound[2],ax
no_diakopi:
	call	screen
	call	putsthles
	call	sbmon
	call	chk_ascii
	call	chk_mnimi
	cmp	PaketOroStiles,0
	je	noPaket
	@WPRINTCH	1,0,"P"
	xor	dx,dx
	mov	ax,PaketOroStiles
	mov	cx,13
	div	cx
	@ITOA	strbuf,4
	@WPRINT	5,2,strbuf

noPaket:	mov	ax,cound
	mov	coundq,ax
	mov	ax,cound[2]
	mov	coundq[2],ax
	call	init_code
	@POP
	ret
patise_taf	db	0
genend	endp

chk_mnimi	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	cmp	memory,1
	jne	lina
	call	grmon
	@POP
	ret
lina:	@POP
	ret
chk_mnimi	endp

chk_ascii	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	cmp	metraAscii,1
	jne	lina1
	call	grAscii
	@POP
	ret
lina1:	@POP
	ret
chk_ascii	endp

pinakes	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	call	check_all
	jnc	secam6
	@POP
	ret
secam6:	call	for_pinakes
	@SETWIND	wparag
	call	binpr
	call	plhra
	call	binpr
	mov	cs:patise_taf,1
	call	genend
	@DELWIND	wparag
	@POP
	ret
pinakes	endp

elegxos	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	call	check_all
	jnc	secam7
	@POP
	ret
secam7:	call	for_elegxos
	@SETWIND	welegx
	call	elegxpr
	call	plhra
	call	elegxpr
	mov	cs:patise_taf,1
	call	genend
	@DELWIND	welegx
	@POP
	ret
elegxos	endp

geniki_taj	proc	near
	@PUSH
	call	kauarisma_metab
	call	tajinompr
	call	prometr
	call	metrima
	call	editomr
	call	tajasc
	jnc	bug0
	call	toobig
	@POP
	stc
	ret
bug0:	@POP
	clc
	ret
geniki_taj	endp

for_stl2prn	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	mov	ax,prog[30]
	mov	word ptr cs:stl2prn,ax
	@POP
	ret
for_stl2prn	endp

for_pinakes	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	mov	ax,prog[14]
	mov	word ptr cs:binlk,ax
	@POP
	ret
for_pinakes	endp

for_metrima	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	mov	al,byte ptr prog[8]
	mov	byte ptr cs:metrima_print,al
	@POP
	ret
for_metrima	endp

for_ascii	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	mov	ax,prog[22]
	mov	word ptr cs:ascii,ax
	@POP
	ret
for_ascii	endp

for_elegxos	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	mov	al,byte ptr prog[2]
	mov	byte ptr cs:pelex0,al
	mov	al,byte ptr prog[3]
	mov	byte ptr cs:pelex1,al
	mov	al,byte ptr prog[4]
	mov	byte ptr cs:pelex2,al
	mov	al,byte ptr prog[5]
	mov	byte ptr cs:pelex3,al
	mov	al,byte ptr prog[7]
	mov	byte ptr cs:pelexm,al
	@POP
	ret
for_elegxos	endp

for_dialogi_ouoni	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	mov	ax,dialogp[0]
	mov	word ptr cs:dialogh0,ax
	mov	ax,dialogp[2]
	mov	word ptr cs:dialogh1,ax
	mov	ax,prog[16]
	mov	word ptr cs:metr1,ax
	@POP
	ret
for_dialogi_ouoni	endp

for_ekt_ouoni	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	mov	ax,prog[0]
	mov	word ptr cs:ayjhsh,ax
	@POP
	ret
for_ekt_ouoni	endp

for_dlt_plirakia	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	mov	ax,pokeplr
	mov	word ptr cs:plhrak,ax
	@POP
	ret
for_dlt_plirakia	endp

take_code	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	mov	ax,word ptr cs:asc2oro
	mov	casc2oro,ax
	mov	ax,word ptr cs:sthmnhm
	mov	stilmn,ax
	mov	ax,word ptr cs:ayjhsh
	mov	word ptr prog[0],ax
	mov	al,byte ptr cs:pelex0
	mov	byte ptr prog[2],al
	mov	al,byte ptr cs:pelex1
	mov	byte ptr prog[3],al
	mov	al,byte ptr cs:pelex2
	mov	byte ptr prog[4],al
	mov	al,byte ptr cs:pelex3
	mov	byte ptr prog[5],al
	mov	al,byte ptr cs:pelexm
	mov	byte ptr prog[7],al
	mov	al,byte ptr cs:metrima_print
	mov	byte ptr prog[8],al
	mov	ax,word ptr cs:binlk
	mov	prog[14],ax
	mov	ax,word ptr cs:metr1
	mov	prog[16],ax
	mov	ax,word ptr cs:ascii
	mov	prog[22],ax
	mov	ax,word ptr cs:stl2prn
	mov	prog[30],ax
	mov	ax,word ptr cs:plhrak
	mov	pokeplr,ax
	mov	ax,word ptr cs:dialogh0
	mov	dialogp[0],ax
	mov	ax,word ptr cs:dialogh1
	mov	dialogp[2],ax
	mov	ax,word ptr cs:metbl1
	mov	pokmetbl,ax
	@POP
	ret
take_code	endp

sbisimo_omadas	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	call	geniki_taj
	call	set_sbise
	mov	ax,coundq
	mov	cound,ax
	mov	ax,coundq[2]
	mov	cound[2],ax
	call	screen
	call	prbuf
	@POP
	ret
sbisimo_omadas	endp

antik_sim	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	call	geniki_taj
	call	set_antikat_sim
	mov	ax,coundq
	mov	cound,ax
	mov	ax,coundq[2]
	mov	cound[2],ax
	call	screen
	call	prbuf
	@POP
	ret
antik_sim	endp

xchange_sim	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	call	geniki_taj
	cmp	arxascii,0
	jne	lsmor0x
	@POP
	ret
lsmor0x:
	call	set_xchange_sim
	mov	ax,coundq
	mov	cound,ax
	mov	ax,coundq[2]
	mov	cound[2],ax
	call	screen
	call	prbuf
	@POP
	ret
xchange_sim	endp

allagi_omadas	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	call	geniki_taj
	cmp	tipos_orou,"B"
	jne	noBB1
	mov	tipos_orou,"W"
noBB1:	call	set_allagi
	mov	ax,coundq
	mov	cound,ax
	mov	ax,coundq[2]
	mov	cound[2],ax
	call	screen
	call	prbuf
	@POP
	ret
allagi_omadas	endp

allagi_orion	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	call	geniki_taj
	call	set_oria
	mov	ax,coundq
	mov	cound,ax
	mov	ax,coundq[2]
	mov	cound[2],ax
	call	screen
	call	prbuf
	@POP
	ret
allagi_orion	endp

antig_omadas	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	call	geniki_taj
	cmp	tipos_orou,"B"
	jne	noBB2
	mov	tipos_orou,"W"
noBB2:	call	set_antigrafi
	mov	ax,coundq
	mov	cound,ax
	mov	ax,coundq[2]
	mov	cound[2],ax
	call	screen
	call	prbuf
	@POP
	ret
antig_omadas	endp


metatropes	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	call	if_mnimi
	jnc	metrt1
	cmp	arxascii,0
	jne	opis8en2
	call	if_Ascii		;;;;;28.11.2021
	jnc	metrt1		;;;;;28.11.2021

opis8en2:	@POP
	ret

metrt1:	cmp	arxascii,0
	je	denest
	@NAIOXI	34,12,mmetatr1,mmetatr2,msigor
	jc	antomt2
	call	sbise_orous
denest:	call	geniki_taj
	jnc	bugt01

antomt2:	@POP
	ret

bugt01:	call	plhra
	mov	metatropi_se_basikes,0
	call	init_code
	call	screen
	call	prbuf
	@POP
	ret
metatropes	endp

metrima_stilon	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	call	check_all
	jnc	secam9
	@POP
	ret

secam9:	call	if_mnimi_on
	je	krit3
	jmp	plir

krit3:	mov	segm,0
	mov	shmeat,0
	mov	mema,0
	call	if_mnimi
	jnc	krit1
	jmp	krit2

krit1:	cmp	arxascii,0
	je	krit2
	mov	strbuf,0
	@NAIOXI	34,12,mdokim1,strbuf,mdokim2
	jnc	plir
	cmp	ax,1
	je	akiro

krit2:	mov	mema,1
	mov	ax,stilmn
	mov	word ptr cs:sthmnhm,ax

plir:	call	for_metrima
	@SETWIND	wmetrima
	call	metrima_print
	call	plhra
	call	metrima_print

	cmp	mema,0
	je	kln
	cmp	cound,0
	jne	exstl
	cmp	cound[2],0
	jne	exstl
	mov	memory,0
	mov	exomnimi,0
	call	klidvma_oxi
	jmp	kln

exstl:	cmp	arxascii,0
	je	goris
	call	klidvma

goris:	call	if_mnimi_on
	jnc	kln
	call	klidvma_oxi
kln:	mov	mema,0
	mov	cs:patise_taf,1
	call	genend
akiro:	@DELWIND	wmetrima
	@POP
	ret
metrima_stilon	endp

get_mnimi	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	cmp	memory,0
	je	for_mnimi_1

	mov	strbuf,0
	@NAIOXI	34,12,mmnimi1,strbuf,mmnimi3
	jnc	zer_mnimi
	@POP
	ret

zer_mnimi:
	mov	memory,0
	mov	exomnimi,0
	call	klidvma_oxi
	call	sbmon
	@POP
	ret

for_mnimi_1:
	call	geniki_taj
	call	if_plires
	jc	no_plr
	mov	strbuf,0
	@NAIOXI	34,12,mmnimi1,strbuf,mmnimi2
	jnc	set_mnimi
no_plr:	@POP
	ret

set_mnimi:	call	tajinompr
	call	prbuf
	call	putsthles
	call	clear_sthl_buf
	mov	memory,1
	mov	exomnimi,0
	call	grmon
	@POP
	ret
get_mnimi	endp

ekt_ouoni	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	mov	errorpl,0
	call	check_plhres
	jnc	kokoe
	mov	errorpl,1
kokoe:	call	check_all
	jnc	secam8
	@POP
	ret
secam8:	@TAKEWIND
	push	ax
	@SETWIND	wstlouoni
	@SELECTWIND	wstlouoni
	call	for_ekt_ouoni
	call	plhra
	call	stl2ouoni
	mov	cs:patise_taf,1
	call	genend
crh3:	@DELWIND	wstlouoni
	pop	ax
	@SELECTWI	al
	@POP
	ret
ekt_ouoni	endp

chk_pindial	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	mov	cx,13
	xor	bx,bx
	xor	ax,ax
ckpin1:	cmp	pindial[bx],0
	jne	ckpin3
	inc	ax
	cmp	ax,6
	jae	ckpin2
ckpin3:	inc	bx
	loop	ckpin1
	@POP
	clc
	ret
ckpin2:	@POP
	stc
	ret
chk_pindial	endp

dialogi_ouoni	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	call	chk_pindial
	jc	pind0
	call	check_all
	jnc	seca88
pind0:	@POP
	ret

seca88:	@TAKEWIND
	push	ax
	@SETWIND	wdialogi
	@SELECTWIND	wdialogi
	call	for_dialogi_ouoni
	call	plhra
	mov	fatal_stack,0
	mov	cs:patise_taf,1
	call	genend
	@DELWIND	wdialogi
	pop	ax
	@SELECTWI	al
	@POP
	ret
dialogi_ouoni	endp

save_ascii	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	call	check_all
	jnc	assecam9
feta:	@POP
	ret
assecam9:
	call	if_mnimi_on
	je	askrit3
	jmp	asplir

askrit3:
	mov	segm,0
	mov	shmeat,0
	mov	mema,0

asplir:	
	call	for_ascii

	mov	pinsthl3[13],13
	mov	pinsthl3[14],10
	mov	cs:save_posa_simia,15

	@SETWIND	wasciiposa
	@SELECTWIND	wasciiposa
fouxten:
	mov	ax,13
	@ITOA	strbuf,2
	@WINPUTNUMBER	17,3,strbuf
	@ATOI	strbuf
	cmp	ax,15
	ja	fouxten
	cmp	ax,13
	jb	fouxten
	@DELWIND	wasciiposa
	cmp	ax,14
	jne	ax14n

	call	super13ari
	mov	al,extra_sim14
	mov	pinsthl3[13],al
	mov	pinsthl3[14],13
	mov	pinsthl3[15],10
	mov	cs:save_posa_simia,16
	jmp	axok
ax14n:	cmp	ax,15
	jne	axok
	call	super13ari
	call	super14ari
	mov	al,extra_sim14
	mov	pinsthl3[13],al
	mov	al,extra_sim15
	mov	pinsthl3[14],al
	mov	pinsthl3[15],13
	mov	pinsthl3[16],10
	mov	cs:save_posa_simia,17

axok:	call	input_name_txt
	jnc	kitare
	@POP
	ret

kitare:	@SETWIND	wplwait
	@CREATE_HANDLE	asciidisk,0
	mov	cs:ascii_handle,ax
	
	call	metrima_print
	call	plhra
	call	metrima_print
	@CLOSE_HANDLE	cs:ascii_handle
	cmp	mema,0
	je	askln
	cmp	fatal_stack,0
	je	asgoris
	cmp	cound,0
	jne	asexstl
	cmp	cound[2],0
	jne	asexstl
	mov	memory,0
	mov	exomnimi,0
	call	klidvma_oxi
	jmp	askln

asexstl:	cmp	arxascii,0
	je	asgoris
	call	klidvma

asgoris:	call	if_mnimi_on
	jnc	askln
	call	klidvma_oxi
askln:	mov	mema,0
	mov	cs:patise_taf,0
	call	genend

asakiro:	@DELWIND	wplwait
	@POP
	ret
save_ascii	endp

save_ascii_4_super	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	call	check_all
	jnc	assecam94s
feta4s:	@POP
	ret
assecam94s:
	call	if_mnimi_on
	je	askrit34s
	jmp	asplir4s

askrit34s:	mov	segm,0
	mov	shmeat,0
	mov	mema,0

asplir4s:	call	for_ascii
	@CHANGESEGM	ds,DATAS1

	mov	cs:save_posa_simia,15	;; TLK mono me 13 SHMEIA (+2)
	mov	pinsthl3[13],13
	mov	pinsthl3[14],10
	call	input_name_ascii
	jnc	kitare4s
	@POP
	ret

kitare4s:	@SETWIND	wplwait
	@CREATE_HANDLE	asciidisk,0
	mov	cs:ascii_handle,ax

	call	metrima_print
	call	plhra
	call	metrima_print
	@CLOSE_HANDLE	cs:ascii_handle
	cmp	mema,0
	je	askln4s
	cmp	fatal_stack,0
	je	asgoris4s
	cmp	cound,0
	jne	asexstl4s
	cmp	cound[2],0
	jne	asexstl4s
	mov	memory,0
	mov	exomnimi,0
	call	klidvma_oxi
	jmp	askln4s

asexstl4s:	cmp	arxascii,0
	je	asgoris4s
	call	klidvma

asgoris4s:	call	if_mnimi_on
	jnc	askln4s
	call	klidvma_oxi

askln4s:	mov	mema,0
	mov	cs:patise_taf,0
	call	genend

asakiro4s:	@DELWIND	wplwait
	@POP
	ret
save_ascii_4_super	endp

deltia_plirakia	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	call	check_all
	jnc	secam4

	@SETWIND	wdeltio_pliraki
	@SELECTWIND	wdeltio_pliraki
	call	loadDeltiaPlirakia
	@DELWIND	wdeltio_pliraki
	
efiges:	@POP
	ret

secam4:	call	ti_kuponi_einai
	jc	efiges

	@TAKEWIND
	push	ax
	@SETWIND	wdeltio_pliraki
	@SELECTWIND	wdeltio_pliraki

	call	for_dlt_plirakia
	call	plhra

	cmp	fatal_stack,0
	je	crh2
	call	plir_1

crh2:	cmp	kuponi_xora,STILESA4
	jne	mitipon
	call	far ptr ekt_stlA4_end

mitipon:	mov	cs:patise_taf,1
	call	genend
	@DELWIND	wdeltio_pliraki

crh4:	pop	ax
	@SELECTWI	al
	@POP
	ret
deltia_plirakia	endp

ti_kuponi_einai	proc	near
	@PUSH
	cmp	kuponi_xora,AUSTRIA
	jne	tiku1
	jmp	isAustria
tiku1:	cmp	kuponi_xora,CROATIA
	jne	tiku2
	jmp	isCroatia
tiku2:	cmp	kuponi_xora,GERMANY
	jne	tiku3
	jmp	isGermany
tiku3:	cmp	kuponi_xora,GERMANY1
	jne	tiku4
	jmp	isGermany1
tiku4:	cmp	kuponi_xora,FRANCE
	jne	tiku5
	jmp	isFrance
tiku5:	cmp	kuponi_xora,HUNGAR
	jne	tiku6
	jmp	isHungar
tiku6:	cmp	kuponi_xora,SERBIA
	jne	tiku7
	jmp	isSerbia
tiku7:	cmp	kuponi_xora,BULGARIA
	jne	tiku8
	jmp	isBulgaria
tiku8:	cmp	kuponi_xora,SPAIN
	jne	tiku9
	jmp	isSpain
tiku9:	cmp	kuponi_xora,SWEDEN
	jne	tiku10
	jmp	isSweden
tiku10:	cmp	kuponi_xora,SWISS
	jne	tiku11
	jmp	isSwiss
tiku11:	cmp	kuponi_xora,PRINT6ADES
	jne	tiku12
	jmp	isPrint6ades
tiku12:	cmp	kuponi_xora,STILESA4
	jne	tiku13
	jmp	isStilesA4
tiku13:	cmp	kuponi_xora,ITALY
	jne	tiku14
	jmp	isItaly
tiku14:	cmp	kuponi_xora,RUMANIA
	jne	tiku15
	jmp	isRumania
tiku15:	cmp	kuponi_xora,PRINT4ADES
	jne	tiku16
	jmp	isPrint4ades
tiku16:	cmp	kuponi_xora,PRINT8ADES
	jne	tiku17
	jmp	isPrint8ades
tiku17:	cmp	kuponi_xora,PRINT10ADES
	jne	tiku18
	jmp	isPrint10ades
tiku18:	cmp	kuponi_xora,TURKEY
	jne	tiku19
	jmp	isTurkey
tiku19:	cmp	kuponi_xora,PORTUGAL
	jne	tiku20
	jmp	isPortugal
tiku20:	cmp	kuponi_xora,GREECE
	jne	tiku21
	jmp	isGreece
tiku21:	@POP
	stc
	ret

kuponi_ok:	@POP
	clc
	ret
isGreece:				;;;;25.06.2023
	mov	STHLES_DELTIOU,4
	mov	SHMEIA_STHLHS,14
	call	super13ari
	mov	al,extra_sim14
	mov	pinsthl3[13],al
	jmp	kuponi_ok
isAustria:
	call	Austria_Position
	mov	STHLES_DELTIOU,13
	mov	SHMEIA_STHLHS,13
	jmp	kuponi_ok
isCroatia:
	mov	STHLES_DELTIOU,10	;;;;29.05.2022
	mov	SHMEIA_STHLHS,13
	jmp	kuponi_ok
isGermany:
	mov	STHLES_DELTIOU,12
	mov	SHMEIA_STHLHS,13
	jmp	kuponi_ok
isGermany1:
	mov	STHLES_DELTIOU,12
	mov	SHMEIA_STHLHS,13
	jmp	kuponi_ok
isFrance:
	mov	STHLES_DELTIOU,8
	mov	SHMEIA_STHLHS,15
	call	super13ari
	call	super14ari
	mov	al,extra_sim14
	mov	pinsthl3[13],al
	mov	al,extra_sim15
	mov	pinsthl3[14],al
	jmp	kuponi_ok
isHungar:
	mov	STHLES_DELTIOU,5
	mov	SHMEIA_STHLHS,14
	call	super13ari
	mov	al,extra_sim14
	mov	pinsthl3[13],al
	jmp	kuponi_ok
isPortugal:
	mov	STHLES_DELTIOU,10	;;;;18.06.2023
	mov	SHMEIA_STHLHS,14
	call	super13ari
	mov	al,extra_sim14
	mov	pinsthl3[13],al
	jmp	kuponi_ok
isTurkey:				;;;;28.03.2023
	mov	STHLES_DELTIOU,5
	mov	SHMEIA_STHLHS,15
	call	super13ari
	call	super14ari
	mov	al,extra_sim14
	mov	pinsthl3[13],al
	mov	al,extra_sim15
	mov	pinsthl3[14],al
	jmp	kuponi_ok
isSerbia:
	mov	STHLES_DELTIOU,10
	mov	SHMEIA_STHLHS,13
	jmp	kuponi_ok
isBulgaria:
	mov	STHLES_DELTIOU,6
	mov	SHMEIA_STHLHS,13	;;; (10, 11, 12, 13)
	jmp	kuponi_ok
isSpain:
	mov	STHLES_DELTIOU,8
;*********************************************************
	cmp	WhatPrinter,@EPSONLQ590
	je	IsEpsonLQ590_1
	jmp	IsNot1
;**************************************************************
IsEpsonLQ590_1:	
	mov	SHMEIA_STHLHS,15
	call	super13ari
	mov	al,extra_sim14
	mov	pinsthl3[13],al
	@SETWIND	wagonas_0_4
	@SELECTWIND	wagonas_0_4
	mov	ax,spain_1
	@ITOA	strbuf,2
	@WINPUTNUMBER	10,2,strbuf
	@ATOI	strbuf
	mov	spain_1,ax
	mov	ax,spain_2
	@ITOA	strbuf,2
	@WINPUTNUMBER	10,3,strbuf
	@ATOI	strbuf
	mov	spain_2,ax
	@DELWIND	wagonas_0_4
;**********************************************************
IsNot1:
	cmp	WhatPrinter,@EPSONLQ870
	je	IsEpsonLQ870_1
	jmp	IsNot2
;**************************************************************
IsEpsonLQ870_1:	
	mov	SHMEIA_STHLHS,14
	call	super13ari
	mov	al,extra_sim14
	mov	pinsthl3[13],al
;**********************************************************
IsNot2:	jmp	kuponi_ok

isSweden:	mov	STHLES_DELTIOU,12
	mov	SHMEIA_STHLHS,13
	jmp	kuponi_ok

isSwiss:	mov	STHLES_DELTIOU,12
	mov	SHMEIA_STHLHS,13
	@SETWIND	wagonas_0_4
	@SELECTWIND	wagonas_0_4
	mov	ax,swiss_1
	@ITOA	strbuf,2
	@WINPUTNUMBER	10,2,strbuf
	@ATOI	strbuf
	mov	swiss_1,ax
	mov	ax,swiss_2
	@ITOA	strbuf,2
	@WINPUTNUMBER	10,3,strbuf
	@ATOI	strbuf
	mov	swiss_2,ax
	@DELWIND	wagonas_0_4
	jmp	kuponi_ok
isPrint6ades:
	mov	STHLES_DELTIOU,6
	mov	SHMEIA_STHLHS,13
	jmp	kuponi_ok
isPrint4ades:
	mov	STHLES_DELTIOU,4
	mov	SHMEIA_STHLHS,13
	jmp	kuponi_ok
isPrint8ades:
	mov	STHLES_DELTIOU,8
	mov	SHMEIA_STHLHS,13
	jmp	kuponi_ok
isPrint10ades:
	mov	STHLES_DELTIOU,10
	mov	SHMEIA_STHLHS,13
	jmp	kuponi_ok
isStilesA4:
	mov	STHLES_DELTIOU,36		;;;;;
	mov	SHMEIA_STHLHS,13
	mov	prn_stl_Selida,0
	mov	prn_str_prsel,1
	jmp	kuponi_ok

;isStilesA4_2:
;	mov	STHLES_DELTIOU,72
;	mov	SHMEIA_STHLHS,13
;	mov	prn_stl_Selida,0
;	mov	prn_str_prsel,1
;	jmp	kuponi_ok

isItaly:	mov	STHLES_DELTIOU,8
	mov	SHMEIA_STHLHS,14
	call	super13ari
	mov	al,extra_sim14
	mov	pinsthl3[13],al
	jmp	kuponi_ok
isRumania:				;;29.05.2022
	mov	STHLES_DELTIOU,3
	mov	SHMEIA_STHLHS,13
	jmp	kuponi_ok
ti_kuponi_einai	endp

Austria_Position	proc	near
	@PUSH
	@SETWIND	waustria
	@SELECTWIND	waustria

aus_al0:
	call	print_austria_position
	mov	cx,8
	xor	bx,bx
	mov	cs:myues1,3
aus_al1:
	xor	ax,ax
	mov	al,Austria_uesi[bx]
	@ITOA	strbuf,2
	@WINPUTNUMBER	9,cs:myues1,strbuf
	jc	aus_al2
	@ATOI	strbuf
	mov	Austria_uesi[bx],al
	call	check_austria_position
	call	print_austria_position
	inc	bx
	inc	cs:myues1
	loop	aus_al1

	mov	cx,7
	xor	bx,bx
aus_al8:
	mov	al,Austria_uesi[bx]
	cmp	al,Austria_uesi[bx+1]
	jb	aus_al7
	call	aus_pos_fix
	jmp	aus_al0
aus_al7:
	inc	bx
	loop	aus_al8
	jmp	aus_al0
aus_al2:

	mov	cx,13	;(18-5)
	mov	si,5
aus_al10:
	mov	byte ptr Austria_uesi_onoff[si],0
	inc	si
	loop	aus_al10

	mov	cx,8
	xor	si,si
aus_al11:
	xor	bx,bx
	mov	bl,Austria_uesi[si]
	dec	bx
	mov	byte ptr Austria_uesi_onoff[bx],1
	inc	si
	loop	aus_al11
	call	check_austria_position
	call	print_austria_position
	@PLHKTRO
	@DELWIND	waustria
	@POP
	ret
myues1	db	0
Austria_Position	endp

check_austria_position	proc	near
	@PUSH
	mov	cx,8
	xor	bx,bx
aus_al5:
	xor	ax,ax
	mov	al,Austria_uesi[bx]
	cmp	al,6
	jb	aus_error
	cmp	al,18
	ja	aus_error
	inc	bx
	loop	aus_al5
	@POP
	ret
aus_error:
	call	aus_pos_fix
	@POP
	ret
check_austria_position	endp

aus_pos_fix	proc	near
	mov	Austria_uesi[0],6
	mov	Austria_uesi[1],7
	mov	Austria_uesi[2],8
	mov	Austria_uesi[3],9
	mov	Austria_uesi[4],10
	mov	Austria_uesi[5],11
	mov	Austria_uesi[6],12
	mov	Austria_uesi[7],13
	ret
aus_pos_fix	endp

print_austria_position	proc	near
	@PUSH
	mov	cx,8
	xor	bx,bx
	mov	cs:myues,3
aus_al:	xor	ax,ax
	mov	al,Austria_uesi[bx]
	@ITOA	strbuf,2
	@WPRINT	9,cs:myues,strbuf
	inc	bx
	inc	cs:myues
	loop	aus_al
	@POP
	ret
myues	db	0
print_austria_position	endp

super13ari	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@SETWIND	wsuper13
	@SELECTWIND	wsuper13
alis0:	@WPRINT	13,3,extra_sim14
	@CURSW	13,3
	cmp	al,27
	jne	alis8
	jmp	sp13f
alis8:	cmp	al," "
	je	alisk
	cmp	al,"1"
	je	alis1
	cmp	al,"2"
	je	alis2
	cmp	al,"3"
	je	alis3
	cmp	al,13
	je	alis13
	jmp	alis0
alis1:	mov	extra_sim14,"1"
	mov	extra_sim14[1]," "
	mov	extra_sim14[2]," "
	jmp	alis0
alis2:	mov	extra_sim14,"2"
	mov	extra_sim14[1]," "
	mov	extra_sim14[2]," "
	jmp	alis0
alis3:	mov	extra_sim14,"X"
	mov	extra_sim14[1]," "
	mov	extra_sim14[2]," "
	jmp	alis0
alisk:	mov	extra_sim14," "
	mov	extra_sim14[1]," "
	mov	extra_sim14[2]," "
	jmp	alis0
alis13:
sp13f:	@DELWIND	wsuper13
	@POP
	ret
super13ari	endp

super14ari	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@SETWIND	wsuper14
	@SELECTWIND	wsuper14
alis0_14:	@WPRINT	13,3,extra_sim15
	@CURSW	13,3
	cmp	al,27
	jne	alis8_14
	jmp	sp13f_14
alis8_14:	cmp	al," "
	je	alisk_14
	cmp	al,"1"
	je	alis1_14
	cmp	al,"2"
	je	alis2_14
	cmp	al,"3"
	je	alis3_14
	cmp	al,13
	je	alis13_14
	jmp	alis0_14
alis1_14:
	mov	extra_sim15,"1"
	mov	extra_sim15[1]," "
	mov	extra_sim15[2]," "
	jmp	alis0_14
alis2_14:
	mov	extra_sim15,"2"
	mov	extra_sim15[1]," "
	mov	extra_sim15[2]," "
	jmp	alis0_14
alis3_14:
	mov	extra_sim15,"X"
	mov	extra_sim15[1]," "
	mov	extra_sim15[2]," "
	jmp	alis0_14
alisk_14:	
	mov	extra_sim15," "
	mov	extra_sim15[1]," "
	mov	extra_sim15[2]," "
	jmp	alis0_14
alis13_14:
sp13f_14:
	@DELWIND	wsuper14
	@POP
	ret
super14ari	endp

plir_1	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	cmp	axbp,0
	je	den_exei
	mov	fatal_stack,sp
	call	buffer_full
den_exei:
	@POP
	ret
plir_1	endp

omadopiisi	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	call	savetmp
	mov	ax,cound
	mov	coundq,ax
	mov	ax,cound[2]
	mov	coundq[2],ax
	call	kauarisma_metab
	call	tajinompr
	call	omades
	call	prometr
	call	metrima
	call	metrpr
	call	edomad
	call	editr
	call	editomr
	call	edtomr1
	call	editot
	call	tajasc
	jnc	bug9
	call	toobig
bug9:	mov	ax,coundq
	mov	cound,ax
	mov	ax,coundq[2]
	mov	cound[2],ax
	call	savetmp
	call	screen
	call	prbuf
	@POP
	ret
omadopiisi	endp

kupon_disp	proc	near
	@PUSH
	xor	ax,ax
	mov	al,kuponi_xora
	sub	ax,"A"
	mov	cx,14
	mul	cx
;------------------------------------------ WPRINT
	push	dx
	push	bx
	push	ax
	mov     	dl,1
	mov	dh,1
	mov	bx,offset kuponi_str
	add	bx,ax
	xor	ax,ax
	call	far ptr windprint
	pop	ax
	pop	bx
	pop	dx
;----------------------------------------------
	@POP
	ret
kupon_disp	endp

dialogi_plirakia	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	
	call	SelectCupon
	call	check_all
	jnc	proxora

	@SETWIND	wdial1
	@SETWIND	wdial2
	@SELECTWIND wdial2
	call	kupon_disp
	mov	dialogi,1
	mov	grammh,3
	call	loadDeltiaPlirakia
	@DELWIND	wdial2
	@DELWIND	wdial1
	@POP
	ret

proxora:	call	chk_pindial
	jnc	all_2
efiges2:	@POP
	ret

all_2:	call	ti_kuponi_einai
	jc	efiges2
	
	@SETWIND	wdial1
	@SETWIND	wdial2
	@SELECTWIND wdial2
	call	kupon_disp

	mov	dialogi,1
	mov	grammh,3

	call	for_dlt_plirakia
	call	plhra

	cmp	fatal_stack,0
	je	crhd2
	cmp	axbp,0
	je	crhd2

	call	plir_1
	
crhd2:	mov	cs:patise_taf,1
	call	genend
	@DELWIND	wdial2
	@DELWIND	wdial1
	@POP
	ret
dialogi_plirakia	endp

check_all	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	call	checkDeletedOros
	jc	chkal1
	call	geniki_taj
	jnc	chkal2
	jmp	chkal1

chkal2:	call	if_mnimi
	jnc	chkal0
	call	if_plires
	jnc	chkal0
	call	if_ascii
	jnc	chkal0
chkal1:	@POP
	stc
	ret

chkal0:	@POP
	clc
	ret
check_all	endp

checkDeletedOros	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	cmp	arxascii,0
	je	IsAdeio

	xor	bx,bx
epomOr:	@CHANGESEGM	ds,DATASC
	mov	dl,arxasc[bx]
	@CHANGESEGM	ds,DATAS1
	cmp	dl,"@"
	je	OrosDenYparxi
	cmp	dl,"1"
	je	OrosDenYparxi
	cmp	dl,"N"
	je	OrosDenYparxi
	cmp	dl,"7"
	je	OrosDenYparxi
	cmp	dl,"J"
	je	OrosDenYparxi
	add	bx,48
	cmp	bx,arxascii
	jbe	epomOr
IsAdeio:	clc
	@POP
	ret

OrosDenYparxi:
	@SETWIND	wProblemWithOros
	@PLHKTRO
	@DELWIND	wProblemWithOros
	stc
	@POP
	ret
checkDeletedOros	endp
	

testonom	proc	near
	@PUSH
	@CHANGESEGM	ds,WINSEGM
	@STRXOR	tstcpr2,39
	@STRCMP	tstcpr2,tstcpr1
	jnc	idio
	@EXIT
idio:	@STRXOR	tstcpr2,39
	@STRXOR	tstcpr4,27
	@STRCMP	tstcpr4,tstcpr5
	jnc	idio1
	@EXIT
idio1:	@STRXOR	tstcpr4,27
	@POP
	ret
testonom	endp

testonom1	proc	near
	@PUSH
	@CHANGESEGM	ds,CODESG
	@CHANGESEGM	es,WINSEGM
	xor	bx,bx
idio2:	mov	al,tstcpr3[bx]
	cmp	al,0
	je	idio3
	xor	al,161
	mov	es:tstcpr1[bx],al
	inc	bx
	jmp	idio2
idio3:	@POP
	ret
tstcpr3	label	byte

XORDATA	<TZORTZAKIS DIMITRIS & PAPADOPOULOS LEONIDAS>,161
	db	0
testonom1	endp

clear_sthl_buf	proc	near
	@PUSH
	@CHANGESEGM	ds,MAST1
	mov	ax,MAST1

allo_segm:	mov	ds,ax
	push	cx
	xor	dx,dx
	xor	bx,bx
	mov	cx,32752	;65504/2
allo_word:
	mov	word ptr ds:[bx],dx
	inc	bx
	inc	bx
	loop	allo_word
	pop	cx
	add	ax,4094
	cmp	ax,MAST6
	jb	allo_segm
	@POP
	ret
clear_sthl_buf	endp

load_lpt	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@OPEN_HANDLE	lptfile,I_READ
	jnc	st201
	jmp	stend2
st201:	mov	cs:handlef,ax
	xor	bx,bx
	xor	si,si
aloch:	mov	strbuf,0
	@READ_HANDLE	cs:handlef,strbuf,1
	mov	al,strbuf
	cmp	al,0
	jne	st203
	jmp	stend
st203:	cmp	al," "
	jb	stend1
	cmp	al,"~"
	ja	stend1
	jmp	nst200

stend1:	jmp	stend

nst200:	cmp	al,13
	jne	nst13
	mov	lptnames[bx],0
	add	si,15
	cmp	si,30
	ja	stend
	mov	bx,si
	jmp	aloch

nst13:	mov	lptnames[bx],al
	inc	bx
	jmp	aloch

stend:	@CLOSE_HANDLE	cs:handlef
stend2:	@POP
	ret
handlef	dw	0
load_lpt	endp


;################################################################################################ S T A R T
;################################################################################################

MyProg	proc	near
	@PUSH
;*********************************
klidi_epistrofi:
;*********************************
	@SETWINSEGM	WINSEGM
	@CHANGESEGM	ds,DATAS1
	@CHANGESEGM	es,DATANA

epilogiekt:	
	@SETWIND	wWhatPrinter
	@SELECTWIND	wWhatPrinter
	@PLHKTRO
	@DELWIND	wWhatPrinter
	cmp	al,"?"
	jne	nofileprn
	@STRCOPY	lptnames[45],lptnames,15
	@CREATE_HANDLE lptnames,0
	mov	cs:handlef,ax
	@CLOSE_HANDLE cs:handlef
	jmp	printer_EPilextike

nofileprn:	cmp	al,"5"
	je	isLQ590
	cmp	al,"1"
	je	isLQ870
	jmp	epilogiekt

isLQ590:
	mov	lptnames[3],"1"
	mov	whatPrinter,@EPSONLQ590
	mov	prnfile[4],"5"
	mov	prnfile[5],"9"
	mov	prnfile[6],"0"
	jmp	printer_EPilextike
	
	
isLQ870:
	mov	lptnames[3],"1"
	mov	whatPrinter,@EPSONLQ870
	mov	prnfile[4],"8"
	mov	prnfile[5],"7"
	mov	prnfile[6],"0"
	jmp	printer_EPilextike
	
	
printer_EPilextike:
	call	load_inf
	call	load_lpt
	call	testonom
	call	testonom1
	@WAIT	20
	@DELWIND	wstart
	call	take_code
	call	init_code
	call	screen
	call	prbuf
	call	copyright
	@BIGCURS
	mov	ax,offset	lptnames
	mov	lpt_number,ax

;----------------------------------------------- ;;; апохгйеусг летабкгтым циа "мео сустгла" (епамаявийопоигсг летабкгтым)
	call	saveMetablites
;-----------------------------------------------

aloop:	call	prbuf
	mov	plktr," "
	mov	dx,18
	call	setcurs
	mov	dl," "
	call	dosdisp
loopa1:	mov	dx,18
	call	setcurs
	@WAITL
fokia:	@UPPERAX
gousouroum:
	cmp	al,0
	je	kasa
;****************************
	cmp	al,27		;escape
	jne	pll1
	call	help
	jmp	gousouroum
;****************************
pll1:	cmp	al,"]"
	je	dioru1
;****************************
	mov	dl,al
	cmp	dl,8
	je	kasa
	cmp	dl," "
	jae	klic
	jmp	aloop
klic:	cmp	dl,"~"
	jbe	__dd
	jmp	aloop
;****************************
__dd:	call	dosdisp
kasa:	mov	plktr,ax
	jmp	elegx
;****************************
;****************************	DIORUOSI	OROU
;****************************
dioru1:	mov	dx,18
	call	setcurs
	mov	dl," "
	call	dosdisp
	call	dioru
	mov	dx,arxascii
	cmp	ax,dx
	jb	noynoy
	mov	dl,stili
	mov	dh,0
	call	setcurs
	mov	dl," "
	call	dosdisp
	jmp	aloop

noynoy:	mov	shmea5,1
	mov	dl,asthlh
	push	dx
	mov	dl,sthlh
	mov	asthlh,dl
	mov	dx,arxascii
	push	dx
	mov	arxascii,ax
	jmp	mplek
rrr1:	call	editor
mplek:	mov	dh,0
	mov	dl,stili
	call	setcurs
	mov	dl,219
	call	dosdisp
	mov	dh,0
	mov	dl,18
	call	setcurs
	cmp	shmeat,1
	jne	plkt1
	mov	al,"T"
	jmp	pll19
plkt1:	call	getkey
	cmp	al,0
	jne	oxi0
	cmp	ah,50h
	je	pll18
oxi0:	cmp	al,"."
	je	pll18
	cmp	al,13
	je	pll18
	jmp	pll19
pll18:	cmp	buffers[0],"W"
	je	bbpl1
	cmp	buffers[0],"#"
	jne	plle1
bbpl1:	jmp	rrr1
plle1:	cmp	buffers[0],"B"
	jne	pll150
	jmp	rrr1
pll150:
pll70:
	cmp	buffers[0],"M"
	jne	tlms
	mov	shmeat,0
	call	edast
	call	editor2
	jmp	mplek
tlms:
	cmp	buffers[0],"K"
	jne	pll71
	mov	shmeat,0
	call	edast
	mov	shmea8,1
	mov	shmea1,1
	mov	shmea3,0
	call	editor1
	call	capo
	jmp	mplek
	
pll71:	cmp	buffers[0],"H"
	je	pll182
	jmp	pll181
pll182:	mov	shmea8,1
	mov	shmeat,0
	call	edast
	jmp	rrr1

pll181:	cmp	buffers[0],"L"
	jne	pll183
	mov	shmeat,0
	call	edast
	call	editor2
	jmp	mplek
pll183:	cmp	buffers[0],"("
	je	likeD
	cmp	buffers[0],")"
	je	likeD
	cmp	buffers[0],"D"
	jne	plqq3
likeD:	mov	shmeat,0
	call	edast
	call	editor2
	jmp	mplek
plqq3:	cmp	buffers[0],"}"
	jne	plqw1
	mov	shmeat,0
	call	edast
	call	editor2
	jmp	mplek
plqw1:	cmp	buffers[0],"%"
	jne	plqw3
	mov	shmeat,0
	call	edast
	call	editor2
	jmp	mplek
plqw3:	cmp	buffers[0],"0"
	jne	pll31
	mov	shmea1,1
	mov	shmea3,0
	mov	shmeat,0
	call	editor1
	jmp	mplek
pll31:	cmp	buffers[0],"X"
	jne	pll32
	mov	shmea7,1
	jmp	rrr1
pll32:	cmp	buffers[0],"Y"
	jne	pll33
	mov	shmea7,2
	jmp	rrr1
pll33:	cmp	buffers[0],"Z"
	jne	pll24
	mov	shmea7,2
	jmp	rrr1
pll24:	cmp	buffers[0],"U"
	jne	pll24i
	mov	shmea2,0
	mov	shmea3,0
	mov	shmea7,1
	mov	shmea_diplh,1
	mov	bx,4
	mov	dh,3
	mov	dl,17
	call	x21
	call	editor2
	mov	shmea_diplh,0
	jmp	mplek
pll24i:	cmp	buffers[0],"O"
	jne	_ep
	mov	shmea2,0
	mov	shmea3,0
	mov	shmea7,2
	mov	bx,4
	mov	dh,3
	mov	dl,17
	call	x21
	call	editor2
	jmp	mplek
_ep:	cmp	buffers[0],"!"
	je	likeR
	cmp	buffers[0],"$"
	je	likeR
	cmp	buffers[0],"I"	;;15.11.2021
	je	likeR
	cmp	buffers[0],"@"	;;15.03.2024
	je	likeR
	cmp	buffers[0],"/"	;;03.2023
	je	likeR
	cmp	buffers[0],"~"	;;14.1.2015
	je	likeR
	cmp	buffers[0],"R"	;;14.1.2015
	je	likeR
	cmp	buffers[0],"5"
	jne	_epqi

likeR:	mov	shmea2,0
	mov	shmea3,0
	mov	shmea7,2
	mov	bx,4
	mov	dh,3
	mov	dl,17
	call	x21
	call	editor2
	jmp	mplek

_epqi:	cmp	buffers[0],"P"
	jne	aquaPPPP
	jmp	aqua
aquaPPPP:	cmp	buffers[0],"Q"
	je	aqua
	cmp	buffers[0],"A"
	je	aqua
	cmp	buffers[0],"S"
	je	aqua
	cmp	buffers[0],"6"
	je	aqua
	cmp	buffers[0],"&"
	je	aquax10
	cmp	buffers[0],"V"
	je	aqua
	cmp	buffers[0],"|"
	je	aqua
	cmp	buffers[0],"2"
	je	aqua
	cmp	buffers[0],"3"
	je	aqua
	cmp	buffers[0],"4"
	je	aqua
	cmp	buffers[0],"5"
	je	aqua
	cmp	buffers[0],"\"
	je	aqua
	cmp	buffers[0],"{"
	je	aqua
	jmp	pll19
aqua:	mov	shmeat,0
	call	editor2
	jmp	mplek
aquax10:
	mov	al,buffers[4]
	cmp	al," "
	jne	l5421
	mov	al,"1"
l5421:	mov	strbuf[0],al
	mov	strbuf[1],0
	@WINPUTNUMBER	17,3,strbuf,emfanejo
	mov	al,strbuf[0]
	cmp	al," "
	je	l541
	mov	buffers[4],al
l541:	mov	shmeat,0
	call	editor2
	jmp	mplek

pll19:	cmp	al,"T"
	jne	pll5
_taf:	@WPRINTCH	stili,0," "
	jmp	taf

pll5:	cmp	al,8
	je	_as
	cmp	al,"-"
	je	_as
	cmp	al,81
	jne	pll6

_as:	@WPRINTCH	stili,0," "
	jmp	delet\

pll6:	mov	shmeat,0
	jmp	plkt1
;**********************************************************************
elegx:		
;---------------------------------------	PROTASI
	mov	ax,plktr
	cmp	al,"*"
	jne	pll7
IFDEF	@DILONO_ELEGXO
	call	dilono_elegxo
ENDIF
IFDEF	@PROTASI
	call	protas
ENDIF
	jmp	aloop
;-----------------------------------------------------
pll7:	cmp	al,0
	je	super
	jmp	aplo
;******************************
super:	cmp	ah,RIGHT_ARROW
	jne	super1
	jmp	selidas
super1:	cmp	ah,LEFT_ARROW
	jne	super2
	jmp	selidam
super2:	cmp	ah,_HOME
	jne	super3
	mov	selida,0
	call	prbuf
	jmp	aloop
super3:	cmp	ah,_END
	jne	super4
	mov	ax,bselida
	cmp	ax,90
	jb	keses
	mov	bselida,89
	mov	ax,89
keses:	mov	selida,ax
	call	prbuf
super4:	jmp	aloop
;*****************************************************
aplo:	cmp	al,"W"
	je	bble2
	jmp	pll25
bble2:	jmp	basthl
pll25:	cmp	al,"X"
	jne	pll26
	mov	shmea7,1
	jmp	basthl
pll26:	cmp	al,"Y"
	jne	pll27
	mov	shmea7,2
	jmp	basthl
pll27:	cmp	al,"Z"
	jne	pll8
	mov	shmea7,2
	jmp	basthl
pll8:	cmp	al,"+"
	jne	pll9
	jmp	selidas
pll9:	cmp	al,"-"
	jne	pll10
	jmp	selidam
;*****************************************	OMADOPOIISI
pll10:	cmp	al,";"
	jne	pll16
	call	omadopiisi
	jmp	aloop
;*****************************************
pll16:	cmp	al,"U"
	jne	pll16i
	call	xarakt
	mov	shmea2,0
	mov	shmea3,0
	mov	shmea7,1
	mov	shmea_diplh,1
	mov	bx,4
	mov	dh,3
	mov	dl,17
	call	x21
	mov	shmea_diplh,0
	jmp	xxar
pll16i:	cmp	al,"O"
	jne	_ep1
	call	xarakt
	mov	shmea2,0
	mov	shmea3,0
	mov	shmea7,2
	mov	bx,4
	mov	dh,3
	mov	dl,17
	call	x21
	jmp	xxar
;*******************************************************
_ep1:	cmp	al,"!"
	je	likeR1
	cmp	al,"$"
	je	likeR1
	cmp	al,"I"	;;15.11.2021
	je	likeR1
	cmp	al,"@"	;;15.03.2024
	je	likeR1
	cmp	al,"/"	;;03.2023
	je	likeR1
	cmp	al,"~"
	je	likeR1	;;14.1.2015
;*********************************************************
	cmp	al,"R"	;;14.1.2015
	je	likeR1
	cmp	al,"5"
	jne	_ep1qi
	
likeR1:	call	xarakt
	mov	shmea2,0
	mov	shmea3,0
	mov	shmea7,2
	mov	bx,4
	mov	dh,3
	mov	dl,17
	call	x21
	jmp	xxar

_ep1qi:	cmp	al,"P"
	jne	aqua3PPP
	jmp	aqua3

aqua3PPP:	cmp	al,"Q"
	je	aqua3
	cmp	al,"A"
	je	aqua3
	cmp	al,"S"
	je	aqua3
	cmp	al,"5"
	je	aqua3
	cmp	al,"6"
	je	aqua3
	cmp	al,"&"
	je	aqua3
	cmp	al,"V"
	je	aqua3
	cmp	al,"2"
	je	aqua3
	cmp	al,"4"
	je	aqua3
	cmp	al,"3"
	je	aqua3
	cmp	al,"\"
	je	aqua3
	cmp	al,"|"
	je	aqua3
	cmp	al,"{"
	je	aqua3
	jmp	pll17
aqua3:	jmp	xarak
pll17:	cmp	al,"0"
	jne	pll21
	call	if_mnimi_on
	jnc	pll21
	call	if_ascii
	jnc	pll21
	jmp	plhres
pll21:
pll38:	cmp	al,"H"
	jne	pll51
	jmp	astra
pll51:	cmp	al,"L"
	jne	pll52
	jmp	skast
pll52:	cmp	al,"("
	je	likeD1
	cmp	al,")"
	je	likeD1
	cmp	al,"D"
	jne	plqq2
likeD1:	jmp	skast
plqq2:	cmp	al,"}"
	jne	plqw2
	jmp	skast
plqw2:	cmp	al,"%"
	jne	plqw4
	jmp	skast
plqw4:
pll60:	cmp	al,"K"
	jne	pll61
	jmp	xvris
pll61:	cmp	al,"B"
	jne	pqq90
	jmp	basthl
;***************************************	diakoptis mnimis
pqq90:	cmp	al,"?"
	jne	metsebas
	call	get_mnimi
	jmp	aloop
;***************************************
metsebas:	cmp	al,">"
	jne	metsetri
	call	InAsciiOros
	jmp	aloop
;***************************************	Utilities
metsetri:	cmp	al,"["
	jne	nklar
	call	utils
	jmp	aloop
;***************************************	metrhths
nklar:	cmp	al,"G"
	jne	peqr1
	call	metrima_stilon
	jmp	aloop
;***************************************	pinakes
peqr1:	cmp	al,"C"
	jne	peqi45
	call	pinakes
	jmp	aloop
;***************************************	elegxos
peqi45:	cmp	al,"E"
	jne	peqi1
	call	elegxos
	jmp	aloop
;***************************************	sthlh dialoghs
peqi1:	cmp	al,"8"
	jne	peql3
	@SETWIND	wnikitr
	call	eisagvgh_dialoghs
	@DELWIND	wnikitr
	call	save_inf
	jmp	aloop
;***************************************	diaxeirhsh arxeivn
peql3:	cmp	al,"9"
	jne	peqd4
lklm:	call	check_plhres
	call	arxeia
	jc	lq13
	call	prbuf
	call	putsthles
	jmp	aloop
lq13:	@FILLSCR	" ",07h
	@ENDPRG
	retf
;#############################################################################
;********** TELOS  
;#############################################################################


;***************************************	metablhto
peqd4:	cmp	al,"M"
	jne	pll94
	call	tajinompr
	mov	bx,arxascii
	cmp	bx,0
	je	nairi
	sub	bx,48
	@CHANGESEGM	ds,DATASC
	mov	dl,arxasc[bx]
	@CHANGESEGM	ds,DATAS1
	cmp	dl,"M"
	je	pll94
nairi:	jmp	skast
;***************************************	sthles xima
pll94:	cmp	al,"F"
	jne	peqi
	call	ekt_ouoni
	jmp	aloop
;***************************************	ektiposis
peqi:	cmp	al,"="
	jne	peqb4
	call	ektip
	jmp	aloop
;***************************************
peqb4:	cmp	al,"#"
	jne	peqe4
	call	dialogi_plirakia
	jmp	aloop
;***************************************	dialogh se ouonh
peqe4:	cmp	al,","
	jne	peqg4
	call	dialogi_ouoni
	jmp	aloop
;***************************************
peqg4:	cmp	al,"`"
	jne	plql4
	call	copyright
	jmp	aloop
;***************************************
plql4:	cmp	al,"^"
	jne	qwer12
	call	get_plirof
	jmp	aloop
;***************************************	ALLA	PLIKTRA
qwer12:
	jmp	aloop
;***************************************


;********************************************************
;****                EISAGVGH ORVN                   ****
;********************************************************
xvris:	mov	buffers[0],al
	mov	shmeat,0
	call	asteri
	call	edast
	mov	shmea8,1
	mov	shmea1,1
	mov	shmea3,0
	call	editor1
	call	capo
	jmp	bas1
skast:	mov	buffers[0],al
	mov	shmeat,0
	call	asteri
	call	edast
	jmp	xxar

astra:	mov	buffers[0],al
	mov	shmeat,0
	call	asteri
	call	edast
	mov	shmea8,1
	jmp	rrr
xarak:	call	xarakt
	jmp	xxar

plhres:	mov	buffers[0],"0"
	mov	buffers[45],80
	mov	buffers[47],0
	jmp	bas2

basthl:	mov	bx,0
	mov	buffers[bx],al
	inc	bx
rrr:	call	editor
	jmp	bas1
xxar:	cmp	buffers[0],"&"
	jne	xxar9
	
	mov	al,buffers[4]
	cmp	al," "
	jne	l544
	mov	al,"1"
l544:	mov	strbuf[0],al
	mov	strbuf[1],0
	@WINPUTNUMBER	17,3,strbuf,emfanejo
	mov	al,strbuf[0]
	cmp	al," "
	je	l542
	mov	buffers[4],al
l542:	mov	shmeat,0

xxar9:	call	editor2
bas1:	mov	dh,0
	mov	dl,18
	call	setcurs
	cmp	shmeat,1
	jne	plhkt
	mov	al,"T"
	jmp	pll12
plhkt:	call	getkey
	cmp	al,0
	jne	oxi0_1
	cmp	ah,50h
	je	pll1222
oxi0_1:	cmp	al,"."
	je	pll1222
	cmp	al,13
	je	pll1222
	jmp	pll12

pll59:  	call    	edast
	mov     	shmea1,1
	mov     	shmea3,0
	mov     	shmeat,0
	call    	editor1
	call    	capo
	jmp     	bas1
pll1222:
pll40:
pll57:	cmp     	buffers[0],"K"
	jne     	pll58
	jmp     	pll59

pll58:	cmp	buffers[0],"H"
	jne	pll54
	call	edast
	jmp	rrr
pll54:	cmp	buffers[0],"L"
	jne	pqq53
	call	edast
	jmp	xxar
pqq53:	cmp	buffers[0],"("
	je	likeD2
	cmp	buffers[0],")"
	je	likeD2
	cmp	buffers[0],"D"
	jne	pll53
likeD2:	call	edast
	jmp	xxar
pll53:	cmp	buffers[0],"}"
	jne	pll537
	call	edast
	jmp	xxar
pll537:	cmp	buffers[0],"%"
	jne	pll536
	call	edast
	jmp	xxar
pll536:	cmp	buffers[0],"0"
	jne	pll22
bas2:	mov	shmea1,1
	mov	shmea3,0
	mov	shmeat,0
	call	editor1
	jmp	bas1
pll22:	cmp	buffers[0],"U"
	jne	pll22i
	mov	shmea2,0
	mov	shmea3,0
	mov	shmea7,1
	mov	shmea_diplh,1
	mov	bx,4
	mov	dh,3
	mov	dl,17
	call	x21
	mov	shmea_diplh,0
	jmp	xxar
pll22i:

	cmp	buffers[0],"!"
	je	likeR2
	cmp	buffers[0],"$"
	je	likeR2
	cmp	buffers[0],"I"	;;15.11.2021
	je	likeR2
	cmp	buffers[0],"@"	;;15.03.2024
	je	likeR2
	cmp	buffers[0],"/"	;;03.2023
	je	likeR2
	cmp	buffers[0],"~"	;;14.1.2015
	je	likeR2		;;14.1.2015
	cmp	buffers[0],"R"
	je	likeR2
	cmp	buffers[0],"5"
	je	likeR2
	cmp	buffers[0],"O"
	jne	_ep2qi
	
likeR2:	mov	shmea2,0
	mov	shmea3,0
	mov	shmea7,2
	mov	bx,4
	mov	dh,3
	mov	dl,17
	call	x21
	jmp	xxar
_ep2qi:	cmp	buffers[0],"P"
	jne	aqua1PPP
	jmp	aqua1
aqua1PPP:
	cmp	buffers[0],"Q"
	je	aqua1
	cmp	buffers[0],"A"
	je	aqua1
	cmp	buffers[0],"S"
	je	aqua1
	cmp	buffers[0],"6"
	je	aqua1
	cmp	buffers[0],"&"
	je	aqua1
	cmp	buffers[0],"V"
	je	aqua1
	cmp	buffers[0],"|"	;;;;;;;;;;;;;;	NEOS	OROS
	je	aqua1
	cmp	buffers[0],"2"
	je	aqua1
	cmp	buffers[0],"3"
	je	aqua1
	cmp	buffers[0],"4"
	je	aqua1
	cmp	buffers[0],"5"
	je	aqua1
	cmp	buffers[0],"\"
	je	aqua1
	cmp	buffers[0],"{"
	je	aqua1
	jmp	pll20
aqua1:	jmp	xxar
pll20:	jmp	rrr
pll12:	cmp	al,"T"
	je	taf
	jmp	pll11
taf:	mov	shmeat,0
	cmp	buffers[0],"R"
	je	_rq
	cmp	buffers[0],"&"
	je	_rq
	cmp	buffers[0],"5"
	je	_rq
	cmp	buffers[0],"U"
	je	_rq
	cmp	buffers[0],"O"
	je	_rq
	cmp	buffers[0],"I"	;;15.11.2021
	je	_rq
	cmp	buffers[0],"@"	;;15.03.2024
	je	_rq
	cmp	buffers[0],"/"	;;03.2023
	je	_rq
	cmp	buffers[0],"~"	;;14.1.2015
	je	_rq		;;14.1.2015
	cmp	buffers[0],"!"
	je	_rq
	cmp	buffers[0],"$"
	je	_rq
	jmp	_r
_rq:	cmp	buffers[4],"0"
	je	_rolo
	cmp	buffers[4]," "
	jne	_r
_rolo:	jmp	pipi3
_r:	cmp	buffers[0],"M"
	jne	zmal
	mov	buffers[47],99
	mov	buffers[45],"M"
	mov	buffers[46]," "
	mov	buffers[44]," "
	cmp	buffers[40]," "
	jne	metb7
	mov	buffers[40],"3"
	mov	buffers[41],"0"
	jmp	metb1
metb7:	cmp	buffers[40],"3"
	jbe	metb1
	cmp	buffers[41]," "
	je	metb1
	mov	buffers[40],"3"
metb1:	cmp	buffers[42],"1"
	je	metb2
	cmp	buffers[42],"6"
	jae	metb3
	mov	buffers[42],"1"
	mov	buffers[43],"2"
	jmp	dtend
metb2:	cmp	buffers[43],"2"
	jbe	metb4
	mov	buffers[43],"2"
metb4:	jmp	dtend
metb3:	mov	buffers[43]," "
	jmp	dtend
zmal:	cmp	buffers[0],"0"
	jne	pqq1
	mov	cx,13
	xor	ax,ax
	mov	bx,1
pll36:	cmp	buffers[bx]," "
	je	pqq5
	inc	ax
pqq5:	add	bx,3
	loop	pll36
	cmp	ax,1
	jae	konter
	jmp	pipi3
konter:	jmp	dtend
pqq1:	cmp	buffers[0],"P"
	jne	aqua4PPP
	jmp	aqua4
aqua4PPP:
	cmp	buffers[0],"Q"
	je	aqua4
	cmp	buffers[0],"A"
	je	aqua4
	cmp	buffers[0],"S"
	je	aqua4
	cmp	buffers[0],"6"
	je	aqua4
	cmp	buffers[0],"&"
	je	aqua4
	cmp	buffers[0],"V"
	je	aqua4
	cmp	buffers[0],"|"	;;;;;;;;;;;;;;	NEOS	OROS
	je	aqua4
	cmp	buffers[0],"2"
	je	aqua4
	cmp	buffers[0],"3"
	je	aqua4
	cmp	buffers[0],"4"
	je	aqua4
	cmp	buffers[0],"5"
	je	aqua4
	cmp	buffers[0],"\"
	je	aqua4
	cmp	buffers[0],"{"
	je	aqua4
	jmp	pqq9
aqua4:	cmp	buffers[0],"&"
	je	perl7
	cmp	buffers[0],"6"
	jne	pqq2
perl7:	cmp	buffers[47],1
	jne	pqq2
	jmp	pipi3
pqq9:	mov	cx,13
	mov	bx,1
pqq3:	cmp	buffers[bx]," "
	jne	pqq2
	add	bx,3
	loop	pqq3
	jmp	pipi3
pqq2:	cmp	buffers[0],"Z"
	je	pqq4
	cmp	buffers[0],"V"
	je	pqq4
	cmp	buffers[0],"K"
	je	pll23
	cmp	buffers[42]," "
	jne	pqq4
	jmp	pipi3
pqq4:	cmp	buffers[0],"Z"
	je	leo32
	cmp	buffers[0],"V"
	je	leo32
leo33:	cmp	buffers[40]," "
	jne	pll23
	jmp	pipi3
leo32:	mov	buffers[42]," "
	mov	buffers[43]," "
	jmp	leo33

pll23:	jmp	ctend
pll11:	cmp	al,8
	je	_as1
	cmp	al,"-"
	je	_as1
	cmp	al,81
	jne	pll13
_as1:	jmp	delet
pll13:	jmp	plhkt
delet:	mov	shmea4,1
	mov	cx,48
	mov	bx,0
pll50:	mov	buffers[bx]," "
	inc	bx
	loop	pll50
	jmp	dtend
ctend:	cmp	buffers[44],"N"	;bale	n	ean	keno
	je	aqua2
	cmp	buffers[44],"O"
	je	aqua2
	mov	buffers[44],"N"
aqua2:	cmp	buffers[45],32
	jne	caplb
	mov	buffers[45],49
	mov	buffers[47],1
caplb:	cmp	shmea11,0
	je	dten1
	mov	bx,1
	jmp	koka
dten1:	cmp	shmea8,0
	je	dtend
	mov	bx,3
	jmp	koka
dtend:	call	tend
	mov	shmea8,0
	mov	shmea7,0
	mov	shmea11,0
	cmp	shmea5,1
	jne	pll14
	jmp	smea53
pll14:	cmp	shmea5,2
	jne	pll15
	jmp	delete
pll15:	jmp	aloop
smea53:	mov	shmea5,0
	pop	dx
	mov	arxascii,dx
	pop	dx
	mov	asthlh,dl
	jmp	aloop
selidas:	mov	ax,selida
	cmp	bselida,ax
	jne	ngrab
	jmp	gyrnab
ngrab:	inc	selida
	cmp	selida,95
	jbe	selini
	dec	selida
selini:	call	prbuf
	jmp	aloop
;************************************
selidam:	cmp	selida,0
	je	gyrnab
	dec	selida
	call	prbuf
gyrnab:	jmp	aloop
koka:	cmp	buffers[bx]," "
	je	pipi3
pqq6:	mov	cx,13
pipi1:	cmp	buffers[bx]," "
	je	pipi2
	add	bx,3
	loop	pipi1
	jmp	dtend
pipi2:	cmp	buffers[bx]," "
	jne	pipi3
	add	bx,3
	loop	pipi2
	jmp	dtend
pipi3:	cmp	shmea5,1
	jne	pipi4
	jmp	mplek
pipi4:	jmp	bas1
delete:	mov	shmea5,0
	pop	ax
	push	ax
	mov	dx,arxascii
	add	dx,48
	sub	ax,dx
	cmp	ax,0
	je	manas3
	@CHANGESEGM	ds,DATASC
	mov	cx,ax
	mov	si,dx
	mov	bx,dx
manas:	mov	dl,arxasc[si]
	mov	arxasc[si-48],dl
	inc	si
	loop	manas
;**********************
	xor	dx,dx
	mov	cx,48
	div	cx
	mov	cx,ax
	xor	dx,dx
	mov	ax,bx
	mov	bx,48
	div	bx
	mov	di,ax
diai:	mov	dl,klioro[di]
	mov	klioro[di-1],dl
	inc	di
	loop	diai
;**********************
	@CHANGESEGM	ds,DATAS1
manas3:	pop	dx
	sub	dx,48
	mov	arxascii,dx
	@CHANGESEGM	ds,DATASC
	mov	cx,48
	mov	si,dx
manas1:	mov	arxasc[si]," "
	inc	si
	loop	manas1
;****************************
	mov	ax,dx
	xor	dx,dx
	mov	bx,48
	div	bx
	mov	di,ax
	mov	klioro[di],0
;****************************
	@CHANGESEGM	ds,DATAS1
	pop	dx
	sub	dx,4
	mov	asthlh,dl
	cmp	dl,19
	je	manas2
	call	prbuf
	jmp	aloop
manas2:	mov	asthlh,75
	dec	bselida
	call	prbuf
	jmp	aloop
Myprog	endp


check_1	proc	near
	@PUSHAX
	mov	cx,13
	xor	ax,ax
	mov	bx,1
filia_2:
	cmp	buffers[bx]," "
	je	filia_1
	inc	ax
filia_1:
	add	bx,3
	loop	filia_2
	cmp	ax,1
	jae	filia_3
	@POPAX
	stc
	ret
filia_3:
	@POPAX
	clc
	ret
check_1	endp

check_oria	proc	near
	@PUSH
	@POP
	stc
	ret
filia_5:
	@POP
	clc
	ret
check_oria	endp

;*****************************************
klidi_do_poke	proc	near
	@PUSH
	mov	al,byte ptr cs:nopit
	mov	byte ptr cs:do_poke,al
	@POP
	retf
nopit:	nop
klidi_do_poke	endp
;*****************************************
CODESG	ends

CODESG2	segment	public

	ASSUME	CS:CODESG2,DS:DATAS1

auristos	proc	near
	@PUSH
	@SETWIND	waurist
	@SELECTWIND	waurist
aur000:	mov	ax,cs:piosaur
	@ITOA	strbuf,2
	@WINPUTNUMBER	22,1,strbuf
	jc	aur001
	@ATOI	strbuf
	cmp	ax,1
	jb	aur000
	cmp	ax,9
	ja	aur000
	jmp	aur002
aur001:	@DELWIND	waurist
	@POP
	retf
aur002:	mov	cs:piosaur,ax
	call	aurist2scr
	call	auristedit
	jmp	aur000
piosaur	dw	1
auristos	endp

auristedit	proc	near
	@PUSH
	mov	ax,piosaur
	dec	ax
	mov	cx,84
	mul	cx
	inc	ax
	inc	ax
	mov	bx,ax
	mov	cs:scry,3
	mov	cx,13
aurs03:	mov	ax,auristikos[bx]
	@ITOA	strbuf,3
aure01:	@WINPUTNUMBER	7,cs:scry,strbuf
	jnc	aurs05
	jmp	aurs00
aurs05:	@ATOI	strbuf
	cmp	ax,100
	ja	aure01
	mov	auristikos[bx],ax

	mov	ax,auristikos[bx+2]
	@ITOA	strbuf,3
aure02:	@WINPUTNUMBER	13,cs:scry,strbuf
	jnc	aurs06
	jmp	aurs00
aurs06:	@ATOI	strbuf
	cmp	ax,100
	ja	aure02
	mov	auristikos[bx+2],ax

	mov	ax,auristikos[bx+4]
	@ITOA	strbuf,3
aure03:	@WINPUTNUMBER	19,cs:scry,strbuf
	jnc	aurs07
	jmp	aurs00
aurs07:	@ATOI	strbuf
	cmp	ax,100
	ja	aure03
	mov	auristikos[bx+4],ax

	add	bx,6
	inc	cs:scry
	loop	aurs97
	jmp	aurs98

aurs97:	jmp	aurs03


aurs98:	mov	ax,auristikos[bx]
	@ITOA	strbuf,4
aure04:	@WINPUTNUMBER	8,17,strbuf
	jnc	aurs08
	jmp	aurs00
aurs08:	@ATOI	strbuf
	cmp	ax,1300
	ja	aure04
	mov	auristikos[bx],ax

	mov	ax,auristikos[bx+2]
	@ITOA	strbuf,4
aure05:	@WINPUTNUMBER	19,17,strbuf
	jnc	aurs09
	jmp	aurs00
aurs09:	@ATOI	strbuf
	cmp	ax,1300
	ja	aure05
	cmp	ax,auristikos[bx]
	jb	aure05
	mov	auristikos[bx+2],ax

aurs00:	@POP
	ret
auristedit	endp

aurist2scr	proc	near
	@PUSH
	mov	ax,piosaur
	dec	ax
	mov	cx,84
	mul	cx
	inc	ax
	inc	ax
	mov	bx,ax
	mov	cs:scry,3
	mov	cx,13
aurs01:	mov	ax,auristikos[bx]
	@ITOA	strbuf,3
	@WPRINT	7,cs:scry,strbuf
	mov	ax,auristikos[bx+2]
	@ITOA	strbuf,3
	@WPRINT	13,cs:scry,strbuf
	mov	ax,auristikos[bx+4]
	@ITOA	strbuf,3
	@WPRINT	19,cs:scry,strbuf
	add	bx,6
	inc	cs:scry
	loop	aurs99
	mov	ax,auristikos[bx]
	@ITOA	strbuf,4
	@WPRINT	8,17,strbuf
	mov	ax,auristikos[bx+2]
	@ITOA	strbuf,4
	@WPRINT	19,17,strbuf
	
	@POP
	ret
aurs99:	jmp	aurs01
scry	db	0
aurist2scr	endp

CODESG2	ends
	end	main
