CLOSE data
SET SAFETY off
CLEAR MEMO
**SET DEFAULT TO "p:\j089 election poster\poster06\"
SET DEFA TO C:\AP2010\

USE dbfs\stategov in 10 ALIAS gov
*** USE dbfs\statepres in 10 ALIAS gov

USE dbfs\statetemplate in 20 ALIAS statetemplate

USE dbfs\USresults IN 1 ALIAS res

USE dbfs\UScandidate IN 2 ALIAS cand

USE dbfs\USrace IN 3 ALIAS ra

SELECT cand
ZAP
APPEND FROM dbfs\US_candidate TYPE DELIMITED WITH CHARACTER ';'
GO top
INDEX ON candid TO indcandid


SELECT res
ZAP
APPEND FROM dbfs\US_results TYPE DELIMITED WITH CHARACTER ';'
GO top
INDEX ON racecntyid TO rcid
SET RELATION TO candid INTO cand


SELECT ra
ZAP
APPEND FROM dbfs\US_race TYPE DELIMITED WITH CHARACTER ';'
GO top
SET RELATION TO racecntyid INTO res
INDEX ON statepost TO indstatepost

** SET FILTER TO officeid = 'S'
** SET FILTER TO officeid = 'G'
** SET FILTER TO officeid = 'H'
** Go TOP

doit=.F.
IF doit

** FOR GOVERNOR or PRES
SELE gov
repl all win_name with ' ', win_party with ' ', win_perc with 0
repl all in_play with 0, incumbent with ' ', pctreport with 0, pcttotal with 0
go top
?stcode,stabbr

DO WHILE .NOT. EOF()
 thisstate = stabbr
 ?"one =",thisstate
 SELE ra
 GO TOP
 LOCATE FOR statepost = thisstate AND officeid = "G"
 *** LOCATE FOR statepost = thisstate AND officeid = "P"
IF EOF()
 inplay = 0
ELSE 
 inplay = 1
ENDIF
 thisracecntyid = racecntyid
 IF thisstate = "NY"
 ?"ra"
 ?"thisrtacecntyid = ",thisracecntyid
 ?"racecntyid=",racecntyid
 ENDIF
 pctreporting = pctreport
 pctcount = pcttotal
 ** pcts reporting 0 or not - data to count
 IF pctreporting >= 0 
** IF pctreporting <> 0 
  SELE res
  ** SUM votecount to vc for thisracecntyid
  ** ?vc
  vcthisrace = 0
  winthisgov = "Z"
  IF thisstate = "NY"
  ?"Res"
  ?"winthisgov = ", winthisgov
  ENDIF
  candidthisgov = 0
  partythisgov = "   "
  incumb = "0"
  winnervc = 0
  winnername = " "
    altpartythisgov = "   "
    altincumb = "0"
    altwinnervc = 0
    biggestvotecount = 0
    altwinnername = " "
  DO WHILE (racecntyid = thisracecntyid) and .NOT. EOF()
   IF winner = "X"
    winthisgov = "X"
    candthisgov = candid
    partythisgov = party
    incumb = incumbent
    winnername = alltrim(cand.fname) + " " + alltrim(cand.mname) + " " + alltrim(cand.lname) + alltrim(cand.junior)
    winnervc = votecount
    IF thisstate = "NY"
    ?"winnervotecount= ",winnervc
	ENDIF
    biggestvotecount = votecount
   ENDIF
   vcthisrace = vcthisrace + votecount
     IF thisstate = "NY"
   ?"first vcthisrace=", vcthisrace 
     ENDIF
   IF votecount > biggestvotecount
    biggestvotecount = votecount
    altpartythisgov = party
    altincumb = incumbent
    altwinnername = alltrim(cand.fname) + " " + alltrim(cand.mname) + " " + alltrim(cand.lname) + alltrim(cand.junior)
    altwinnervc = votecount
   ENDIF
   SKIP
  ENDDO
    IF thisstate = "NY"
  ?"last vcthisrace=", vcthisrace
    ENDIF
  ELSE
  winthisgov = " "
 ** pcts reporting = 0 or not
 ENDIF
 
 SELE gov
 REPL in_play with inplay
 IF pctreporting = 0
  **repl win_name with " ", win_party with " "
  repl win_name with winnername, win_party with partythisgov
  ** repl win_perc with 0, incumbent with "0"
  repl win_perc with 100, incumbent with incumb
  repl pctreport with 0, pcttotal with pctcount
 ELSE
  repl win_name with winnername, win_party with partythisgov
  repl win_perc with ((winnervc/vcthisrace)*100), incumbent with incumb
  repl pctreport with pctreporting, pcttotal with pctcount
 ENDIF
 IF winthisgov = "Z" and pctreporting <> 0
  repl win_name with altwinnername, win_party with altpartythisgov
  repl win_perc with ((biggestvotecount/vcthisrace)*100), incumbent with altincumb
 ENDIF
 IF thisstate = "NY" 
   ??"NY"
   ??win_name, win_perc, pctreport
 ENDIF
 ** for stategov
 SKIP 
ENDDO

ENDIF
**doit