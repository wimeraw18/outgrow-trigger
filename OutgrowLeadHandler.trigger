trigger OutgrowLeadHandler on Lead (after insert) {
    // initialize variables
    List<Contact> contactsToUpdate = new List<Contact>();
    List<Id> leadsToDelete         = new List<Id>();
    List<Lead> myOutgrowLeads      = new List<Lead>();
    List<String> firstNameList     = new List<String>();
    List<String> lastNameList      = new List<String>();
    List<String> emailList         = new List<String>();

    // Determine if the new lead is from Outgrow
    for (Lead myLead : Trigger.new) {
       if (myLead.Projects_Completed_Annually__c != null && myLead.Email != null && myLead.FirstName != null && myLead.LastName != null) {
            myOutgrowLeads.add(myLead);
            firstNameList.add(myLead.FirstName);
            lastNameList.add(myLead.LastName);
            emailList.add(myLead.Email);
       }
    }
    if (!myOutgrowLeads.isEmpty()) {
        // get list of matching contacts
        List<Contact> matchingContacts = [SELECT Id, Projects_Completed_Annually__c, Average_Project_Cost__c, Number_of_Project_Managers__c,
            Annual_Cost_per_Project_Manager__c, Average_Cycle_Time_Months__c, Cumulative_benefits_for_a_3_year_period__c,
            Saved_by_reducing_project_failure_rates__c, Saved_by_reducing_project_cycle_times__c, Saved_by_reducing_cost_overruns_on_succe__c,
            Saved_by_avoiding_low_no_value_projects__c, Saved_by_automating_low_value_tasks__c 
            FROM Contact WHERE FirstName IN: firstNameList AND LastName IN: lastNameList AND Email IN: emailList
        ];
        // update the survey results section of each matching contact
        if (!matchingContacts.isEmpty()) {
            for (Integer i = 0; i < matchingContacts.size(); i++) {
                matchingContacts.get(i).Projects_Completed_Annually__c              = myOutgrowLeads.get(i).Projects_Completed_Annually__c;
                matchingContacts.get(i).Average_Project_Cost__c                     = myOutgrowLeads.get(i).Average_Project_Cost__c;
                matchingContacts.get(i).Number_of_Project_Managers__c               = myOutgrowLeads.get(i).Number_of_Project_Managers__c;
                matchingContacts.get(i).Annual_Cost_per_Project_Manager__c          = myOutgrowLeads.get(i).Annual_Cost_per_Project_Manager__c;
                matchingContacts.get(i).Average_Cycle_Time_Months__c                = myOutgrowLeads.get(i).Average_Cycle_Time_Months__c;
                matchingContacts.get(i).Cumulative_benefits_for_a_3_year_period__c  = myOutgrowLeads.get(i).Cumulative_benefits_for_a_3_year_period__c;
                matchingContacts.get(i).Saved_by_reducing_project_failure_rates__c  = myOutgrowLeads.get(i).Saved_by_reducing_project_failure_rates__c;
                matchingContacts.get(i).Saved_by_reducing_project_cycle_times__c    = myOutgrowLeads.get(i).Saved_by_reducing_project_cycle_times__c;
                matchingContacts.get(i).Saved_by_reducing_cost_overruns_on_succe__c = myOutgrowLeads.get(i).Saved_by_reducing_cost_overruns_on_succe__c;
                matchingContacts.get(i).Saved_by_avoiding_low_no_value_projects__c  = myOutgrowLeads.get(i).Saved_by_avoiding_low_no_value_projects__c;
                matchingContacts.get(i).Saved_by_automating_low_value_tasks__c      = myOutgrowLeads.get(i).Saved_by_automating_low_value_tasks__c;
                contactsToUpdate.add(matchingContacts.get(i));
                leadsToDelete.add(myOutgrowLeads.get(i).Id);
            }
            if (!contactsToUpdate.isEmpty()) {
                update contactsToUpdate;
                // delete the duplicate leads
                Database.delete(leadsToDelete);
            }
        }
    }
}