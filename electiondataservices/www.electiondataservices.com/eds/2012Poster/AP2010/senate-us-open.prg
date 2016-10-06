*** SENATE-US-OPEN.PRG

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
 Go TOP