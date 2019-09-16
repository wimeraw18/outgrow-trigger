@isTest
private class OutgrowLeadHandlerTest {
    @isTest static void matchingContactFound() {
        // Create Account
        Account myAcc         = new Account();
        myAcc.Name            = 'Parquet Marketing';
        myAcc.CurrencyIsoCode = 'USD';
        insert myAcc;

        // Create Contact
        Contact myCon   = new Contact();
        myCon.Account   = myAcc;
        myCon.FirstName = 'Roy';
        myCon.LastName  = 'Wimer';
        myCon.Email     = 'alaric.wimer@parquetmarketing.com';
        insert myCon;

        // Create Outgrow Lead
        Lead myLead        = new Lead();
        myLead.FirstName   = 'Roy';
        myLead.LastName    = 'Wimer';
        myLead.Email       = 'alaric.wimer@parquetmarketing.com';
        myLead.Company     = 'Parquet Marketing';
        myLead.Language__c = 'English';
        //myLead.LeadSource = 'outgrow';
        myLead.Projects_Completed_Annually__c = '5';
        myLead.Average_Project_Cost__c        = '5';
        myLead.Number_of_Project_Managers__c  = '5';
        myLead.Average_Cycle_Time_Months__c   = '5';
        myLead.Annual_Cost_per_Project_Manager__c          = '5';
        myLead.Cumulative_benefits_for_a_3_year_period__c  = '5';
        myLead.Saved_by_reducing_project_failure_rates__c  = '5';
        myLead.Saved_by_reducing_project_cycle_times__c    = '5';
        myLead.Saved_by_reducing_cost_overruns_on_succe__c = '5';
        myLead.Saved_by_avoiding_low_no_value_projects__c  = '5';
        myLead.Saved_by_automating_low_value_tasks__c      = '5';
        insert myLead;

        // Create non-outgrow Lead
        Lead myLead2       = new Lead();
        myLead2.FirstName  = 'Roy';
        myLead2.LastName   = 'Wimer';
        myLead2.Email      = 'alaric.wimer@parquetmarketing.com';
        myLead2.Company    = 'Parquet Marketing';
        myLead2.LeadSource = 'Website';
        myLead.Language__c  = 'English';
        insert myLead2;

        // check Contact's survey results
        Contact myUpdatedContact = [
            SELECT Id, Projects_Completed_Annually__c
              FROM Contact 
             WHERE Id = :myCon.Id
             LIMIT 1
        ];

        System.assertEquals('5', myUpdatedContact.Projects_Completed_Annually__c);

        List<Lead> myUpdatedLeads = [
            SELECT Id
              FROM Lead 
             WHERE Id = :myLead.Id
                OR Id = :myLead2.Id
        ];

        System.assertEquals(1, myUpdatedLeads.size());
    }
    @isTest static void bulkOutgrowLeadsInsert() {
        // Initalize lead list
        List<Lead> myLeadsList = new List<Lead>();
        // Create Account
        Account myAcc         = new Account();
        myAcc.Name            = 'Parquet Marketing';
        myAcc.CurrencyIsoCode = 'USD';
        insert myAcc;

        // Create Contact
        Contact myCon   = new Contact();
        myCon.Account   = myAcc;
        myCon.FirstName = 'Roy';
        myCon.LastName  = 'Wimer';
        myCon.Email     = 'alaric.wimer@parquetmarketing.com';
        insert myCon;

        // Create 101 Outgrow Leads to test governor limits
        for (Integer i = 0; i < 102; i++) {
            Lead myLead         = new Lead();
            myLead.FirstName    = 'Roy'+ i;
            myLead.LastName     = 'Wimer' + i;
            myLead.Email        = 'alaric.wimer@parquetmarketing.com'+i;
            myLead.Company      = 'Parquet Marketing';
            myLead.Language__c  = 'English';
            //myLead.LeadSource = 'outgrow';
            myLead.Projects_Completed_Annually__c = '5'+ i;
            myLead.Average_Project_Cost__c        = '5'+ i;
            myLead.Number_of_Project_Managers__c  = '5'+ i;
            myLead.Average_Cycle_Time_Months__c   = '5'+ i;
            myLead.Annual_Cost_per_Project_Manager__c          = '5'+ i;
            myLead.Cumulative_benefits_for_a_3_year_period__c  = '5'+ i;
            myLead.Saved_by_reducing_project_failure_rates__c  = '5'+ i;
            myLead.Saved_by_reducing_project_cycle_times__c    = '5'+ i;
            myLead.Saved_by_reducing_cost_overruns_on_succe__c = '5'+ i;
            myLead.Saved_by_avoiding_low_no_value_projects__c  = '5'+ i;
            myLead.Saved_by_automating_low_value_tasks__c      = '5'+ i;
            myLeadsList.add(myLead);
        }
        insert myLeadsList;

        // Create matching Outgrow Lead
        Lead myLead         = new Lead();
        myLead.FirstName    = 'Roy';
        myLead.LastName     = 'Wimer';
        myLead.Email        = 'alaric.wimer@parquetmarketing.com';
        myLead.Company      = 'Parquet Marketing';
        myLead.Language__c  = 'English';
        //myLead.LeadSource = 'outgrow';
        myLead.Projects_Completed_Annually__c = '2';
        myLead.Average_Project_Cost__c        = '2';
        myLead.Number_of_Project_Managers__c  = '2';
        myLead.Average_Cycle_Time_Months__c   = '2';
        myLead.Annual_Cost_per_Project_Manager__c          = '2';
        myLead.Cumulative_benefits_for_a_3_year_period__c  = '2';
        myLead.Saved_by_reducing_project_failure_rates__c  = '2';
        myLead.Saved_by_reducing_project_cycle_times__c    = '2';
        myLead.Saved_by_reducing_cost_overruns_on_succe__c = '2';
        myLead.Saved_by_avoiding_low_no_value_projects__c  = '2';
        myLead.Saved_by_automating_low_value_tasks__c      = '2';
        insert myLead;

        // Create non-outgrow Lead
        Lead myLead2        = new Lead();
        myLead2.FirstName   = 'Roy';
        myLead2.LastName    = 'Wimer';
        myLead2.Email       = 'alaric.wimer@parquetmarketing.com';
        myLead2.Company     = 'Parquet Marketing';
        myLead2.LeadSource  = 'Website';
        myLead.Language__c  = 'English';
        insert myLead2;

        // check Contact's survey results
        Contact myUpdatedContact = [
            SELECT Id, Projects_Completed_Annually__c
              FROM Contact 
             WHERE Id = :myCon.Id
             LIMIT 1
        ];

        System.assertEquals('2', myUpdatedContact.Projects_Completed_Annually__c);

        List<Lead> myUpdatedLeads = [
            SELECT Id
              FROM Lead 
             WHERE Id = :myLead.Id
                OR Id = :myLead2.Id
        ];

        System.assertEquals(1, myUpdatedLeads.size());
    }
    @isTest static void noMatchingContactFound() {
        // Create Account
        Account myAcc         = new Account();
        myAcc.Name            = 'Parquet Marketing';
        myAcc.CurrencyIsoCode = 'USD';
        insert myAcc;

        // Create Contact
        Contact myCon   = new Contact();
        myCon.Account   = myAcc;
        myCon.FirstName = 'Roy';
        myCon.LastName  = 'Wimer';
        myCon.Email     = 'alaric.wimer@parquetmarketing.com';
        insert myCon;

        // Create Outgrow Lead
        Lead myLead         = new Lead();
        myLead.FirstName    = 'Jon';
        myLead.LastName     = 'Snow';
        myLead.Email        = 'jon.snow@parquetmarketing.com';
        myLead.Company      = 'Parquet Marketing';
        myLead.Language__c  = 'English';
        //myLead.LeadSource = 'outgrow';
        myLead.Projects_Completed_Annually__c = '5';
        myLead.Average_Project_Cost__c        = '5';
        myLead.Number_of_Project_Managers__c  = '5';
        myLead.Average_Cycle_Time_Months__c   = '5';
        myLead.Annual_Cost_per_Project_Manager__c          = '5';
        myLead.Cumulative_benefits_for_a_3_year_period__c  = '5';
        myLead.Saved_by_reducing_project_failure_rates__c  = '5';
        myLead.Saved_by_reducing_project_cycle_times__c    = '5';
        myLead.Saved_by_reducing_cost_overruns_on_succe__c = '5';
        myLead.Saved_by_avoiding_low_no_value_projects__c  = '5';
        myLead.Saved_by_automating_low_value_tasks__c      = '5';
        insert myLead;

        // Create non-outgrow Lead
        Lead myLead2 = new Lead();
        myLead2.FirstName   = 'Roy';
        myLead2.LastName    = 'Wimer';
        myLead2.Email       = 'alaric.wimer@parquetmarketing.com';
        myLead2.Company     = 'Parquet Marketing';
        myLead2.LeadSource  = 'Website';
        myLead.Language__c  = 'English';
        insert myLead2;

        // check Contact's survey results
        Contact myUpdatedContact = [
            SELECT Id, Projects_Completed_Annually__c
              FROM Contact 
             WHERE Id = :myCon.Id
             LIMIT 1
        ];

        System.assertEquals(null, myUpdatedContact.Projects_Completed_Annually__c);

        List<Lead> myUpdatedLeads = [
            SELECT Id
              FROM Lead 
             WHERE Id = :myLead.Id
                OR Id = :myLead2.Id
        ];

        System.assertEquals(2, myUpdatedLeads.size());
    }
}