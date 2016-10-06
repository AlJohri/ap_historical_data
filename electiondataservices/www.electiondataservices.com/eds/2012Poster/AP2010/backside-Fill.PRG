
close data
SET DEFA to c:\AP2010
SET SAFETY OFF

SELE 100
use states-backside alias states
inde on name2_ to ssss

SELE 99
use BackSideAttributes-Fix.dbf alias attrs
inde on state to aaaa


sele 100
set relation to name2_ into attrs

repl all map5 with attrs->map5
repl all map5text with attrs->map5text
repl all map6 with attrs->map6
repl all map7 with attrs->map7
repl all map7text with attrs->map7text
repl all map8 with attrs->map8
repl all map12 with attrs->map12
repl all map14 with attrs->map14
repl all map14text with attrs->map14text
repl all map15 with attrs->map15
repl all map15text with attrs->map15text
repl all map16 with attrs->map16
repl all map16text with attrs->map16text

