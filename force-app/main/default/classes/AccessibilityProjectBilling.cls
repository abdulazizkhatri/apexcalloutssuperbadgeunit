global class AccessibilityProjectBilling{
    
   @future(callout=true)
   public static void callBillingService(String projectId, Decimal billingAmount){
       //Setup username, password, billAmount, and projectid in BillingServiceProxy.project and then call billProject method
       BillingServiceProxy.project prj = new BillingServiceProxy.project();
       prj.projectid = projectId;
       prj.billAmount = billingAmount;
       prj.username = '{!$Credential.BillingServiceCredential.username}';
       prj.password = '{!$Credential.BillingServiceCredential.password}';
       
       
       BillingServiceProxy.InvoicesPortSoap11 stub = new BillingServiceProxy.InvoicesPortSoap11();
       string status = stub.billProject(prj);

       //If response is ok set Accessibility Project Status = Complete
       if(status == 'ok'){
           Accessibility_Project__c accessProject = [SELECT Id, Status__c
                                                	FROM Accessibility_Project__c
                                                	WHERE Id = :projectId
                                                	LIMIT 1];
           accessProject.Status__c = 'Complete';
           update accessProject;
       }
            
    }
}