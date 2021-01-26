//This Autocreated Handler has been modified to read UW SAML request.

//This class provides logic for inbound just-in-time provisioning of single sign-on users in your Salesforce organization.
global class JITHandler_UW implements Auth.SamlJitHandler {
	private class JitException extends Exception{}

    private void handleUser(boolean create, User u, Map<String, String> attributes,
		String federationIdentifier, boolean isStandard) {
		system.debug('*** Running handleUser');
            
        if(create && attributes.containsKey('User.Username')) {
			u.Username = attributes.get('User.Username');
		}
		if(create) {
			if(attributes.containsKey('User.FederationIdentifier')) {
				u.FederationIdentifier = attributes.get('User.FederationIdentifier');
			} else {
				u.FederationIdentifier = federationIdentifier;
			}
		}
		if(attributes.containsKey('User.Phone')) {
			u.Phone = attributes.get('User.Phone');
		}
		if(attributes.containsKey('User.Email')) {
			u.Email = attributes.get('User.Email');
		}
		if(attributes.containsKey('User.FirstName')) {
			u.FirstName = attributes.get('User.FirstName');
		}
		if(attributes.containsKey('User.LastName')) {
			u.LastName = attributes.get('User.LastName');
		}
/* 		if(attributes.containsKey('User.Title')) {
			u.Title = attributes.get('User.Title');
		}
		if(attributes.containsKey('User.CompanyName')) {
			u.CompanyName = attributes.get('User.CompanyName');
		}
		if(attributes.containsKey('User.AboutMe')) {
			u.AboutMe = attributes.get('User.AboutMe');
		}
		if(attributes.containsKey('User.Street')) {
			u.Street = attributes.get('User.Street');
		}
		if(attributes.containsKey('User.State')) {
			u.State = attributes.get('User.State');
		}
		if(attributes.containsKey('User.City')) {
			u.City = attributes.get('User.City');
		}
		if(attributes.containsKey('User.Zip')) {
			u.PostalCode = attributes.get('User.Zip');
		}
		if(attributes.containsKey('User.Country')) {
			u.Country = attributes.get('User.Country');
		}
		if(attributes.containsKey('User.CallCenter')) {
			u.CallCenterId = attributes.get('User.CallCenter');
		}
		if(attributes.containsKey('User.Manager')) {
			u.ManagerId = attributes.get('User.Manager');
		}
		if(attributes.containsKey('User.MobilePhone')) {
			u.MobilePhone = attributes.get('User.MobilePhone');
		}
		if(attributes.containsKey('User.DelegatedApproverId')) {
			u.DelegatedApproverId = attributes.get('User.DelegatedApproverId');
		}
		if(attributes.containsKey('User.Department')) {
			u.Department = attributes.get('User.Department');
		}
		if(attributes.containsKey('User.Division')) {
			u.Division = attributes.get('User.Division');
		}
*/
		if(attributes.containsKey('User.EmployeeNumber')) {
			u.EmployeeNumber = attributes.get('User.EmployeeNumber');
		}
/*
		if(attributes.containsKey('User.Extension')) {
			u.Extension = attributes.get('User.Extension');
		}
		if(attributes.containsKey('User.Fax')) {
			u.Fax = attributes.get('User.Fax');
		}
*/
		if(attributes.containsKey('User.CommunityNickname')) {
			u.CommunityNickname = attributes.get('User.CommunityNickname');
		}
/*		if(attributes.containsKey('User.ReceivesAdminInfoEmails')) {
			String ReceivesAdminInfoEmailsVal = attributes.get('User.ReceivesAdminInfoEmails');
			u.ReceivesAdminInfoEmails = '1'.equals(ReceivesAdminInfoEmailsVal) || Boolean.valueOf(ReceivesAdminInfoEmailsVal);
		}
		if(attributes.containsKey('User.ReceivesInfoEmails')) {
			String ReceivesInfoEmailsVal = attributes.get('User.ReceivesInfoEmails');
			u.ReceivesInfoEmails = '1'.equals(ReceivesInfoEmailsVal) || Boolean.valueOf(ReceivesInfoEmailsVal);
		}
*/
		String uid = UserInfo.getUserId();
		User currentUser = 
			[SELECT LocaleSidKey, LanguageLocaleKey, TimeZoneSidKey, EmailEncodingKey FROM User WHERE Id=:uid];
		if(attributes.containsKey('User.LocaleSidKey')) {
			u.LocaleSidKey = attributes.get('User.LocaleSidKey');
		} else if(create) {
			u.LocaleSidKey = currentUser.LocaleSidKey;
		}
		if(attributes.containsKey('User.LanguageLocaleKey')) {
			u.LanguageLocaleKey = attributes.get('User.LanguageLocaleKey');
		} else if(create) {
			u.LanguageLocaleKey = currentUser.LanguageLocaleKey;
		}
		if(attributes.containsKey('User.Alias')) {
			u.Alias = attributes.get('User.Alias');
		} else if(create) {
			String alias = '';
			if(u.FirstName == null) {
				alias = u.LastName;
			} else {
				alias = u.FirstName.charAt(0) + u.LastName;
			}
			if(alias.length() > 5) {
				alias = alias.substring(0, 5);
			}
			u.Alias = alias;
		}
		if(attributes.containsKey('User.TimeZoneSidKey')) {
			u.TimeZoneSidKey = attributes.get('User.TimeZoneSidKey');
		} else if(create) {
			u.TimeZoneSidKey = currentUser.TimeZoneSidKey;
		}
		if(attributes.containsKey('User.EmailEncodingKey')) {
			u.EmailEncodingKey = attributes.get('User.EmailEncodingKey');
		} else if(create) {
			u.EmailEncodingKey = currentUser.EmailEncodingKey;
		}

		/*
		 * If you are updating Contact or Account object fields, you cannot update the following User fields at the same time.
		 * If your identity provider sends these User fields as attributes along with Contact 
		 * or Account fields, you must modify the logic in this class to update either these 
		 * User fields or the Contact and Account fields.
		 */
		if(attributes.containsKey('User.IsActive')) {
			String IsActiveVal = attributes.get('User.IsActive');
			u.IsActive = '1'.equals(IsActiveVal) || Boolean.valueOf(IsActiveVal);
		}
		if(attributes.containsKey('User.ForecastEnabled')) {
			String ForecastEnabledVal = attributes.get('User.ForecastEnabled');
			u.ForecastEnabled = '1'.equals(ForecastEnabledVal) || Boolean.valueOf(ForecastEnabledVal);
		}

		if(attributes.containsKey('User.ProfileId')) {
			String profileId = attributes.get('User.ProfileId');
			Profile p = [SELECT Id FROM Profile WHERE Id=:profileId];
			u.ProfileId = p.Id;
		}
		if(attributes.containsKey('User.UserRoleId')) {
			String userRole = attributes.get('User.UserRoleId');
			UserRole r = [SELECT Id FROM UserRole WHERE Id=:userRole];
			u.UserRoleId = r.Id;
		}

//--------------Begin Custom User Fields------------------------
        //Handle custom fields here 
        
        if(attributes.containsKey('User.Student_Number__c')) {
			u.Student_Number__c = attributes.get('User.Student_Number__c');
		}
        if(attributes.containsKey('User.preferredSurname__c')) {
			u.preferredSurname__c = attributes.get('User.preferredSurname__c');
		}
        if(attributes.containsKey('User.preferredFirst__c')) {
			u.preferredFirst__c = attributes.get('User.preferredFirst__c');
		}
        if(attributes.containsKey('User.preferredMiddle__c')) {
			u.preferredMiddle__c = attributes.get('User.preferredMiddle__c');
		}
        if(attributes.containsKey('User.EDW_System_Key__c')) {
			u.EDW_System_Key__c = attributes.get('User.EDW_System_Key__c');
		}
        if(attributes.containsKey('User.UW_Registry_ID__c')) {
			u.UW_Registry_ID__c = attributes.get('User.UW_Registry_ID__c');
		}

//--------------End Custom User Fields--------------------------
		
		if(!create) {
			update(u);
		//Not sure why the Insert call is missing in the default code ??
        } else {
            insert u;
        }
	}
	
    // private void handleContact(boolean create, String accountId, User u, Map<String, String> attributes) {
	private void handleContact(boolean create, User u, Map<String, String> attributes) {
		system.debug('***Running handleContact - Attributes:' + attributes);
		system.debug('***Create: ' + create);
        Contact c;
		boolean newContact = false;
        
		if(create) {
			if(attributes.containsKey('User.Contact')) {
			String contact = attributes.get('User.Contact');
				c = [SELECT Id, AccountId FROM Contact WHERE Id=:contact];
				u.ContactId = contact;
			} else {
				c = new Contact();
				newContact = true;
			}
		} else {
			if(attributes.containsKey('User.Contact')) {
				String contact = attributes.get('User.Contact');
				c = [SELECT Id, AccountId FROM Contact WHERE Id=:contact];
				if(u.ContactId != c.Id) {
					throw new JitException('Cannot change User.ContactId');
				}
			} else {
				String thisContact = u.ContactId;
                system.debug('contact id: ' + thisContact);
				c = [SELECT Id, AccountId FROM Contact WHERE Id=:thisContact];
			}
		}
        
        
        //Comment out due to EDA Administrative Accounts being created.
		/*if(!newContact && c.AccountId != accountId) {
			throw new JitException('Mismatched account: ' + c.AccountId + ', ' + accountId);
		} 
		*/
		if(attributes.containsKey('Contact.Email')) {
			c.Email = attributes.get('Contact.Email');
		}
		if(attributes.containsKey('Contact.FirstName')) {
			c.FirstName = attributes.get('Contact.FirstName');
		}
		if(attributes.containsKey('Contact.LastName')) {
			c.LastName = attributes.get('Contact.LastName');
		}
		if(attributes.containsKey('Contact.Phone')) {
			c.Phone = attributes.get('Contact.Phone');
		}
/*		if(attributes.containsKey('Contact.MailingStreet')) {
			c.MailingStreet = attributes.get('Contact.MailingStreet');
		}
		if(attributes.containsKey('Contact.MailingCity')) {
			c.MailingCity = attributes.get('Contact.MailingCity');
		}
		if(attributes.containsKey('Contact.MailingState')) {
			c.MailingState = attributes.get('Contact.MailingState');
		}
		if(attributes.containsKey('Contact.MailingCountry')) {
			c.MailingCountry = attributes.get('Contact.MailingCountry');
		}
		if(attributes.containsKey('Contact.MailingPostalCode')) {
			c.MailingPostalCode = attributes.get('Contact.MailingPostalCode');
		}
		if(attributes.containsKey('Contact.OtherStreet')) {
			c.OtherStreet = attributes.get('Contact.OtherStreet');
		}
		if(attributes.containsKey('Contact.OtherCity')) {
			c.OtherCity = attributes.get('Contact.OtherCity');
		}
		if(attributes.containsKey('Contact.OtherState')) {
			c.OtherState = attributes.get('Contact.OtherState');
		}
		if(attributes.containsKey('Contact.OtherCountry')) {
			c.OtherCountry = attributes.get('Contact.OtherCountry');
		}
		if(attributes.containsKey('Contact.OtherPostalCode')) {
			c.OtherPostalCode = attributes.get('Contact.OtherPostalCode');
		}
		if(attributes.containsKey('Contact.AssistantPhone')) {
			c.AssistantPhone = attributes.get('Contact.AssistantPhone');
		}
		if(attributes.containsKey('Contact.Department')) {
			c.Department = attributes.get('Contact.Department');
		}
		if(attributes.containsKey('Contact.Description')) {
			c.Description = attributes.get('Contact.Description');
		}
		if(attributes.containsKey('Contact.Fax')) {
			c.Fax = attributes.get('Contact.Fax');
		}
		if(attributes.containsKey('Contact.HomePhone')) {
			c.HomePhone = attributes.get('Contact.HomePhone');
		}
		if(attributes.containsKey('Contact.MobilePhone')) {
			c.MobilePhone = attributes.get('Contact.MobilePhone');
		}
		if(attributes.containsKey('Contact.OtherPhone')) {
			c.OtherPhone = attributes.get('Contact.OtherPhone');
		}
		if(attributes.containsKey('Contact.Title')) {
			c.Title = attributes.get('Contact.Title');
		}
		if(attributes.containsKey('Contact.Salutation')) {
			c.Salutation = attributes.get('Contact.Salutation');
		}
		if(attributes.containsKey('Contact.LeadSource')) {
			c.LeadSource = attributes.get('Contact.LeadSource');
		}
		if(attributes.containsKey('Contact.DoNotCall')) {
			String DoNotCallVal = attributes.get('Contact.DoNotCall');
			c.DoNotCall = '1'.equals(DoNotCallVal) || Boolean.valueOf(DoNotCallVal);
		}
		if(attributes.containsKey('Contact.HasOptedOutOfEmail')) {
			String HasOptedOutOfEmailVal = attributes.get('Contact.HasOptedOutOfEmail');
			c.HasOptedOutOfEmail = '1'.equals(HasOptedOutOfEmailVal) || Boolean.valueOf(HasOptedOutOfEmailVal);
		}
		if(attributes.containsKey('Contact.HasOptedOutOfFax')) {
			String HasOptedOutOfFaxVal = attributes.get('Contact.HasOptedOutOfFax');
			c.HasOptedOutOfFax = '1'.equals(HasOptedOutOfFaxVal) || Boolean.valueOf(HasOptedOutOfFaxVal);
		}
		if(attributes.containsKey('Contact.Owner')) {
			c.OwnerId = attributes.get('Contact.Owner');
		}
		if(attributes.containsKey('Contact.AssistantName')) {
			c.AssistantName = attributes.get('Contact.AssistantName');
		}
		if(attributes.containsKey('Contact.Birthdate')) {
			c.Birthdate = Date.valueOf(attributes.get('Contact.Birthdate'));
		} 
*/
        //--------------Begin Custom Contact Fields------------------------
		if(attributes.containsKey('Contact.UWNetID')) {
            system.debug('Inserting UWNetID to contact: '+ attributes.get('Contact.UWNetID'));
			c.UWNetID__c = attributes.get('Contact.UWNetID');
		}
		
        if(attributes.containsKey('Contact.Email')) {
			c.hed__UniversityEmail__c = attributes.get('Contact.Email');
            //c.hed__Preferred_Email__c = 'University'; Add later on.
		}
        if(attributes.containsKey('Contact.Personal_Email__c')) {
			c.Personal_Email__c = attributes.get('Contact.Personal_Email__c');
		}
        if(attributes.containsKey('Contact.Student_Number__c')) {
        	system.debug('***Student Number in if statement in attributes: ' + attributes.get('Contact.Student_Number__c'));
			c.Student_Number__c = attributes.get('Contact.Student_Number__c');
		}
        //system.debug('*** Contact Student Number: ' + c.Student_Number__c);
            
        if(attributes.containsKey('Contact.Preferred_Last_Name__c')) {
			c.Preferred_Last_Name__c = attributes.get('Contact.Preferred_Last_Name__c');
		}
        if(attributes.containsKey('Contact.Preferred_First_Name__c')) {
			c.Preferred_First_Name__c = attributes.get('Contact.Preferred_First_Name__c');
		}
        if(attributes.containsKey('Contact.Preferred_Middle_Name__c')) {
			c.Preferred_Middle_Name__c = attributes.get('Contact.Preferred_Middle_Name__c');
		}
        if(attributes.containsKey('Contact.EDW_System_Key__c')) {
			c.EDW_System_Key__c = attributes.get('Contact.EDW_System_Key__c');
		}
        if(attributes.containsKey('Contact.Employee_ID__c')) {
			c.Employee_ID__c = attributes.get('Contact.Employee_ID__c');
		}
        if(attributes.containsKey('Contact.UW_Registry_ID__c')) {
			c.UW_Registry_ID__c = attributes.get('Contact.UW_Registry_ID__c');
		}
        
        //--------------End Custom Contact Fields--------------------------
     
         //Account commented out due to EDA Administrative Accounts being created. 
        system.Debug('*** newContact Value: ' + newContact);      
        if(newContact) {
		  //c.AccountId = accountId;
		  	system.debug('Creating New User: '+c);
			Database.DMLOptions dml = new Database.DMLOptions();
			dml.DuplicateRuleHeader.AllowSave = true; 
            Database.insert(c, dml);
			u.ContactId = c.Id;
		} else {
			update(c);
            system.debug('***Update Contact: ' + c);
            //u.ContactId = c.Id;
		}
	}

//handleAccount has been commented out due to EDA Administrative Accounts being created.
   
/*	private String handleAccount(boolean create, User u, Map<String, String> attributes) {
		Account a;
		boolean newAccount = false;
		if(create) {
			if(attributes.containsKey('User.Account')) {
				String account = attributes.get('User.Account');
				a = [SELECT Id FROM Account WHERE Id=:account];
			} else {
				if(attributes.containsKey('User.Contact')) {
					String contact = attributes.get('User.Contact');
					Contact c = [SELECT AccountId FROM Contact WHERE Id=:contact];
					String account = c.AccountId;
					a = [SELECT Id FROM Account WHERE Id=:account];
				} else {
					a = new Account();
					newAccount = true;
				}
			}
		} else {
			if(attributes.containsKey('User.Account')) {
			String account = attributes.get('User.Account');
				a = [SELECT Id FROM Account WHERE Id=:account];
			} else {
				if(attributes.containsKey('User.Contact')) {
					String contact = attributes.get('User.Contact');
					Contact c = [SELECT Id, AccountId FROM Contact WHERE Id=:contact];
					if(u.ContactId != c.Id) {
						throw new JitException('Cannot change User.ContactId');
					}
					String account = c.AccountId;
					a = [SELECT Id FROM Account WHERE Id=:account];
				} else {
					throw new JitException('Could not find account');
				}
			}
		}
		if(attributes.containsKey('Account.Name')) {
			a.Name = attributes.get('Account.Name');
		}
		if(attributes.containsKey('Account.AccountNumber')) {
			a.AccountNumber = attributes.get('Account.AccountNumber');
		}
		if(attributes.containsKey('Account.Owner')) {
			a.OwnerId = attributes.get('Account.Owner');
		}
		if(attributes.containsKey('Account.BillingStreet')) {
			a.BillingStreet = attributes.get('Account.BillingStreet');
		}
		if(attributes.containsKey('Account.BillingCity')) {
			a.BillingCity = attributes.get('Account.BillingCity');
		}
		if(attributes.containsKey('Account.BillingState')) {
			a.BillingState = attributes.get('Account.BillingState');
		}
		if(attributes.containsKey('Account.BillingCountry')) {
			a.BillingCountry = attributes.get('Account.BillingCountry');
		}
		if(attributes.containsKey('Account.BillingPostalCode')) {
			a.BillingPostalCode = attributes.get('Account.BillingPostalCode');
		}
		if(attributes.containsKey('Account.AnnualRevenue')) {
			a.AnnualRevenue = Integer.valueOf(attributes.get('Account.AnnualRevenue'));
		}
		if(attributes.containsKey('Account.Description')) {
			a.Description = attributes.get('Account.Description');
		}
		if(attributes.containsKey('Account.Fax')) {
			a.Fax = attributes.get('Account.Fax');
		}
		if(attributes.containsKey('Account.NumberOfEmployees')) {
			a.NumberOfEmployees = Integer.valueOf(attributes.get('Account.NumberOfEmployees'));
		}
		if(attributes.containsKey('Account.Phone')) {
			a.Phone = attributes.get('Account.Phone');
		}
		if(attributes.containsKey('Account.ShippingStreet')) {
			a.ShippingStreet = attributes.get('Account.ShippingStreet');
		}
		if(attributes.containsKey('Account.ShippingCity')) {
			a.ShippingCity = attributes.get('Account.ShippingCity');
		}
		if(attributes.containsKey('Account.ShippingState')) {
			a.ShippingState = attributes.get('Account.ShippingState');
		}
		if(attributes.containsKey('Account.ShippingCountry')) {
			a.ShippingCountry = attributes.get('Account.ShippingCountry');
		}
		if(attributes.containsKey('Account.ShippingPostalCode')) {
			a.ShippingPostalCode = attributes.get('Account.ShippingPostalCode');
		}
		if(attributes.containsKey('Account.Sic')) {
			a.Sic = attributes.get('Account.Sic');
		}
		if(attributes.containsKey('Account.TickerSymbol')) {
			a.TickerSymbol = attributes.get('Account.TickerSymbol');
		}
		if(attributes.containsKey('Account.Website')) {
			a.Website = attributes.get('Account.Website');
		}
		if(attributes.containsKey('Account.Industry')) {
			a.Industry = attributes.get('Account.Industry');
		}
		if(attributes.containsKey('Account.Ownership')) {
			a.Ownership = attributes.get('Account.Ownership');
		}
		if(attributes.containsKey('Account.Rating')) {
			a.Rating = attributes.get('Account.Rating');
		}
		if(newAccount) {
			insert(a);
		} else {
			update(a);
		}
		return a.Id;
	}
*/
	private void handleJit(boolean create, User u, Id samlSsoProviderId, Id communityId, Id portalId,
// Updated hadleJIT to handle the SAML request from uwIDP
            // Adding the uwNetID(urn:oid:0.9.2342.19200300.100.1.1) to Alias, Nickname and Contact UENetID
            String federationIdentifier, Map<String, String> attributes, String assertion) {
                
            Map<String, String> uw_attributes = new Map<String, string>();
            //String uwEmail; 
            String uwNetID;
               
            //Adding uwNETID to UwnetID contact, user, community nickname & Alias
            if(attributes.containsKey('urn:oid:0.9.2342.19200300.100.1.1') ){
            	uw_attributes.put('User.Alias', attributes.get('urn:oid:0.9.2342.19200300.100.1.1').left(8));
           		uw_attributes.put('User.CommunityNickname', attributes.get('urn:oid:0.9.2342.19200300.100.1.1'));   
           		uw_attributes.put('Contact.UWNetID', attributes.get('urn:oid:0.9.2342.19200300.100.1.1'));  
                uwNetID = attributes.get('urn:oid:0.9.2342.19200300.100.1.1');
            } 	
            
            // Adding the uwEmail(urn:oid:1.2.840.113994.200.45) to Email, Username and Federation ID
            if(attributes.containsKey('urn:oid:1.2.840.113994.200.45') ){
            	uw_attributes.put('User.Email', attributes.get('urn:oid:1.2.840.113994.200.45'));
            	uw_attributes.put('User.Username', attributes.get('urn:oid:1.2.840.113994.200.45'));
           	 	uw_attributes.put('User.FederationIdentifier', attributes.get('urn:oid:1.2.840.113994.200.45'));
           	 	uw_attributes.put('Contact.Email', attributes.get('urn:oid:1.2.840.113994.200.45'));
                //uwEmail = attributes.get('urn:oid:1.2.840.113994.200.45');
            } 	
             // Adding the Personal Email (urn:oid:0.9.2342.19200300.100.1.3) to Contact
            if(attributes.containsKey('urn:oid:0.9.2342.19200300.100.1.3') ){
            	uw_attributes.put('Contact.Personal_Email__c', attributes.get('urn:oid:0.9.2342.19200300.100.1.3'));
            } 	
            
            //Adding Profile ID
            //Temporarily Hard codeing this value, should be updated to lookup the Metadata.
            //attributes.put('User.ProfileId','00e23000000DlPR');
            //communityID = '0DB230000004CTjGAM';
                If (create){
                	Profile profileLookup = [select Id, Name from Profile where name ='Custom Undergrad Community Login' Limit 1]; 
             		uw_attributes.put('User.ProfileId',String.valueOf(profileLookup.Id));
                }
                 
            // Preferred Last Name (urn:oid:1.2.840.113994.200.49) to User & Contact
            if(attributes.containsKey('urn:oid:1.2.840.113994.200.49') ){
                uw_attributes.put('Contact.Preferred_Last_Name__c', attributes.get('urn:oid:1.2.840.113994.200.49'));
                uw_attributes.put('User.preferredSurname__c', attributes.get('urn:oid:1.2.840.113994.200.49'));
            }

            //Registered Sur Last Name (urn:oid:1.2.840.113994.200.31) to User & Contact
            if(attributes.containsKey('urn:oid:1.2.840.113994.200.31') ){
                uw_attributes.put('Contact.LastName', attributes.get('urn:oid:1.2.840.113994.200.31'));
                uw_attributes.put('User.LastName', attributes.get('urn:oid:1.2.840.113994.200.31'));
            }
            
            // Preferred First Name (urn:oid:1.2.840.113994.200.47)to User & Contact
            if(attributes.containsKey('urn:oid:1.2.840.113994.200.47') ){
                uw_attributes.put('User.preferredFirst__c', attributes.get('urn:oid:1.2.840.113994.200.47'));
            	uw_attributes.put('Contact.Preferred_First_Name__c', attributes.get('urn:oid:1.2.840.113994.200.47')); 
            }

            //Registered Given Name (urn:oid:1.2.840.113994.200.32) to User & Contact
            if(attributes.containsKey('urn:oid:1.2.840.113994.200.32') ){
                uw_attributes.put('Contact.FirstName', attributes.get('urn:oid:1.2.840.113994.200.32'));
                uw_attributes.put('User.FirstName', attributes.get('urn:oid:1.2.840.113994.200.32'));
            }


            // Adding the Preferred Middle Name (urn:oid:1.2.840.113994.200.48)to User & Contact
            if(attributes.containsKey('urn:oid:1.2.840.113994.200.48') ){
                uw_attributes.put('User.preferredMiddle__c', attributes.get('urn:oid:1.2.840.113994.200.48'));
            	uw_attributes.put('Contact.Preferred_Middle_Name__c', attributes.get('urn:oid:1.2.840.113994.200.48')); 
            } 
            // Adding the Phone (urn:oid:2.5.4.20) to User & Contact
            if(attributes.containsKey('urn:oid:2.5.4.20') ){
            	uw_attributes.put('User.Phone', attributes.get('urn:oid:2.5.4.20'));
            	uw_attributes.put('Contact.Phone', attributes.get('urn:oid:2.5.4.20'));
            } 	
            // Adding the EDW System Key (urn:oid:1.2.840.113994.200.20) to User & Contact
            if(attributes.containsKey('urn:oid:1.2.840.113994.200.20') ){
            	uw_attributes.put('User.EDW_System_Key__c', attributes.get('urn:oid:1.2.840.113994.200.20'));
            	uw_attributes.put('Contact.EDW_System_Key__c', attributes.get('urn:oid:1.2.840.113994.200.20'));
            } 	
            // Adding the Student Number (urn:oid:1.2.840.113994.200.21) to User & Contact
            if(attributes.containsKey('urn:oid:1.2.840.113994.200.21') ){
                integer studentNumb = integer.valueof(attributes.get('urn:oid:1.2.840.113994.200.21'));
                if (studentNumb <> 0){
            		uw_attributes.put('User.Student_Number__c', attributes.get('urn:oid:1.2.840.113994.200.21'));
            		uw_attributes.put('Contact.Student_Number__c', attributes.get('urn:oid:1.2.840.113994.200.21'));
                }
            } 
                
            // Adding the Employee Number (urn:oid:2.16.840.1.113730.3.1.3) to User & Contact
            if(attributes.containsKey('urn:oid:2.16.840.1.113730.3.1.3') ){
            	uw_attributes.put('User.EmployeeNumber', attributes.get('urn:oid:2.16.840.1.113730.3.1.3'));
            	uw_attributes.put('Contact.Employee_ID__c', attributes.get('urn:oid:2.16.840.1.113730.3.1.3'));
            } 
            // Adding the Registry Number (urn:oid:1.2.840.113994.200.24) to User & Contact
            if(attributes.containsKey('urn:oid:1.2.840.113994.200.24') ){
            	uw_attributes.put('User.UW_Registry_ID__c', attributes.get('urn:oid:1.2.840.113994.200.24'));
            	uw_attributes.put('Contact.UW_Registry_ID__c', attributes.get('urn:oid:1.2.840.113994.200.24'));
            } 
              
            //Adding User.Contact
            if (create){
            	List<Contact> contactList = new List<contact>();
            	contactList = [SELECT ID FROM Contact WHERE UWNetID__c = :uwNetID];
            	if (contactList.size()==1){
                	uw_attributes.put('User.Contact',contactList[0].ID);
            	}
            }
            
		system.debug('UW Attributes: '+ uw_attributes);
        if(communityId != null || portalId != null) {
		//	String account = handleAccount(create, u, attributes); // Account creation being handled by EDA
		
		//	handleContact(create, account, u, attributes);
			handleContact(create, u, uw_attributes); // added instead of the line above to exclude account
			handleUser(create, u, uw_attributes, federationIdentifier, false);
		} else {
			handleUser(create, u, uw_attributes, federationIdentifier, true);
		}
	}

	global User createUser(Id samlSsoProviderId, Id communityId, Id portalId,
        String federationIdentifier, Map<String, String> attributes, String assertion) {
        system.debug('*** Running Create User');
        system.debug('*** FederationID '+federationIdentifier);
        system.debug('*** Community: '+communityID +'/ Portal:' + portalID);

        User u = new User();
		handleJit(true, u, samlSsoProviderId, communityId, portalId,
			federationIdentifier, attributes, assertion);
		system.debug('*** End of Program' + u);
        return u;
	}

	global void updateUser(Id userId, Id samlSsoProviderId, Id communityId, Id portalId,
		String federationIdentifier, Map<String, String> attributes, String assertion) {

        system.debug('*** Running Create User');
        system.debug('*** FederationID '+federationIdentifier);
        system.debug('*** Community: '+communityID +'/ Portal:' + portalID);
		User u = [SELECT Id, FirstName, ContactId FROM User WHERE Id=:userId];
		handleJit(false, u, samlSsoProviderId, communityId, portalId,
			federationIdentifier, attributes, assertion);
	}
    
 /*   public void addAttributes (Map<String, String> attributesUW){
        if(attributesUW.containsKey('urn:oid:0.9.2342.19200300.100.1.1') ){
            attributesUW.put('User.Alias', attributesUW.get('urn:oid:0.9.2342.19200300.100.1.1'));
        }
    }*/
}