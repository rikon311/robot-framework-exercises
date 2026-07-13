*** Settings ***
Library     Browser


*** Variables ***
${URL_ADD_REMOVE_ELEMENTS}      https://the-internet.herokuapp.com/add_remove_elements/
${ADD_ELEMENT}                  text=Add Element
${DELETE_ELEMENT}               text=Delete


*** Keywords ***
Open "Add/Remove elements" page
    [Documentation]    Opens "https://the-internet.herokuapp.com/add_remove_elements/" page and verifies it is visible
    New Browser    chromium    headless=False
    New Page    ${URL_ADD_REMOVE_ELEMENTS}
    Wait For Elements State    ${ADD_ELEMENT}    visible

Click "Add Element"
    [Documentation]    Clicks "Add Element" button and checks that "Delete" button is visible
    Click    ${ADD_ELEMENT}
    Wait For Elements State    ${DELETE_ELEMENT}    visible

Click "Delete" button
    [Documentation]    Clicks "Delete" button and checks that the "Delete" button is not visible anymore
    Click    ${DELETE_ELEMENT}
    Wait For Elements State    ${DELETE_ELEMENT}    hidden
