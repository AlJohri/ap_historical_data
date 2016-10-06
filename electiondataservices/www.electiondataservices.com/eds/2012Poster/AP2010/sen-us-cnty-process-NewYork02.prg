clear prog 
close all

USE "c:\ap2010\dbfs\2006 County Senate-NewYork02" in 10 ALIAS sencnty
** "c:\ap2010\dbfs\2006 County Senate-NewYork02" is taken from and equivalent to
**    "c:\ap2010\dbfs\2006 County Senate"
USE c:\ap2010\NewYork-Senate02 in 9 ALIAS counties
** C:\POSTER08\shapes\NewYork-Senate02 is taken from and equivalent to 
**   c:\poster08\shapes\counties_ak-sld


sele sencnty
repl all sen_dem_p with  0
repl all sen_rep_p with  0
repl all sen_ind_p with  0
repl all sen_oth_p with  0
repl all s_winner with 0
*** for Alaska
*** ?80340+136348+1223+2677+1090
**repl all sen_tot with (80340+136348+1223+2677+1090) for statefips = '02'
**repl all sen_dem with (80340) for statefips = '02'
**repl all sen_rep with (136348) for statefips = '02'
**repl all sen_oth with (1223+2677+1090) for statefips = '02'
************
repl all sen_dem_p with (sen_dem/sen_tot)*100 for sen_tot <> 0
repl all sen_rep_p with (sen_rep/sen_tot)*100 for sen_tot <> 0
repl all sen_ind_p with (sen_ind/sen_tot)*100 for sen_tot <> 0
repl all sen_oth_p with (sen_oth/sen_tot)*100 for sen_tot <> 0

GO TOP

DO WHILE .NOT. EOF()

 IF sen_dem_p > sen_rep_p
  winning = "Dem"
  winperc = sen_dem_p
 ELSE
  winning = "Rep"
  winperc = -sen_rep_p
 ENDIF

 repl s_winner with winperc
   
 SKIP
ENDDO
** TIE
REPL ALL s_winner with 10000 for sen_dem = sen_rep
REPL ALL s_winner with 10000 for sen_dem = sen_rep

index on val(stcty) to wwwwwwwwwww
GO TOP


sele counties
repl all s_winner with 0
go top
set relation to val(name1_) into sencnty

repl all s_winner with sencnty->s_winner

FLUSH