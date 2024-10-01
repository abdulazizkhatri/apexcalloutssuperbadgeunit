@isTest
public class BillingCalloutServiceTest {

    @isTest static void testCallBillingService() {
    	
        Accessibility_Project__c project = new Accessibility_Project__c();
        project.Amount__c = 100.00;
        insert project;
        
        Test.startTest();
        Test.setMock (WebServiceMock.class, new BillingCalloutServiceMock());
        AccessibilityProjectBilling.callBillingService(project.Id, project.Amount__c);
        Test.stopTest();
        
        project = [SELECT status__c FROM Accessibility_Project__c WHERE Id = :project.Id];
        System.assertEquals('Complete', project.Status__c);
    }
}