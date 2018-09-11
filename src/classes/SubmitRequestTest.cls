@isTest
public class SubmitRequestTest {

	 static testMethod void test() {
	      Account acc = new Account();
        acc.Name='test';
        insert acc;
        Apttus__APTS_Agreement__c AA = new Apttus__APTS_Agreement__c();
        AA.Apttus__Account__c=acc.id;
        AA.Payment_Terms__c='Special';
        AA.State_of_Incorporation__c='test';
        AA.Contract_Month__c='June';
        AA.Contract_Day__c='04';
        AA.Contract_Year__c='2011';
        AA.Submit_Request__c=true;
        insert AA;
        
        /*Group grp = new Group();
        grp.name = 'Aggrement Request';
        grp.Type = 'Queue'; 
        Insert grp; 
        
       GroupMember grpMem1 = new GroupMember();
        grpMem1.UserOrGroupId = UserInfo.getUserId();
        grpMem1.GroupId = grp.Id;
       // Insert grpMem1;*/
       
       //Group g1 = new Group(Name='group name', type='Queue');
        //insert g1;
        //QueuesObject q1 = new QueueSObject(QueueID = g1.id);
        //insert q1;
        
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
        User u = new User(Alias = 'standt', Email='submitrequestAc@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='submitrequestAc@testorg.com');
        
     ApexPages.currentPage().getParameters().put('id',AA.id);
     SubmitRequest_AC Sa = new SubmitRequest_AC ();
     Sa.AggRedirect();
   

	} 

}