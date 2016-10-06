*** CHECK COUNTIES

CLOSE ALL

SELE 1
use "c:\ap\dbfs\2006 County Senate.DBF" alias apcnty
inde on val(stcty) to jjjjj

SELE 2
use c:\ap\counties_ak-sld alias shapecnty
inde on val(name1_) to jksjsjsj

sele shapecnty
go top
**set relation to val(name1_) into apcnty
**repl all flag with '1' for apcnty->stcty = ''



