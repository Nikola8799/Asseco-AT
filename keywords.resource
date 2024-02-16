*** Settings ***
Library    SeleniumLibrary
Library    String
Resource   locators.resource
Resource   ../../../../../global/resources/browser.resource
Resource   ../../../../../global/resources/keyword.resource

*** Keywords ***
KontrolaStlpcov
    [Arguments]         ${loc}             ${expected}
     ${elements}   Get WebElements        ${loc}
     Should Not Be Empty    ${elements}
     FOR    ${element}    IN    @{elements}
     Should Be Equal    ${element.text}    ${expected}
     END

Vloz do inputu
    [Arguments]    ${label}    ${text}
    ${locator}    Format String    ${input}   ${label}
    Log    ${locator}
    Input Text    ${locator}    ${text}

Setup Keyword
    Open Browser With Logging    url=${prostredie}
    Maximize Browser Window
    Wait Until Page Contains Element    xpath=//*[@id="username"]
    Input Text                          id=username  ${username}
    Input Text                          id=password  ${password}
    Click Element                       xpath=//button[@type="submit"]
    Wait Until Element Is Visible       xpath=//dashboard-view[@class="ng-star-inserted"]   ${wait}
    Click Element                       xpath=//dashboard-view/div/a[@href="/barbastella/prehlad"]
    Wait Until Page Contains            PREHĽAD BENEFITOV
    Wait Until Loading Disappears

Kontrola filtra Evidecne cislo
    Input Text      xpath=//input[@placeholder="Evidenčné číslo"]   ${evidecnecislo}
    Click Button    ${Hladat}
    Sleep    2
    ${evidecnecislo1}     Get Text    xpath=//td[@data-header-title="Evidenčné číslo"]
    Should Be Equal    ${evidecnecislo1}   ${evidecnecislo}

Kontrola filtra Typ benefitu
    Click Button     ${obnovitStranku}
    Click Element    xpath=//div[label/text()="Typ benefitu"]/ng-select/div/div/button
    Click Element    xpath=//div[label/text()="Typ benefitu"]/ng-select/div/div/div/div[contains(.,"Okuliarové šošovky pre dospelých")]
    Click Button     ${Hladat}
    Sleep   1
    ${count}           SeleniumLibrary.Get Element Count    xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr
    FOR    ${INDEX}    IN RANGE      1      ${count} + 1                                                                                                           # Kontroluje dalšie riadky vporadí
    ${TypBenefitu}     Get Text     xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr[${INDEX}]/td[@data-header-title="Typ"]/div    # Kontroluje v dalších riadkoch daný stlpec (Typ benefitu)
    Should Be Equal    ${TypBenefitu}       O1
    END

Kontrola filtra Datum prijatia
    Click Button       ${obnovitStranku}
    Click Element      xpath=//input[@placeholder="Od"]
    Press Keys         xpath=//input[@placeholder="Od"]  CTRL+a+BACKSPACE                                           # Vymaže input datumu OD
    Input Text         xpath=//input[@placeholder="Od"]  ${Datum}                                                   # Vloží požadovaný dátum
    Press Keys         xpath=//input[@placeholder="Do"]  CTRL+a+BACKSPACE                                           # Vymaže input dátumu DO
    Input Text         xpath=//input[@placeholder="Do"]  ${Datum}
    Click Button       ${Hladat}
    Sleep    1
    ${count}           SeleniumLibrary.Get Element Count    xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr
    FOR    ${INDEX}    IN RANGE      1      ${count} + 1
    ${Datum1}          Get Text      xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr[${INDEX}]/td[@data-header-title="Dát. prijatia"]
    Should Be Equal    ${Datum1}       ${Datum}
    END

Kontrola filtra Datum uhrady
    Click Button       ${obnovitStranku}
    Click Element      xpath=//div[label/text()="Dátum úhrady"]/div/date-time-selector/input-date-time-selector/input[@placeholder="Od"]
    Press Keys         xpath=//div[label/text()="Dátum úhrady"]/div/date-time-selector/input-date-time-selector/input[@placeholder="Od"]     CTRL+a+BACKSPACE
    Input Text         xpath=//div[label/text()="Dátum úhrady"]/div/date-time-selector/input-date-time-selector/input[@placeholder="Od"]     ${Datum11}
    Press Keys         xpath=//div[label/text()="Dátum úhrady"]/div/date-time-selector/input-date-time-selector/input[@placeholder="Do"]     CTRL+a+BACKSPACE
    Input Text         xpath=//div[label/text()="Dátum úhrady"]/div/date-time-selector/input-date-time-selector/input[@placeholder="Do"]     ${Datum11}
    Click Element      xpath=//prehlad-view[@class="ng-star-inserted"]
    Click Button       ${Hladat}
    Sleep    2
    ${count}           SeleniumLibrary.Get Element Count    xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr
    FOR    ${INDEX}    IN RANGE      1      ${count} + 1
    ${Datum1}         Get Text      xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr[${INDEX}]/td[@data-header-title="Dát. úhrady"]
    Should Be Equal    ${Datum1}       ${Datum11}
    END

Kontrola filtr Stav Ziadosti
    Click Button       ${obnovitStranku}
    Click Element      xpath=//div[label/text()="Stav žiadosti"]/ng-select/div/div/button
    Click Element      xpath=//div[label/text()="Stav žiadosti"]/ng-select/div/div/div/div[contains(.,"Evidovaná")]
    Click Button       ${Hladat}
    Sleep    1
    ${count}           SeleniumLibrary.Get Element Count    xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr
    FOR    ${INDEX}    IN RANGE      1      ${count} + 1
    ${StavZiadosti}    Get Text      xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr[${INDEX}]/td[@data-header-title="Stav žiadosti"]
    Should Be Equal    ${StavZiadosti}        Evidovaná
    END

Kontrola filtra Stav Chiroptera
    Click Button       ${obnovitStranku}
    Click Element      xpath=//div[label/text()="Stav v chiroptera"]/ng-select/div/div/button
    Click Element      xpath=//div[label/text()="Stav v chiroptera"]/ng-select/div/div/div/div[contains(.,"AU: Schvál.")]
    Click Element      xpath=//prehlad-view[@class="ng-star-inserted"]
    Click Button       ${Hladat}
    Sleep    1
    ${count}           SeleniumLibrary.Get Element Count    xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr
    FOR    ${INDEX}    IN RANGE      1      ${count} + 1
    ${StavvChiroptere}      Get Text      xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr[${INDEX}]/td[@data-header-title="Rozhodnutie"]
    Should Be Equal     ${StavvChiroptere}       Schválené, automaticky
    END

Kontrola filtra Ukoncene
    Click Button       ${obnovitStranku}
    Click Element      xpath=//div[label/text()="Ukončené"]/ng-select/div/div/button
    Click Element      xpath=//div[label/text()="Ukončené"]/ng-select/div/div/div/div[contains(.,"Nie")]
    Click Button       ${Hladat}
    Sleep    1
    ${count}           SeleniumLibrary.Get Element Count    xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr
    FOR    ${INDEX}    IN RANGE      1      ${count} + 1
    ${Ukončené}        SeleniumLibrary.Get Element Attribute      xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr[${INDEX}]/td[@data-header-title="Ukončené"]/span   class   # Cez "Get element attribute" pretože v GUI je znak zámky
    Should Be Equal    ${Ukončené}       fa darker-text-color fa-unlock ng-star-inserted
    END

Kontrola filtra Poskytovatel
    Click Button       ${obnovitStranku}
    Input Text         xpath=//input[@placeholder="IČO, názov alebo kód PZS"]    ${poskytovatel}
    Sleep   1
    Click Element      xpath=//div[label/text()="Poskytovateľ"]/ng-select/div/div/div/div[contains(.,"P40707 - UNIVERZITNÁ NEMOCNICA BRATISLAVA")]
    Click Button       ${Hladat}
    Sleep    1
    ${count}           SeleniumLibrary.Get Element Count    xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr
    FOR    ${INDEX}    IN RANGE      1      ${count} + 1
    ${Poskytovatel1}   Get Text      xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr[${INDEX}]/td[@data-header-title="Poskytovateľ"]
    Should Be Equal     ${Poskytovatel1}       ${poskytovatel}
    END

Kontrola filtra Pacient
    Click Button       ${obnovitStranku}
    Input Text         xpath=//input[@placeholder="Meno, priezvisko alebo rodné číslo poistenca"]    ${pacient}
    Sleep    1
    Click Element      xpath=//div[label/text()="Pacient"]/ng-select/div/div/div/div[contains(.,"206101301234")]
    Click Button       ${Hladat}
    Sleep    1
    ${count}           SeleniumLibrary.Get Element Count    xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr
    FOR    ${INDEX}    IN RANGE      1      ${count} + 1
    ${pacient1}        Get Text      xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr[${INDEX}]/td[@data-header-title="Pacient"]
    Element Should Contain    xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr/td[@data-header-title="Pacient"]    206101301234
    END

Kontrola filtra Vek
    Click Button       ${obnovitStranku}
    Sleep  1
    Input Text         xpath=//div[label/text()="Vek"]/div/input[@placeholder="Od"]  ${vek}
    Input Text         xpath=//div[label/text()="Vek"]/div/input[@placeholder="Do"]  ${vek}
    Click Button       ${Hladat}
    Sleep    1
    ${count}     SeleniumLibrary.Get Element Count    xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr
    FOR    ${INDEX}    IN RANGE      1      ${count} + 1
    ${vek1}          Get Text      xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr[${INDEX}]/td[@data-header-title="Vek"]
    Should Be Equal     ${vek1}       ${vek}
    END

Kontrola filtra Suma pozadovana
    Click Button       ${obnovitStranku}
    Sleep  1
    Input Text    xpath=//div[label/text()="Suma požadovaná"]/div/input[@placeholder="Od"]    ${sumapozadovana}
    Input Text    xpath=//div[label/text()="Suma požadovaná"]/div/input[@placeholder="Do"]    ${sumapozadovana}
    Click Button    ${Hladat}
    Sleep    1
    ${count}     SeleniumLibrary.Get Element Count    xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr
    FOR    ${INDEX}    IN RANGE      1      ${count} + 1
    ${sumapozadovana1}     Get Text    xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr[${INDEX}]/td[@data-header-title="Suma pož."]
    Should Be Equal     ${sumapozadovana1}      ${sumapozadovana}
    END

Kontrola filtra Suma uhradena
    Click Button     ${obnovitStranku}
    Sleep  1
    Input Text       xpath=//div[label/text()="Suma uhradená"]/div/input[@placeholder="Od"]    ${sumauhradena}
    Input Text       xpath=//div[label/text()="Suma uhradená"]/div/input[@placeholder="Do"]    ${sumauhradena}
    Click Button    ${Hladat}
    Sleep    1
    ${count}     SeleniumLibrary.Get Element Count    xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr
    FOR    ${INDEX}    IN RANGE      1      ${count} + 1
    ${sumauhradena1}   Get Text     xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr[${INDEX}]/td[@data-header-title="Suma uh."]
    Should Be Equal     ${sumauhradena1}      ${sumauhradena}
    END

Kontrola filtra Suma schvalena
    Click Button     ${obnovitStranku}
    Sleep  1
    Input Text       xpath=//div[label/text()="Suma schválená"]/div/input[@placeholder="Od"]    ${sumaschvalena}
    Input Text       xpath=//div[label/text()="Suma schválená"]/div/input[@placeholder="Do"]    ${sumaschvalena}
    Click Button     ${Hladat}
    Sleep    2
    Page Should Contain    Neboli nájdené dáta odpovedajúce zadaným parametrom

Kontrola filtra Vaha chyby
    Click Button     xpath=//button[span/text()="OBNOVIŤ"]
    Sleep  1
    Click Element    xpath=//div[label/text()="Váha chyby"]/ng-select/div/div/button
    Click Element    xpath=//div[label/text()="Váha chyby"]/ng-select/div/div/div/div[contains(.,"5")]
    Click Element    xpath=//prehlad-view[@class="ng-star-inserted"]
    Click Button     ${Hladat}
    Sleep    1
    ${count}     SeleniumLibrary.Get Element Count    xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr
    FOR    ${INDEX}    IN RANGE      1      ${count} + 1
    ${vahachyby5}          Get Text      xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr[${INDEX}]/td[@data-header-title="Váha chyby"]
    Should Be Equal     ${vahachyby5}          5
    END

Kontrola filtra Typ penazenky
    Click Button     xpath=//button[span/text()="OBNOVIŤ"]
    Wait Until Element Is Visible    xpath=//div[label/text()="Typ peňaženky"]/ng-select/div/div/button
    Click Element    xpath=//div[label/text()="Typ peňaženky"]/ng-select/div/div/button
    Click Element    xpath=//div[label/text()="Typ peňaženky"]/ng-select/div/div/div/div[contains(.,"MINI")]
    Click Element    xpath=//prehlad-view[@class="ng-star-inserted"]
    Click Button     ${Hladat}
    Sleep    1
    ${count}     SeleniumLibrary.Get Element Count    xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr
    FOR    ${INDEX}    IN RANGE      1      ${count} + 1
    ${typpenazenky}          Get Text      xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr[${INDEX}]/td[@data-header-title="Typ peňaženky"]
    Should Be Equal     ${typpenazenky}          MINI
    END

Kontrola filtra Typ chyby
    Click Button     xpath=//button[span/text()="OBNOVIŤ"]
    Wait Until Element Is Visible    xpath=//div[label/text()="Typ chyby"]/ng-select/div/div/button
    Click Element    xpath=//div[label/text()="Typ chyby"]/ng-select/div/div/button
    Click Element    xpath=//div[label/text()="Typ chyby"]/ng-select/div/div/div/div[contains(.,"Benefit O1 - nemôže byť vyplatený z dôvodu, že poistenec nedosiahol vek 19 rokov")]
    Click Element    xpath=//prehlad-view[@class="ng-star-inserted"]
    Click Button     ${Hladat}
    Sleep    1
    ${count}     SeleniumLibrary.Get Element Count    xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr
    FOR    ${INDEX}    IN RANGE      1      ${count} + 1
    ${typchyby1}          Get Text      xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr[${INDEX}]/td[@data-header-title="Typ"]
    Element Should Contain    xpath=//table[@class="table table-condensed table-striped table-hover"]/tbody/tr[${INDEX}]/td[@data-header-title="Typ"]       O1
    END

Btn Detail
    Click Button     xpath=//button[span/text()="OBNOVIŤ"]
    Sleep    3
    Click Element    xpath=//div[label/text()="Typ benefitu"]/ng-select/div/div/button
    Click Element    xpath=//div[label/text()="Typ benefitu"]/ng-select/div/div/div/div[contains(.,"Okuliarové šošovky pre dospelých")]
    Click Button     ${Hladat}
    Sleep    3
    Wait Until Element Is Visible    xpath=//a[@tooltip="zobraziť detail benefitu"]    ${wait}
    Double Click Element    xpath=//a[@tooltip="zobraziť detail benefitu"]
    Wait Until Loading Disappears
    Wait Until Element Is Visible    xpath=//history-view     500
    Wait Until Element Is Visible    xpath=//div[text()="Okuliarové šošovky pre dospelých"]    ${wait}
    Page Should Contain    Okuliarové šošovky pre dospelých
    Sleep    3
    Go Back
    Wait Until Loading Disappears

Kontrola príloh v detaile
    Click Button     xpath=//button[span/text()="OBNOVIŤ"]
    Input Text         xpath=//input[@placeholder="Evidenčné číslo"]    ${EV}
    Click Button       ${Hladat}
    Sleep    3
    Wait Until Element Is Visible    xpath=//a[@tooltip="zobraziť detail benefitu"]    ${wait}
    Double Click Element    xpath=//a[@tooltip="zobraziť detail benefitu"]
    Wait Until Element Is Visible    xpath=//history-view     ${wait}
    Wait Until Element Is Visible    xpath=//div[text()="prílohy"]    ${wait}
    Wait Until Element Is Visible    xpath=//div/a[@href="api/minio/bucket/penazenka?object=1/P2/sample.pdf"]
    Wait Until Element Is Visible    xpath=//div/a[@href="api/minio/bucket/penazenka?object=1/P2/sample.pdf"]
    Wait Until Page Contains    P1-Blok
    Wait Until Page Contains    P2-Potvrdenie o preventivnej prehliadke
    Sleep    3
    Go Back
    Wait Until Loading Disappears

Btn Strankovanie
    Wait Until Page Does Not Contain Element    xpath=//div[@class="progress-indicator running"]
    Click Element    xpath=//ng-es-basic-paging//li/a/span[text()="15"]
    Wait Until Element Is Visible    xpath=//ng-es-basic-paging//li/a/span[text()="30"]    ${wait}
    Click Element    xpath=//ng-es-basic-paging//li/a/span[text()="30"]
    Wait Until Element Is Visible    xpath=//ng-es-basic-paging//li/a/span[text()="60"]    ${wait}
    Click Element    xpath=//ng-es-basic-paging//li/a/span[text()="60"]
    Wait Until Element Is Visible    ${obnovitStranku}    ${wait}

Btn Export
    Click Button          ${obnovitStranku}
    Click Button       xpath=//button[span/text()="EXPORT"]
    Wait Until Page Contains    Zvoľte si typ exportu     ${wait}
    Wait Until Element Is Visible    xpath=//export-prehlad-dialog/div/button[span/text()="EXPORTOVAŤ PREHĽAD"]    ${wait}
    Click Button    xpath=//export-prehlad-dialog/div/button[span/text()="EXPORTOVAŤ PREHĽAD"]
    Wait Until Page Contains    MOJE ASYNCHRÓNNE ÚLOHY     ${wait}
    Wait Until Element Is Visible    xpath=//ul/li/a/span[span/text()="Barbastella"]    ${wait}
    Wait Until Loading Disappears
    Wait Until Element Is Visible    xpath=//table[@class="table table-condensed table-striped table-hover"]//tbody/tr  ${wait}
    Click Element    xpath=//ul/li/a/span[span/text()="Barbastella"]
    Wait Until Element Is Visible    xpath=//ul/li/a[span/text()="Prehľad benefitov"]    ${wait}
    Click Element    xpath=//ul/li/a[span/text()="Prehľad benefitov"]
    Wait Until Element Is Visible    xpath=//h3[text()="PREHĽAD BENEFITOV"]    ${wait}
    Page Should Contain    PREHĽAD BENEFITOV 
    Wait Until Element Is Visible    xpath=//button[span/text()="VÝBER STĹPCOV"]    ${wait}

Btn Vyber stlpcov
    Sleep    5
    Click Button       xpath=//button[span/text()="VÝBER STĹPCOV"]
    ${count}           SeleniumLibrary.Get Element Count    xpath=//mat-dialog-container//label
    FOR    ${INDEX}    IN RANGE      1      ${count} + 1
    Checkbox Should Be Selected    xpath=//mat-dialog-container//div[2]/div[${INDEX}]/label/input
    END