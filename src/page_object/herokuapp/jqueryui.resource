*** Settings ***
Library    Browser
Library    Collections

*** Variables ***
${URL_JQUERYUI}     https://the-internet.herokuapp.com/jqueryui
${MENU_LINK}        text=menu
${ENABLE_MENU}      text=Enable
${DOWNLOADS_MENU}   text=Downloads
@{FILE_TYPES}       PDF    CSV    Excel
${DOWNLOAD_DIR}     ${EXECDIR}${/}resources${/}downloads

*** Keywords ***
Open JQuery UI Page
    [Documentation]    Opens the jQuery UI page
    New Browser    chromium    headless=False    downloadsPath=${DOWNLOAD_DIR}
    New Context    acceptDownloads=True
    New Page    ${URL_JQUERYUI}
    Wait For Elements State    ${MENU_LINK}    visible

Click Menu Link
    [Documentation]    Clicks the menu link and verifies Disable/Enable menu is visible
    Click    ${MENU_LINK}
    Wait For Elements State    ${ENABLE_MENU}    visible

Hover Enable Menu
    [Documentation]    Hovers over Enable menu and verifies Downloads submenu appears
    Hover    ${ENABLE_MENU}
    Wait For Elements State    ${DOWNLOADS_MENU}    visible
    Hover    ${DOWNLOADS_MENU}

Pick Random File Type And Download
    [Documentation]    Picks a random file type and clicks to download
    ${random_type}    Evaluate    random.choice($FILE_TYPES)    modules=random
    ${download_promise}    Promise To Wait For Download
    Click    text=${random_type}
    ${download_info}    Wait For    ${download_promise}
    Log    Downloaded: ${random_type}    console=True
