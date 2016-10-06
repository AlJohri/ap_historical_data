
CLOSE data
SET SAFETY off
CLEAR MEMO
**SET DEFAULT TO "p:\j089 election poster\poster06\"
SET DEFA TO C:\AP2010\dbfs

USE USHouse in 10 ALIAS ushouse

**USE statetemplate in 20 ALIAS statetemplate

USE UScandidate IN 2 ALIAS cand
SELE cand
INDEX ON candid TO indcandid

USE USresults IN 1 ALIAS res
SELE res
INDEX ON racecntyid TO rcid
SET RELATION TO candid INTO cand

USE USrace IN 3 ALIAS ra
SELE ra
SET RELATION TO racecntyid INTO res
INDEX ON statepost + str(seatno) TO indstatepost for officeid = 'H'

SELE ushouse