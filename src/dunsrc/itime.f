C ITIME-	RETURN TIME IN HOURS, MINUTES, AND SECONDS
C
C COPYRIGHT 1980, INFOCOM COMPUTERS AND COMMUNICATIONS, CAMBRIDGE MA. 02142
C ALL RIGHTS RESERVED, COMMERCIAL USAGE STRICTLY PROHIBITED
C WRITTEN BY R. M. SUPNIK
C
C DECLARATIONS
C
	SUBROUTINE ITIME(H,M,S)
	IMPLICIT INTEGER(A-Z)
	INTEGER*4 T
C
	CALL GTIM(T)			
	CALL CVTTIM(T,H,M,S,TK)		
	RETURN
	END