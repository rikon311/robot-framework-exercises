*** Settings ***
Library    Browser
Library    OperatingSystem

*** Variables ***
${URL_DOWNLOAD}       https://the-internet.herokuapp.com/download
${DOWNLOAD_DIR}    ${EXECDIR}${/}resources${/}downloads
${FILE_LINKS}         css=.example a

*** Keywords ***
Open Download Page
    [Documentation]    Opens the download page
    New Browser    chromium    headless=False    downloadsPath=${DOWNLOAD_DIR}
    New Context    acceptDownloads=True
    New Page    ${URL_DOWNLOAD}
    Wait For Elements State    ${FILE_LINKS} >> nth=0    visible

Pick Random File Link
    [Documentation]    Picks a random file link from the page and returns the file name
    ${links}    Get Elements    ${FILE_LINKS}
    ${count}    Get Length    ${links}
    ${random_index}    Evaluate    random.randint(0, ${count} - 1)    modules=random
    ${file_name}    Get Text    ${links}[${random_index}]
    RETURN    ${file_name}

Download File
    [Documentation]    Clicks the file link and verifies the file is downloaded
    [Arguments]    ${file_name}
    ${download_promise}    Promise To Wait For Download
    Click    css=a[href="download/${file_name}"]
    ${download_info}    Wait For    ${download_promise}
    Log To Console    ${download_info}
    Copy File    ${download_info}[saveAs]    ${DOWNLOAD_DIR}${/}${file_name}
    File Should Exist    ${DOWNLOAD_DIR}${/}${file_name}

Delete Downloaded File
    [Documentation]    Deletes the downloaded file from the local machine
    [Arguments]    ${file_name}
    ${file_exists}    Run Keyword And Return Status    File Should Exist    ${DOWNLOAD_DIR}${/}${file_name}
    Run Keyword If    ${file_exists}    Remove File    ${DOWNLOAD_DIR}${/}${file_name}
