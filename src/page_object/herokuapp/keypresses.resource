*** Settings ***
Library     Browser


*** Variables ***
${KEY_PRESSES_URL}      https://the-internet.herokuapp.com/key_presses
${TEXT_FIELD}           id=target
${TEXTED_CHARACTER}     id=result


*** Keywords ***
Open "key presses" page
    [Documentation]    Opens https://the-internet.herokuapp.com/key_presses
    New Browser    chromium    headless=False
    New Page    ${KEY_PRESSES_URL}
    Wait For Elements State    ${TEXT_FIELD}    visible

Select text field
    [Documentation]    Focuses the text field and checks no character is typed
    Click    ${TEXT_FIELD}
    Wait For Elements State    ${TEXTED_CHARACTER}    hidden

Type in text field
    [Documentation]    Fill the text field with the string passed as input
    [Arguments]    ${string}
    Type Text    ${TEXT_FIELD}    ${string}    100ms

Verify character typed
    [Documentation]    Checks that the last character typed is present in result paragraph
    [Arguments]    ${last_character_typed}
    ${result}=    Get Text    ${TEXTED_CHARACTER}
    Should End With    ${result}    ${last_character_typed}

Clear text field
    [Documentation]    Clear text field
    Clear Text    ${TEXT_FIELD}
