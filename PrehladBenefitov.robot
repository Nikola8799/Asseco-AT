*** Settings ***
Library    SeleniumLibrary
Library    String
Library    OperatingSystem
Resource    ./resources/keywords.resource
Resource    ./resources/locators.resource
Resource    ../../../../global/resources/browser.resource
Test Setup     Setup Keyword
Test Teardown     Print Browser Logs And Close Browser

*** Test Cases ***
Prehlad Benefitov - Funkčnosť filtrov
    Kontrola filtra Evidecne cislo
    Kontrola filtra Typ benefitu
    Kontrola filtra Datum prijatia
    Kontrola filtra Datum uhrady
    Kontrola filtr Stav Ziadosti
    Kontrola filtra Stav Chiroptera
    Kontrola filtra Ukoncene
    Kontrola filtra Poskytovatel
    Kontrola filtra Pacient
    Kontrola filtra Vek
    Kontrola filtra Suma pozadovana
    Kontrola filtra Suma uhradena
    Kontrola filtra Suma schvalena
    Kontrola filtra Vaha chyby
    Kontrola filtra Typ penazenky
    Kontrola filtra Typ chyby

Kontrola funkčnosti buttonov
    Btn Detail
    Kontrola príloh v detaile
    Btn Strankovanie
    Btn Export
    Btn Vyber stlpcov
