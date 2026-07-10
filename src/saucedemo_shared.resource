*** Settings ***
Library    Browser    timeout=30s

Resource    ./page_object/saucedemo/login.resource
Resource    ./page_object/saucedemo/products.resource
Resource    ./page_object/saucedemo/cart.resource
