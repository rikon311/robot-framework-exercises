*** Settings ***
Library     Browser


*** Variables ***
${PRODUCT_LIST}         css=.inventory_list
${ADD_BACKPACK}         css=[data-test="add-to-cart-sauce-labs-backpack"]
${ADD_BIKE_LIGHT}       css=[data-test="add-to-cart-sauce-labs-bike-light"]
${CART_BADGE}           css=.shopping_cart_badge
${CART_ICON}            css=.shopping_cart_link


*** Keywords ***
Verify Product List Is Visible
    [Documentation]    Verifies that the product list is displayed on the page
    Wait For Elements State    ${PRODUCT_LIST}    visible

Add Backpack To Cart
    [Documentation]    Adds Sauce Labs Backpack to the cart and verifies button changes to Remove
    Click    ${ADD_BACKPACK}
    Wait For Elements State    css=[data-test="remove-sauce-labs-backpack"]    visible

Add Bike Light To Cart
    [Documentation]    Adds Sauce Labs Bike Light to the cart and verifies button changes to Remove
    Click    ${ADD_BIKE_LIGHT}
    Wait For Elements State    css=[data-test="remove-sauce-labs-bike-light"]    visible

Open Cart
    [Documentation]    Clicks the cart icon to navigate to the cart page
    Click    ${CART_ICON}
