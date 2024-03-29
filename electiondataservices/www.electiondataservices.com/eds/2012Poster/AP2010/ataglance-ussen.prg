*** ataglance-ussen
clea
SET SAFETY oFF
SET DEFA TO C:\AP2010
**
use dbfs\statesen-AtAGlance.dbf in 100 alias sen

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

SELE sen
go top

doit=.T.
IF doit
DO WHILE .NOT. EOF()

 STORE stabbr to thisState
  ***seatno will be either 0 or 2
  *** 2 if Wyoming or Missisippi
 STORE seatno to seat2
 
IF in_play = 1
 SELE ra
 GO TOP
 locate for statepost = thisState .and. seatno = seat2 .and. officeid = 'S'
 STORE racecntyid to thisracecnty

 SELE res
 
 GO TOP
 locate for racecntyid = thisracecnty and party = 'GOP'
 IF FOUND()
  GOPParty = .T.
  GOPIncumb = incumbent
  GOPWinner = winner
 ELSE
  GOPParty = .F.
  GOPIncumb = '0'
  GOPWinner = ' '
 ENDIF
 GO TOP
 locate for racecntyid = thisracecnty and party = 'Dem'
 IF FOUND()
  DemParty = .T.
  DemIncumb = incumbent
  DemWinner = winner
 ELSE
  DemParty = .F.
  DemIncumb = '0'
  DemWinner = ' '
 ENDIF
 
 SELE sen
 
 IF demincumb = '0' .and. GOPincumb = '0'
  REPL openseat with 1
 ELSE
  REPL openseat with 0
 ENDIF
 IF GOPIncumb = '1'
  REPL incumbent WITH GOPIncumb
  REPL Partyinc with 'GOP'
 ENDIF
 IF DemIncumb = '1'
  REPL incumbent with demincumb
  REPL PartyInc with 'Dem'
 ENDIF
 IF GOPWinner = 'X'
  REPL PartyWin with 'GOP'
  REPL winnerx WITH 'X'
 ENDIF
 IF DemWinner = 'X'
  REPL PartyWIn with 'Dem'
  REPL winnerx WITH 'X'
 ENDIF
*** in_play = 1
ENDIF
 SKIP
ENDDO
GO TOP

ENDIF

*** BROW FIELDS stabbr, stcode3, incumbent, openseat, partyinc, partywin, winnerx, cd_mapvalu


dothispart = .t.
IF dothispart

SET ALTE TO c:\ap2010\ataglance-ussen.txt
SET ALTE ON

?' '
?' '
?' ALL CALLED RACES (NOT CALLED SUBTRACTED OUT)'
?' '

count to notcalled for winnerx = 'Z'
?"notcalled= ", notcalled
?" "
?"all seats on Nov 3"
count to allseatsbefore
count to repsbefore for partyinc = 'GOP'
count to demsbefore for partyinc = 'Dem'
?"allBEFORE= ", allseatsbefore
?"repsBEFORE= ", repsbefore
?"demsBEFORE= ", demsbefore
?' '
count to incs for incumbent = '1'
count to repincs for partyinc = 'GOP' and incumbent = '1'
count to demincs for partyinc = 'Dem' and incumbent = '1'
?"incsBEFORE= ", incs
?"repincsBEFORE= ", repincs
?"demincsBEFORE= ", demincs
?' '
count to openseats for openseat = 1
count to repopen for partyinc = 'GOP' and openseat = 1
count to demopen for partyinc = 'Dem' and openseat = 1
?"openseatsBEFORE= ", openseats
?"reps openseatsBEFORE= ", repopen
?"dems openseatsBEFORE= ", demopen
?' '


?"all seats on Nov 5"
count to allseats for winnerx <> 'Z'
count to reps for partywin = 'GOP' and winnerx <> 'Z'
count to dems for partywin = 'Dem' and winnerx <> 'Z'
?"all= ", allseats
?"reps= ", reps
?"dems= ", dems
?' '
count to incs for incumbent = '1' and winnerx <> 'Z'
count to repincs for partywin = 'GOP' and incumbent = '1' and winnerx <> 'Z' 
count to demincs for partywin = 'Dem' and incumbent = '1' and winnerx <> 'Z'
?"incs= ", incs
?"repincs= ", repincs
?"demincs= ", demincs
?' '
count to openseats for openseat = 1 and winnerx <> 'Z'
count to repopen for partywin = 'GOP' and openseat = 1 and winnerx <> 'Z'
count to demopen for partywin = 'Dem' and openseat = 1 and winnerx <> 'Z'
?"openseats= ", openseats
?"reps openseats= ", repopen
?"dems openseats= ", demopen
?' '


count to allswitch for partyinc <> partywin and winnerx <> 'Z'
count to repswitch for partyinc = "Dem" and partywin = "GOP" and winnerx <> 'Z'
count to demswitch for partyinc = "GOP" and partywin = "Dem" and winnerx <> 'Z'
?"allswitch= ", allswitch
?"repswitch= ", repswitch
?"demswitch= ", demswitch
?' '
count to allswitch for partyinc <> partywin and winnerx <> 'Z' and incumbent = '1'
count to repswitch for partyinc = "Dem" and partywin = "GOP" and winnerx <> 'Z' and incumbent = '1'
count to demswitch for partyinc = "GOP" and partywin = "Dem" and winnerx <> 'Z' and incumbent = '1'
?"allswitchInc= ", allswitch
?"repswitchInc= ", repswitch
?"demswitchInc= ", demswitch
?' '
count to allswitch for partyinc <> partywin and winnerx <> 'Z' and openseat = 1
count to repswitch for partyinc = "Dem" and partywin = "GOP" and winnerx <> 'Z' and openseat = 1
count to demswitch for partyinc = "GOP" and partywin = "Dem" and winnerx <> 'Z' and openseat = 1
?"allswitchOpen= ", allswitch
?"repswitchOpen= ", repswitch
?"demswitchOpen= ", demswitch
?' '


count to allretain for partyinc = partywin and winnerx <> 'Z'
count to repretain for partyinc = "GOP" and partywin = "GOP" and winnerx <> 'Z'
count to demretain for partyinc = "Dem" and partywin = "Dem" and winnerx <> 'Z'
?"allretain= ", allretain
?"repretain= ", repretain
?"demretain= ", demretain
?' '
count to allretain for partyinc = partywin and winnerx <> 'Z' and incumbent = '1'
count to repretain for partyinc = "GOP" and partywin = "GOP" and winnerx <> 'Z' and incumbent = '1'
count to demretain for partyinc = "Dem" and partywin = "Dem" and winnerx <> 'Z' and incumbent = '1'
?"allretainINc= ", allretain
?"repretainInc= ", repretain
?"demretainInc= ", demretain
?' '
count to allretain for partyinc = partywin and winnerx <> 'Z' and openseat = 1
count to repretain for partyinc = "GOP" and partywin = "GOP" and winnerx <> 'Z' and openseat = 1
count to demretain for partyinc = "Dem" and partywin = "Dem" and winnerx <> 'Z' and openseat = 1
?"allretainOpen= ", allretain
?"repretainOpen= ", repretain
?"demretainOpen= ", demretain
?' '


SET ALTE OFF
SET ALTE TO
ENDIF
