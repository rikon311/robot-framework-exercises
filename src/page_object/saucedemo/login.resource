*** Settings ***
Library         Browser
Variables       ../../../resources/saucedemo.yaml


*** Variables ***
${URL}                  ${urls}[saucedemo]
${USERNAME_FIELD}       id=user-name
${PASSWORD_FIELD}       id=password
${LOGIN_BUTTON}         id=login-button
${PRODUCT_LIST}         css=.inventory_list


*** Keywords ***
Open Login Page
    [Documentation]    Opens the SauceDemo login page and verifies it is visible
    New Browser    chromium    headless=False
    New Page    ${URL}
    Wait For Elements State    ${USERNAME_FIELD}    visible

Login With Valid Credentials
    [Documentation]    Performs login using valid credentials and verifies redirect to products page
    ...    Precondition: Login page must be open
    [Arguments]    ${username}    ${password}
    Type Text    ${USERNAME_FIELD}    ${username}
    Type Text    ${PASSWORD_FIELD}    ${password}
    Click    ${LOGIN_BUTTON}
    Wait For Elements State    ${PRODUCT_LIST}    visible
