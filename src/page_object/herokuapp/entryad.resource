*** Settings ***
Library     Browser


*** Variables ***
${ENTRY_AD_URL}     https://the-internet.herokuapp.com/entry_ad
${MODAL_BOX}        css=div.modal
${MODAL_CLOSE}      css=div.modal-footer>p
${CLICK_HERE}       text=click here


*** Keywords ***
Open modal url
    New Browser    chromium    headless=False
    New Page    ${ENTRY_AD_URL}
    Check modal    True

Close modal and check is disappeared
    [Documentation]    Clicks 'Close' and check that modal is disappeared
    Click    ${MODAL_CLOSE}
    Check modal    False

Refresh page x times
    [Documentation]    Refreshes the page ${refresh_counts} times.
    [Arguments]    ${refresh_counts}

    FOR    ${i}    IN RANGE    ${refresh_counts}
        Reload
        Wait For Load State    load
    END

Click "click here" link
    [Documentation]    Clicks "click here" link
    Click    ${CLICK_HERE}

Check modal
    [Documentation]    Checks whether the modal is visible or hidden.
    [Arguments]    ${should_be_visible}=True

    IF    ${should_be_visible}
        Wait For Elements State    ${MODAL_BOX}    visible
    ELSE
        Wait For Elements State    ${MODAL_BOX}    hidden
    END
