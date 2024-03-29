*** ataglance-gov

**
USE c:\ap2010\dbfs\stategov

SET PRINT ON
?? "GOV At-A-Glance"
*** DIVIDED CONTROL
COUNT TO r100 for gov10 = 100
?r100, 'No Election-Divided Control/Tied'

COUNT TO r1000 for gov10 = 1000
?r1000, 'Remained Divided Control/Tied'

COUNT TO r10000 for gov10 = 10000
?r10000, 'Switched to Divided Control/Tied'


*** Reps
COUNT TO r101 for gov10 = 101
?r101, 'No Election-held by Republicans'

COUNT TO r1001 for gov10 = 1001
?r1001, 'Retained by Republicans'

COUNT TO r10001 for gov10 = 10001
?r10001, 'Switched to Republicans'

*** Dems
COUNT TO r102 for gov10 = 102
?r102, 'No Election-held by Democrats'

COUNT TO r1002 for gov10 = 1002
?r1002, 'Retained by Democrats'

COUNT TO r10002 for gov10 = 10002
?r10002, 'Switched to Democrats'

*** Inds
COUNT TO r103 for gov10 = 103
?r103, 'No Election-held by Independents'

COUNT TO r1003 for gov10 = 1003
?r1003, 'Retained by Independents'

COUNT TO r10003 for gov10 = 10003
?r10003, 'Switched to Independents'
??
EJECT
SET PRINT OFF
