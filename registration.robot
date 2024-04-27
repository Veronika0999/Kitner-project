*** Settings ***
Library  Browser

Resource        Data_and_Config/Configuration.robot
Resource        Data_and_Config/TestData.robot

Suite Setup     Před sadou
Suite Teardown  Po sadě

Test Setup      Před sadou
Test Teardown   Po sadě

*** Test Cases ***
Registrace - úspěšná
    Registrace - úspěšná        ${USER1_EMAIL}                   ${USER1_PASSWORD}          ${USER1_NAME}       ano

Registrace - neúspěšná
    Registrace - neúspěšná      ${EMPTY}                         ${USER2_PASSWORD}          ${USER2_NAME}       ne

*** Keywords ***
Registrace - úspěšná
    [Arguments]         ${email}        ${password}     ${name}     ${registration}
    Click               ${SEL_LoginLink}
    Click               ${SEL_RegistrationLink}
    Type Text           ${SEL_UserName}                 ${USER1_NAME}
    Type Text           ${SEL_LoginFormEmail}           ${USER1_EMAIL}
    Type Text           ${SEL_LoginFormPwd}             ${USER1_PASSWORD}
    Type Text           ${SEL_LoginFormPwdAgain}        ${USER1_PASSWORD}
    Click               ${SEL_RegistrationBtn}
    Get Text            ${SEL_UserLogoutBtn}        ==       ${TEXT_Odhlasit}

Registrace - neúspěšná
    [Arguments]         ${EMPTY}           ${email}     ${name}     ${registration}
    Click               ${SEL_LoginLink}
    Click               ${SEL_RegistrationLink}
    Type Text           ${SEL_UserName}                 ${USER2_NAME}
    Type Text           ${SEL_LoginFormEmail}           ${EMPTY}
    Type Text           ${SEL_LoginFormPwd}             ${USER2_PASSWORD}
    Type Text           ${SEL_LoginFormPwdAgain}        ${USER2_PASSWORD}
    Click               ${SEL_RegistrationBtn}
    Get Text            ${SEL_LoginIncorrectEmail}    *=      ${ERROR_TEXT_EmptyEmail}

    IF    "${registration}" == "ano"
        Log To Console      Registrace byla úspěšná
        Get Text            ${SEL_UserLogoutBtn}          ==       ${TEXT_Odhlasit}
    ELSE
         Log To Console     Registrace nebyla úspěšná
         Get Text           ${SEL_LoginIncorrectEmail}    *=      ${ERROR_TEXT_EmptyEmail}
    END

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
