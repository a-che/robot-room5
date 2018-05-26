*** Settings ***
Documentation     A test suite with a single test for valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          resource.robot

*** Test Cases ***
Submit form
    Open Browser To Login Page for trivago
    Scroll and click to contact in footer
    [Teardown]    Close Browser


