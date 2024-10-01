@isTest
public class RewardsCalloutServiceTest {

    @testSetup static void methodName() {
        List<User> userListToInsert = new List<User>();
        List<Wellness_Journey__c> wjListToInsert = new List<Wellness_Journey__c>();
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        for(Integer i = 0 ; i <= 12 ; i++){
            userListToInsert.add(buildUsers(i, p));
            wjListToInsert.add(buildWellnessJourney(i));
        }
        insert userListToInsert;
        insert wjListToInsert;
		

        
        
    }
    
    @isTest static void testSuccessCallout() {	
        
        Test.StartTest();
        Test.setMock(HttpCalloutMock.class, new RewardsCalloutServiceMock());
        Database.executeBatch(new WellnessJourneyRewardsBatch(), 13);
        Test.StopTest();
    }  
    
    
    private static User buildUsers(Integer counter, Profile p){
        User u = new User(Alias = 'standt'
                          , Email='dak00000dgjgheav' + String.ValueOf(counter) + '@testorg.com'
                          , EmailEncodingKey='UTF-8'
                          , LastName='dak00000dgjgheav' + String.ValueOf(counter)
                          , LanguageLocaleKey='en_US'
                          , LocaleSidKey='en_US'
                          , ProfileId = p.Id
                          , TimeZoneSidKey='America/Los_Angeles'
                          , UserName='dak00000dgjgheav' + String.ValueOf(counter) + '@testorg.com');
        return u;

    }
    
    private static Wellness_Journey__c buildWellnessJourney(Integer counter){
        
        Wellness_Journey__c wj = new Wellness_Journey__c( Name = 'Test WJ ' + String.ValueOf(counter)
                                                         , Status__c = 'Complete'
                                                         , Type__c = 'Physical'
                                                         , Completion_Goal__c = 10000
                                                         , Completion_Value__c = 1000
                                                         , Metric_Type__c = 'Minutes'
                                                         , Description__c = 'test WJ'
                                                         , Completion_Date__c = System.Now() - 30
        												);
        return wj;
    }
}