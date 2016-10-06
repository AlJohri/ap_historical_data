*** CALC BY STATE

CLOSE data
SET SAFETY off
CLEAR MEMO
**SET DEFAULT TO "p:\j089 election poster\poster06\"
SET DEFA TO C:\AP\

**USE ******* in 10 ALIAS StateRace

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
** SET FILTER TO officeid = 'P'
** Go TOP

** FOR Senator
**SELE ushouse
**go top
**?stcode,stabbr
