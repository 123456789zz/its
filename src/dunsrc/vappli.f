C VAPPLI- MAIN VERB PROCESSING ROUTINE
C
C COPYRIGHT 1980, INFOCOM COMPUTERS AND COMMUNICATIONS, CAMBRIDGE MA. 02142
C ALL RIGHTS RESERVED, COMMERCIAL USAGE STRICTLY PROHIBITED
C WRITTEN BY R. M. SUPNIK
C
C DECLARATIONS
C
	LOGICAL FUNCTION VAPPLI(RI)
	IMPLICIT INTEGER (A-Z)
	LOGICAL LIT,OBJACT
	LOGICAL QEMPTY,RMDESC,CLOCKD
	LOGICAL QOPEN,EDIBLE,DRKBLE
	LOGICAL TAKE,PUT,DROP,WALK
	LOGICAL QHERE,SVERBS,FINDXT,OAPPLI,F
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
	COMMON /STAR/ MBASE,STRBIT
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
C EXITS
C
	COMMON /XSRCH/ XMIN,XMAX,XDOWN,XUP,
	1	XNORTH,XSOUTH,XENTER,XEXIT,XEAST,XWEST
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
C FUNCTIONS AND DATA
C
	QOPEN(R)=(OFLAG2(R).AND.OPENBT).NE.0
	EDIBLE(R)=(OFLAG1(R).AND.FOODBT).NE.0
	DRKBLE(R)=(OFLAG1(R).AND.DRNKBT).NE.0
	DATA MXNOP/39/,MXSMP/99/
C VAPPLI, PAGE 2
C
	VAPPLI=.TRUE.				
	IF(PRSO.NE.0) ODO2=ODESC2(PRSO)		
	IF(PRSI.NE.0) ODI2=ODESC2(PRSI)
	AV=AVEHIC(WINNER)
	RMK=372+RND(6)				
C
	IF(RI.EQ.0) GO TO 10			
	IF(RI.LE.MXNOP) RETURN			
	IF(RI.LE.MXSMP) GO TO 100		
	GO TO (18000,20000,
	2       22000,23000,24000,25000,26000,27000,28000,29000,30000,
	3 31000,32000,33000,34000,35000,36000,      38000,39000,40000,
	4 41000,42000,43000,44000,45000,46000,47000,48000,49000,50000,
	5 51000,52000,53000,      55000,56000,      58000,59000,60000,
	6             63000,64000,65000,66000,      68000,69000,70000,
	7 71000,72000,73000,74000,            77000,78000,
	8 80000,81000,82000,83000,84000,85000,86000,87000,88000),
	8	(RI-MXSMP)
	CALL BUG(7,RI)
C
C ALL VERB PROCESSORS RETURN HERE TO DECLARE FAILURE.
C
10	VAPPLI=.FALSE.				
	RETURN
C
C SIMPLE VERBS ARE HANDLED EXTERNALLY.
C
100	VAPPLI=SVERBS(RI)
	RETURN
C VAPPLI, PAGE 3
C
C V100--	READ.  OUR FIRST REAL VERB.
C
18000	IF(LIT(HERE)) GO TO 18100		
	CALL RSPEAK(356)			
	RETURN
C
18100	IF(PRSI.EQ.0) GO TO 18200		
	IF((OFLAG1(PRSI).AND.TRANBT).NE.0) GO TO 18200
	CALL RSPSUB(357,ODI2)			
	RETURN
C
18200	IF((OFLAG1(PRSO).AND.READBT).NE.0) GO TO 18300
	CALL RSPSUB(358,ODO2)			
	RETURN
C
18300	IF(.NOT.OBJACT(X)) CALL RSPEAK(OREAD(PRSO))
	RETURN
C
C V101--	MELT.  UNLESS OBJECT HANDLES, JOKE.
C
20000	IF(.NOT.OBJACT(X)) CALL RSPSUB(361,ODO2)
	RETURN
C
C V102--	INFLATE.  WORKS ONLY WITH BOATS.
C
22000	IF(.NOT.OBJACT(X)) CALL RSPEAK(368)	
	RETURN
C
C V103--	DEFLATE.
C
23000	IF(.NOT.OBJACT(X)) CALL RSPEAK(369)	
	RETURN
C VAPPLI, PAGE 4
C
C V104--	ALARM.  IF SLEEPING, WAKE HIM UP.
C
24000	IF((OFLAG2(PRSO).AND.SLEPBT).EQ.0) GO TO 24100
	VAPPLI=OBJACT(X)			
	RETURN
C
24100	CALL RSPSUB(370,ODO2)			
	RETURN
C
C V105--	EXORCISE.  OBJECTS HANDLE.
C
25000	F=OBJACT(X)				
	RETURN
C
C V106--	PLUG.  LET OBJECTS HANDLE.
C
26000	IF(.NOT.OBJACT(X)) CALL RSPEAK(371)
	RETURN
C
C V107--	KICK.  IF OBJECT IGNORES, JOKE.
C
27000	IF(.NOT.OBJACT(X)) CALL RSPSB2(378,ODO2,RMK)
	RETURN
C
C V108--	WAVE.  SAME.
C
28000	IF(.NOT.OBJACT(X)) CALL RSPSB2(379,ODO2,RMK)
	RETURN
C
C V109,V110--	RAISE, LOWER.  SAME.
C
29000	CONTINUE
30000	IF(.NOT.OBJACT(X)) CALL RSPSB2(380,ODO2,RMK)
	RETURN
C
C V111--	RUB.  SAME.
C
31000	IF(.NOT.OBJACT(X)) CALL RSPSB2(381,ODO2,RMK)
	RETURN
C
C V112--	PUSH.  SAME.
C
32000	IF(.NOT.OBJACT(X)) CALL RSPSB2(382,ODO2,RMK)
	RETURN
C VAPPLI, PAGE 5
C
C V113--	UNTIE.  IF OBJECT IGNORES, JOKE.
C
33000	IF(OBJACT(X)) RETURN			
	I=383					
	IF((OFLAG2(PRSO).AND.TIEBT).EQ.0) I=384	
	CALL RSPEAK(I)
	RETURN
C
C V114--	TIE.  NEVER REALLY WORKS.
C
34000	IF((OFLAG2(PRSO).AND.TIEBT).NE.0) GO TO 34100
	CALL RSPEAK(385)			
	RETURN
C
34100	IF(.NOT.OBJACT(X)) CALL RSPSUB(386,ODO2) 
	RETURN
C
C V115--	TIE UP.  NEVER REALLY WORKS.
C
35000	IF((OFLAG2(PRSI).AND.TIEBT).NE.0) GO TO 35100
	CALL RSPSUB(387,ODO2)			
	RETURN
C
35100	I=388					
	IF((OFLAG2(PRSO).AND.VILLBT).EQ.0) I=389
	CALL RSPSUB(I,ODO2)			
	RETURN
C
C V116--	TURN.  OBJECT MUST HANDLE.
C
36000	IF((OFLAG1(PRSO).AND.TURNBT).NE.0) GO TO 36100
	CALL RSPEAK(390)			
	RETURN
C
36100	IF((OFLAG1(PRSI).AND.TOOLBT).NE.0) GO TO 36200
	CALL RSPSUB(391,ODI2)			
	RETURN
C
36200	VAPPLI=OBJACT(X)			
	RETURN
C
C V117--	BREATHE.  BECOMES INFLATE WITH LUNGS.
C
38000	PRSA=INFLAW
	PRSI=LUNGS
	GO TO 22000				
C
C V118--	KNOCK.  MOSTLY JOKE.
C
39000	IF(OBJACT(X)) RETURN			
	I=394					
	IF((OFLAG1(PRSO).AND.DOORBT).EQ.0) I=395
	CALL RSPSUB(I,ODO2)			
	RETURN
C
C V119--	LOOK.
C
40000	IF(PRSO.NE.0) GO TO 41500		
	VAPPLI=RMDESC(3)			
	RETURN
C
C V120--	EXAMINE.
C
41000	IF(PRSO.NE.0) GO TO 41500		
	VAPPLI=RMDESC(0)			
	RETURN
C
41500	IF(OBJACT(X)) RETURN			
	I=OREAD(PRSO)				
	IF(I.NE.0) CALL RSPEAK(I)		
	IF(I.EQ.0) CALL RSPSUB(429,ODO2)	
	PRSA=FOOW				
	RETURN
C
C V121--	SHAKE.  IF HOLLOW OBJECT, SOME ACTION.
C
42000	IF(OBJACT(X)) RETURN			
	IF((OFLAG2(PRSO).AND.VILLBT).EQ.0) GO TO 42100
	CALL RSPEAK(371)			
	RETURN
C
42100	IF(QEMPTY(PRSO).OR.((OFLAG1(PRSO).AND.TAKEBT).EQ.0))
	1	GO TO 10			
	IF(QOPEN(PRSO)) GO TO 42300		
	CALL RSPSUB(396,ODO2)			
	RETURN
C
42300	CALL RSPSUB(397,ODO2)			
	DO 42500 I=1,OLNT			
	  IF(OCAN(I).NE.PRSO) GO TO 42500	
	  OFLAG2(I)=OFLAG2(I).OR.TCHBT		
	  IF(AV.EQ.0) GO TO 42400		
	  CALL NEWSTA(I,0,0,AV,0)		
	  GO TO 42500
C
42400	  CALL NEWSTA(I,0,HERE,0,0)		
	  IF(I.EQ.WATER) CALL NEWSTA(I,133,0,0,0)	
42500	CONTINUE
	RETURN
C
C V122--	MOVE.  MOSTLY JOKES.
C
43000	IF(OBJACT(X)) RETURN			
	I=398					
	IF(QHERE(PRSO,HERE)) I=399
	CALL RSPSUB(I,ODO2)			
	RETURN
C VAPPLI, PAGE 6
C
C V123--	TURN ON.
C
44000	F=LIT(HERE)				
	IF(OBJACT(X)) GO TO 44300		
	IF(((OFLAG1(PRSO).AND.LITEBT).NE.0).AND.
	1	(OADV(PRSO).EQ.WINNER)) GO TO 44100
	CALL RSPEAK(400)			
	RETURN
C
44100	IF((OFLAG1(PRSO).AND.ONBT).EQ.0) GO TO 44200
	CALL RSPEAK(401)			
	RETURN
C
44200	OFLAG1(PRSO)=OFLAG1(PRSO).OR.ONBT	
	CALL RSPSUB(404,ODO2)
44300	IF(.NOT.F .AND.LIT(HERE)) F=RMDESC(0)	
	RETURN
C
C V124--	TURN OFF.
C
45000	IF(OBJACT(X)) GO TO 45300		
	IF(((OFLAG1(PRSO).AND.LITEBT).NE.0).AND.
	1	(OADV(PRSO).EQ.WINNER)) GO TO 45100
	CALL RSPEAK(402)			
	RETURN
C
45100	IF((OFLAG1(PRSO).AND.ONBT).NE.0) GO TO 45200
	CALL RSPEAK(403)			
	RETURN
C
45200	OFLAG1(PRSO)=OFLAG1(PRSO).AND. .NOT.ONBT
	CALL RSPSUB(405,ODO2)
45300	IF(.NOT.LIT(HERE)) CALL RSPEAK(406)	
	RETURN
C
C V125--	OPEN.  A FINE MESS.
C
46000	IF(OBJACT(X)) RETURN			
	IF((OFLAG1(PRSO).AND.CONTBT).NE.0) GO TO 46100
46050	CALL RSPSUB(407,ODO2)			
	RETURN
C
46100	IF(OCAPAC(PRSO).NE.0) GO TO 46200
	CALL RSPSUB(408,ODO2)			
	RETURN
C
46200	IF(.NOT.QOPEN(PRSO)) GO TO 46225
	CALL RSPEAK(412)			
	RETURN
C
46225	OFLAG2(PRSO)=OFLAG2(PRSO).OR.OPENBT	
	IF(((OFLAG1(PRSO).AND.TRANBT).NE.0).OR.QEMPTY(PRSO))
	1	GO TO 46300
	CALL PRINCO(PRSO,410)			
	RETURN
C
46300	CALL RSPEAK(409)			
	RETURN
C
C V126--	CLOSE.
C
47000	IF(OBJACT(X)) RETURN			
	IF((OFLAG1(PRSO).AND.CONTBT).EQ.0) GO TO 46050
	IF(OCAPAC(PRSO).NE.0) GO TO 47100
	CALL RSPSUB(411,ODO2)			
	RETURN
C
47100	IF(QOPEN(PRSO)) GO TO 47200		
	CALL RSPEAK(413)			
	RETURN
C
47200	OFLAG2(PRSO)=OFLAG2(PRSO).AND. .NOT.OPENBT
	CALL RSPEAK(414)			
	RETURN
C VAPPLI, PAGE 7
C
C V127--	FIND.  BIG MEGILLA.
C
48000	IF(OBJACT(X)) RETURN			
	I=415					
	IF(QHERE(PRSO,HERE)) GO TO 48300	
	IF(OADV(PRSO).EQ.WINNER) GO TO 48200	
	J=OCAN(PRSO)				
	IF(J.EQ.0) GO TO 10
	IF((((OFLAG1(J).AND.TRANBT).EQ.0).AND.
	2 (.NOT.QOPEN(J).OR.((OFLAG1(J).AND.(DOORBT+CONTBT)).EQ.0))))
	3	GO TO 10			
	I=417					
	IF(QHERE(J,HERE)) GO TO 48100
	IF(OADV(J).NE.WINNER) GO TO 10		
	I=418
48100	CALL RSPSUB(I,ODESC2(J))		
	RETURN
C
48200	I=416
48300	CALL RSPSUB(I,ODO2)			
	RETURN
C
C V128--	WAIT.  RUN CLOCK DEMON.
C
49000	CALL RSPEAK(419)			
	DO 49100 I=1,3
	  IF(CLOCKD(X)) RETURN
49100	CONTINUE
	RETURN
C
C V129--	SPIN.
C V159--	TURN TO.
C
50000	CONTINUE
88000	IF(.NOT.OBJACT(X)) CALL RSPEAK(663)	
	RETURN
C
C V130--	BOARD.  WORKS WITH VEHICLES.
C
51000	IF((OFLAG2(PRSO).AND.VEHBT).NE.0) GO TO 51100
	CALL RSPSUB(421,ODO2)			
	RETURN
C
51100	IF(QHERE(PRSO,HERE)) GO TO 51200	
	CALL RSPSUB(420,ODO2)			
	RETURN
C
51200	IF(AV.EQ.0) GO TO 51300			
	CALL RSPSUB(422,ODO2)			
	RETURN
C
51300	IF(OBJACT(X)) RETURN			
	CALL RSPSUB(423,ODO2)			
	AVEHIC(WINNER)=PRSO
	IF(WINNER.NE.PLAYER) OCAN(AOBJ(WINNER))=PRSO
	RETURN
C
C V131--	DISEMBARK.
C
52000	IF(AV.EQ.PRSO) GO TO 52100		
	CALL RSPEAK(424)			
	RETURN
C
52100	IF(OBJACT(X)) RETURN			
	IF((RFLAG(HERE).AND.RLAND).NE.0) GO TO 52200
	CALL RSPEAK(425)			
	RETURN
C
52200	AVEHIC(WINNER)=0
	CALL RSPEAK(426)
	IF(WINNER.NE.PLAYER) CALL NEWSTA(AOBJ(WINNER),0,HERE,0,0)
	RETURN
C
C V132--	TAKE.  HANDLED EXTERNALLY.
C
53000	VAPPLI=TAKE(.TRUE.)
	RETURN
C
C V133--	INVENTORY.  PROCESSED EXTERNALLY.
C
55000	CALL INVENT(WINNER)
	RETURN
C VAPPLI, PAGE 8
C
C V134--	FILL.  STRANGE DOINGS WITH WATER.
C
56000	IF(PRSI.NE.0) GO TO 56050		
	IF((RFLAG(HERE).AND.(RWATER+RFILL)).NE.0) GO TO 56025
	CALL RSPEAK(516)			
	PRSWON=.FALSE.				
	RETURN
C
56025	PRSI=GWATE				
56050	IF(OBJACT(X)) RETURN			
	IF((PRSI.NE.GWATE).AND.(PRSI.NE.WATER))
	1	CALL RSPSB2(444,ODI2,ODO2)	
	RETURN
C
C V135,V136--	EAT/DRINK
C
58000	CONTINUE
59000	IF(OBJACT(X)) RETURN			
	IF(PRSO.EQ.GWATE) GO TO 59500		
	IF(.NOT.EDIBLE(PRSO)) GO TO 59400	
	IF(OADV(PRSO).EQ.WINNER) GO TO 59200	
59100	CALL RSPSUB(454,ODO2)			
	RETURN
C
59200	IF(PRSA.EQ.DRINKW) GO TO 59300		
	CALL NEWSTA(PRSO,455,0,0,0)		
	RETURN
C
59300	CALL RSPEAK(456)			
	RETURN
C
59400	IF(.NOT.DRKBLE(PRSO)) GO TO 59600	
	IF(OCAN(PRSO).EQ.0) GO TO 59100		
	IF(OADV(OCAN(PRSO)).NE.WINNER) GO TO 59100
	IF(QOPEN(OCAN(PRSO))) GO TO 59500	
	CALL RSPEAK(457)			
	RETURN
C
59500	CALL NEWSTA(PRSO,458,0,0,0)		
	RETURN
C
59600	CALL RSPSUB(453,ODO2)			
	RETURN
C
C V137--	BURN.  COMPLICATED.
C
60000	IF((OFLAG1(PRSI).AND.(FLAMBT+LITEBT+ONBT)).NE.
	1	(FLAMBT+LITEBT+ONBT)) GO TO 60400
	IF(OBJACT(X)) RETURN			
	IF(OCAN(PRSO).NE.RECEP) GO TO 60050	
	IF(OAPPLI(OACTIO(BALLO),0)) RETURN	
60050	IF((OFLAG1(PRSO).AND.BURNBT).EQ.0) GO TO 60300
	IF(OADV(PRSO).NE.WINNER) GO TO 60100	
	CALL RSPSUB(459,ODO2)
	CALL JIGSUP(460)
	RETURN
C
60100	J=OCAN(PRSO)				
	IF(QHERE(PRSO,HERE).OR. ((AV.NE.0).AND.(J.EQ.AV)))
	1	GO TO 60200			
	IF(J.EQ.0) GO TO 60150			
	IF(.NOT.QOPEN(J)) GO TO 60150		
	IF(QHERE(J,HERE).OR.((AV.NE.0).AND.(OCAN(J).EQ.AV)))
	1	GO TO 60200			
60150	CALL RSPEAK(461)			
	RETURN
C
60200	CALL RSPSUB(462,ODO2)			
	CALL NEWSTA(PRSO,0,0,0,0)
	RETURN
C
60300	CALL RSPSUB(463,ODO2)			
	RETURN
C
60400	CALL RSPSUB(301,ODI2)		
	RETURN
C VAPPLI, PAGE 9
C
C V138--	MUNG.  GO TO COMMON ATTACK CODE.
C
63000	I=466					
	IF((OFLAG2(PRSO).AND.VILLBT).NE.0) GO TO 66100
	IF(.NOT.OBJACT(X)) CALL RSPSB2(466,ODO2,RMK)
	RETURN
C
C V139--	KILL.  GO TO COMMON ATTACK CODE.
C
64000	I=467					
	GO TO 66100
C
C V140--	SWING.  INVERT OBJECTS, FALL THRU TO ATTACK.
C
65000	J=PRSO					
	PRSO=PRSI
	PRSI=J
	J=ODO2
	ODO2=ODI2
	ODI2=J
	PRSA=ATTACW				
C
C V141--	ATTACK.  FALL THRU TO ATTACK CODE.
C
66000	I=468
C
C COMMON MUNG/ATTACK/SWING/KILL CODE.
C
66100	IF(PRSO.NE.0) GO TO 66200		
	CALL RSPEAK(469)			
	RETURN
C
66200	IF(OBJACT(X)) RETURN			
	IF((OFLAG2(PRSO).AND.VILLBT).NE.0) GO TO 66300
	IF((OFLAG1(PRSO).AND.VICTBT).EQ.0)
	1	CALL RSPSUB(470,ODO2)		
	RETURN
C
66300	J=471					
	IF(PRSI.EQ.0) GO TO 66500
	IF((OFLAG2(PRSI).AND.WEAPBT).EQ.0) GO TO 66400
	MELEE=1					
	IF(PRSI.NE.SWORD) MELEE=2		
	I=BLOW(PLAYER,PRSO,MELEE,.TRUE.,0)	
	RETURN
C
66400	J=472					
66500	CALL RSPSB2(I,ODO2,J)			
	RETURN
C VAPPLI, PAGE 10
C
C V142--	WALK.  PROCESSED EXTERNALLY.
C
68000	VAPPLI=WALK(X)
	RETURN
C
C V143--	TELL.  PROCESSED IN GAME.
C
69000	CALL RSPEAK(603)
	RETURN
C
C V144--	PUT.  PROCESSED EXTERNALLY.
C
70000	VAPPLI=PUT(.TRUE.)
	RETURN
C
C V145,V146,V147,V148--	DROP/GIVE/POUR/THROW
C
71000	CONTINUE
72000	CONTINUE
73000	CONTINUE
74000	VAPPLI=DROP(.FALSE.)
	RETURN
C
C V149--	SAVE
C
77000	IF((RFLAG(TSTRS).AND.RSEEN).EQ.0) GO TO 77100
	CALL RSPEAK(828)			
	RETURN
C
77100	CALL SAVEGM
	RETURN
C
C V150--	RESTORE
C
78000	IF((RFLAG(TSTRS).AND.RSEEN).EQ.0) GO TO 78100
	CALL RSPEAK(829)			
	RETURN
C
78100	CALL RSTRGM
	RETURN
C VAPPLI, PAGE 11
C
C V151--	HELLO
C
80000	IF(PRSO.NE.0) GO TO 80100		
	CALL RSPEAK(346+RND(4))			
	RETURN
C
80100	IF(PRSO.NE.AVIAT) GO TO 80200		
	CALL RSPEAK(350)			
	RETURN
C
80200	IF(PRSO.NE.SAILO) GO TO 80300		
	HS=HS+1					
	I=351					
	IF(MOD(HS,10).EQ.0) I=352		
	IF(MOD(HS,20).EQ.0) I=353
	CALL RSPEAK(I)				
	RETURN
C
80300	IF(OBJACT(X)) RETURN			
	I=354					
	IF((OFLAG2(PRSO).AND.(VILLBT+ACTRBT)).EQ.0) I=355
	CALL RSPSUB(I,ODO2)			
	RETURN
C
C V152--	LOOK INTO
C
81000	IF(OBJACT(X)) RETURN			
	IF((OFLAG1(PRSO).AND.DOORBT).EQ.0) GO TO 81300	
	IF(.NOT.QOPEN(PRSO)) GO TO 81200	
	CALL RSPSUB(628,ODO2)			
	RETURN
C
81200	CALL RSPSUB(525,ODO2)			
	RETURN
C
81300	IF((OFLAG2(PRSO).AND.VEHBT).NE.0) GO TO 81400	
	IF(QOPEN(PRSO).OR.((OFLAG1(PRSO).AND.TRANBT).NE.0))
	1	GO TO 81400			
	IF((OFLAG1(PRSO).AND.CONTBT).NE.0) GO TO 81200	
	CALL RSPSUB(630,ODO2)			
	RETURN
C
81400	IF(QEMPTY(PRSO)) GO TO 81500		
	CALL PRINCO(PRSO,573)			
	RETURN
C
81500	CALL RSPSUB(629,ODO2)			
	RETURN
C
C V153--	LOOK UNDER
C
82000	IF(.NOT.OBJACT(X)) CALL RSPEAK(631)	
	RETURN
C VAPPLI, PAGE 12
C
C V154--	PUMP
C
83000	IF((OROOM(PUMP).EQ.HERE).OR.(OADV(PUMP).EQ.WINNER))
	1	GO TO 83100			
	CALL RSPEAK(632)			
	RETURN
C
83100	PRSI=PUMP				
	PRSA=INFLAW				
	GO TO 22000				
C
C V155--	WIND
C
84000	IF(.NOT.OBJACT(X)) CALL RSPSUB(634,ODO2)	
	RETURN
C
C V156--	CLIMB
C V157--	CLIMB UP
C V158--	CLIMB DOWN
C
85000	CONTINUE
86000	CONTINUE
87000	I=XUP					
	IF(PRSA.EQ.CLMBDW) I=XDOWN		
	F=(OFLAG2(PRSO).AND.CLMBBT).NE.0
	IF(F.AND.FINDXT(I,HERE)) GO TO 87500		
	IF(OBJACT(X)) RETURN			
	I=657
	IF(F) I=524				
	IF(.NOT.F .AND.((PRSO.EQ.WALL).OR.
	1	((PRSO.GE.WNORT).AND.(PRSO.LE.WNORT+3))))
	2	I=656				
	CALL RSPEAK(I)			
	RETURN
C
87500	PRSA=WALKW				
	PRSO=I					
	VAPPLI=WALK(X)
	RETURN
C
	END
C CLOCKD- CLOCK DEMON FOR INTERMOVE CLOCK EVENTS
C
C DECLARATIONS
C
	LOGICAL FUNCTION CLOCKD(X)
	IMPLICIT INTEGER (A-Z)
C
C CLOCK INTERRUPTS
C
	LOGICAL*1 CFLAG
	COMMON /CEVENT/ CLNT,CTICK(25),CACTIO(25),CFLAG(25)
C
	CLOCKD=.FALSE.			
	DO 100 I=1,CLNT
	  IF(.NOT.CFLAG(I) .OR.(CTICK(I).EQ.0)) GO TO 100
	  IF(CTICK(I).LT.0) GO TO 50		
	  CTICK(I)=CTICK(I)-1
	  IF(CTICK(I).NE.0) GO TO 100		
50	  CLOCKD=.TRUE.
	  CALL CEVAPP(CACTIO(I))		
100	CONTINUE
	RETURN
C
	END