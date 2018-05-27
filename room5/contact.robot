*** Settings ***
Documentation     A test suite with a single test for contact
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          resource.robot

*** Test Cases ***
Submit form
    Given Open Browser To Login Page for trivago
    When Scroll and click to contact in footer
    Then Wait Until Following Text Appears On New Tab  Please give us feedback on what you want to read about!
    When Fill conftact form and check checkbox
    And press submit button
    Then Wait until following text appears    Message Sent Successfully!
    [Teardown]    Close Browser

