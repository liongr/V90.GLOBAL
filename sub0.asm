
INCLUDE	equs.h

codesg	segment public

	assume	cs:codesg,ds:datas1

plhrakia	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	mov	si,0
	mov	cx,13
	mov	bx,axbp
	mov	si,0
plr1:	mov	dl,pinsthl[si]
	inc	dl
	mov	axbpin[bx][si],dl
	inc	si
	loop	plr1

	add	axbp,13
	mov	ax,STHLES_DELTIOU
	mov	cx,13
	mul	cx
	cmp	axbp,ax	;n sthles x 13
	jb	plrm1

	call	buffer_full
	mov	axbp,0

plrm1:	@POP
	ret
plhrakia	endp

buffer_full	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1

	cmp	axbp,0
	je	tere12
	cmp	dialogi,0
	je	pr_plr
	
	call	ypologismos_sthlvn
	call	plirakia_dialogi
	@POP
	ret

pr_plr:	call	ypologismos_sthlvn
	call	plirakia_print

tere12:	@POP
	ret
buffer_full	endp

ypologismos_sthlvn	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1

	mov	cx,STHLES_DELTIOU
	mov	bx,4
midenp:	mov	word ptr stlplr[bx],1
	mov	word ptr stlplr[bx+2],0
	add	bx,4
	loop	midenp

	mov	stlplr[0],0
	mov	stlplr[2],0

	mov	bx,0
	mov	di,4	;; thesi 0,2 gia to sinolo
	xor	si,si
plrepom:
	mov	cx,13
plir13: 	mov	dl,axbpin[si]
	cmp	dl,9
	je	is_tripli
	cmp	dl,4
	ja	is_dipli
	jmp	qoqor
is_tripli:	@LMUL	stlplr[di][2],stlplr[di],0,3
	mov	stlplr[di],ax
	mov	stlplr[di][2],dx
qoqor:	inc	si
	loop	plir13
	jmp	epomenoPliraki


is_dipli:	@LMUL	stlplr[di][2],stlplr[di],0,2
	mov	stlplr[di],ax
	mov	stlplr[di][2],dx
	jmp	qoqor

epomenoPliraki:
	@LADDN	stlplr[0],stlplr[di]
	cmp	si,axbp
	jae	tel0
	add	di,4
	jmp	plrepom

tel0:	@LADDN	mexri_tora,stlplr[0]
	cmp	isPlirakiaFULL,1
	je	doTaxinomisiPlirakia
	@POP
	ret
;########################################################################### TAXINOMISI PLIRAKION
doTaxinomisiPlirakia:
	mov	cx,STHLES_DELTIOU
	dec	cx
	mov	bx,4
alosetaki:	@LCMPN	stlplr[bx],stlplr[bx+4]
	jae	MinAllazis
	call	enalagiPlirakia
	jmp	doTaxinomisiPlirakia
	
MinAllazis:	add	bx,4
	loop	alosetaki
	@POP
	ret

enalagiPlirakia:
	@PUSH
	mov	dx,stlplr[bx]
	mov	ax,stlplr[bx+4]
	mov	stlplr[bx],ax
	mov	stlplr[bx+4],dx
	mov	ax,bx
	shr 	ax,2
	dec	ax
	mov	cx,13
	mul	cx
	mov	bx,ax
next01:	mov	dl,axbpin[bx]
	mov	dh,axbpin[bx+13]
	mov	axbpin[bx],dh
	mov	axbpin[bx+13],dl
	inc	bx
	loop	next01
	@POP
	ret
ypologismos_sthlvn	endp


plirakia_screen	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1

	mov	bx,0
	mov	sthlh,6	

	mov	cx,STHLES_DELTIOU	;posa plirakia
plrt99:	mov	grammh,3
	push	cx

onlin2:	mov	cx,13
plrt19:	mov	dl,axbpin[bx]


	call	plr_apcode

	inc	grammh
	cmp	grammh,6
	je	balekeno
	cmp	grammh,10
	je	balekeno
	cmp	grammh,14
	je	balekeno
	cmp	grammh,18
	je	balekeno
	jmp	denpidas
balekeno:	@SELECTWIND	wdeltio_pliraki
	@FILLSTR	strbuf,"Ä",52
	@WPRINT	5,grammh,strbuf
	inc	grammh
denpidas:	inc	bx
	loop	plrt19
;-------------------------------------------------Super13
	cmp	SHMEIA_STHLHS,13	;;;; >13
	jbe	pit134

	call	take_super_apcode
	cmp	dl,0
	je	pit13
	call	plr_apcode

pit13:	cmp	kuponi_xora,FRANCE
	je	isFRANCE 		;;;; +15
	cmp	kuponi_xora,TURKEY
	je	isTURKEY 		;;;; +15
	jmp	pit134
	
isFRANCE:
isTURKEY:
	inc	grammh
	call	take_super_apcode15
	cmp	dl,0
	je	pit134
	call	plr_apcode

pit134:
;---------------------------------------------
	pop	cx
	cmp	bx,axbp
	jb	plrt8
	jmp	plrt09
	
plrt9999:	jmp	plrt99	
	
plrt8:	
	inc	sthlh
;################################################################################################
	cmp	isPlirakiaFULL,0
	je	noFULL
	inc	sthlh
	inc	sthlh
	inc	sthlh
	cmp	STHLES_DELTIOU,10
	jae	stlA4
	cmp	STHLES_DELTIOU,8
	jae	pidato1
	inc	sthlh
pidato1:	inc	sthlh
	jmp	stlA4
	
;################################################################################################
noFULL:
	cmp	STHLES_DELTIOU,20 ;an einai pano apo 20 mhn emfanizeis kena
	ja	stlA4
	inc	sthlh
	inc	sthlh
stlA4:
;################################################################################################	
	loop	plrt9999

plrt09:	@TAKEWIND
	push	ax
	@SELECTWIND	wdeltio_pliraki
	@CHANGESEGM	ds,WINSEGM
	@WPRINT	1,1,wdeltio_pliraki[7]
	@CHANGESEGM	ds,DATAS1
	
	call	kupon_disp

	@LTOAN	ar_deltiou,strbuf
	@WPRINT	26,1,strbuf

	@LTOAN	stlplr[0],strbuf
	@WPRINT	40,1,strbuf

	@LTOAN	mexri_tora,strbuf
	@WPRINT	48,1,strbuf
	
	pop	ax
	@SELECTWI	al
	@POP
	ret
plirakia_screen	endp

plirakia_print	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@INCL	ar_deltiou

	call	plirakia_screen

	@LCMPN	ar_deltiou,ardel
	jae	isbr1
	@CPLRNS
	jc	isbr1
	jmp	ardel9

isbr1:
eje3:	cmp	aytomato_plr,1
	jne	liri
	cmp	protia_prn,0
	jne	liri2
	jmp	liri
liri2:
	call	dimiourgia_deltiou_plr
	call	far ptr ektiposi_plirakia
	jc	liri1
	jmp	ardel9

liri1:	jmp	short liri

belxi:	jmp	ardel9

liri:	@SETWIND	wdelti
	@CLRPLBUF

	@WAITL
	@UPPERAX
	@DELWIND	wdelti
	cmp	al,"T"
	jne	noTTT

aspro:	mov	cx,1000
	mov	bx,0
llrtc:	mov	axbpin[bx],0
	inc	bx
	loop	llrtc
	mov	axbp,0
	mov	sp,fatal_stack
	mov	fatal_stack,0
	@POP
	ret
noTTT:	cmp	al,"P"
	jne	noPPP
	mov	dx,0
	call	far ptr riumisi_ektip
	jmp	liri

noPPP:	cmp	al,"Q"
	jne	noQQQ
	call	dimiourgia_deltiou_plr
	call	far ptr ektiposi_plirakia
	jmp	liri

noQQQ:	cmp	al,"A"
	jne	noAAA
	call	pane_deltio
	mov	protia_prn,0
	jmp	liri

noAAA:	cmp	al,"!"
	jne	no_dd
	@ZEROBBUF	deltio2prn,600,1
	call	far ptr ektiposi_plirakia
	jmp	liri

no_dd:	cmp	al,"E"
	je	ardel9
	jmp	liri

ardel9:	@CLSWIND	wclr_pliraki
;*****************************************
	mov	cx,1000
	mov	bx,0
plrtc9:	mov	axbpin[bx],0
	inc	bx
	loop	plrtc9
	mov	axbp,0
	@POP
	ret
plirakia_print	endp

take_super_apcode	proc	near
	mov	dl,extra_sim14
	cmp	dl,'1'
	jne	pit_1
	mov	dl,2
	jmp	pitt4

pit_1:	cmp	dl,'X'
	jne	pit_x
	mov	dl,3
	jmp	pitt4

pit_x:	cmp	dl,'2'
	jne	pit_2
	mov	dl,4
	jmp	pitt4

pit_2:	mov	dl,0
pitt4:
	ret
take_super_apcode	endp

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

riumisi_ektip	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@TAKEWIND
	push	ax
	@SETWIND	wektip
	@SELECTWIND	wektip

	call	kupon_disp

	mov	bx,offset ektip_plr
	call	riumisi1_ektip
	xor	di,di
	mov	cx,13
	mov	cs:_yyt,4

kakas:	mov	ax,[bx][di]
	@ITOA	strbuf,4
	@WINPUTNUMBER	22,cs:_yyt,strbuf
	@ATOI	strbuf
	mov	[bx][di],ax

	call	riumisi1_ektip

	add	di,2
	inc	cs:_yyt
	loop	kakas

	@DELWIND	wektip
	pop	ax
	@SELECTWI	al
	@POP
	retf
_yyt	db	0
riumisi_ektip	endp

riumisi1_ektip	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1

	mov	cx,13
	mov	cs:_yyd,4
	xor	di,di

kakas22:
	mov	ax,[bx][di]
	@ITOA	strbuf,4
	@WPRINT	22,cs:_yyd,strbuf
	add	di,2
	inc	cs:_yyd
	loop	kakas22

	@POP
	ret
_yyd	db	0
riumisi1_ektip	endp

take_super_apcode15	proc	near
	mov	dl,extra_sim15
	cmp	dl,'1'
	jne	vpit_41
	mov	dl,2
	jmp	vpitt44

vpit_41:
	cmp	dl,'X'
	jne	vpit_4x
	mov	dl,3
	jmp	vpitt44

vpit_4x:
	cmp	dl,'2'
	jne	vpit_42
	mov	dl,4
	jmp	vpitt44

vpit_42:
	mov	dl,0
vpitt44:
	ret
take_super_apcode15	endp

plr_apcode	proc	near		;apokodikopoihsh plhrakia
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@TAKEWIND
	push	ax
	@SELECTWIND	wdeltio_pliraki
	cmp	dl,2
	jb	error
	cmp	dl,9
	ja	error
	jmp	plr_ap1

error:	mov	dl,8	;;; KENO

plr_ap1:	dec	dx
	dec	dx
	mov	ax,dx
	mov	cx,4
	mul	cx
	mov	si,ax
	mov	ax,offset antistplr
	add	si,ax

ass:	@WPRINTSI	sthlh,grammh
ass_1:	pop	ax
	@SELECTWI	al
	@POP
	ret
plr_apcode	endp
;
dimiourgia_deltiou_plr	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@ZEROBBUF	deltio2prn,600,0

	cmp	kuponi_xora,STILESA4
	je	bale_TXT
	cmp	kuponi_xora,PRINT6ADES
	je	bale_TXT
	cmp	kuponi_xora,PRINT4ADES
	je	bale_TXT
	cmp	kuponi_xora,PRINT8ADES
	je	bale_TXT
	cmp	kuponi_xora,PRINT10ADES
	je	bale_TXT
	
	jmp	bale_ASTERAKIA

;#####################################################################################################

bale_TXT:	cmp	isPlirakiaFULL,1
	je	IsFullPliraki
	mov	ax,SHMEIA_STHLHS
	mov	cs:xxx1,ax
	xor	bx,bx
	xor	di,di

xpitt2:	push	bx
	push	di
	mov	cx,SHMEIA_STHLHS

xpitt:	mov	dl,axbpin[bx]
	push	di

	call	put_simia_txt

	pop	di
	inc	bx
	inc	di
	loop	xpitt
	
	pop	di
	add	di,cs:xxx1
	pop	bx
	add	bx,13
	cmp	bx,axbp
	jae	xpitt1
	jmp	xpitt2
	
xpitt1:	@POP
	ret

IsFullPliraki:
	mov	ax,SHMEIA_STHLHS
	mov	cx,3
	mul	cx
	mov	cs:xxx1,ax
	xor	bx,bx
	xor	di,di

Fxpitt2:	push	bx
	push	di
	mov	cx,SHMEIA_STHLHS

Fxpitt:	mov	dl,axbpin[bx]
	push	di

	call	put_simia_txt_Full

	pop	di
	inc	bx
	add	di,3
	loop	Fxpitt
	
	pop	di
	add	di,cs:xxx1
	pop	bx
	add	bx,13
	cmp	bx,axbp
	jae	xpitt1
	jmp	xpitt2
	
Fxpitt1:	@POP
	ret

;#####################################################################################################

bale_ASTERAKIA:
	mov	ax,SHMEIA_STHLHS
	mov	cx,3
	mul	cx
	mov	cs:xxx1,ax
	xor	bx,bx
	xor	di,di

pitt2:
	push	bx
	push	di
	mov	cx,13

pitt:	mov	dl,axbpin[bx]
	push	di

	call	put_simia

	pop	di
	inc	bx
	inc	di
	loop	pitt
;------------------------------------------------- agonas 14
	cmp	SHMEIA_STHLHS,13
	jbe	pitt_1

	call	take_super_apcode
	cmp	dl,0
	je	pit12
	push	di
	
	call	put_simia

	pop	di
;------------------------------------------------- agonas 15
pit12:	cmp	kuponi_xora,FRANCE
	je	isFRANCE_1 		;;;; +15
	cmp	kuponi_xora,TURKEY
	je	isTURKEY_1		;;;; +15
	cmp	kuponi_xora,SPAIN
	je	isSPAIN_1 		;;;; +GKOL 15 [ BUT NO WORKING AT LQ870 ]
	jmp	pitt_1
isFRANCE_1:
isTURKEY_1:
	call	take_super_apcode15
	cmp	dl,0
	je	pitt_1
	push	di
	inc	bx
	inc	di
	call	put_simia
	pop	di
	jmp	pitt_1

;######################################################################### SPAIN
isSPAIN_1:	cmp	WhatPrinter,@EPSONLQ590
	je	IsEpsonLQ590_1
	jmp	IsNot1
IsEpsonLQ590_1:	
	@PUSH
	mov	ax,15
	mov	cx,spain_1
	mul	cx
	mov	bx,ax
	mov	deltio2prn[119][bx],1
	mov	ax,15
	mov	cx,spain_2
	mul	cx
	mov	bx,ax
	mov	deltio2prn[314][bx],1
	@POP
IsNot1:
;#########################################################################

pitt_1:	pop	di
	add	di,cs:xxx1
	pop	bx
	add	bx,13
	cmp	bx,axbp
	jae	pitt1
	jmp	pitt2
	
pitt1:	@POP
	ret

xxx1	dw	0
;**************************************
put_simia:
	cmp	kuponi_xora,AUSTRIA
	jne	is1X2
	call	put_simia12X
	ret
is1X2:	call	put_simia1X2
	ret
;#################################################################################################################
put_simia1X2:				;;;; DELTIA MORFIS "1X2" [ AUSTRIA ]
	cmp	dl,2		;"1  "
	jne	ino_2
	mov	deltio2prn[di],1
	ret
ino_2:	cmp	dl,4		;"  2"
	jne	ino_3
	add	di,SHMEIA_STHLHS
	add	di,SHMEIA_STHLHS
	mov	deltio2prn[di],1
	ret
ino_3:	cmp	dl,3		;" X "
	jne	ino_4
	add	di,SHMEIA_STHLHS
	mov	deltio2prn[di],1
	ret
ino_4:	cmp	dl,5		;"1X "
	jne	ino_5
	mov	deltio2prn[di],1
	add	di,SHMEIA_STHLHS
	mov	deltio2prn[di],1
	ret
ino_5:	cmp	dl,6		;"1 2"
	jne	ino_6
	mov	deltio2prn[di],1
	add	di,SHMEIA_STHLHS
	add	di,SHMEIA_STHLHS
	mov	deltio2prn[di],1
	ret
ino_6:	cmp	dl,7		;" X2"
	jne	ino_7
	add	di,SHMEIA_STHLHS
	mov	deltio2prn[di],1
	add	di,SHMEIA_STHLHS
	mov	deltio2prn[di],1
	ret
ino_7:	cmp	dl,9		;"1X2"
	jne	ino_9
	mov	deltio2prn[di],1
	add	di,SHMEIA_STHLHS
	mov	deltio2prn[di],1
	add	di,SHMEIA_STHLHS
	mov	deltio2prn[di],1
	ret

ino_9:	ret
;#################################################################################################################
put_simia12X:				;;; DELTIA MORFIS "12X"
	cmp	dl,2		;"1  "
	jne	ino_20
	mov	deltio2prn[di],1
	ret
ino_20:	cmp	dl,4		;" 2 "
	jne	ino_30
	add	di,SHMEIA_STHLHS
	mov	deltio2prn[di],1
	ret
ino_30:	cmp	dl,3		;"  X"
	jne	ino_40
	add	di,SHMEIA_STHLHS
	add	di,SHMEIA_STHLHS
	mov	deltio2prn[di],1
	ret
ino_40:	cmp	dl,5		;"1 X"
	jne	ino_50
	mov	deltio2prn[di],1
	add	di,SHMEIA_STHLHS
	add	di,SHMEIA_STHLHS
	mov	deltio2prn[di],1
	ret
ino_50:	cmp	dl,6		;"12 "
	jne	ino_60
	mov	deltio2prn[di],1
	add	di,SHMEIA_STHLHS
	mov	deltio2prn[di],1
	ret
ino_60:	cmp	dl,7		;" 2X"
	jne	ino_70
	add	di,SHMEIA_STHLHS
	mov	deltio2prn[di],1
	add	di,SHMEIA_STHLHS
	mov	deltio2prn[di],1
	ret
ino_70:	cmp	dl,9		;"1X2"
	jne	ino_90
	mov	deltio2prn[di],1
	add	di,SHMEIA_STHLHS
	mov	deltio2prn[di],1
	add	di,SHMEIA_STHLHS
	mov	deltio2prn[di],1
	ret

ino_90:	ret
;#################################################################################################################

put_simia_txt:					; TXT - EKTYPOSI SE A4
	cmp	dl,2
	jne	no_21
	mov	deltio2prn[di],"1"
	ret
no_21:	cmp	dl,3
	jne	no_31
	mov	deltio2prn[di],"0"
	ret
no_31:	cmp	dl,4
	jne	no_41
	mov	deltio2prn[di],"2"
	ret
no_41:	mov	deltio2prn[di]," "
	ret

put_simia_txt_Full:					; TXT - EKTYPOSI SE A4 PLIRAKIA FULL
	cmp	dl,2
	jne	fno_21
	mov	deltio2prn[di],"1"
	add	di,STHLES_DELTIOU
	mov	deltio2prn[di]," "
	add	di,STHLES_DELTIOU
	mov	deltio2prn[di]," "
	ret
fno_21:	cmp	dl,3
	jne	fno_31
	mov	deltio2prn[di],"0"
	add	di,STHLES_DELTIOU
	mov	deltio2prn[di]," "
	add	di,STHLES_DELTIOU
	mov	deltio2prn[di]," "
	ret
fno_31:	cmp	dl,4
	jne	fno_41
	mov	deltio2prn[di],"2"
	add	di,STHLES_DELTIOU
	mov	deltio2prn[di]," "
	add	di,STHLES_DELTIOU
	mov	deltio2prn[di]," "
	ret
fno_41:	cmp	dl,5
	jne	fno_51
	mov	deltio2prn[di],"1"
	add	di,STHLES_DELTIOU
	mov	deltio2prn[di],"O"
	add	di,STHLES_DELTIOU
	mov	deltio2prn[di]," "
	ret
	
fno_51:	cmp	dl,6
	jne	fno_61
	mov	deltio2prn[di],"1"
	add	di,STHLES_DELTIOU
	mov	deltio2prn[di],"2"
	add	di,STHLES_DELTIOU
	mov	deltio2prn[di]," "
	ret
	
fno_61:	cmp	dl,7
	jne	fno_71
	mov	deltio2prn[di],"0"
	add	di,STHLES_DELTIOU
	mov	deltio2prn[di],"2"
	add	di,STHLES_DELTIOU
	mov	deltio2prn[di]," "
	ret
	
fno_71:	cmp	dl,9
	jne	fno_91
	mov	deltio2prn[di],"1"
	add	di,STHLES_DELTIOU
	mov	deltio2prn[di],"O"
	add	di,STHLES_DELTIOU
	mov	deltio2prn[di],"2"
	ret
	
fno_91:	mov	deltio2prn[di]," "
	add	di,STHLES_DELTIOU
	mov	deltio2prn[di]," "
	add	di,STHLES_DELTIOU
	mov	deltio2prn[di]," "
	ret
dimiourgia_deltiou_plr	endp

codesg	ends

;************************************************************

codesg5	segment	public

	 assume	cs:codesg5,ds:datas1

ektiposi_plirakia	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	
	mov	cs:print_stack5,sp
	mov	ax,offset lptnames
	mov	lpt_number,ax

	cmp	aytomato_plr,0
	jne	isauto
	jmp	oxiayt

isauto:	mov	protia_prn,1

oxiayt:	
;***********************************************************
	cmp	kuponi_xora,STILESA4
	jne	kanoniko_kuponi
	call	far ptr ekt_StilesA4
	jmp	epistrof
kanoniko_kuponi:
;-------------------------------------------------> Start
	@LPRINT_START	lpt_number
;-------------------------------------------------------------> Reset
	@LPRINTSTR	prn_reset,lpt_number,cs:print_stack5
;-------------------------------------------------------------> Aristero periuorio
	mov	ax,riumisi_aris_plr
	call	far ptr do_left_mergin
;-------------------------------------------------------------> Arxiki proouisi
	mov	ax,riumisi_pano_plr
	call	far ptr do_proouisi
;-------------------------------------------------------------
	mov	ax,kena_kaueta_plr
	call	far ptr do_vertical_space
	mov	ax,kena_orizontia_plr
	call	far ptr do_horizontial_space
;-------------------------------------------------------------
	@LPRINTSTR	prn_expanded_on,lpt_number,cs:print_stack5
	@LPRINTSTR	prn_set_10cpi,lpt_number,cs:print_stack5

	call	far ptr ektiposi_pliraki_4

egine:	@LPRINTSTR	prn_formfeed,lpt_number,cs:print_stack5
	@LPRINTSTR	prn_reset,lpt_number,cs:print_stack5
	@LPRINT_STOP

epistrof:	cmp	aytomato_plr,0
	je	oxiat1
	@WAIT	anamoni_plr
oxiat1:	@CLRPLBUF
	@POP
	retf
ektiposi_plirakia	endp

ektiposi_pliraki_4	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1

	cmp	kuponi_xora,AUSTRIA
	jne	kup_n0
	call	far ptr ekt_Austria
	@POP
	retf

kup_n0:	cmp	kuponi_xora,CROATIA
	jne	kup_n1
	call	far ptr ekt_Croatia
	@POP
	retf

kup_n1:	cmp	kuponi_xora,GERMANY
	jne	kup_n2
	call	far ptr ekt_Germany
	@POP
	retf	

kup_n2:	cmp	kuponi_xora,GERMANY1
	jne	kup_n3
	call	far ptr ekt_Germany_1
	@POP
	retf	

kup_n3:	cmp	kuponi_xora,FRANCE
	jne	kup_n4
	call	far ptr ekt_France
	@POP
	retf	

kup_n4:	cmp	kuponi_xora,HUNGAR
	jne	kup_n5
	call	far ptr ekt_Hungar
	@POP
	retf	

kup_n5:	cmp	kuponi_xora,SERBIA
	jne	kup_n6
	call	far ptr ekt_Serbia
	@POP
	retf	

kup_n6:	cmp	kuponi_xora,SPAIN
	jne	kup_n7
	call	far ptr ekt_Spain
	@POP
	retf	

kup_n7:	cmp	kuponi_xora,SWEDEN
	jne	kup_n8
	call	far ptr ekt_Sweden
	@POP
	retf	

kup_n8:	cmp	kuponi_xora,SWISS
	jne	kup_n9
	call	far ptr ekt_Swiss
	@POP
	retf	

kup_n9:	cmp	kuponi_xora,PRINT4ADES
	je	fffind
	cmp	kuponi_xora,PRINT6ADES
	je	fffind
	cmp	kuponi_xora,PRINT8ADES
	je	fffind
	cmp	kuponi_xora,PRINT10ADES
	je	fffind
	jmp	kup_n10
	
fffind:	cmp	isPlirakiaFULL,0
	je	isNormalStiles
	call	far ptr ekt_PlirakiaFull_N_ades
	@POP
	retf
	
isNormalStiles:
	call	far ptr ekt_Print_N_ades
	@POP
	retf

kup_n10:	cmp	kuponi_xora,ITALY
	jne	kup_n11
	call	far ptr ekt_Italy
	@POP
	retf	

kup_n11:	cmp	kuponi_xora,BULGARIA
	jne	kup_n12
	call	far ptr ekt_Bulgaria
	@POP
	retf	

kup_n12:	cmp	kuponi_xora,RUMANIA
	jne	kup_n13
	call	far ptr ekt_Rumania
	@POP
	retf	

kup_n13:	cmp	kuponi_xora,TURKEY
	jne	kup_n14
	call	far ptr ekt_Turkey
	@POP
	retf	

kup_n14:	cmp	kuponi_xora,PORTUGAL
	jne	kup_n15
	call	far ptr ekt_Portugal
	@POP
	retf	

kup_n15:	cmp	kuponi_xora,GREECE
	jne	kup_n16
	call	far ptr ekt_Greece
	@POP
	retf	

kup_n16:	@POP
	retf	
ektiposi_pliraki_4	endp

check_s14	proc	near
	@PUSH
	mov	dl,extra_sim14
	cmp	dl,'1'
	jne	pit_11
	cmp	cx,13
	jne	ojo1
	@LPRINTCHR	prchar_plr,lpt_number,cs:print_stack5
	jmp	ojo2

pit_11:	cmp	dl,'X'
	jne	pit_x1
	cmp	cx,11
	jne	ojo1
	@LPRINTCHR	prchar_plr,lpt_number,cs:print_stack5
	jmp	ojo2

pit_x1:	cmp	dl,'2'
	jne	ojo1
	cmp	cx,9
	jne	ojo1
	@LPRINTCHR	prchar_plr,lpt_number,cs:print_stack5
	jmp	ojo2

ojo1:	@LPRINTCHR	" ",lpt_number,cs:print_stack5
ojo2:	@POP
	retf
check_s14	endp

ekt_stand_riumisi	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	@LPRINTSTR	prn_can_conden,lpt_number,cs:print_stack5
	@LPRINTSTR	prn_set_10cpi,lpt_number,cs:print_stack5
	mov	ax,kena_kaueta_plr
	call	far ptr do_vertical_space
	mov	ax,kena_orizontia_plr
	call	far ptr do_horizontial_space
	@POP
	retf
ekt_stand_riumisi	endp

ekt_plirof	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	mov	ax,0
	call	far ptr do_horizontial_space
	@LPRINTSTR	prn_set_12cpi,lpt_number,cs:print_stack5
	@LPRINTSTR	prn_set_conden,lpt_number,cs:print_stack5
	@LTOAN	ar_deltiou,strbuf
	@LPRINTSTR	strbuf,lpt_number,cs:print_stack5
	@LPRINTCHR	"-",lpt_number,cs:print_stack5
	@LTOAN	stlplr[96],strbuf
	@LPRINTSTR	strbuf,lpt_number,cs:print_stack5
	@LPRINTSTR	prn_line_feed,lpt_number,cs:print_stack5
	@LPRINTSTR	prn_set_10cpi,lpt_number,cs:print_stack5
	@LPRINTSTR	prn_can_conden,lpt_number,cs:print_stack5
	mov	ax,kena_orizontia_plr
	call	far ptr do_horizontial_space
	@POP
	retf
ekt_plirof	endp

make_orizontia_riumisi_printer proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	xor	dx,dx
	mov	ax,cx
	mov	cx,endiam_oriz_plr
	cmp	cx,0
	je	is_or_kirios
	div	cx
	cmp	dx,0
	je	is_or_endiameso
is_or_kirios:
	mov	ax,kena_orizontia_plr
	call	far ptr do_horizontial_space
	@POP
	retf

is_or_endiameso:
	mov	ax,kena_oriz_end_plr
	call	far ptr do_horizontial_space
	@POP
	retf
make_orizontia_riumisi_printer endp

make_kaueti_riumisi_printer proc near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	xor	dx,dx
	mov	ax,cx
	mov	cx,endiam_kau_plr
	cmp	cx,0
	je	is_ka_kirios
	div	cx
	cmp	dx,0
	je	is_ka_endiameso
is_ka_kirios:
	mov	ax,kena_kaueta_plr
	jmp	do_kaueto
is_ka_endiameso:
	mov	ax,kena_kaueta_end_plr
do_kaueto:
	call	far ptr do_vertical_space
	@LPRINTSTR	prn_line_feed,lpt_number,cs:print_stack5
	@POP
	retf
make_kaueti_riumisi_printer endp

do_proouisi	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	cmp	ax,0
	jne	isnt0
	jmp	is_miden
isnt0:	mov	cs:_temp,al
	cmp	ax,40
	ja	is_big
	jmp	is_nmiden
is_big:	xor	dx,dx
	mov	cx,40
	div	cx
	mov	cs:_temp,dl
	mov	cx,ax
	mov	ax,40
	call	far ptr do_vertical_space
nxtsm:
	@LPRINTSTR	prn_line_feed,lpt_number,cs:print_stack5
	loop	nxtsm
is_small:
	cmp	cs:_temp,0
	jne	is_nmiden
	jmp	is_miden
is_nmiden:
	mov	ah,0
	mov	al,cs:_temp
	call	far ptr do_vertical_space
	@LPRINTSTR	prn_line_feed,lpt_number,cs:print_stack5

is_miden:	@POP
	retf
_temp	db	0
do_proouisi	endp

do_horizontial_space	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	cmp	ax,0
	je	ax_isss_0
	@LPRINTSTR	prn_hori_space,lpt_number,cs:print_stack5
	@LPRINTCHR	al,lpt_number,cs:print_stack5
ax_isss_0:	@POP
	retf
do_horizontial_space	endp

do_vertical_space	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	cmp	ax,0
	je	ax_is_0
	@LPRINTSTR	prn_vert_space,lpt_number,cs:print_stack5
	@LPRINTCHR	al,lpt_number,cs:print_stack5
ax_is_0:	@POP
	retf
do_vertical_space	endp

do_left_mergin	proc	near
	@PUSH
	@CHANGESEGM	ds,DATAS1
	cmp	ax,0
	je	ax_iss_0
	@LPRINTSTR	prn_left_mergin,lpt_number,cs:print_stack5
	@LPRINTCHR	al,lpt_number,cs:print_stack5
ax_iss_0:	@POP
	retf
do_left_mergin	endp

codesg5	ends
	end
