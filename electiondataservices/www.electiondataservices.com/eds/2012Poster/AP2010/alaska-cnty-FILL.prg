
close data
set defa to c:\ap2010

sele 100
use alaskasen2010-good alias akhsedata
inde on stcty to ind1

sele 99
use "dbfs\2006 County Senate.DBF" alias cntys
set relation to stcty into akhsedata

repl all sen_tot with 0 for statefips='02'
repl all sen_dem with 0 for statefips='02'
repl all sen_rep with 0 for statefips='02'
repl all sen_ind with 0 for statefips='02'
repl all sen_oth with 0 for statefips='02'

repl all sen_tot with akhsedata->total for statefips='02'
repl all sen_dem with akhsedata->scott_dem_ for statefips='02'
repl all sen_rep with akhsedata->miller_rep for statefips='02'
repl all sen_ind with akhsedata->write_ins for statefips='02'
repl all sen_oth with 0 for statefips='02'

