#
# Tento soubor obsahuje všechny Testovací Data
#

*** Variables ***
#email and password
${USER1_EMAIL}                      rataw6678qqq8a@glaslack.com
${USER1_PASSWORD}                   vercaTestuje1
${USER1_NAME}                       Verca

${USER2_PASSWORD}                   ahojAHOJ
${USER2_NAME}                       John Doe


#strings
${TEXT_MainTitle}                   Testování - Přehled kurzů
${TEXT_Prihlasit}                   Přihlásit se
${TEXT_Odhlasit}                    Odhlásit se
${TEXT_Registrovat}                 Registrovat

#Error strings
${ERROR_TEXT_IncorrectEmailOrPwd}   These credentials do not match our records.
${ERROR_TEXT_EmptyPwd}              The password field is required.
${ERROR_TEXT_EmptyEmail}            The email field is required.

#SELEKTORY pro Login a registraci
${SEL_LoginLink}                    data-test=login_link
${SEL_LoginErrorTxt}                data-test=email_input_errors
${SEL_LoginIncorrectEmail}          data-test=email_input_errors
${SEL_LoginIncorrectPwd}            data-test=password_input_errors
${SEL_UserName}                     data-testid=name_input
${SEL_LoginFormEmail}               data-test=email_input
${SEL_LoginFormPwd}                 data-test=password_input
${SEL_LoginFormPwdAgain}            data-testid=password_again_input
${SEL_UserLoginBtn}                 data-test=login_button
${SEL_UserLogoutBtn}                data-test=logout_button
${SEL_RegistrationLink}             data-testid=register_link
${SEL_RegistrationBtn}              data-testid=register_button