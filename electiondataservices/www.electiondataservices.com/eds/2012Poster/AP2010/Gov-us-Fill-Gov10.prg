close all

use c:\ap2010\dbfs\stategov in 100 alias gov
use c:\ap2010\states in 99 alias states
sele gov
index on id_ to indstategov
sele states
set relation to id_ into gov

doit=.F.
IF doit
** Fill Gov_Part10 -------------------------------------------------------
sele gov
repl all gov_part10 with ' '
repl all gov_part10 with Win_party
repl all gov_part10 with gov_part08 for gov_part10 = ' '

** Fill gov10 for mapping ------------------------------------------------
**
** RETAINED BY
** Retained by Republicans
repl all gov10 with 1001 for gov_part10 = "GOP" .and. gov_part08 = "GOP"
** Retained by Democratas
repl all gov10 with 1002 for gov_part10 = "Dem" .and. gov_part08 = "Dem"
** Retained by Independents
repl all gov10 with 1003 for gov_part10 = "Ind" .and. gov_part08 = "Ind"
** 
** SWITCHED TO 
** Switched to Republicans
repl all gov10 with 10001 for gov_part10 = "GOP" .and. gov_part08 = "Dem"
** Switched to Democrats
repl all gov10 with 10002 for gov_part10 = "Dem" .and. gov_part08 = "GOP"
**Switched to Independents
repl all gov10 with 10003 for gov_part10 = 'Ind' .and. (gov_part08='GOP' .or. gov_part08='Dem')
**
** NO ELECTION
** No Elec - GOP Control
repl all gov10 with 101 for win_party = ' ' .and. (gov08=101 .or. gov08=1001 .or. gov08=10001)
** No Elec - Dem Control
repl all gov10 with 102 for win_party = ' ' .and. (gov08=102 .or. gov08=1002 .or. gov08=10002)
** No Elec - Ind Control
repl all gov10 with 103 for win_party = ' ' .and. (gov08=103 .or. gov08=1003 .or. gov08=10003)
** No Elec - Divided/Tied

** UNCALLED??????
**REPL ALL gov10 with 0 for winnerx = 'Z'
ENDIF
**doit

sele states
repl all gov10 with gov->gov10