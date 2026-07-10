*** Settings ***
Library    Browser
Library    OperatingSystem
Library    String


*** Variables ***
${UPLOAD_URL}    https://the-internet.herokuapp.com/upload
${UPLOAD_INPUT}    id=file-upload
${UPLOAD_BUTTON}   id=file-submit
${FILE_NAME}       testfile.txt

*** Keywords ***
Open File Upload page
  [Documentation]  Opens "https://the-internet.herokuapp.com/upload" page
  New Browser  chromium  headless=False
  New Page  ${UPLOAD_URL}
  Wait For Elements State  ${UPLOAD_BUTTON}  visible

Create Test File
    [Documentation]    Creates a test file with random 100 character text
    ${random_text}    Generate Random String    100
    Create File    ${CURDIR}/../../resources/${FILE_NAME}    ${random_text}
    File Should Exist    ${CURDIR}/../../resources/${FILE_NAME}

Upload File
    [Documentation]    Uploads a file using the Choose File button
    Upload File By Selector    ${UPLOAD_INPUT}    ${CURDIR}/../../resources/${FILE_NAME}
    Click    ${UPLOAD_BUTTON}
    Wait For Elements State    css=.example h3    visible

Delete Test File
    [Documentation]    Deletes the test file created during the test
    Remove File    ${CURDIR}/../../resources/${FILE_NAME}
    File Should Not Exist    ${CURDIR}/../../resources/${FILE_NAME}
