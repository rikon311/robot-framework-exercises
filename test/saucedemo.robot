*** Settings ***
Documentation       Test Suite for SauceDemo application

Resource            ../src/saucedemo_shared.resource


*** Test Cases ***
TC01 - Valid Login
    [Documentation]    Verifies that a valid user can login and see the product list
    ...    Precondition: Open Login Page
    Open Login Page
    Login With Valid Credentials    standard_user    secret_sauce
    Verify Product List Is Visible
    [Teardown]    Close Browser

TC02 - Add Products To Cart
    [Documentation]    Verifies that two products can be added to the cart
    ...    Precondition: Open Login Page, Login With Valid Credentials
    Open Login Page
    Login With Valid Credentials    standard_user    secret_sauce
    Add Backpack To Cart
    Add Bike Light To Cart
    Open Cart
    Verify Cart Contains Products    2
    [Teardown]    Close Browser
