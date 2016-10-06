set defa to c:\AP2010

**use dbfs\ushouse in 10 alias ushouse
sele ushouse
inde on stabbr+stcode3 to jjj

use cd110_albers_sq.dbf in 9 alias shape
sele 9
set relation to name1 into ushouse

sele ushouse
**repl all incumbent with '1' for cd_mapvalu = 0
**repl all win_perc with 100 for cd_mapvalu = 0
**repl all win_name with winname110 for cd_mapvalu = 0
**repl all win_party with winparty11 for cd_mapvalu = 0
*** for LA US Hse Dist 2 and 4 need to be coded "TBD"
repl all cd_mapvalu with 0
repl all PartyInc with WinPart111
repl all PartyWin with Win_Party

dothisstuff= .F.
IF dothisstuff = .T.
repl all win_party with 'GOP' for stabbr = 'AL' .and. (stcode3 = '001' .OR. stcode3 = '006')
repl all win_party with 'Dem' for stabbr = 'AL' .and. (stcode3 = '007')
repl all win_party with 'Dem' for stabbr = 'AR' .and. (stcode3 = '001')
repl all win_party with 'GOP' for stabbr = 'CA' .and. (stcode3 = '019' .OR. stcode3 = '022')
repl all win_party with 'Dem' for stabbr = 'CA' .and. (stcode3 = '018' .OR. stcode3 = '028')
repl all win_party with 'Dem' for stabbr = 'CA' .and. (stcode3 = '030' .OR. stcode3 = '031')
repl all win_party with 'Dem' for stabbr = 'CA' .and. (stcode3 = '032')
repl all win_party with 'Dem' for stabbr = 'DC' .and. (stcode3 = '001')
repl all win_party with 'Dem' for stabbr = 'FL' .and. (stcode3 = '017' .OR. stcode3 = '003')
repl all win_party with 'Dem' for stabbr = 'GA' .and. (stcode3 = '004' .OR. stcode3 = '005')
repl all win_party with 'Dem' for stabbr = 'IL' .and. (stcode3 = '017')
repl all win_party with 'TBD' for stabbr = 'LA' .and. (stcode3 = '002' .OR. stcode3 = '004')
repl all win_party with 'Dem' for stabbr = 'LA' .and. (stcode3 = '003')
repl all win_party with 'GOP' for stabbr = 'LA' .and. (stcode3 = '005')
repl all win_party with 'Dem' for stabbr = 'NY' .and. (stcode3 = '006')
repl all win_party with 'Dem' for stabbr = 'TN' .and. (stcode3 = '008')
repl all win_party with 'GOP' for stabbr = 'TX' .and. (stcode3 = '014')
repl all win_party with 'Dem' for stabbr = 'MA' .and. (stcode3 = '002' .OR. stcode3 = '003')
repl all win_party with 'Dem' for stabbr = 'MA' .and. (stcode3 = '005' .OR. stcode3 = '008')
repl all win_party with 'Dem' for stabbr = 'MA' .and. (stcode3 = '009' .OR. stcode3 = '010')
repl all win_party with 'Dem' for stabbr = 'VA' .and. (stcode3 = '009' .OR. stcode3 = '003')
repl all win_party with 'Dem' for stabbr = 'WV' .and. (stcode3 = '001')
ENDIF

** Retained by Republicans
repl all cd_mapvalu with 1001 for partywin = "GOP" and partyinc = "GOP"
** Retained by Democratas
repl all cd_mapvalu with 1002 for partywin = "Dem" and partyinc = "Dem"
** Retained by Independents
*repl all cd_mapvalu with 1003 for 
** Switched to Republicans
repl all cd_mapvalu with 10001 for partywin = "GOP" and partyinc = "Dem"
** Switched to Democrats
repl all cd_mapvalu with 10002 for partywin = "Dem" and partyinc = "GOP"
**Switched to Independents
*repl all cd_mapvalu with 10003 for 
REPL ALL cd_mapvalu with 0 for winnerx = 'Z'


sele 9
repl all cd_mapvalu with ushouse->cd_mapvalu
count to ggg for cd_mapvalu = 0
?"No cd_mapvalu = ", ggg

