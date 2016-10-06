close all
SET SAFETY OFF

SET DEFA TO C:\AP2010

sele 100
use legiscontrol11052010-Kims alias legctl
inde on alltr(id_) to llll

SELE 99
USE states alias states
set relation to allt(id_) into legctl

repl all SSenCtl10 with legctl->SSenCtl
repl all SHsectl10 with legctl->SHseCtl
repl all SLegCtl10 with legctl->SAllCtl

