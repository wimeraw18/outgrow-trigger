# outgrow-trigger
This Salesforce trigger checks incoming Leads to see if they come from an Outgrow form. If they do, it checks for matching contacts and updates the matching contact record with the survey results, and then deletes the incoming lead. If no matching contact is found, it creates the lead.
