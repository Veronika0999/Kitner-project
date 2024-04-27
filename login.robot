*** Settings ***
Library  Browser

Resource        Data_and_Config/Configuration.robot
Resource        Data_and_Config/TestData.robot

Suite Setup     Před sadou
Suite Teardown  Po sadě

Test Setup      Před sadou
Test Teardown   Po sadě

*** Test Cases ***
Login - úspěšné přihlášení
    Login                       ${USER1_EMAIL}                ${USER1_PASSWORD}
    Uživatel je přihlášen

Login - chybné heslo
    Login                       ${USER1_EMAIL}                 chyba
    Uživatel není přihlášen
    Chybova hlaska neplatne udaje

Login - chybné jméno
    Login                       blbe@neco.cz                   ${USER1_PASSWORD}
    Uživatel není přihlášen
    Chybova hlaska neplatne udaje

Login - prázdné heslo
    Login                       ${USER1_EMAIL}                  ${EMPTY}
    Uživatel není přihlášen
    Chybova hlaska prazdne heslo

Login - prázdný email
    Login                       ${EMPTY}                        ${USER1_PASSWORD}
    Uživatel není přihlášen
    Chybova hlaska prazdny email

*** Keywords ***
Login
   [Arguments]      ${Email}                         ${Heslo}
   Click            ${SEL_LoginLink}
   Type Text        ${SEL_LoginFormEmail}            ${Email}
   Type Text        ${SEL_LoginFormPwd}              ${Heslo}
   Click            ${SEL_UserLoginBtn}
   Take Screenshot

Uživatel je přihlášen
    Get Text        ${SEL_UserLogoutBtn}     ==       ${TEXT_Odhlasit}
    Take Screenshot

Uživatel není přihlášen
    Get Text        ${SEL_LoginLink}         ==       ${TEXT_Prihlasit}
    Take Screenshot

Chybova hlaska neplatne udaje
    Get Text   ${SEL_LoginErrorTxt}          *=       ${ERROR_TEXT_IncorrectEmailOrPwd}   # AssertNeg1
    Take Screenshot

Chybova hlaska prazdny email
    Get Text   ${SEL_LoginIncorrectEmail}    *=      ${ERROR_TEXT_EmptyEmail}
    Take Screenshot

Chybova hlaska prazdne heslo
    Get Text   ${SEL_LoginIncorrectPwd}      *=      ${ERROR_TEXT_EmptyPwd}
    Take Screenshot

Před sadou
    New Browser                  chromium            headless=False
    New Page                     ${URL}
    Set Browser Timeout          ${TIMEOUT_BROWSER}
    Get Title  ==                ${TEXT_MainTitle}

Po sadě
     Close Browser

Před testem
     Go To              ${URL}

Po testu
     Go To              ${URL}
