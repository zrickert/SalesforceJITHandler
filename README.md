# SalesforceJITHandler
Just-in-Time Handler for Salesforce

## Maps these Fields
Assertion attributes | Description | Contact  | User | SAML Attribute
affiliation | eduPerson affiliation |  |  | 
email | email (uwEWPEmail1 or uwSWPEmail or id@uw.edu) | Personal_Email__c |  | urn:oid:0.9.2342.19200300.100.1.3
employeeNumber | Employee id (PDS: uwEmployeeID) | Employee_ID__c | EmployeeNumber | urn:oid:2.16.840.1.113730.3.1.3
givenName | Based on preferred name parts (first, middle) if available, else PDS: uwPersonRegisteredFirstMiddle |  |  | 
phone | Employee phone (PDS: uwEWPPhone1) | Phone | Phone | urn:oid:2.5.4.20
preferredFirst | Preferred first name (PDS: uwPersonPreferredFirst) | Preferred_First_Name__c | preferredFirst__c | urn:oid:1.2.840.113994.200.47
preferredMiddle | Preferred middle name (PDS: uwPersonPreferredMiddle) | Preferred_Middle_Name__c | preferredMiddle__c | urn:oid:1.2.840.113994.200.48
preferredSurname | Preferred surname (PDS: uwPersonPreferredSurname) | Preferred_Last_Name__c | preferredSurname__c | urn:oid:1.2.840.113994.200.49
registeredGivenName | Registered givenname (PDS: uwPersonRegisteredFirstMidddle) | FirstName | FirstName | urn:oid:1.2.840.113994.200.32
registeredSurname | Registered surname (PDS: uwPersonRegisteredSurname) | LastName | LastName | urn:oid:1.2.840.113994.200.31
surname | PDS: uwPersonPreferredSurname if available, else PDS:uwPersonRegisteredSurname |  |  | 
title | Title (PDS: uwEWPTitle1) | Title | Title | urn:oid:2.5.4.12
uwEduEmail | UW.EDU email (netid@uw.edu) | hed__UniversityEmail__c | SenderEmail | urn:oid:1.2.840.113994.200.45
uwNetID | UW NetID | UWNetID__c | CommunityNickname, Alias | urn:oid:0.9.2342.19200300.100.1.1
uwRegID | UW registry id | UW_Registry_ID__c | UW_Registry_ID__c | urn:oid:1.2.840.113994.200.24
uwStudentID | UW Student ID | Student_Number__c | Student_Number__c | urn:oid:1.2.840.113994.200.21
uwStudentSystemKey | UW Student System Key | EDW_System_Key__c | EDW_System_Key__c | urn:oid:1.2.840.113994.200.20