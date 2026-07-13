*** Settings ***
Library     Browser


*** Variables ***
${URL_BASIC_AUTH}       https://admin:admin@the-internet.herokuapp.com/basic_auth
${SUCCESS_MSG}          css=.example p


*** Keywords ***
Open Basic Auth Page
    [Documentation]    Opens the basic auth page with credentials in URL
    New Browser    chromium    headless=False
    New Page    ${URL_BASIC_AUTH}
    Wait For Elements State    ${SUCCESS_MSG}    visible

Verify Authentication Successful
    [Documentation]    Verifies that authentication was successful
    ${text}    Get Text    ${SUCCESS_MSG}
    Should Contain    ${text}    Congratulations
