*** Senate-US-Cnty-NewYork02.PRG

SET SAFETY OFF
CLOSE data
SET SAFETY off
CLEAR MEMO
**SET DEFAULT TO "p:\j089 election poster\poster06\"
SET DEFA TO C:\AP2010\

USE "dbfs\2006 County Senate-NewYork02" in 10 ALIAS sencnty

USE dbfs\statetemplate in 20 ALIAS statetemplate

USE dbfs\USSenresults IN 1 ALIAS res

USE dbfs\USSencandidate IN 2 ALIAS cand

USE dbfs\USSenrace IN 3 ALIAS ra

SELECT cand
ZAP
SELE statetemplate
GO TOP
DO WHILE .NOT. EOF()
  IF flag = '1' 
 thisst = stabbr
 thisstfile = "dbfs\" + stabbr + "_" + "candidate.txt"
 SELE cand
 APPEND FROM &thisstfile TYPE DELIMITED WITH CHARACTER ';'
 SELE statetemplate
  ENDIF 
 SKIP
ENDDO
SELE cand
GO top
INDEX ON candid TO indcandid
************************************cand

SELECT res
ZAP
SELE statetemplate
GO TOP
DO WHILE .NOT. EOF()
  IF flag = '1' 
 thisst = stabbr
 thisstfile = "dbfs\" + stabbr + "_" + "results.txt"
 SELE res
 APPEND FROM &thisstfile TYPE DELIMITED WITH CHARACTER ';'
 SELE statetemplate
   ENDIF 
 SKIP
ENDDO
SELE res
***repl all votecount with 1
GO top
INDEX ON racecntyid TO rcid
SET RELATION TO candid INTO cand
************************************res

SELECT ra
ZAP
SELE statetemplate
GO TOP
DO WHILE .NOT. EOF()
  IF flag = '1' 
 thisst = stabbr
 thisstfile = "dbfs\" + stabbr + "_" + "race.txt"
 SELE ra
 APPEND FROM &thisstfile TYPE DELIMITED WITH CHARACTER ';'
 SELE statetemplate
   ENDIF 
 SKIP
ENDDO

SELE ra
SET FILTER TO officeid = 'S' and cntyno<>1 and .not.(statepost='NY' and seatno = 0)
GO TOP
INDEX ON val(cntyfips) TO indstatepost
SET RELATION TO racecntyid INTO res

*************************************ra

** SET FILTER TO officeid = 'G'
** SET FILTER TO officeid = 'H'
** Go TOP

SELE sencnty
INDEX ON stcty TO stcty
SET RELATION TO val(stcty) INTO ra
GO TOP

DO WHILE .NOT. EOF() 
 ** initialize vote counts for new SENCNTY rec
 totalvote = 0
 gopvote = 0
 demvote = 0
 indvote = 0
 othvote = 0
 thisvote = 0
 thiswinenrxR = ' '
 thiswinnerxD = ' '
 ** key for cnty to seek in RA
 thiscounty = val(stcty)
 IF statefips='46'
  useit= "SD"
  ?"SD"
  ELSE
   useit=' '
 ENDIF
 SELE RA
 GO TOP
 SEEK thiscounty
 IF useit="SD"
  ?"RA"
  ?found()
 ENDIF
 IF FOUND()
  DO WHILE val(cntyfips) = thiscounty
   thisracecntyid = racecntyid
   SELE res
   GO TOP
   SEEK thisracecntyid
    IF useit="SD"
     ?"RES"
     ?found()
     ?party
    ENDIF
   IF FOUND() 
    DO WHILE racecntyid = thisracecntyid .and. .not. eof()
     IF party = 'GOP' .OR. party = 'Dem' .OR. party = 'Ind'
      IF party = 'GOP'
       gopvote = gopvote + votecount
       thiswinnerxR = winner
      ENDIF
      IF party = 'Dem'
       demvote = demvote + votecount
       thiswinnerxD = winner
      ENDIF
      IF party = 'Ind' 
       indvote = indvote + votecount 
      ENDIF
     ELSE
      thisparty = 'Oth'   
      othvote = othvote + votecount
     ENDIF
     SKIP  
    ENDDO 
    ** loop res should be a cursor from relation, 5 or 6 recs
    totalvote = (gopvote + demvote + indvote + othvote)
   ENDIF	
    IF useit = 'SD'
     ?totalvote     
    ENDIF
    ******************************
    IF totalvote = 0
      totalvote=100
      IF thiswinnerxR='X'
        gopvote=100
        demmvote=0
        indvote=0
        othvote=0
      ENDIF
      IF thiswinnerxD='X'
        gopvote=0
        demmvote=100
        indvote=0
        othvote=0
      ENDIF      
    ENDIF
    ******************************
   *** if RES recs found for racecntyid
   SELE RA
   SKIP
  ENDDO  
  
 ENDIF 	
 

 ** update sencnty party vote totals
 SELE sencnty
IF statefips <> '02'
 REPL sen_tot with totalvote
 REPL sen_rep with gopvote
 REPL sen_dem with demvote
 REPL sen_ind with indvote
 REPL sen_oth with othvote
ENDIF
 IF .NOT.(thiswinnerxR<>' ' .AND. thiswinnerxD<>' ')
  REPL winnerx with 'X'
 ELSE 
  REPL winnerx with ' '
 ENDIF

 SKIP
ENDDO  ** SENCNTY us county loop main loop

FLUSH




