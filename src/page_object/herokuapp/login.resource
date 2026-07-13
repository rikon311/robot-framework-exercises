*** Settings ***
Variables       ../../../resources/herokuapp.yaml
Library         Browser


*** Variables ***
${URL_LOGIN}            ${urls}[login]
${USERNAME_FIELD}       id=username
${PASSWORD_FIELD}       id=password


*** Keywords ***
Open Login Page
    [Documentation]    Opens the login page
    New Browser    chromium    headless=False
    New Page    ${URL_LOGIN}
    Wait For Elements State    ${USERNAME_FIELD}    visible

Insert Username
    [Arguments]    ${username}
    Type Text    ${USERNAME_FIELD}    ${username}
    ${value}    Get Text    ${USERNAME_FIELD}
    Should Be Equal As Strings    ${value}    ${username}

Insert Password
    [Arguments]    ${password}
    Type Text    ${PASSWORD_FIELD}    ${password}
    ${type}    Get Attribute    ${PASSWORD_FIELD}    type
    Should Be Equal As Strings    ${type}    password
