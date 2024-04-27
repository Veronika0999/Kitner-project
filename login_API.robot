*** Settings ***
Library     RequestsLibrary
Library     String
Library     Collections

*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      /login_app/userauth.php
${urlapp}   ${url}${app}

*** Test Cases ***
Successful login - Chrome
    API course login     novak        tajnenovak     Chrome    200

Successful login - Firefox
    API course login     novak        tajnenovak     Firefox    200

Unuccessful login - Novak
    API course login     Novak        tajnenovak     Chrome     403

Unsuccessful login - bad password
    API course login     admin        ffdasdfadf     Chrome     403

Unsuccessful login - bad name
    API course login    ffdasdfadf    tajneadmin     Chrome     403



*** Keywords ***
API course login
    [Arguments]         ${name}     ${pass}    ${useragent}     ${error_resp}
    ${json} =           Catenate    {"username":"${name}","password":"${pass}","useragent":"${useragent}"}
    ${json_utf8} =      Encode String To Bytes    ${json}    UTF-8

    &{header} =       Create Dictionary     Content-Type=application/json;charset=utf-8
    #&{header} =       Create Dictionary     Server=nginx/1.22.1
    #&{header} =       Create Dictionary     Date=Wed, 25 Apr 2024 04:54:58 GMT

    ${resp} =      POST     ${urlapp}     data=${json}      expected_status=Anything    headers=${header}
    Log            ${resp.json()}

    Should Be Equal    ${resp.json()}[response]    ${error_resp}

#    Log    >>>${response.headers}<<<
