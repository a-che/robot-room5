*** Settings ***
Documentation     A test suite with a single test for valid login.
...
...               This test has a workflow that is created using keywords in
...               the imported resource file.
Resource          resource.robot

*** Test Cases ***
Search in room5
    Given Open Browser To Login Page for trivago
    When I click to search icon in header
    Then Wait until search input is visible
    When Type in search input article about gay pride
    Then I should get only one article in result with title 11 Best Gay Pride Parades Where You Can Be Loud and Be Proud


