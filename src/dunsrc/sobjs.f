C SOBJS-	SIMPLE OBJECTS PROCESSOR
C	OBJECTS IN THIS MODULE CANNOT CALL RMINFO, JIGSUP,
C	MAJOR VERBS, OR OTHER NON-RESIDENT SUBROUTINES
C
C COPYRIGHT 1980, INFOCOM COMPUTERS AND COMMUNICATIONS, CAMBRIDGE MA. 02142
C ALL RIGHTS RESERVED, COMMERCIAL USAGE STRICTLY PROHIBITED
C WRITTEN BY R. M. SUPNIK
C
C DECLARATIONS
C
	LOGICAL FUNCTION SOBJS(RI,ARG)
	IMPLICIT INTEGER (A-Z)
	LOGICAL QOPEN
	LOGICAL MOVETO,OPNCLS,LIT
	LOGICAL QHERE,F
C
C PARSER OUTPUT
C
	LOGICAL PRSWON
	COMMON /PRSVEC/ PRSA,PRSI,PRSO,PRSWON,PRSCON
C
C GAME STATE
C
	LOGICAL TELFLG
	COMMON /PLAY/ WINNER,HERE,TELFLG
	COMMON /STATE/ MOVES,DEATHS,RWSCOR,MXSCOR,MXLOAD,
	1	LTSHFT,BLOC,MUNGRM,HS,EGSCOR,EGMXSC
C
C ROOMS
C
	COMMON /ROOMS/ RLNT,RDESC2,RDESC1(200),REXIT(200),
	1	RACTIO(200),RVAL(200),RFLAG(200)
	INTEGER RRAND(200)
	EQUIVALENCE (RVAL,RRAND)
C
	COMMON /RFLAG/ RSEEN,RLIGHT,RLAND,RWATER,RAIR,
	1	RSACRD,RFILL,RMUNG,RBUCK,RHOUSE,RNWALL,REND
C
	COMMON /RINDEX/ WHOUS,LROOM,CELLA
	COMMON /RINDEX/ MTROL,MAZE1	
	COMMON /RINDEX/ MGRAT,MAZ15	
	COMMON /RINDEX/ FORE1,FORE3,CLEAR,RESER
	COMMON /RINDEX/ STREA,EGYPT,ECHOR
	COMMON /RINDEX/ TSHAF	
	COMMON /RINDEX/ BSHAF,MMACH,DOME,MTORC
	COMMON /RINDEX/ CAROU	
	COMMON /RINDEX/ RIDDL,LLD2,TEMP1,TEMP2,MAINT
	COMMON /RINDEX/ BLROO,TREAS,RIVR1,RIVR2,RIVR3,MCYCL
	COMMON /RINDEX/ RIVR4,RIVR5,FCHMP,FALLS,MBARR
	COMMON /RINDEX/ MRAIN,POG,VLBOT,VAIR1,VAIR2,VAIR3,VAIR4
	COMMON /RINDEX/ LEDG2,LEDG3,LEDG4,MSAFE,CAGER
	COMMON /RINDEX/ CAGED,TWELL,BWELL,ALICE,ALISM,ALITR
	COMMON /RINDEX/ MTREE,BKENT,BKVW,BKTWI,BKVAU,BKBOX
	COMMON /RINDEX/ CRYPT,TSTRS,MRANT,MREYE
	COMMON /RINDEX/ MRA,MRB,MRC,MRG,MRD,FDOOR
	COMMON /RINDEX/ MRAE,MRCE,MRCW,MRGE,MRGW,MRDW,INMIR
	COMMON /RINDEX/ SCORR,NCORR,PARAP,CELL,PCELL,NCELL
	COMMON /RINDEX/ CPANT,CPOUT,CPUZZ
C
C OBJECTS
C
	COMMON /OBJCTS/ OLNT,ODESC1(220),ODESC2(220),ODESCO(220),
	1	OACTIO(220),OFLAG1(220),OFLAG2(220),OFVAL(220),
	2	OTVAL(220),OSIZE(220),OCAPAC(220),OROOM(220),
	3	OADV(220),OCAN(220),OREAD(220)
C
	COMMON /OFLAGS/ VISIBT,READBT,TAKEBT,DOORBT,TRANBT,FOODBT,
	1	NDSCBT,DRNKBT,CONTBT,LITEBT,VICTBT,BURNBT,FLAMBT,
	2	TOOLBT,TURNBT,ONBT
	COMMON /OFLAGS/ FINDBT,SLEPBT,SCRDBT,TIEBT,CLMBBT,ACTRBT,
	1	WEAPBT,FITEBT,VILLBT,STAGBT,TRYBT,NOCHBT,OPENBT,
	2	TCHBT,VEHBT,SCHBT
C
	COMMON /OINDEX/ GARLI,FOOD,GUNK,COAL,MACHI,DIAMO,TCASE,BOTTL
	COMMON /OINDEX/ WATER,ROPE,KNIFE,SWORD,LAMP,BLAMP,RUG
	COMMON /OINDEX/	LEAVE,TROLL,AXE
	COMMON /OINDEX/ RKNIF,KEYS,ICE,BAR
	COMMON /OINDEX/ COFFI,TORCH,TBASK,FBASK,IRBOX
	COMMON /OINDEX/ GHOST,TRUNK,BELL,BOOK,CANDL
	COMMON /OINDEX/ MATCH,TUBE,PUTTY,WRENC,SCREW,CYCLO,CHALI
	COMMON /OINDEX/ THIEF,STILL,WINDO,GRATE,DOOR
	COMMON /OINDEX/ HPOLE,LEAK,RBUTT,RAILI
	COMMON /OINDEX/ POT,STATU,IBOAT,DBOAT,PUMP,RBOAT
	COMMON /OINDEX/ STICK,BUOY,SHOVE,BALLO,RECEP,GUANO
	COMMON /OINDEX/ BROPE,HOOK1,HOOK2,SAFE,SSLOT,BRICK,FUSE
	COMMON /OINDEX/ GNOME,BLABE,DBALL,TOMB
	COMMON /OINDEX/ LCASE,CAGE,RCAGE,SPHER,SQBUT
	COMMON /OINDEX/ FLASK,POOL,SAFFR,BUCKE,ECAKE,ORICE,RDICE,BLICE
	COMMON /OINDEX/ ROBOT,FTREE,BILLS,PORTR,SCOL,ZGNOM
	COMMON /OINDEX/ EGG,BEGG,BAUBL,CANAR,BCANA
	COMMON /OINDEX/ YLWAL,RDWAL,PINDR,RBEAM
	COMMON /OINDEX/ ODOOR,QDOOR,CDOOR,NUM1,NUM8
	COMMON /OINDEX/ WARNI,CSLIT,GCARD,STLDR
	COMMON /OINDEX/ HANDS,WALL,LUNGS,SAILO,AVIAT,TEETH
	COMMON /OINDEX/ ITOBJ,EVERY,VALUA,OPLAY,WNORT,GWATE,MASTER
C
C CLOCK INTERRUPTS
C
	LOGICAL*1 CFLAG
	COMMON /CEVENT/ CLNT,CTICK(25),CACTIO(25),CFLAG(25)
C
	COMMON /CINDEX/ CEVCUR,CEVMNT,CEVLNT,CEVMAT,CEVCND,
	1	CEVBAL,CEVBRN,CEVFUS,CEVLED,CEVSAF,CEVVLG,
	2	CEVGNO,CEVBUC,CEVSPH,CEVEGH,
	3	CEVFOR,CEVSCL,CEVZGI,CEVZGO,CEVSTE,
	5	CEVMRS,CEVPIN,CEVINQ,CEVFOL

C
C VILLAINS AND DEMONS
C
	LOGICAL THFFLG,SWDACT,THFACT
	COMMON /HACK/ THFPOS,THFFLG,THFACT,SWDACT,SWDSTA
C
C ADVENTURERS
C
	COMMON /ADVS/ ALNT,AROOM(4),ASCORE(4),AVEHIC(4),
	1	AOBJ(4),AACTIO(4),ASTREN(4),AFLAG(4)
C
	COMMON /AINDEX/ PLAYER,AROBOT,AMASTR
C
C VERBS
C
	COMMON /VINDEX/ CINTW,DEADXW,FRSTQW,INXW,OUTXW
	COMMON /VINDEX/ WALKIW,FIGHTW,FOOW
	COMMON /VINDEX/ MELTW,READW,INFLAW,DEFLAW,ALARMW,EXORCW
	COMMON /VINDEX/ PLUGW,KICKW,WAVEW,RAISEW,LOWERW,RUBW
	COMMON /VINDEX/ PUSHW,UNTIEW,TIEW,TIEUPW,TURNW,BREATW
	COMMON /VINDEX/ KNOCKW,LOOKW,EXAMIW,SHAKEW,MOVEW,TRNONW,TRNOFW
	COMMON /VINDEX/ OPENW,CLOSEW,FINDW,WAITW,SPINW,BOARDW,UNBOAW,TAKEW
	COMMON /VINDEX/ INVENW,FILLW,EATW,DRINKW,BURNW
	COMMON /VINDEX/ MUNGW,KILLW,ATTACW,SWINGW
	COMMON /VINDEX/ WALKW,TELLW,PUTW,DROPW,GIVEW,POURW,THROWW
	COMMON /VINDEX/ DIGW,LEAPW,STAYW,FOLLOW
	COMMON /VINDEX/ HELLOW,LOOKIW,LOOKUW,PUMPW,WINDW
	COMMON /VINDEX/ CLMBW,CLMBUW,CLMBDW,TRNTOW
C
C FLAGS
C
	LOGICAL*1 TROLLF,CAGESF,BUCKTF,CAROFF,CAROZF,LWTIDF
	LOGICAL*1 DOMEF,GLACRF,ECHOF,RIDDLF,LLDF,CYCLOF
	LOGICAL*1 MAGICF,LITLDF,SAFEF,GNOMEF,GNODRF,MIRRMF
	LOGICAL*1 EGYPTF,ONPOLF,BLABF,BRIEFF,SUPERF,BUOYF
	LOGICAL*1 GRUNLF,GATEF,RAINBF,CAGETF,EMPTHF,DEFLAF
	LOGICAL*1 GLACMF,FROBZF,ENDGMF,BADLKF,THFENF,SINGSF
	LOGICAL*1 MRPSHF,MROPNF,WDOPNF,MR1F,MR2F,INQSTF
	LOGICAL*1 FOLLWF,SPELLF,CPOUTF,CPUSHF
	COMMON /FINDEX/ TROLLF,CAGESF,BUCKTF,CAROFF,CAROZF,LWTIDF,
	1	DOMEF,GLACRF,ECHOF,RIDDLF,LLDF,CYCLOF,
	2	MAGICF,LITLDF,SAFEF,GNOMEF,GNODRF,MIRRMF,
	3	EGYPTF,ONPOLF,BLABF,BRIEFF,SUPERF,BUOYF,
	4	GRUNLF,GATEF,RAINBF,CAGETF,EMPTHF,DEFLAF,
	5	GLACMF,FROBZF,ENDGMF,BADLKF,THFENF,SINGSF,
	6	MRPSHF,MROPNF,WDOPNF,MR1F,MR2F,INQSTF,
	7	FOLLWF,SPELLF,CPOUTF,CPUSHF
	COMMON /FINDEX/ BTIEF,BINFF
	COMMON /FINDEX/ RVMNT,RVCLR,RVCYC,RVSND,RVGUA
	COMMON /FINDEX/ ORRUG,ORCAND,ORMTCH,ORLAMP
	COMMON /FINDEX/ MDIR,MLOC,POLEUF
	COMMON /FINDEX/ QUESNO,NQATT,CORRCT
	COMMON /FINDEX/ LCELL,PNUMB,ACELL,DCELL,CPHERE
C
C FUNCTIONS AND DATA
C
	QOPEN(R)=(OFLAG2(R).AND.OPENBT).NE.0
C SOBJS, PAGE 2
C
	IF(PRSO.NE.0) ODO2=ODESC2(PRSO)
	IF(PRSI.NE.0) ODI2=ODESC2(PRSI)
	AV=AVEHIC(WINNER)
	SOBJS=.TRUE.
C
	GO TO (1000,3000,4000,6000,7000,8000,9000,
	1 13000,14000,16000,17000,
	2 21000,23000,24000,27000,28000,29000,30000,
	3 31000,33000,34000,36000,37000,38000,
	4 41000,42000,43000,44000,46000,
	5 53000,56000)
	6	RI
	CALL BUG(6,RI)
C
C RETURN HERE TO DECLARE FALSE RESULT
C
10	SOBJS=.FALSE.
	RETURN
C SOBJS, PAGE 3
C
C O1--	GUNK FUNCTION
C
1000	IF(OCAN(GUNK).EQ.0) GO TO 10		
	CALL NEWSTA(GUNK,122,0,0,0)		
	RETURN
C
C O2--	TROPHY CASE
C
3000	IF(PRSA.NE.TAKEW) GO TO 10		
	CALL RSPEAK(128)			
	RETURN
C
C O3--	BOTTLE FUNCTION
C
4000	IF(PRSA.NE.THROWW) GO TO 4100		
	CALL NEWSTA(PRSO,129,0,0,0)		
	RETURN
C
4100	IF(PRSA.NE.MUNGW) GO TO 10		
	CALL NEWSTA(PRSO,131,0,0,0)		
	RETURN
C SOBJS, PAGE 4
C
C O4--	ROPE FUNCTION
C
6000	IF(HERE.EQ.DOME) GO TO 6100		
	DOMEF=.FALSE.				
	IF(PRSA.NE.UNTIEW) GO TO 6050		
	CALL RSPEAK(134)			
	RETURN
C
6050	IF(PRSA.NE.TIEW) GO TO 10		
	CALL RSPEAK(135)			
	RETURN
C
6100	IF((PRSA.NE.TIEW).OR.(PRSI.NE.RAILI)) GO TO 6200
	IF(DOMEF) GO TO 6150			
	DOMEF=.TRUE.				
	OFLAG1(ROPE)=OFLAG1(ROPE).OR.NDSCBT
	OFLAG2(ROPE)=OFLAG2(ROPE).OR.CLMBBT
	CALL NEWSTA(ROPE,137,DOME,0,0)
	RETURN
C
6150	CALL RSPEAK(136)			
	RETURN
C
6200	IF(PRSA.NE.UNTIEW) GO TO 6300		
	IF(DOMEF) GO TO 6250			
	CALL RSPEAK(134)			
	RETURN
C
6250	DOMEF=.FALSE.				
	OFLAG1(ROPE)=OFLAG1(ROPE).AND. .NOT.NDSCBT
	OFLAG2(ROPE)=OFLAG2(ROPE).AND. .NOT.CLMBBT
	CALL RSPEAK(139)
	RETURN
C
6300	IF(DOMEF.OR.(PRSA.NE.DROPW)) GO TO 6400	
	CALL NEWSTA(ROPE,140,MTORC,0,0)		
	RETURN
C
6400	IF((PRSA.NE.TAKEW).OR. .NOT.DOMEF) GO TO 10
	CALL RSPEAK(141)			
	RETURN
C
C O5--	SWORD FUNCTION
C
7000	IF((PRSA.EQ.TAKEW).AND.(WINNER.EQ.PLAYER))
	1	SWDACT=.TRUE.			
	GO TO 10
C
C O6--	LANTERN
C
8000	IF(PRSA.NE.THROWW) GO TO 8100		
	CALL NEWSTA(LAMP,0,0,0,0)		
	CALL NEWSTA(BLAMP,142,HERE,0,0)		
	RETURN
C
8100	IF(PRSA.EQ.TRNONW) CFLAG(CEVLNT)=.TRUE.
	IF(PRSA.EQ.TRNOFW) CFLAG(CEVLNT)=.FALSE.
	GO TO 10
C
C O7--	RUG FUNCTION
C
9000	IF(PRSA.NE.RAISEW) GO TO 9100		
	CALL RSPEAK(143)			
	RETURN
C
9100	IF(PRSA.NE.TAKEW) GO TO 9200		
	CALL RSPEAK(144)			
	RETURN
C
9200	IF(PRSA.NE.MOVEW) GO TO 9300		
	CALL RSPEAK(145+ORRUG)
	ORRUG=1
	OFLAG1(DOOR)=OFLAG1(DOOR).OR.VISIBT	
	RETURN
C
9300	IF((PRSA.NE.LOOKUW).OR.(ORRUG.NE.0).OR.
	1	QOPEN(DOOR)) GO TO 10		
	CALL RSPEAK(345)
	RETURN
C SOBJS, PAGE 5
C
C O8--	SKELETON
C
13000	I=ROBRM(HERE,100,LLD2,0,0)+ROBADV(WINNER,LLD2,0,0)
	IF(I.NE.0) CALL RSPEAK(162)		
	RETURN
C
C O9--	MIRROR
C
14000	IF(MIRRMF.OR.(PRSA.NE.RUBW)) GO TO 14500
	MROOM=HERE.XOR.1			
	DO 14100 I=1,OLNT			
	  IF(OROOM(I).EQ.HERE) OROOM(I)=-1
	  IF(OROOM(I).EQ.MROOM) OROOM(I)=HERE
	  IF(OROOM(I).EQ.-1) OROOM(I)=MROOM
14100	CONTINUE
	F=MOVETO(MROOM,WINNER)
	CALL RSPEAK(163)			
	RETURN
C
14500	IF((PRSA.NE.LOOKW).AND.(PRSA.NE.LOOKIW).AND.
	1	(PRSA.NE.EXAMIW)) GO TO 14600
	I=164					
	IF(MIRRMF) I=165			
	CALL RSPEAK(I)
	RETURN
C
14600	IF(PRSA.NE.TAKEW) GO TO 14700		
	CALL RSPEAK(166)			
	RETURN
C
14700	IF((PRSA.NE.MUNGW).AND.(PRSA.NE.THROWW)) GO TO 10
	I=167					
	IF(MIRRMF) I=168			
	MIRRMF=.TRUE.
	BADLKF=.TRUE.
	CALL RSPEAK(I)
	RETURN
C SOBJS, PAGE 6
C
C O10--	DUMBWAITER
C
16000	IF(PRSA.NE.RAISEW) GO TO 16100		
	IF(CAGETF) GO TO 16400			
	CALL NEWSTA(TBASK,175,TSHAF,0,0)	
	CALL NEWSTA(FBASK,0,BSHAF,0,0)
	CAGETF=.TRUE.			
	RETURN
C
16100	IF(PRSA.NE.LOWERW) GO TO 16200		
	IF(.NOT.CAGETF) GO TO 16400		
	CALL NEWSTA(TBASK,176,BSHAF,0,0)	
	CALL NEWSTA(FBASK,0,TSHAF,0,0)
	CAGETF=.FALSE.
	IF(.NOT.LIT(HERE)) CALL RSPEAK(406)	
	RETURN
C
16200	IF((PRSO.NE.FBASK).AND.(PRSI.NE.FBASK)) GO TO 16300
	CALL RSPEAK(130)			
	RETURN
C
16300	IF(PRSA.NE.TAKEW) GO TO 10		
	CALL RSPEAK(177)			
	RETURN
C
16400	CALL RSPEAK(125+RND(3))			
	RETURN
C
C O11--	GHOST FUNCTION
C
17000	I=178					
	IF(PRSO.NE.GHOST) I=179			
	CALL RSPEAK(I)
	RETURN					
C SOBJS, PAGE 7
C
C O12--	TUBE
C
21000	IF((PRSA.NE.PUTW).OR.(PRSI.NE.TUBE)) GO TO 10
	CALL RSPEAK(186)			
	RETURN
C
C O13--	CHALICE
C
23000	IF((PRSA.NE.TAKEW).OR.(OCAN(PRSO).NE.0).OR.
	1	(OROOM(PRSO).NE.TREAS).OR.(OROOM(THIEF).NE.TREAS).OR.
	2	((OFLAG2(THIEF).AND.FITEBT).EQ.0).OR.
	3	.NOT. THFACT) GO TO 10
	CALL RSPEAK(204)			
	RETURN
C
C O14--	PAINTING
C
24000	IF(PRSA.NE.MUNGW) GO TO 10		
	CALL RSPEAK(205)			
	OFVAL(PRSO)=0
	OTVAL(PRSO)=0
	ODESC1(PRSO)=207
	ODESC2(PRSO)=206
	RETURN
C SOBJS, PAGE 8
C
C O15--	BOLT
C
27000	IF(PRSA.NE.TURNW) GO TO 10		
	IF(PRSI.NE.WRENC) GO TO 27500		
	IF(GATEF) GO TO 27100			
	CALL RSPEAK(210)			
	RETURN
C
27100	IF(LWTIDF) GO TO 27200			
	LWTIDF=.TRUE.				
	CALL RSPEAK(211)
	OFLAG2(COFFI)=OFLAG2(COFFI).AND. .NOT.SCRDBT
	OFLAG1(TRUNK)=OFLAG1(TRUNK).OR.VISIBT	
	RFLAG(RESER)=(RFLAG(RESER).OR.RLAND)
	1	.AND..NOT.(RWATER+RSEEN)	
	RETURN
C
27200	LWTIDF=.FALSE.				
	CALL RSPEAK(212)
	IF(QHERE(TRUNK,RESER)) OFLAG1(TRUNK)=OFLAG1(TRUNK)
	1	.AND. .NOT.VISIBT
	RFLAG(RESER)=(RFLAG(RESER).OR.RWATER) .AND..NOT.RLAND
	RETURN
C
27500	CALL RSPSUB(299,ODI2)			
	RETURN
C
C O16--	GRATING
C
28000	IF((PRSA.NE.OPENW).AND.(PRSA.NE.CLOSEW)) GO TO 10
	IF(GRUNLF) GO TO 28200			
	CALL RSPEAK(214)			
	RETURN
C
28200	I=215					
	IF(HERE.NE.CLEAR) I=216			
	SOBJS=OPNCLS(GRATE,I,885)		
	RFLAG(MGRAT)=RFLAG(MGRAT).AND. .NOT.RLIGHT	
	IF(QOPEN(GRATE)) RFLAG(MGRAT)=RFLAG(MGRAT).OR.RLIGHT
	IF(.NOT.LIT(HERE)) CALL RSPEAK(406)	
	RETURN
C
C O17--	TRAP DOOR
C
29000	IF(HERE.NE.LROOM) GO TO 29100		
	SOBJS=OPNCLS(DOOR,218,219)		
	RETURN
C
29100	IF(HERE.NE.CELLA) GO TO 10		
	IF((PRSA.NE.OPENW).OR.QOPEN(DOOR)) GO TO 29200
	CALL RSPEAK(220)			
	RETURN
C
29200	SOBJS=OPNCLS(DOOR,0,22)			
	RETURN
C
C O18--	DURABLE DOOR
C
30000	I=0					
	IF(PRSA.EQ.OPENW) I=221			
	IF(PRSA.EQ.BURNW) I=222			
	IF(PRSA.EQ.MUNGW) I=223+RND(3)		
	IF(I.EQ.0) GO TO 10
	CALL RSPEAK(I)
	RETURN
C
C O19--	MASTER SWITCH
C
31000	IF(PRSA.NE.TURNW) GO TO 10		
	IF(PRSI.NE.SCREW) GO TO 31500		
	IF(QOPEN(MACHI)) GO TO 31600		
	CALL RSPEAK(226)			
	IF(OCAN(COAL).NE.MACHI) GO TO 31400	
	CALL NEWSTA(COAL,0,0,0,0)		
	CALL NEWSTA(DIAMO,0,0,MACHI,0)		
	RETURN
C
31400	DO 31450 I=1,OLNT			
	  IF(OCAN(I).NE.MACHI) GO TO 31450	
	  CALL NEWSTA(I,0,0,0,0)		
	  CALL NEWSTA(GUNK,0,0,MACHI,0)		
31450	CONTINUE
	RETURN
C
31500	CALL RSPSUB(300,ODI2)			
	RETURN
C
31600	CALL RSPEAK(227)			
	RETURN
C SOBJS, PAGE 9
C
C O20--	LEAK
C
33000	IF((PRSO.NE.LEAK).OR.(PRSA.NE.PLUGW).OR.(RVMNT.LE.0))
	1	GO TO 10			
	IF(PRSI.NE.PUTTY) GO TO 33100		
	RVMNT=-1				
	CTICK(CEVMNT)=0
	CALL RSPEAK(577)
	RETURN
C
33100	CALL RSPSUB(301,ODI2)			
	RETURN
C
C O21--	DROWNING BUTTONS
C
34000	IF(PRSA.NE.PUSHW) GO TO 10		
	GO TO (34100,34200,34300,34400),(PRSO-RBUTT+1)
	GO TO 10				
C
34100	RFLAG(HERE)=RFLAG(HERE).XOR.RLIGHT	
	I=230
	IF((RFLAG(HERE).AND.RLIGHT).NE.0) I=231
	CALL RSPEAK(I)
	RETURN
C
34200	GATEF=.TRUE.				
	CALL RSPEAK(232)
	RETURN
C
34300	GATEF=.FALSE.				
	CALL RSPEAK(232)
	RETURN
C
34400	IF(RVMNT.NE.0) GO TO 34500		
	CALL RSPEAK(233)			
	RVMNT=1
	CTICK(CEVMNT)=-1
	RETURN
C
34500	CALL RSPEAK(234)			
	RETURN
C
C O22--	INFLATABLE BOAT
C
36000	IF(PRSA.NE.INFLAW) GO TO 10		
	IF(OROOM(IBOAT).NE.0) GO TO 36100	
	CALL RSPEAK(235)			
	RETURN
C
36100	IF(PRSI.NE.PUMP) GO TO 36200		
	CALL NEWSTA(IBOAT,0,0,0,0)		
	CALL NEWSTA(RBOAT,236,HERE,0,0)		
	DEFLAF=.FALSE.
	RETURN
C
36200	I=237					
	IF(PRSI.NE.LUNGS) I=303
	CALL RSPSUB(I,ODI2)
	RETURN
C
C O23--	DEFLATED BOAT
C
37000	IF(PRSA.NE.INFLAW) GO TO 37100		
	CALL RSPEAK(238)			
	RETURN
C
37100	IF(PRSA.NE.PLUGW) GO TO 10		
	IF(PRSI.NE.PUTTY) GO TO 33100		
	CALL NEWSTA(IBOAT,239,OROOM(DBOAT),OCAN(DBOAT),OADV(DBOAT))
	CALL NEWSTA(DBOAT,0,0,0,0)		
	RETURN
C SOBJS, PAGE 10
C
C O24--	RUBBER BOAT
C
38000	IF(ARG.NE.0) GO TO 10			
	IF((PRSA.NE.BOARDW).OR.(OADV(STICK).NE.WINNER)) GO TO 38100
	CALL NEWSTA(RBOAT,0,0,0,0)		
	CALL NEWSTA(DBOAT,240,HERE,0,0)		
	DEFLAF=.TRUE.
	RETURN
C
38100	IF(PRSA.NE.INFLAW) GO TO 38200		
	CALL RSPEAK(367)			
	RETURN
C
38200	IF(PRSA.NE.DEFLAW) GO TO 10		
	IF(AV.EQ.RBOAT) GO TO 38300		
	IF(OROOM(RBOAT).EQ.0) GO TO 38400	
	CALL NEWSTA(RBOAT,0,0,0,0)		
	CALL NEWSTA(IBOAT,241,HERE,0,0)		
	DEFLAF=.TRUE.
	RETURN
C
38300	CALL RSPEAK(242)			
	RETURN
C
38400	CALL RSPEAK(243)			
	RETURN
C
C O25--	BRAIDED ROPE
C
41000	IF((PRSA.NE.TIEW).OR.(PRSO.NE.BROPE).OR.
	1	((PRSI.NE.HOOK1).AND.(PRSI.NE.HOOK2)))
	2	GO TO 41500			
	BTIEF=PRSI				
	CFLAG(CEVBAL)=.FALSE.			
	CALL RSPEAK(248)
	RETURN
C
41500	IF((PRSA.NE.UNTIEW).OR.(PRSO.NE.BROPE)) GO TO 10
	IF(BTIEF.NE.0) GO TO 41600		
	CALL RSPEAK(249)			
	RETURN
C
41600	CALL RSPEAK(250)
	BTIEF=0					
	CTICK(CEVBAL)=3				
	CFLAG(CEVBAL)=.TRUE.
	RETURN
C
C O26--	SAFE
C
42000	I=0					
	IF(PRSA.EQ.TAKEW) I=251			
	IF((PRSA.EQ.OPENW).AND.SAFEF) I=253	
	IF((PRSA.EQ.OPENW).AND..NOT.SAFEF) I=254 
	IF((PRSA.EQ.CLOSEW).AND.SAFEF) I=253	
	IF((PRSA.EQ.CLOSEW).AND..NOT.SAFEF) I=255
	IF(I.EQ.0) GO TO 10
	CALL RSPEAK(I)
	RETURN
C
C O27--	FUSE
C
43000	IF(PRSA.NE.BURNW) GO TO 10		
	CALL RSPEAK(256)
	CTICK(CEVFUS)=2				
	RETURN
C
C O28--	GNOME
C
44000	IF((PRSA.NE.GIVEW).AND.(PRSA.NE.THROWW)) GO TO 44500
	IF(OTVAL(PRSO).EQ.0) GO TO 44100	
	CALL RSPSUB(257,ODO2)			
	CALL NEWSTA(PRSO,0,0,0,0)
	CALL NEWSTA(GNOME,0,0,0,0)		
	GNODRF=.TRUE.
	RETURN
C
44100	CALL RSPSUB(258,ODO2)			
	CALL NEWSTA(PRSO,0,0,0,0)
	RETURN
C
44500	CALL RSPEAK(259)			
	IF(.NOT.GNOMEF) CTICK(CEVGNO)=5		
	GNOMEF=.TRUE.
	RETURN
C
C O29--	COKE BOTTLES
C
46000	IF((PRSA.NE.THROWW).AND.(PRSA.NE.MUNGW)) GO TO 10
	CALL NEWSTA(PRSO,262,0,0,0)		
	RETURN
C SOBJS, PAGE 11
C
C
C O30--	ROBOT
C
53000	IF(PRSA.NE.GIVEW) GO TO 53200		
	CALL NEWSTA(PRSO,0,0,0,AROBOT)		
	CALL RSPSUB(302,ODO2)
	RETURN
C
53200	IF((PRSA.NE.MUNGW).AND.(PRSA.NE.THROWW)) GO TO 10
	CALL NEWSTA(ROBOT,285,0,0,0)		
	RETURN
C
C O31--	GRUE
C
56000	IF(PRSA.NE.EXAMIW) GO TO 56100		
	CALL RSPEAK(288)
	RETURN
C
56100	IF(PRSA.NE.FINDW) GO TO 10		
	CALL RSPEAK(289)
	RETURN
C
	END
