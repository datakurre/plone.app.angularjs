# bin/robot-server plone.app.angularjs.testing.PLONE_APP_ANGULARJS_ROBOT_TESTING
# bin/robot src/plone/app/angularjs/tests/robot/test_index_html.robot
*** Settings ***

Resource  plone/app/robotframework/selenium.robot
Resource  plone/app/robotframework/keywords.robot

Library  Remote  ${PLONE_URL}/RobotRemote

Test Setup  Open test browser
Test Teardown  Close all browsers

*** Variables ***

${ADMIN_ROLE}  Site Administrator

*** Test Cases ***

Site Navigation
  Given I'm logged in as a '${ADMIN_ROLE}'
    and a folder  My Folder
   When I open the Plone AngularJS App
   Then the navigation contains  My Folder

Portal Navigation
  Given I'm logged in as a '${ADMIN_ROLE}'
    and a document within a folder  My Document
   When I open the Plone AngularJS App
   Then the portal navigation contains  My Document

*** Keywords ***

I'm logged in as a '${ROLE}'
  Enable autologin as  ${ROLE}
  Go to  ${PLONE_URL}/index.html

a document
  [Arguments]  ${title}
  Create content  type=Document  id=document1  title=${title}

a folder
  [Arguments]  ${title}
  Create content  type=Folder  id=folder1  title=${title}

a document within a folder
  [Arguments]  ${title}
  ${folder_uid}  Create content  type=Folder  id=folder1  title=Folder 1
  Create content  type=Document  id=doc1  title=${title}  container=${folder_uid}

I open the Plone AngularJS App
  Go To  ${PLONE_URL}/index.html

the navigation contains
  [Arguments]  ${title}
  Page should contain  ${title}

the portal navigation contains
  [Arguments]  ${title}
  Wait until page contains element  css=#navigation-portlet-directive
  Element should contain  css=#navigation-portlet-directive  ${title}
