*** Settings ***
Library    Browser

*** Variables ***
${URL_CONTEXT}      https://the-internet.herokuapp.com/context_menu
${HOT_SPOT}         id=hot-spot

*** Keywords ***
Open Context Menu Page
    [Documentation]    Opens the context menu page
    New Browser    chromium    headless=False
    New Page    ${URL_CONTEXT}
    Wait For Elements State    ${HOT_SPOT}    visible

Right Click On Hot Spot
    [Documentation]    Moves mouse to center of hot spot area and right clicks
    ${box}    Get BoundingBox    ${HOT_SPOT}
    ${center_x}    Evaluate    ${box}[x] + ${box}[width] / 2
    ${center_y}    Evaluate    ${box}[y] + ${box}[height] / 2
    Mouse Move    ${center_x}    ${center_y}
    Click    ${HOT_SPOT}    button=right

Verify Context Menu Not Visible Outside Area
    [Documentation]    Verifies context menu does not appear outside the hot spot
    ${viewport}    Get Viewport Size
    ${x}    Evaluate    ${viewport}[width] - 100
    ${y}    Evaluate    ${viewport}[height] / 2
    Mouse Move    ${x}    ${y}
    Mouse Button    action=click    button=right
    Wait For Elements State    ${HOT_SPOT}    visible

Accept Context Menu Alert
    [Documentation]    Accepts the alert dialog that appears after right click
    Handle Future Dialogs    action=accept
    Mouse Button    right    0    0
