
*** CALC_DISTRIBUTION
set safety off
close all
clea memo
SET DEFA TO C:\AP\

USE "dbfs\2006 County Senate" in 10 ALIAS sencnty

SELE sencnty

repl all distribrep with 0, repp with 0
repl all distribdem with 0, demp with 0
GO TOP

repl all repp with (sen_rep/sen_tot)*100 FOR sen_tot > 0
REPL ALL demp WITH (sen_dem/sen_tot)*100 FOR sen_tot > 0

REPL ALL distribrep with 1 for ( repp >= 0 .and. repp < 10 )
REPL ALL distribdem with 1 for ( demp >= 0 .and. demp < 10 )

REPL ALL distribrep with 2 for ( repp >= 10 .and. repp < 20 )
REPL ALL distribdem with 2 for ( demp >= 10 .and. demp < 20 )

REPL ALL distribrep with 3 for ( repp >= 20 .and. repp < 30 )
REPL ALL distribdem with 3 for ( demp >= 20 .and. demp < 30 )

REPL ALL distribrep with 4 for ( repp >= 30 .and. repp < 40 )
REPL ALL distribdem with 4 for ( demp >= 30 .and. demp < 40 )

REPL ALL distribrep with 5 for ( repp >= 40 .and. repp < 50 )
REPL ALL distribdem with 5 for ( demp >= 40 .and. demp < 50 )

REPL ALL distribrep with 6 for ( repp >= 50 .and. repp < 60 )
REPL ALL distribdem with 6 for ( demp >= 50 .and. demp < 60 )

REPL ALL distribrep with 7 for ( repp >= 60 .and. repp < 70 )
REPL ALL distribdem with 7 for ( demp >= 60 .and. demp < 70 )

REPL ALL distribrep with 8 for ( repp >= 70 .and. repp < 80 )
REPL ALL distribdem with 8 for ( demp >= 70 .and. demp < 80 )

REPL ALL distribrep with 9 for ( repp >= 80 .and. repp < 90 )
REPL ALL distribdem with 9 for ( demp >= 80 .and. demp < 90 )

REPL ALL distribrep with 10 for ( repp >= 90 .and. repp <= 100 )
REPL ALL distribdem with 10 for ( demp >= 90 .and. demp <= 100 )

GO TOP
?
?
SET alte TO c:\ap\DistributionRep.txt
SET ALTE ON
thisCount = 1
thisclass = 1
DO WHILE thiscount <=10
 
 COUNT TO rep1 for distribrep = thisClass
 ?rep1
 
 thisclass = thisclass + 1
 thiscount = thiscount + 1
 
ENDDO

SET ALTE OFF
SET ALTE TO
?
?
SET alte TO c:\ap\DistributionDem.txt
SET ALTE ON
thisCount = 1
thisclass = 1
DO WHILE thiscount <=10
 
 COUNT TO dem1 for distribdem = thisClass

 ?dem1
 
 thisclass = thisclass + 1
 thiscount = thiscount + 1
 
ENDDO

SET ALTE OFF
SET ALTE TO
?
?

SET ALTE TO c:\AP\Distribution.txt
SET ALTE ON

COUNT TO r1 for s_winner < 0 .AND. repp > 55
COUNT TO r2 for s_winner < 0 .AND. repp >= 50 .AND. repp <= 55
COUNT TO r3 for s_winner < 0 .AND. repp < 50
COUNT TO d1 for (s_winner > 0 .AND. s_winner <> 10000).AND. demp > 55
COUNT TO d2 for (s_winner > 0 .AND. s_winner <> 10000) .AND. demp >= 50 .AND. demp <= 55
COUNT TO d3 for (s_winner > 0 .AND. s_winner <> 10000) .AND. demp < 50
COUNT TO t  FOR sen_dem = sen_rep
?r1
?r2
?r3
?d1
?d2
?d3
?t, "tie"
SET ALTE OFF
SET ALTE TO
