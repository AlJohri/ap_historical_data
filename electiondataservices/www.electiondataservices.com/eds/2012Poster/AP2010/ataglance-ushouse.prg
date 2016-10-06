
clea

SELE ushouse
go top

doit=.f.
IF doit
DO WHILE .NOT. EOF()

 STORE stabbr to thisState
 STORE val(stcode3) to thisdist
  
 SELE ra
 GO TOP
 locate for statepost = thisState .and. seatno = thisdist .and. officeid = 'H'
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
 
 SELE ushouse
 
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
 ENDIF
 IF DemWinner = 'X'
  REPL PartyWIn with 'Dem'
 ENDIF
 IF thisstate = 'LA' and (thisdist = 4 or thisdist = 2)
  repl winnerx with 'Z'
  REPL partywin with '   '
  IF thisdist = 2
   repl incumbent with '1'
   repl openseat with 0
  ENDIF
 ENDIF
 SKIP
ENDDO
GO TOP
ENDIF

*** BROW FIELDS stabbr, stcode3, incumbent, openseat, partyinc, partywin, winnerx, cd_mapvalu


dothispart = .t.
IF dothispart

SET ALTE TO c:\ap\ataglanceushouse.txt
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
