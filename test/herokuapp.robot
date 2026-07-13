*** Settings ***
Documentation    Test Suite for Herokuapp application
Resource         ../src/herokuapp_shared.resource


*** Test Cases ***
TC01 - Add & Remove Elements
    [Documentation]    Verifies add/remove element from the page
    ...    Precondition: Open "https://the-internet.herokuapp.com/add_remove_elements/"
    Open "Add/Remove elements" page
    Click "Add Element"
    Click "Delete" button
    [Teardown]    Close Browser

TC02 - Dropdown
   [Documentation]   Verifies dropdown functionality from the page
   ...   Precondition: Open "https://the-internet.herokuapp.com/dropdown" page
   Open "Dropdown" page
   Check selected option   Please select an option
   Select option   Option 1
   Check selected option   Option 1
   Select option   Option 2
   Check selected option   Option 2

TC03 - File Upload
    [Documentation]    Verifies file upload functionality
    ...    Precondition: Open File Upload Page
    Create Test File
    Open File Upload Page
    Upload File
    [Teardown]    Delete Test File

TC04 - Status Codes
    [Documentation]    Verifies that clicking a status code link loads the correct HTTP status
    Open Status Codes Page
    ${code}    Pick Random Status Code
    Click Status Code Link    ${code}
    Verify Status Code    ${code}
    [Teardown]    Close Browser

TC05 - Horizontal Slider
    [Documentation]    Verifies horizontal slider functionality
    ...    Precondition: Open Slider Page
    Open Slider Page
    ${value}    Pick Random Slider Value
    Move Slider To Value    ${value}
    Reset Slider To Zero
    [Teardown]    Close Browser

TC06 - Checkboxes
    [Documentation]    Verifies checkboxes functionality
    ...    Precondition: Open Checkboxes Page
    Open Checkboxes Page
    Verify Initial State
    Select All Checkboxes
    Deselect All Checkboxes
    [Teardown]    Close Browser

TC07 - TinyMCE
    [Documentation]    Verifies TinyMCE editor functionality
    ...    Precondition: Open TinyMCE Page
    Open TinyMCE Page
    Insert Random Text
    Make Text Bold
    [Teardown]    Close Browser

TC08 - File Download
    [Documentation]    Verifies file download functionality
    ...    Precondition: Open Download Page
    Open Download Page
    ${file_name}    Pick Random File Link
    ${file_path}    Download File    ${file_name}
    [Teardown]    Run Keywords    Delete Downloaded File    ${file_name}    AND    Close Browser

TC09 - Entry ad
   [Documentation]   Verifies the modal functionality
   Open modal url
   Close modal and check is disappeared
   Refresh page x times  3
   Check modal  False
   Click "click here" link
   Refresh page x times  1
   Check modal  True
   [Teardown]    Close Browser
