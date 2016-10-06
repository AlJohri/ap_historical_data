*** SENATE-US.PRG

CLOSE data
SET SAFETY off
CLEAR MEMO
**SET DEFAULT TO "p:\j089 election poster\poster06\"
SET DEFA TO C:\AP2010

USE dbfs\stateSen in 10 ALIAS sen

**USE statetemplate in 20 ALIAS statetemplate

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

 SET FILTER TO officeid = 'S'
** SET FILTER TO officeid = 'G'
** SET FILTER TO officeid = 'H'
 Go TOP

doit=.F.
IF doit
** FOR Senator
SELE Sen
repl all win_name with ' ', win_party with ' ', win_perc with 0
repl all in_play with 0, incumbent with ' ', pctreport with 0, pcttotal with 0
repl all partyinc with ' ', partywin with ' ', winnerx with ' '
go top

?stcode,stabbr

DO WHILE .NOT. EOF()
 thisstate = stabbr
 thisseatno = seatno
 ?"one =",thisstate, " ", thisseatno
 
 *******************************
 SELE ra
 GO TOP
 LOCATE FOR statepost = thisstate AND officeid = "S" AND seatno=thisseatno
 IF EOF()
  inplay = 0
  GO TOP
  ELSE 
  inplay = 1
  ?"inplay= ", inplay
  thisracecntyid = racecntyid
  pctreporting = pctreport
  pctcount = pcttotal
  ** for RES
  vcthisrace = 0
  winthisgov = "Z"
  candidthisgov = 0
  partythisgov = "   "
  incumb = " "
  winnervc = 0
  winnername = " "
    altpartythisgov = "   "
    altincumb = "0"
    altwinnervc = 0
    biggestvotecount = 0
    altwinnername = " "
 *************************************
  SELE res
  DO WHILE (racecntyid = thisracecntyid) and .NOT. EOF()
   IF winner = "X"
    winthisgov = "X"
    candthisgov = candid
    partythisgov = party
    incumb = incumbent
    winnername = alltrim(cand.fname) + " " + alltrim(cand.mname) + " " + alltrim(cand.lname) + alltrim(cand.junior)
    winnervc = votecount
    ?"winnervotecount= ",winnervc
    biggestvotecount = votecount
   ENDIF
   vcthisrace = vcthisrace + votecount
   IF votecount > biggestvotecount
    biggestvotecount = votecount
    altpartythisgov = party
    altincumb = incumbent
    altwinnername = alltrim(cand.fname) + " " + alltrim(cand.mname) + " " + alltrim(cand.lname) + alltrim(cand.junior)
    altwinnervc = votecount
   ENDIF
   SKIP
  ENDDO
*************************************
 SELE sen
 REPL in_play with inplay
 repl win_name with winnername, win_party with partythisgov
 IF vcthisrace <> 0
  repl win_perc with ((winnervc/vcthisrace)*100)
  ELSE
  repl win_perc with 100
 ENDIF
 repl pctreport with pctreporting, pcttotal with pctcount, incumbent with incumb

 IF winthisgov = "Z" and pctreporting >= 0
  repl win_name with altwinnername, win_party with altpartythisgov
  IF vcthisrace =0
   repl win_perc with 0, incumbent with altincumb
  ELSE
   repl win_perc with ((biggestvotecount/vcthisrace)*100), incumbent with altincumb
  ENDIF
 ENDIF
 REPL winnerx with winthisgov
 
*********************** 
 ENDIF  
 ** inplay
 SELE sen

 ** for statesen
 SKIP 
ENDDO

ENDIF
** doit