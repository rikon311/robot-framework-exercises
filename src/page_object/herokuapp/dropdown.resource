*** Settings ***
Library     Browser


*** Variables ***
${URL_DROPDOWN}     https://the-internet.herokuapp.com/dropdown
${DROPDOWN}         id=dropdown


*** Keywords ***
Open "Dropdown" page
    [Documentation]    Open https://the-internet.herokuapp.com/dropdown url
    New Browser    chromium    headless=False
    New Page    ${URL_DROPDOWN}
    Wait For Elements State    ${DROPDOWN}    visible

Check selected option
    [Documentation]    Checks the selected option for dropdown
    [Arguments]    ${option}
    ${selected_text}    Get Selected Options    ${DROPDOWN}    text
    Should Be Equal As Strings    ${selected_text}[0]    ${option}

Select option
    [Documentation]    Clicks the dropdown and selects an option by text
    [Arguments]    ${option}
    Select Options By    ${DROPDOWN}    text    ${option}
