*** Variables ***
${username}        ace.insider
${password}        Antrum
${csilofaktura}    2017VY0008570568
${Dovod}           Test
${lekar}           lucia.golianova
${poskytovatel}    P40707 UNIVERZITNÁ NEMOCNICA BRATISLAVA
${OtvFa}           Otv. fa
${Postrevizia}     Neboli nájdené dáta odpovedajúce zadaným parametrom
${HOSP}            HOSP
${DRG}             DRG
${Datum}           05.01.2021
${Datum11}         07.01.2021
${PPnaHOSP}        PP na HOSP
${nonDRG}          nonDRG
${evidecnecislo}          198736855011
${pacient}         206101301234
${vek}             84
${sumapozadovana}       8,00
${sumauhradena}         7,00
${sumaschvalena}        0
${Hladat}             xpath=//button[span/text()="HĽADAŤ"]
${obnovitStranku}     xpath=//button[span/text()="OBNOVIŤ"]
${kontrolazoznamu}    xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr/td[@data-header-title="{}"]/div
${input}    xpath=//input[@placeholder="{}"]
${wait}    700
${browserVyvoj}    http://jubula-vyvoj/
${browserRozvoj}   http://jubula-rozvoj/
${EV}    112951400421