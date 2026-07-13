*** Settings ***
Library     Browser


*** Variables ***
${URL_CHECKBOXES}       https://the-internet.herokuapp.com/checkboxes
${CHECKBOX_1}           css=input[type="checkbox"]:nth-of-type(1)
${CHECKBOX_2}           css=input[type="checkbox"]:nth-of-type(2)


*** Keywords ***
Open Checkboxes Page
    [Documentation]    Opens the checkboxes page
    New Browser    chromium    headless=False
    New Page    ${URL_CHECKBOXES}
    Wait For Elements State    ${CHECKBOX_1}    visible

Verify Initial State
    [Documentation]    Verifies checkbox 1 is unchecked and checkbox 2 is checked
    Get Checkbox State    ${CHECKBOX_1}    ==    unchecked
    Get Checkbox State    ${CHECKBOX_2}    ==    checked

Select All Checkboxes
    [Documentation]    Selects checkbox 1 so all checkboxes are checked
    Check Checkbox    ${CHECKBOX_1}
    Get Checkbox State    ${CHECKBOX_1}    ==    checked
    Get Checkbox State    ${CHECKBOX_2}    ==    checked

Deselect All Checkboxes
    [Documentation]    Deselects all checkboxes
    Uncheck Checkbox    ${CHECKBOX_1}
    Uncheck Checkbox    ${CHECKBOX_2}
    Get Checkbox State    ${CHECKBOX_1}    ==    unchecked
    Get Checkbox State    ${CHECKBOX_2}    ==    unchecked
