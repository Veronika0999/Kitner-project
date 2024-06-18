*** Settings ***
Library     RequestsLibrary
Library     String
Library     Collections

*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}

*** Test Cases ***
Pozitivní registrace - fyzická osoba
    API course registration     1   John    Doe    fyz     8966 Valley Farms Court Ozone Park      johndoe@bestemail.com       777444111       1       Looking forward to the course       false     200

Pozitivní registrace - právnická osoba
    API course registration    2   Jane    Doe     pra     25596641                                 janedoe@bestemail.com       777444111       1       Looking forward to the course       true     200

Pozitivní registrace - telefon s předčíslím
    API course registration    2   Jane    Doe     pra     25596641                                 janedoe@bestemail.com       +420777123123       1       Looking forward to the course       true     200

Pozitivní registrace - pouze povinné položky
    API course registration    2   John    Doe     fyz     8966 Valley Farms Court Ozone Park      johndoe@bestemail.com       777123123       1       ${EMPTY}                  ${EMPTY}       200

Negativní registrace - prázdné IČO
    API course registration    2   Jane    Doe     pra     ${EMPTY}                                 janedoe@bestemail.com       777444111       1       Looking forward to the course       false     500

Negativní registrace - dlouhý telefon
    API course registration    2   Jane    Doe     pra     25596641                                 janedoe@bestemail.com       7774441111       1       Looking forward to the course       false     500

Negativní registrace - bez kurzu
    API course registration    0   Jane    Doe     pra     25596641                                 janedoe@bestemail.com       7774441111       1       Looking forward to the course       false     500

*** Keywords ***
API course registration
    [Arguments]     ${course}     ${name}    ${surname}     ${person}      ${adresa_ico}      ${email}       ${phone}      ${count}        ${comment}     ${consent}       ${responce_code}
    ${json} =     Catenate    {"targetid":"","kurz":"${course}","name":"${name}","surname":"${surname}","person":"${person}","address":"${adresa_ico}", "ico":"${adresa_ico}", "email":"${email}","phone":"${phone}","count":"${count}","comment":"${comment}","souhlas":${consent}}

    ${json_utf8} =       Encode String To Bytes    ${json}    UTF-8

    ${response} =        POST     ${urlapp}        data=${json_utf8}        expected_status=Anything
    Log                  Responce: @{response}

    Should Be Equal      ${response.json()}[response]    ${responce_code}
