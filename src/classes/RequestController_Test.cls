@isTest
public class RequestController_Test {

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
        insert AA;
        ApexPages.currentPage().getParameters().put('id',AA.id);
   ApexPages.StandardController sc = new ApexPages.StandardController(AA); 
   RequestController_AC Rc = new RequestController_AC(sc);
   Rc.AggRedirect();

	}

}