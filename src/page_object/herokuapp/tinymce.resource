*** Settings ***
Library     Browser
Library     String


*** Variables ***
${URL_TINYMCE}      https://the-internet.herokuapp.com/tinymce
${EDITOR_FRAME}     css=#mce_0_ifr
${EDITOR_BODY}      css=body#tinymce
${BOLD_BUTTON}      css=.tox-tbtn[aria-label="Bold"]


*** Keywords ***
Open TinyMCE Page
    [Documentation]    Opens the TinyMCE page
    New Browser    chromium    headless=False
    New Page    ${URL_TINYMCE}
    Wait For Elements State    ${EDITOR_FRAME}    visible

Insert Random Text
    [Documentation]    Inserts a random 100 character text into the editor
    ${random_text}    Generate Random String    100
    Click    ${EDITOR_FRAME}
    Type Text    ${EDITOR_FRAME} >>> ${EDITOR_BODY}    ${random_text}
    ${displayed}    Get Text    ${EDITOR_FRAME} >>> ${EDITOR_BODY}
    Should Be Equal As Strings    ${displayed}    ${random_text}
    RETURN    ${random_text}

Make Text Bold
    [Documentation]    Selects all text and applies bold formatting
    Keyboard Key    press    Control+a
    Click    ${BOLD_BUTTON}
    ${bold_text}    Get Element    ${EDITOR_FRAME} >>>
