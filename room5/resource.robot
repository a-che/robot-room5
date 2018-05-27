*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported Selenium2Library.
Library           Selenium2Library

*** Variables ***
${TRV ROOM URL}   http://room5.trivago.com/
${BROWSER}        Chrome
${DELAY}          0
${ERROR URL}      http://${TRV ROOM URL}/error.html
${search_input_block}   div.search-icon.open
${search_input}   input.input.search-input
${contact_link}   a:contains('Contact')
${textarea}    textarea.contact-msg
${full_name}    //span[text()='Full Name']/../input
${email}    input#contact-email.contact-input
${checkbox}    input#confirm
${submit}    //button[@class='contact-submit']

*** Keywords ***
Open Browser To Login Page for trivago
    Open Browser    ${TRV ROOM URL}    ${BROWSER}
    Set Selenium Speed    ${DELAY}
    Trivago Page Should Be Open

Open trivago room5 page
    Go To    ${TRV ROOM URL}
    Trivago Page Should Be Open

Trivago Page Should Be Open
    Title Should Be    Room5

I click to search icon in header
    Click Element    css=div.search-icon

Wait until search input is visible
    Wait Until Page Contains Element    css=${search_input_block}    timeout=5   error=false

Type in search input article about gay pride
	Click Element    css:${search_input}
    Input Text    css:${search_input}    11 Best Gay Pride Parades Where You Can Be Loud and Be Proud
    Press key  css:${search_input}    \\13

Scroll and click to contact in footer
    Execute Javascript    window.document.evaluate("//a[text()='Contact']", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Click Element    xpath=//a[text()='Contact']

I should get only one article in result with title 11 Best Gay Pride Parades Where You Can Be Loud and Be Proud
    Wait Until Page Contains   1 Search Results   timeout=50   error=false
    Wait Until Page Contains Element    //*[@class='container-wide search-results']//a[text()='11 Best Gay Pride Parades Where You Can Be Loud and Be Proud']    timeout=10   error=false

Wait until following text appears on new tab
    [arguments]  ${text}
    Select Window    new
    Wait Until Page Contains   ${text}   timeout=10   error=text Please give us feedback on what you want to read about! not found
    Wait Until Page Contains   Your Message   timeout=10   error=full name not found

Fill conftact form and check checkbox
    Press Key    css=${textarea}    test message here
    Press Key    xpath=${full_name}    artem tester
    Press Key    css=${email}    artem.tester@maiinator.com
    Execute Javascript    window.document.evaluate("${submit}", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    Click Element    css=${checkbox}

Press submit button
    Click button    xpath=${submit}

Wait until following text appears
    [arguments]  ${text}
    Wait Until Page Contains   ${text}   timeout=10   error=false
