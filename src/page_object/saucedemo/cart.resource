*** Settings ***
Library     Browser


*** Variables ***
${CART_LIST}    css=.cart_list
${CART_ITEM}    css=.cart_item


*** Keywords ***
Verify Cart Contains Products
    [Documentation]    Verifies that the cart contains the expected number of products
    [Arguments]    ${expected_count}
    ${items}    Get Elements    ${CART_ITEM}
    Length Should Be    ${items}    ${expected_count}
