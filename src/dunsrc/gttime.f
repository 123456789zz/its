C GTTIME-- GET TOTAL TIME PLAYED
C
C COPYRIGHT 1980, INFOCOM COMPUTERS AND COMMUNICATIONS, CAMBRIDGE MA. 02142
C ALL RIGHTS RESERVED, COMMERCIAL USAGE STRICTLY PROHIBITED
C WRITTEN BY R. M. SUPNIK
C
C DECLARATIONS
C
	SUBROUTINE GTTIME(T)
	IMPLICIT INTEGER(A-Z)
C
	COMMON /TIME/ PLTIME,SHOUR,SMIN,SSEC
C
	CALL ITIME(H,M,S)
	T=((H*60)+M)-((SHOUR*60)+SMIN)
	IF(T.LT.0) T=T+1440
	T=T+PLTIME
	RETURN
	END
C OPNCLS-- PROCESS OPEN/CLOSE FOR DOORS
C
C DECLARATIONS
C
	LOGICAL FUNCTION OPNCLS(OBJ,SO,SC)
	IMPLICIT INTEGER (A-Z)
	LOGICAL QOPEN
C
C PARSER OUTPUT
C
	LOGICAL PRSWON
	COMMON /PRSVEC/ PRSA,PRSI,PRSO,PRSWON,PRSCON
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
	QOPEN(O)=(OFLAG2(O).AND.OPENBT).NE.0
C
	OPNCLS=.TRUE.			
	IF(PRSA.EQ.CLOSEW) GO TO 100	
	IF(PRSA.EQ.OPENW) GO TO 50	
	OPNCLS=.FALSE.			
	RETURN
C
50	IF(QOPEN(OBJ)) GO TO 200	
	CALL RSPEAK(SO)
	OFLAG2(OBJ)=OFLAG2(OBJ).OR.OPENBT
	RETURN
C
100	IF(.NOT.QOPEN(OBJ)) GO TO 200	
	CALL RSPEAK(SC)
	OFLAG2(OBJ)=OFLAG2(OBJ).AND..NOT.OPENBT
	RETURN
C
200	CALL RSPEAK(125+RND(3))		
	RETURN
	END
C LIT-- IS ROOM LIT?
C
C DECLARATIONS
C
	LOGICAL FUNCTION LIT(RM)
	IMPLICIT INTEGER (A-Z)
	LOGICAL QHERE
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
C ADVENTURERS
C
	COMMON /ADVS/ ALNT,AROOM(4),ASCORE(4),AVEHIC(4),
	1	AOBJ(4),AACTIO(4),ASTREN(4),AFLAG(4)
C
	LIT=.TRUE.				
	IF((RFLAG(RM).AND.RLIGHT).NE.0) RETURN	
C
	DO 1000 I=1,OLNT			
	  IF(QHERE(I,RM)) GO TO 100		
	  OA=OADV(I)				
	  IF(OA.LE.0) GO TO 1000		
	  IF(AROOM(OA).NE.RM) GO TO 1000	
C
C OBJ IN ROOM OR ON ADV IN ROOM
C
100	  IF((OFLAG1(I).AND.ONBT).NE.0) RETURN	
	  IF(((OFLAG1(I).AND.VISIBT).EQ.0).OR.
	1	(((OFLAG1(I).AND.TRANBT).EQ.0).AND.
	2	((OFLAG2(I).AND.OPENBT).EQ.0))) GO TO 1000
C
C OBJ IS VISIBLE AND OPEN OR TRANSPARENT
C
	  DO 500 J=1,OLNT
	    IF((OCAN(J).EQ.I).AND.((OFLAG1(J).AND.ONBT).NE.0))
	1	RETURN
500	  CONTINUE
1000	CONTINUE
	LIT=.FALSE.
	RETURN
	END
C WEIGHT- RETURNS SUM OF WEIGHT OF QUALIFYING OBJECTS
C
C DECLARATIONS
C
	INTEGER FUNCTION WEIGHT(RM,CN,AD)
	IMPLICIT INTEGER (A-Z)
	LOGICAL QHERE
C
C OBJECTS
C
	COMMON /OBJCTS/ OLNT,ODESC1(220),ODESC2(220),ODESCO(220),
	1	OACTIO(220),OFLAG1(220),OFLAG2(220),OFVAL(220),
	2	OTVAL(220),OSIZE(220),OCAPAC(220),OROOM(220),
	3	OADV(220),OCAN(220),OREAD(220)
C
	WEIGHT=0
	DO 100 I=1,OLNT				
	  IF(OSIZE(I).GE.10000) GO TO 100	
	  IF((QHERE(I,RM).AND.(RM.NE.0)).OR.
	1	((OADV(I).EQ.AD).AND.(AD.NE.0))) GO TO 50
	  J=I					
25	  J=OCAN(J)				
	  IF(J.EQ.0) GO TO 100			
	  IF(J.NE.CN) GO TO 25
50	  WEIGHT=WEIGHT+OSIZE(I)
100	CONTINUE
	RETURN
	END
