*** Settings ***
Library     Browser


*** Variables ***
${URL_LOGIN}            https://the-internet.herokuapp.com/login
${USERNAME_FIELD}       id=username
${PASSWORD_FIELD}       id=password


*** Keywords ***
Open Login Page
    [Documentation]    Opens the login page
    New Browser    chromium    headless=False
    New Page    ${URL_LOGIN}
    Wait For Elements State    ${USERNAME_FIELD}    visible

Insert Username
    [Documentation]    Inserts username and verifies it is visible
    Type Text    ${USERNAME_FIELD}    tomsmith
    ${value}    Get Text    ${USERNAME_FIELD}
    Should Be Equal As Strings    ${value}    tomsmith

Insert Password
    [Documentation]    Inserts password and verifies it is not visible
    Type Text    ${PASSWORD_FIELD}    SuperSecretPassword!
    ${type}    Get Attribute    ${PASSWORD_FIELD}    type
    Should Be Equal As Strings    ${type}    password
