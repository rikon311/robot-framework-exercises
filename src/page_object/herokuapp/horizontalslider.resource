*** Settings ***
Variables       ../../../resources/herokuapp.yaml
Library         Browser


*** Variables ***
${URL_SLIDER}       ${urls}[slider]
${SLIDER}           css=input[type="range"]
${SLIDER_VALUE}     css=#range


*** Keywords ***
Open Slider Page
    [Documentation]    Opens the horizontal slider page
    New Browser    chromium    headless=False
    New Page    ${URL_SLIDER}
    Wait For Elements State    ${SLIDER}    visible

Pick Random Slider Value
    [Documentation]    Picks a random integer between 1 and 5
    ${value}    Evaluate    random.randint(1, 5)    modules=random
    RETURN    ${value}

Move Slider To Value
    [Documentation]    Moves the slider to the chosen value using arrow keys
    [Arguments]    ${value}
    Click    ${SLIDER}
    Evaluate JavaScript
    ...    ${SLIDER}
    ...    (element) => { element.value = ${value}; element.dispatchEvent(new Event('input')); element.dispatchEvent(new Event('change')); }
    ${displayed}    Get Text    ${SLIDER_VALUE}
    ${expected}    Evaluate    float(${value})
    Should Be Equal As Numbers    ${displayed}    ${expected}

Reset Slider To Zero
    [Documentation]    Resets the slider to zero using Home key
    Evaluate JavaScript
    ...    ${SLIDER}
    ...    (element) => { element.value = 0; element.dispatchEvent(new Event('input')); element.dispatchEvent(new Event('change')); }
    ${displayed}    Get Text    ${SLIDER_VALUE}
    Should Be Equal As Numbers    ${displayed}    0
