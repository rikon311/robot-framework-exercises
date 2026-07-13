*** Settings ***
Library     Browser
Library     RequestsLibrary


*** Variables ***
${URL_STATUS}       https://the-internet.herokuapp.com/status_codes
@{STATUS_CODES}     200    301    404    500


*** Keywords ***
Open Status Codes Page
    [Documentation]    Opens the status codes page
    New Browser    chromium    headless=False
    New Page    ${URL_STATUS}
    Wait For Elements State    css=.example    visible

Pick Random Status Code
    [Documentation]    Picks a random status code from the list and returns it
    ${random_code}    Evaluate    random.choice($STATUS_CODES)    modules=random
    RETURN    ${random_code}

Click Status Code Link
    [Documentation]    Clicks the link for the given status code
    [Arguments]    ${code}
    Click    text=${code}

Verify Status Code
    [Documentation]    Verifies that the page HTTP status matches the expected code
    [Arguments]    ${code}
    ${response}    GET    ${URL_STATUS}/${code}    expected_status=${code}
