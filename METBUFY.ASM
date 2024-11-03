
INCLUDE	equs.h

DATAS1	segment	public
;#############################################################################################
;#############################################################################################

;************************************************************************************************ Ektyposh Deltiou
lptfile	db	"lptinfo.ini",0

lptnames	label	byte
	db	"lpt2",0,0,0,0,0,0,0,0,0,0,0
	db	"lpt3",0,0,0,0,0,0,0,0,0,0,0
	db	"lpt4",0,0,0,0,0,0,0,0,0,0,0
	db	"DELTIO.TXT",0,0,0,0,0

lpt_number	dw	offset lptnames

prn_reset		db	27,64,27,"M",27,15,0,0,0,0	;prn_reset
prn_formfeed	db	12,0,0,0,0,0,0,0,0,0		;prn_formfeed
prn_left_mergin	db	27,"l",0,0,0,0,0,0,0,0		;prn_left_mergin
prn_vert_space	db	27,"3",0,0,0,0,0,0,0,0		;prn_vert_space
prn_hori_space	db	27," ",0,0,0,0,0,0,0,0		;prn_hori_space
prn_set_10cpi	db	27,"P",0,0,0,0,0,0,0,0		;prn_set_10cpi
prn_set_12cpi	db	27,"M",0,0,0,0,0,0,0,0		;prn_set_12cpi
prn_set_conden	db	27,15,0,0,0,0,0,0,0,0		;prn_set_conden
prn_can_conden	db	27,18,0,0,0,0,0,0,0,0		;prn_can_conden
prn_line_feed	db	10,13,0,0,0,0,0,0,0,0		;prn_line_feed
prn_expanded_on	db	27,"W","1",0,0,0,0,0,0,0 	;prn_expanded_on
prn_expanded_off	db	27,"W","0",0,0,0,0,0,0,0 	;prn_expanded_off
prn_relative_horiz_pos	db	27,"\",0,0,0,0,0,0,0,0
prn_absolute_horiz_pos	db	27,"$",0,0,0,0,0,0,0,0
prn_relative_vert_pos	db	27,"(","v",0,0,0,0,0,0,0
prn_absolute_vert_pos	db	27,"(","V",0,0,0,0,0,0,0
prn_stilesA4	db	27,64,27,"P",27,"W","1",27,"3",30,27," ",4,0
prn_stl_Selida	db	0
prn_str_prsel	dw	0
;*******************************************************
ektip_plr		label	word
aytomato_plr	dw	1
anamoni_plr		dw	1
riumisi_pano_plr	dw	1
riumisi_aris_plr	dw	1
kena_kaueta_plr	dw	1
kena_kaueta_end_plr	dw	1
kena_orizontia_plr	dw	1
kena_oriz_end_plr	dw	1
prchar_plr		dw	1
endiam_kau_plr	dw	1
endiam_oriz_plr	dw	1
kena_info_plr	dw	1
kena_info1_plr	dw	1
ektip_save		dw	30 dup(13 dup(5));
;************************************************************************************************

cprgt0	db	" GREECE & SERBIA "
cprgt1	db	" LEONIDAS DUSAN  "
mload	db	"PUNENJE SISTEMA",0
mascii	db	"PUNENJE SISTEMA ASCII",0
mplirakia	db	"PUNENJE PLIRAKIA DLT",0
mypmnimi	db	"POSTOJI SISTEM U MEMORIJI",0
mnaapou	db	"?? GA DA SKLADIRAM  ??",0
myparx1	db	"POSTOJI SISTEM SA ISTOM IMENOM",0
myparx2	db	"DA GA IZBRISEM?",0
mmetatr1	db	"ZAMENA KOLONE SA USLOVIMA",0
mmetatr2	db	"USLOVI SISTEM CE MEMORIJE",0
mdokim1	db	"BROJENJE IZ MEMORIJE",0
mdokim2	db	"??  PROBA BROJENJA  ??",0
mmnimi1	db	"PREKIDAC MEMORIJE",0
mmnimi2	db	"??  IZBOR MEMORIJE  ??",0
mmnimi3	db	"??  PONISTENJE MEMORIJE  ??",0
msbise	db	"BRISANJE GRUPE",0
mprint_A4	db	"PRINTING KOLONE A4?",0
mantiksim	db	"ZAMENA 1X2",0
mallage	db	"ZAMENA GRUPE",0
maloria	db	"ZAMENA GRANICE",0
mantigr	db	"PREPIS GRUPE",0
mejodos	db	"ZAVRSETAK RADA",0
msigor	db	"??  JESTE LI SIGURAN  ??",0
mpatapl	db	"PRITISNITE JEDNU TIRKU",0
mypolog	db	"RACUNAM...",0
mdelsys	db	"BRISANJE SISTEMA",0
mdelm	db	"IZBRISACU ARHIVU ",12 dup(0)
mtelos	db	"KRAJ....PRITISNITE 'T'",0
mhnplhr 	db	"  CELOVITI                                GRUPA    TERM     # OBAVEZ #",0
omada   	db	"  GRUPA    USLO      OD      DO           GRUPA    USLO      OD      DO    ",0
omadb   	db	"  GRUPA   GRUPE      OD      DO   ",0
omadea  	db	"ZBIR USLOVA:                       G R U P E",0
omadeb  	db	"                               S U P E R G R U P E",0

prnfile	db	"V99-TMP.PRN",0
infofile	db	"V99.INF",0
filetemp	db	"\V90\AUTOSAVE.V99",0
disk	db	"\V90\*.V99",0
disk_asc	db	"\ASCII\*.TLK",0
disk_Plirakia db	"\ASCII\*.DLT",0
fileSaveMetablites db	"\V90\V99.MTL",0

antist_screen db	" 1O2 "         	;apokodikopiisi stilvn o8oni
antist	db	" 1X2 "		;apokodikopiisi stilvn (px metrapoph se oro)

antistplr	label	byte		;apokodikopiisi plirakia FULL
	db	"1  ",0		;2
	db	"0  ",0		;3
	db	"2  ",0		;4
	db	"10 ",0		;5
	db	"12 ",0		;6
	db	"02 ",0		;7
	db      	"   ",0		;8
	db	"102",0		;9	

mhnhm	db	" OD",0
	db	" DO",0
	db	"N/O",0
	db	"GRUPA",0

leonid	db	"O   GRUPE     "
	db	"PNAJIZMENICNE "
	db	"QSIMETRICNO   "
	db	"R   OPSTIPOKAZ"
	db	"SZBIR         "
	db	"U   GR DUPLE  "
	db	"\GR 1X2       "
	db	"2GR NAJIZMEN  "
	db	"3POSTOJ.SIM   "
	db	"ATEZINA       "
	db	"4PAROVI U NIZU"
	db	"5   OPST.NIZU "
	db	"6POJ.USLOVA   "
	db	"&   POJ.US.x N"
	db	"{TROJKE U NIZU"
	db	"VATHRISTIKOS  "
	db	"!   AXONES  ! "
	db	"$   MONADES $ "
	db	"|PAKET KOLONE "
	db	"~   DUSAN2  ~ "
	db	"I   DUSAN3  I "
	db	"/   DUSAN4  / "
	db	"@   DUSAN5  @ "

;;	db	"@MONADES  1X2 "  -> $
;;	db	"1OSKE         "  -> !
;;	db	"NDUSAN2     N "  -> ~
;;	db	"7DUSAN3     7 "  -> I
;;	db	"JDUSAN4     J "  -> /
	db	0

aurmsg	db	"  1   X   2    ",0
mesfor12	db	"PROMENLJIVO ZA ",0

kuponi_str	db	"AUSTRIA      ",0
	db	"HRVATSKA     ",0 
	db	"BRD MINCHEN  ",0
	db	"BRD STUTGART ",0
	db	"FRANCE       ",0
	db	"MADJARSKA    ",0
	db	"SRBIJA 1     ",0
	db	"BUGARSKA     ",0
	db	"ESPANIA      ",0
	db	"SWEDEN       ",0
	db	"SWISS        ",0
	db	"ITALY        ",0
	db	"KOLONE 6     ",0
	db	"KOLONE A4    ",0
	db	"ROUMANIA     ",0
	db	"KOLONE 4     ",0
	db	"KOLONE 8     ",0
	db	"KOLONE 10    ",0
	db	"TURKEY       ",0
	db	"PORTUGAL     ",0
	db	"GREECE       ",0

;#############################################################################
Metablites4SaveStart	label	byte
;#############################################################################

STHLES_DELTIOU dw	4
SHMEIA_STHLHS dw	13
emfanejo	db	".",0
metraAscii	db	0
FileMetraAscii	db 25 dup(" "),0
WhatPrinter	db	0
PaketOroApo	dw	0
PaketOroEos	dw	0
PaketOroStiles dw	0
;******************************************************
asciidisk	db	"\ASCII\"
asciiname	db	15 dup(" "),0
;******************************************************
filedisk 	db	"\V90\"
filename 	db	15 dup(" "),0
;******************************************************
Plirakiadisk db	"\ASCII\"
Plirakianame db	15 dup(" "),0
;******************************************************
strbuf	db	100 dup(0)
protapo	dw	0,0
protevs	dw	0,0
protop	db	15 dup(0)
protodrx 	dw	0,0
pejeproto 	db	0
coundq	dw	0,0
pokeplr 	dw	0

antistixia 	db	1,2,3,4,5,6,7,8,9,10,11,12,13

tipos_orou 	db	"W",0

errorpl	db	0
komad1	dw	0
es_point 	dw	0
ds_point 	dw	0
dialogp 	dw	0,0

metatropi_se_basikes	db	0
swiss_1	dw	0
swiss_2	dw	0
spain_1	dw	0
spain_2	dw	0
Austria_uesi db	6,7,8,9,10,11,12,13
Austria_uesi_onoff db	1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0
kuponi_xora	db	0
extra_sim14	db	"   ",0
extra_sim15	db	"   ",0
	db	10 dup(0)
;*******************************************************
pindial 	db	13 dup(1)
klidoma_prot  db	0
stilmn	dw	0
casc2oro	dw	0
pokmetbl 	dw	0
aromad	db	20 dup(0)
sigoyra 	db	0
buffers 	db	47 dup(" "),"*"
buffer	db	47 dup(" "),"*"
prog	dw	50 dup(0)
pinplhr	db	39 dup(" "),0	;sthn plhra
;******************************************************* AURISTIKOI PINAKES
auristikos	dw	10 dup(0,39 dup(100),0,1300)   ;flag,39pososta,apo,eos
deltio2prn	db	1500 dup(0)

;#############################################################################################
;SAVE START
;#############################################################################################
saveheader	label byte
	db	10,13
	db	"*************************************************",10,13
	db	"**      (C)Copyright 1988-2024  PROPO V90      **",10,13
	db	"** TZORTZAKIS DIMITRIS - PAPADOPOYLOS LEONIDAS **",10,13
	db	"*************************************************",10,13
	db	26
mversion	dw	2024,03
saveinf	db	5 dup(59 dup(" "),0)		;Plirofories

savestart	label byte
buf_protasi	db	19 dup(39 dup(" "),0)		;Protaseis
cound	dw	0,0			;Ariumos Sthlvn
pinak1	dw	108 dup(0)			;Omadopoihsh
pinak2	db	34 dup("*")			;   ""
pinak3	db	12 dup(0)			;   ""
stili	db	0			;Editor
asthlh	db	23			;  ""
selida	dw	0			;  ""
bselida 	dw	0			;  ""
arxascii	dw	0			;Pointer tou Arxasc
arbuf	dw	0			;Ariumos Buffers gia Mnhmh
memory	db	0			;Mnhmh...1=nai..0=oxi
exomnimi	db	0
	db	0,0			;...
;#############################################################################################
;SAVE START [synexizi o pinakas arxasc]
;#############################################################################################


;**************************************************************************
;*********************   METABLHTES POY MHDENIZONTAI MAZIKA
;**************************************************************************
arxhm	label	byte		;ARXH MHDENISMOY METABLHTON
;**************************************************************************
axbpin	db	10000 dup(0)	;buffer plirakia
fatal_stack	dw	0
mexri_tora	dw	0,0
point_bx 	dw	0,0
point_si 	dw	0,0
segm	db	0
antig	db	14 dup(0)
cbyte	db	0
point	db	0
ubyte	db	0
upoint	db	0
stand	db	13 dup(0)
tajin	dw	0
epitixies 	db	22 dup(0)
epig	db	13 dup(0)
sepig	dw	15 dup(0)
metabl	db	0
metablhths 	db	0,0
filtra	dw	0,0
pin_ues_met db	13 dup(0),0		;uesis metablhtoy...
sel	db	0
artyor	dw	0
bin	dw	0
ayjhse	dw	0
synor	dw	0
sthlh	db	0
grammh	db	0
plktr	dw	0	;plhktro
bufpik	db	200 dup(0)	;omades protasevn
pinmet	db	5100 dup(0)	;pinakas metablhtoy
metp	dw	0
chfioa	db	0
chfiob	db	0
chfioc	db	5 dup(0),0
poipro	dw	0
callipr 	dw	400 dup(0)	;protaseis
callpro 	dw	800 dup(0)	;protaseis
pinprot 	db	400 dup(0)	;protaseis
comom	db	0,0
axbp	dw	0	;pointer toy axbpin
pinbil	dw	600 dup(0)	;binelikia (elegxos)
pinbil1	dw	6 dup(0)	;binelikia (shmeia ana uesh+paragoga)
pinak	dw	0
buf24	db	315 dup(0)	;gia thn proc deltyp
klitaj	dw	0
mastos	db	0
stlplr	dd	50 dup(0)	;stiles sta plirakia
deltio	dw	0,0
ar_deltiou 	dw	0,0	; ariumos deltiou
ardel	dw	0,0	; pane ston ariumo deltiou ('1')
shmeadel 	db	0
pointp	dw	0
pdata	dw	0	;deikths toy arxdat
pplhr	dw	0	;sthn tajasc
komad	db	0	;sthn tajasc
mapo	db	0	;perna o oros...1=oxi..0=nai
poros	dw	0,0
noxi	db	0
	dw	10 dup(0)
pinsthl 	db	15 dup(0)	;sthn plhra
pinsthl1 	db	15 dup(0)
pinsthl3	db	20 dup(0)
ypoxr	dw	0	;ariumos ypoxreotikvn orvn
comast	dw	0	;ariumos orvn poy perasan se omada
porel	dw	0	;pointer toy pinaka pinbil gia elegxo E
sofi	db	0
skata	db	0
ypor	dw	0
ypor1	dw	0
plr	dw	0
pror	db	0
asor	dw	0
omor	db	5 dup(0)
poson	dw	0,0
mema	db	0
emfan	db	0
g_emf	dw	0
shmbas	db	0
shmea_diplh db	0
shmea1	db	0
shmea2	db	0
shmea3	db	0
shmea4	db	0
shmea5	db	0
shmea6	db	0
shmea7	db	0
shmea8	db	0
shmea9	db	0
shmea10 	db	0
shmea11 	db	0
shmea12 	db	0
shmea13 	db	0
shmeat	db	0
dialogi	db	0
gen_buf	db	200 dup(0)
protia_prn	dw	0
clr_win	db	0
elepin	db	100 dup(0)
IsPlirakiaFULL db	0
;**************************************************************************
telosm	db	0       ;------------- TELOS MIDENISMOY METABLITON
;**************************************************************************
Metablites4SaveEnd	label	byte

DATAS1	ends

;#############################################################################################
;#############################################################################################

DATANA	segment public
datanarxh 	db	0
arxdat	db	BUFDATA dup(0)	;PINAKAS DATA
datanend 	db	0
DATANA	ends

;#############################################################################################
;#############################################################################################

DATASC	segment public
arxasc	db	BUFASCII dup(0)	;PINAKAS ASCII
klioma	db	34 dup(0)		;klidoma omadvn *
kliype	db	4 dup(0)		;  ""	   ""  a,b,c,d
klioro	db	1350 dup(0)		;  ""	 orvn
DATASC	ends

;#############################################################################################
;#############################################################################################

WINSEGM	segment public
whelp	db	1,0,0,78,23,07h,1
	db	0
	db      	"   0 ..NOVI CELOVIT         P ..NAIZMENICNE SMENE    Q ..SIMETRICNO",0
	db      	"   W ..GLAVNA KOLONA        \ ..GRUPE 1x2            M ..PROMENLJIVO",0
	db      	"   O ..GRUPE ZNAKOVA        U ..GRUPE PAROVA         R ..OPSTI PROIZVODI",0
	db      	"   L ..PROIZVODI            Z ..NEPARNE-PARNE        Y ..GRUPE U NIZU",0
	db      	"   A ..TEZINA 1x2 - 102     S ..ZBIR 1x2 - 012       D ..ZBIR SVIH POLAZAJA",0
	db      	"   | ..PAKET KOLONE         2 ..GRUPE NAJIZMENICNE   3 ..U NIZU SIMETRICNE",0
	db	"   4 ..PAROVI U NIZU        5 ..OPSTI NIZ            6 ..POJAVA USLOVA",0
	db	"   { ..TROJKE U NIZU        X ..U NIZU               & ..POJAVA USLOVA x N",0
	db	"   % ..U NIZU NAIZMENICNE   } ..NAIZM.SVIH POLAZAJA  V ..ZNAKOVI 1X2 %",0
	db	"   ! ..OSOVINA AXONES       ( ..DEVET-9-             ) ..DVADESESET SEDAM-27",0
	db	"   H ..STAB.PAR.SA USLOVA   K ..STAB.PAR.BEZ USLOVA  $ ..ZBIR ZNAKOVA",0
	db	"   ~ ..DUSAN 2              / ..DUSAN 4              B ..TROJNI PRIKAZ",0
	db      	"   I ..DUSAN 3              @ ..DUSAN 5 ",0
	db	"ƒ",1
	db	"   G ..BROJ KOLONA          8 ..DOBITNA KOLONA       ; ..GRUPACIJA",0
	db      	"   C ..TABLA PROVERE        , ..ODABIRANJE EKRANU    9 ..ARHIVE",0
	db      	"   E ..PROVERA SISTEMA      ? ..KOLONE U MEMORIJI    = ..PRINTER",0
	db      	"   F ..KOLONE NA EKRANU     ] ..KOREKCIJA USLOVA     # ..DOBITNI KUPONI",0
	db	"   > ..PAK.KOLONE OD-DO     ^ ..INFORMACIJE          [ ..TOOLS",0
	db	"ƒ",1
tstcpr5	db	"    1988-2024 TZORTZAKIS DIMITRIS & PAPADOPOULOS LEONIDAS & DUSAN JANKOVIC",0
	db	0,0

tstcpr4	label byte
XORDATA	<    1988-2024 TZORTZAKIS DIMITRIS & PAPADOPOULOS LEONIDAS>,27
	db	0

wutils	db	21,30,1,30,22,70h,2
	db	"          T O O L S",0
	db	0
	db	"  1 ..CHANGE FILTER",0
	db	"  2 ..FILTER FROM KOLONE",0
	db	"  3 ..FILTER KOLONE 3334",0
	db	"  E ..FILTER KOLONE 3442",0
	db	"  F ..FILTER KOLONE 4441",0
	db	"  4 ..CHANGE GROUP",0
	db	"  5 ..COPY GROUP",0
	db	"  6 ..DELETE GROUP",0
	db	"  7 ..CHANGE OD-DO",0
	db	"  8 ..CHANGE 1X2",0
	db	"  9 ..GROUP X FILTER",0
	db	0
	db	"  A ..PINAKA TEZINA",0
	db	"  X ..ZAMENA ZNAKOVA 1-2 2-1",0
	db	"  V ..ZAMENA ZNAKOVA X-1 1-X",0
	db	"  N ..ZAMENA ZNAKOVA 2-X X-2",0
	db	0
	db	"  O ..SAVE ASCII (TXT)",0
	db	"  G ..SAVE ASCII SUPER (TLK)",0
	db	"  C ..FILTER-PACK",0
	db	0
	
wektiposis	db	22,30,1,19,22,70h,2
	db	"     K U P O N",0
	db	0
	db	"  A - AUSTRIA",0
	db	"  B - HRVATSKA",0
	db	"  C - BRD MUNCHEN",0
	db	"  D - BRD STUTGART",0
	db	"  E - FRANCE",0
	db	"  F - MADJARSKA",0
	db	"  G - SRBIJA",0
	db	"  H - BUGARSKA",0
	db	"  I - ESPANIA",0
	db	"  J - SWEDEN",0
	db	"  K - SWISS",0
	db	"  L - ITALY",0
	db	"  O - RUMANIA",0
	db	"  S - TURKEY",0
	db	"  T - PORTUGAL",0
	db	"  U - GREECE",0
	db	0
	db	"  P: 4  M: 6  Q:8",0
	db	"  R:10  N:A4     ",0
	db	0,0,0,0

wasciiposa	db	6,24,7,22,4,70h,2
	db	"        A S C I I",0
	db	0
	db	" (13-15) ASCII:",0
	db	0

warxeia	db	3,30,3,40,15,70h,1
	db	"                ARHIVE",0
	db	"ƒ",1
	db	0
	db	"      1.. SPAS SISTEMA",0
	db	"      2.. PUNJENJE SISTEMA",0
	db	"      3.. DODAVANJE USLOVA",0
	db	0
	db	"      5.. + FILTER ASCII",0
	db	"      6.. PUNJENJE KOLONE ASCII",0
	db	0
	db	"      X.. NOVI SISTEM",0
	db	"      P.. BRISANJE SISTEMA IZ DISKA",0
	db	"      M.. BRISANJE SAMO USLOVA",0
	db	"      *.. ZAVRSETAK RADA",0
	db	0

wsave	db	4,2,9,35,4,07h,2
	db	"         SPAS SISTEMA",0
	db	0
	db	"        IME ARHIVE :",0
	db	0

wsaveAscii	db	4,2,9,35,5,07h,2
	db	"          ARHIVE ÄSCII",0
	db	0
	db	"        IME ARHIVE :",0
	db	0
	db	0

wsuper13	db	6,24,7,18,4,70h,2
	db	"      * 14 *",0
	db	0
	db	"       14 :",0
	db	0

wsuper14	db	6,28,10,18,4,70h,2
	db	"      * 15 *",0
	db	0
	db	"       15 :",0
	db	0

widio	db	5,6,6,69,6,70h,2
	db	0
	db	"     ARHIV UPOTREBLJAVA ISTE GRUPE USLOVA SA ONIM KOJI POSTOJE",0
	db	"     VEC U MEMORIJ, XAMENITE GRUPE USLOVA I POKUSAJTE PONOVO.",0
	db	0
	db	"ƒ",1
	db	"                          PRITISNUTI 'T'",0

wdelti	db	8,1,13,17,8,70h,1
	db	0
	db	" E ..SLEDECI",0
	db	" Q ..STAMPANJE",0
	db	" P ..POD.STAMPAC",0
	db	" A ..IDI U KUPON",0
	db	" T ..ZAVRSETAK",0
	db	" ! ..TEST",0
	db	0

wdial1	db	10,2,5,60,17,70h,1
	db	"   KUPON  ⁄ƒ13ƒø⁄ƒ12ƒø⁄ƒ11ƒø⁄ƒ10ƒø⁄ƒ09ƒø⁄ƒ^5ƒø⁄ƒ^7ƒø⁄ƒ^9ƒø",0
	db	"ƒ",1
	db	13 dup(0)
	db	"ƒ",1
	db	"   RACUNAM...",0

wclr_dial	db	13,3,7,59,13,70h,1

wdial2	db	11,64,5,13,17,70h,1
	db	0
	db	" ⁄ƒ KUPON ƒø",0
	db	0
	db	" ⁄ƒ DOSAD ƒø",0
	db	0
	db	0
	db	" 13 :",0
	db	" 12 :",0
	db	" 11 :",0
	db	" 10 :",0
	db	"  9 :",0
	db	0
	db	" ^5 :",0
	db	" ^7 :",0
	db	" ^9 :",0
	db	0,0,0,0

wnikitr	db	13,7,1,4,16,70h,2
	db	0
	db	" D",0
	db	" O",0
	db	" B",0
	db	" I",0
	db	" T",0
	db	" N",0
	db	" A",0
	db	0
	db	" K",0
	db	" O",0
	db	" L",0
	db	" O",0
	db	" N",0
	db	" A",0
	db	0,0

wektip	db	14,20,1,30,18,70h,2
	db	" PRINTER",0
	db	0
	db	"                   ⁄ƒƒƒƒƒƒƒø",0
	db	"          (1) AUTO ≥       ≥",0
	db	"        (100) WAIT ≥       ≥",0
	db	"                UP ≥       ≥",0
	db	"              LEFT ≥       ≥",0
	db	"      DOWN SPACE 1 ≥       ≥",0
	db	"      DOWN SPACE 2 ≥       ≥",0
	db	"    HORIZ. SPACE 1 ≥       ≥",0
	db	"    HORIZ. SPACE 2 ≥       ≥",0
	db	"    (42) CHARACTER ≥       ≥",0
	db	"      DOWN BETWEEN ≥       ≥",0
	db	"     HORIZ BETWEEN ≥       ≥",0
	db	"      INFO SPACE 1 ≥       ≥",0
	db	"      INFO SPACE 2 ≥       ≥",0
	db	"                   ¿ƒƒƒƒƒƒƒŸ",0
	db	0

waurist	db	14,10,4,25,17,70h,2
	db	"       SUM.TABLE No:   ",0
	db	"    ⁄ƒƒ1ƒƒ¬ƒƒXƒƒ¬ƒƒ2ƒƒø",0
	db	"  1 ≥     ≥     ≥     ≥",0
	db	"  2 ≥     ≥     ≥     ≥",0
	db	"  3 ≥     ≥     ≥     ≥",0
	db	"  4 ≥     ≥     ≥     ≥",0
	db	"  5 ≥     ≥     ≥     ≥",0
	db	"  6 ≥     ≥     ≥     ≥",0
	db	"  7 ≥     ≥     ≥     ≥",0
	db	"  8 ≥     ≥     ≥     ≥",0
	db	"  9 ≥     ≥     ≥     ≥",0
	db	" 10 ≥     ≥     ≥     ≥",0
	db	" 11 ≥     ≥     ≥     ≥",0
	db	" 12 ≥     ≥     ≥     ≥",0
	db	" 13 ≥     ≥     ≥     ≥",0
	db	"    ¿ƒƒƒƒƒ¡ƒƒƒƒƒ¡ƒƒƒƒƒŸ",0
	db	" FROM:        TO:",0

wasciiOro	db	16,13,8,20,7,70h,2
	db	0          
	db	"    FILTER  PACK",0
	db	0
	db	"     OD :",0
	db	"     DO :",0
	db	0
	db	"     LER TASTE",0

wpane	db	15,13,8,28,3,70h,2
	db	0
	db	" BROJ KUPONA :",0
	db	0
	
wtaf	db	17,1,22,23,1,70h,2
	db	" KRAJ-PRITISNUTI  'T'",0
	
wparag	db	18,4,1,71,21,70h,1
	db	"                     * * *    T A B E L E   * * *",0
	db	"ƒ",1
	db	"         ZNAKOVE NA SVA MESTA      ≥               PROIZVODI",0
	db	"         1         X         2     ≥         1         X         2",0
	db	"   1.                              ≥   0.",0
	db	"   2.                              ≥   1.",0
	db	"   3.                              ≥   2.",0
	db	"   4.                              ≥   3.",0
	db	"   5.                              ≥   4.",0
	db	"   6.                              ≥   5.",0
	db	"   7.                              ≥   6.",0
	db	"   8.                              ≥   7.",0
	db	"   9.                              ≥   8.",0
	db	"  10.                              ≥   9.",0
	db	"  11.                              ≥  10.",0
	db	"  12.                              ≥  11.",0
	db	"  13.                              ≥  12.",0
	db	"                                   ≥  13.",0
	db	" PROSLI SU:",0
	db	"ƒ",1
	db	"                      PRITISNUTI  Esc  ZA PREKID",0

wgen	db	19,0,22,78,1,70h,2
	db	0

welegx	db	20,1,1,75,22,70h,1
	db	"    PROVERENI SU:         -PROMENLJVO:        -PROSLI SU:",0
	db	"ƒƒƒƒƒƒƒƒƒ≥ OBAVEZNE USLOVE   ≥ ......0 ƒ",1
	db	"  1",0
	db	"  9",0
	db	" 17",0
	db	" 25",0
	db	" 33",0
	db	" 41",0
	db	" 49",0
	db	"ƒƒƒƒƒƒƒƒƒ≥ PREDLOZI          ≥ ......0 ƒ",1
	db	0
	db	0
	db	"ƒƒƒƒƒƒƒƒƒ≥ GRUPE             ≥ ......0 ƒ",1
	db	"  2",0
	db	"  9",0
	db	" 16",0
	db	" 23",0
	db	" 30",0
	db	"ƒƒƒƒƒƒƒƒƒ≥ SUPERGRUPE        ≥ ......0 ƒ",1
	db	0
	db	"ƒ",1
	db	"                         PRITISNUTI Esc ZA PREKID ",0


wdiakop	db	21,2,2,36,15,70h,2
	db	"            PREKID OBRADE",0
	db	"ƒ",1
	db	"        KOLONA RAZVIJANJA",0
	db	0
	db	"ƒ",1
	db	"         KOLONE DO SAD : ......0",0
	db	"ƒ",1
	db	0,0,0,0,0
	db	"ƒ",1
	db	"      PRITISNUTI 'T' ZA KRAJ",0
	db	"  ILI DRUGU TIRKU ZA PRODUZENJE",0

wfatal	db	22,25,7,30,7,70h,2
	db	0
fatl	db	"    !! OZBILJNA GRESKA !!",0
	db	0
	db	"       PRITISNUTI 'T'",0
	db	0
kenl	db	"                         ",0
	db	0

wtoobig	db	23,20,10,40,6,70h,2
	db	0
	db	"     !!! PROBLEM SA MEMORIJOM !!!",0
	db	" IZBRISATI USLOVE I POKUSAJTE PONOVO",0
	db	0
	db	"ƒ",1
	db	"           PRITISNUTI  'T'",0

waustria	db	24,28,2,13,12,70h,2
	db	"   AUSTRIA",0
	db	0
	db	"   6 -> 06",0
	db	"   7 -> 07",0
	db	"   8 -> 08",0
	db	"   9 -> 09",0
	db	"  10 -> 10",0
	db	"  11 -> 11",0
	db	"  12 -> 12",0
	db	"  13 -> 13",0
	db	0
	db	"    Esc",0


widosor	db	24,28,2,22,20,70h,2
	db	" PREDMET USLOVA: W",0
	db	"ƒ",1
	db	"      UPOREDNOST",0
	db	"ƒ",1
	db	"        1 ->",0
	db	"        2 ->",0
	db	"        3 ->",0
	db	"        4 ->",0
	db	"        5 ->",0
	db	"        6 ->",0
	db	"        7 ->",0
	db	"        8 ->",0
	db	"        9 ->",0
	db	"       10 ->",0
	db	"       11 ->",0
	db	"       12 ->",0
	db	"       13 ->",0
	db	"ƒ",1
	db	"PRITISNUTI Esc ZA KRAJ"
	db	"       Q = RESET",0

wmetrima	db	25,32,2,36,16,70h,2
	db	"         BROJANJE KOLONA",0
	db	"ƒ",1
	db	"     KOLONA--> ",0
	db	"         KOLONE CELINE : ......0",0
	db	"ƒ",1
	db	" KOLONE KOJE SU PROSLE : ......0",0
	db	"ƒ",1
	db	0,0,0,0,0
	db	"ƒ",1
	db	"       EKONOMIJA : ",0
	db	"ƒ",1
	db	"     PRITISNUTI Esc ZA PREKID",0

waxb	db	26,23,9,33,3,70h,2
	db	0
	db	"    RASPORED MESTA AXB :",0
	db	0

wsbise	db	27,23,9,34,3,70h,2
	db	0
	db	"     GRUPA ZA BRISANJE :",0
	db	0

wallagi	db	28,23,9,34,4,70h,2
	db	0
	db	"         PROMENA GRUPE :",0
	db	"              PO GRUPI :",0
	db	0

waloria	db	29,23,9,34,8,70h,2
	db	0
	db	"  PROMENA GRANICA USLOVA",0
	db	0
	db	"          GRUPA :",0
	db	"    GRANICE  OD :",0
	db	"             DO :",0
	db	"            N/O :",0
	db	0
	db	0

wantiksim	db	30,23,9,34,8,70h,2
	db	0
	db	"        CHANGE POINT",0
	db	0
	db	"          GROUP :",0
	db	"       POSITION :",0
	db	"           FROM :",0
	db	"             TO :",0
	db	0
	db	0

wxchangesim	db	31,23,9,34,6,70h,2
	db	0
	db	"  ZAMENA ZNAKOVA "
wxch_mes	db	"1-2 2-1",0
	db	0
	db	"          GROUP :",0
	db	"       POSITION :",0
	db	0

wantigr	db	32,23,9,34,4,70h,2
	db	0
	db	"          PREPIS GRUPE :",0
	db	"               U GRUPI :",0
	db	0

wprotas	db	33,17,2,46,19,70h,1
	db	"         ****   P R E D L O Z I   ****",0
	db	"ƒ",1
	db	"  1.",0
	db	"  2.",0
	db	"  3.",0
	db	"  4.",0
	db	"  5.",0
	db	"  6.",0
	db	"  7.",0
	db	"  8.",0
	db	"  9.",0
	db	" 10.",0
	db	" 11.",0
	db	" 12.",0
	db	" 13.",0
	db	" 14.",0
	db	" 15.",0
	db	"ƒ",1
	db	"            PRITIZNUTI Esc ZA KRAJ",0

wdilono	db	34,17,2,25,19,70h,1
	db	"   ≥ IF  THIS ≥  CHECK",0
	db	"ƒ",1
	db	"  1≥          ≥",0
	db	"  2≥          ≥",0
	db	"  3≥          ≥",0
	db	"  4≥          ≥",0
	db	"  5≥          ≥",0
	db	"  6≥          ≥",0
	db	"  7≥          ≥",0
	db	"  8≥          ≥",0
	db	"  9≥          ≥",0
	db	" 10≥          ≥",0
	db	" 11≥          ≥",0
	db	" 12≥          ≥",0
	db	" 13≥          ≥",0
	db	" 14≥          ≥",0
	db	" 15≥          ≥",0
	db	"ƒ",1
	db	"          Esc END",0

wbaleomad	db	35,19,8,41,3,70h,2
	db	0
	db	" OPREDELIT NOVU GRUPACIJU PO     USLOVIMA",0
	db	0

wdialogi	db	36,29,8,22,9,70h,2
	db	"  SORTIRANJE SISTEMA",0
	db	"ƒ",1
	db	0
	db	"      13 -> 0",0
	db	"      12 -> 0",0
	db	"      11 -> 0",0
	db	"      10 -> 0",0
	db	"       9 -> 0",0
	db	0

wstlouoni	db	37,27,0,26,21,70h,1
	db	0
	db	3 dup(0)
	db	"ƒ",1
	db	3 dup(0)
	db	"ƒ",1
	db	3 dup(0)
	db	"ƒ",1
	db	4 dup(0)
	db	"ƒ",1
	db	0
	db	"  PRITISNUTI 'T' ZA KRAJ",0
	db	0

wtajin	db	38,25,8,26,5,70h,2
	db	0
	db	0
	db	"        SPEDIVANJE",0
	db	0
	db	0


wdeltio_pliraki db	41,21,1,56,21,70h,1
	db	"                ≥ KUPON:        - KOL:       |        ",0
	db	"ƒ",1
	db	"  1≥",0
	db	"  2≥",0
	db	"  3≥",0
	db	" ƒƒ≥",0
	db	"  4≥",0
	db	"  5≥",0
	db	"  6≥",0
	db	" ƒƒ≥",0
	db	"  7≥",0
	db	"  8≥",0
	db	"  9≥",0
	db	" ƒƒ≥",0
	db	" 10≥",0
	db	" 11≥",0
	db	" 12≥",0
	db	" ƒƒ≥",0
	db	" 13≥",0
	db	" 14≥",0
	db	" 15≥",0
	db	0

wclr_pliraki db	42,26,3,51,19,70h,1

wagonas_0_4	 db	43,28,10,24,4,07h,2
	db	0
	db	"    R1 :      (0 - 4)",0
	db	"    R2 :      (0 - 4)",0
	db	0

wbaleaxb	db	44,28,10,27,4,07h,2
	db	0
	db	"    STAVITE KUPONE AXB",0
	db	"    & PRITISNUTI 'Esc'",0
	db	0

wbaleplr	db	45,28,10,27,4,07h,2
	db	0
	db	"   STAVITE KUPONE MALIH ",0
	db	"    & PRITISNUTI 'Esc'",0
	db	0

winkeno	db	94,30 dup(0)

wplwait	db	59,25,9,29,3,70h,2
	db	0
	db	"         PLEASE WAIT",0
	db	0

wplirof	db	47,14,6,63,9,70h,2
	db	"                     I N F O R M A C I J E",0
	db	"ƒ",1
	db	0,0,0,0,0
	db	"ƒ",1
	db	"                              'Esc'",0

wpollapl	db	48,10,8,20,5,70h,2
	db	"  TêàÄÉÑë èéääÄèä. ",0
	db	0
	db	"  Äèé: ",0
	db	"  Ñóë: ",0
	db	0

wWhatPrinter db	50,24,10,35,7,70h,2
	db	"          PRINTER",0
	db	"ƒ",1
	db	0
	db	"     1. EPSON LQ870",0
	db	0
	db	"     5. EPSON LQ590",0
	db	0	
;**************************************************************
wright	label	byte
	db	51,24,5,47,13,70h,2
	db	0
	db	"        T  ±±     ±±   ±±±±    ±±±±   T",0
	db	"        O  ±±     ±±  ±±  ±±  ±±  ±±  O",0
	db	"        T   ±±   ±±   ±±±±±±  ±±±±±±  T",0
	db	"        O    ±± ±±        ±±      ±±  O",0
	db	"              ±±±  ±  ±±±±±   ±±±±±",0
	db	0
	db	"                    D U S A N",0
	db	0
	db	"                 Version 10.2024",0
	db	"  "
tstcpr1	db	"TZORTZAKIS DIMITRIS & PAPADOPOULOS LEONIDAS",0
	db	"            e-mail: leonpap@gmail.com",0
	db	0

tstcpr2	label	byte
XORDATA	<TZORTZAKIS DIMITRIS & PAPADOPOULOS LEONIDAS>,39
	db	0
	
wProblemWithOros	label	byte
	db	60,13,8,42,10,07h,2
	db	0
	db	0
	db	"        THE SYSTEM USE OLD FILTERS",0
	db	0
	db	"           - 1 - @ - N - 7 - J -",0
	db	0
	db	"       PLEASE EDIT THEM AND SAVE IT",0
	db	0
	db	"                PRESS A KEY",0
	db	0
	db	0


wstart	db	42,13,4,52,17,07h,0
	db	"±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±"
	db	"±±±€€€€€€€±±€€€€€€±±€€€€€€±±±±±±±€€€€€€€±±€€€€€€±±±±"
	db	"±±±€€∞∞∞€€∞±€€∞∞€€∞±€€∞∞€€∞±±±±±±€€∞∞∞€€∞±€€∞∞€€∞±±±"
	db	"±±±€€∞±±€€∞±€€€€€€∞±€€∞±€€∞±€€€±±€€∞±±€€∞±€€∞±€€∞±±±"
	db	"±±±€€∞±±€€∞±€€∞∞∞∞∞±€€€€€€∞±±∞∞∞±€€∞±±€€∞±€€€€€€∞±±±"
	db	"±±±±∞∞±±±∞∞±±∞∞±±±±±±∞∞∞∞∞∞±±±±±±±∞∞±±±∞∞±±∞∞∞∞∞∞±±±"
	db	"±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±"
	db	"±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±"
	db	"±±±±±±±±±±±±€€±±±±±±€€±±±€€€€€€±±€€€€€€±±±±±±±±±±±±±"
	db	"±±±±±±±±±±±±€€∞±±±±±€€∞±±€∞∞∞∞€∞±€€∞∞€€∞±±±±±±±±±±±±"
	db	"±±±±±±±±±±±±±€∞±±±±±€∞±±±€€€€€€∞±€€∞±€€∞±±±±±±±±±±±±"
	db	"±±±±±±±±±±±±±±€∞±±±€∞±±±±±∞∞∞∞€∞±€€∞±€€∞±±±±±±±±±±±±"
	db	"±±±±±±±±±±±±±±±€∞±€∞±±±±±±±±±±€∞±€€∞±€€∞±±±±±±±±±±±±"
	db	"±±±±±±±±±±±±±±±±€€∞∞±€€±±€€€€€€∞±€€€€€€∞±±±±±±±±±±±±"
	db	"±±±±±±±±±±±±±±±±±∞∞±±±∞∞±±∞∞∞∞∞∞±±∞∞∞∞∞∞±±±±±±±±±±±±"
	db	"±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±"
	db	"   (c)TZORTZAKIS DIMITRIS & PAPADOPOULOS LEONIDAS",0

wstr	db	10 dup(0)
;***********************************************
WINSEGM ends

;#############################################################################################
;#############################################################################################

CODESG	segment	public
ascii_handle	dw	0
plirakia_handle	dw	0
save_posa_simia	dw	0
print_stack	dw	0
CODESG	ends

;#############################################################################################
;#############################################################################################

CODESG5	segment	public
print_stack5	dw	0
CODESG5	ends

;#############################################################################################
;#############################################################################################

PAKETOR	segment public	;;; PAKETO ORON (5000 X 13 = 65000)
paketo_oron	db	0
	db	65100 dup(?)
PAKETOR	ends

;#############################################################################################
;#############################################################################################

MAST1	segment	public	;;; MNHMH
master1	db	65504 dup(?)
MAST1	ends

MAST2	segment	public
	db	65504 dup(?)
MAST2	ends

MAST3	segment	public
	db	65504 dup(?)
MAST3	ends

MAST4	segment public
	db	65504 dup(?)
MAST4	ends

MAST6	segment public
	db	0
MAST6	ends

	end
