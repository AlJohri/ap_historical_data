*** HOUSE-US.PRG
*** HOUSE-US

CLOSE data
SET SAFETY off
CLEAR MEMO
**SET DEFAULT TO "p:\j089 election poster\poster06\"
SET DEFA TO C:\AP2010\dbfs

USE USHouse in 10 ALIAS ushouse

**USE statetemplate in 20 ALIAS statetemplate

USE USresults IN 1 ALIAS res

USE UScandidate IN 2 ALIAS cand

USE USrace IN 3 ALIAS ra

SELECT cand
ZAP
APPEND FROM US_candidate TYPE DELIMITED WITH CHARACTER ';'
GO top
INDEX ON candid TO indcandid


SELECT res
ZAP
APPEND FROM US_results TYPE DELIMITED WITH CHARACTER ';'
GO top
INDEX ON racecntyid TO rcid
SET RELATION TO candid INTO cand


SELECT ra
ZAP
APPEND FROM US_race TYPE DELIMITED WITH CHARACTER ';'
GO top
SET RELATION TO racecntyid INTO res
INDEX ON statepost TO indstatepost

** SET FILTER TO officeid = 'S'
** SET FILTER TO officeid = 'G'
 SET FILTER TO officeid = 'H'
 Go TOP

** FOR Senator
SELE ushouse
go top
?stcode,stabbr

DO WHILE .NOT. EOF()
 thisstate = stabbr
 thisdist = val(stcode3)
 ?"one =",thisstate
 SELE ra
 GO TOP
 LOCATE FOR statepost = thisstate AND seatno = thisdist AND officeid = "H"
IF EOF()
 inplay = 0
ELSE 
 inplay = 1
ENDIF
 ?"inplay= ", inplay
 thisracecntyid = racecntyid
 ?"ra"
 ?"thisrtacecntyid = ",thisracecntyid
 ?"racecntyid=",racecntyid
 pctreporting = pctreport
 pctcount = pcttotal
 ** pcts reporting 0 or not - data to count ------changed here for pctreporting=0
 IF pctreporting >= 0 
** IF pctreporting <> 0 
  SELE res
  ** SUM votecount to vc for thisracecntyid
  ** ?vc
  vcthisrace = 0
  winthisgov = "Z"
  ?"Res"
  ?"winthisgov = ", winthisgov
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
    ?"winnervotecount= ",winnervc
    biggestvotecount = votecount
   ENDIF
   vcthisrace = vcthisrace + votecount
   ?"first vcthisrace=", vcthisrace 
   IF votecount > biggestvotecount
    biggestvotecount = votecount
    altpartythisgov = party
    altincumb = incumbent
    altwinnername = alltrim(cand.fname) + " " + alltrim(cand.mname) + " " + alltrim(cand.lname) + alltrim(cand.junior)
    altwinnervc = votecount
   ENDIF
   SKIP
  ENDDO
  ?"last vcthisrace=", vcthisrace
  ELSE
  winthisgov = " "
 ** pcts reporting = 0 or not
 ENDIF
 
 SELE ushouse
 REPL in_play with inplay
 IF pctreporting = 0
**  repl win_name with " ", win_party with " "
  repl win_name with winnername, win_party with partythisgov
**  repl win_perc with 0, incumbent with "0"
  repl win_perc with 0, incumbent with incumb
  repl pctreport with 0, pcttotal with pctcount
  repl winnerx with winthisgov
 ELSE
  repl win_name with winnername, win_party with partythisgov
  repl win_perc with ((winnervc/vcthisrace)*100), incumbent with incumb
  repl pctreport with pctreporting, pcttotal with pctcount
  repl winnerx with winthisgov
 ENDIF
 IF winthisgov = "Z" and pctreporting <> 0
  repl win_name with altwinnername, win_party with altpartythisgov
  repl win_perc with ((biggestvotecount/vcthisrace)*100), incumbent with altincumb
  repl winnerx with winthisgov
 ENDIF
 
 ** for stategov
 SKIP 
ENDDO