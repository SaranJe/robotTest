*** Settings ***
Library  SeleniumLibrary
Test Setup  Start Testcase
Test Teardown  Finish Testcase

*** Test Cases ***
Open web URL and search keyword TV, add TV with “44 - 55 inches” screen size to cart and add TV with “32 - 43 inches” screen size to cart again
    [documentation]  Website search testing
    [tags]  functional

    Search by using Keyword  TV
    Search for TV of size  '44 - 55 inches'
    Add a Delivery item to cart
    go back
    Sleep  5s
    Uncheck TV filter for  '44 - 55 inches'
    Search for TV of size  '32 - 43 inches'
    Add a Delivery item to cart


*** Keywords ***
Start Testcase
    Open Browser  https://www.powerbuy.co.th/th/   chrome
    MAXIMIZE BROWSER WINDOW
    click element  xpath://a[@id='lnk-setLanguageDesktop-en']
    Sleep  5s

Search by using Keyword
    [Arguments]     ${search_key}
    click element  xpath://input[starts-with(@class, 'SearchBox__SearchInput') and @id='txt-searchBox-input' and not(@type)]
    input text  xpath://input[starts-with(@class, 'SearchBox__SearchInput') and @id='txt-searchBox-input' and not(@type)]  ${search_key}
    click element  xpath://img[@src='/images/ic-search.svg' and @class='Icon-sc-134752z-0 bhdaRb']
    Sleep  5s

Search for TV of size
    [Arguments]     ${tv_size}
    click element  xpath://div[contains(text(),'Screen Size Group (inches)')]/../following-sibling::div//div[contains(text(), ${tv_size})]/../preceding-sibling::div/div[contains(@class, 'Checkbox')]
    Sleep  7s

Add a Delivery item to cart
    click element  xpath://div[text()='Delivery' and starts-with(@class, 'ProductGridItem')][1]/ancestor::div[starts-with(@class, 'ProductGridItem')]/descendant::div[contains(@class,'ProductBadge')]
    wait until element is visible  xpath://span[text()="Add to Cart"]/ancestor::button[starts-with(@id,"btn-addCart")]
    click element  xpath://span[text()="Add to Cart"]/ancestor::button[starts-with(@id,"btn-addCart")]
    wait until element is visible  xpath://span[contains(text(), "your shopping cart") and starts-with(text(), "You added")]  10s
    Sleep  3s

Uncheck TV filter for
    [Arguments]     ${tv_size}
    wait until element is visible  xpath://div[contains(text(),'Screen Size Group (inches)')]/../following-sibling::div//div[contains(text(), ${tv_size})]/../preceding-sibling::div/div[contains(@class, 'Checkbox')]
    click element  xpath://div[contains(text(),'Screen Size Group (inches)')]/../following-sibling::div//div[contains(text(), ${tv_size})]/../preceding-sibling::div/div[contains(@class, 'Checkbox')]

Finish Testcase
    Close Browser