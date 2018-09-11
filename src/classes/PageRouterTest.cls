@isTest
public class PageRouterTest {
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
        
        RecordType Rtype = [Select id,Name From RecordType where SobjectType = 'Apttus__APTS_Agreement__c' and Name='New Request'];
        System.currentPageReference().getParameters().put('RecordType',Rtype.id);
        ApexPages.currentPage().getParameters().put('id',AA.id);
        ApexPages.StandardController sc = new ApexPages.StandardController(AA); 
        PageRouter pr = new PageRouter(sc);
        pr.redirectPage();
	}
	
	static testMethod void test1() {
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
        
        RecordType Rtype = [Select id,Name From RecordType where SobjectType = 'Apttus__APTS_Agreement__c' and Name='New NDA'];
        System.currentPageReference().getParameters().put('RecordType',Rtype.id);
        ApexPages.currentPage().getParameters().put('id',AA.id);
   ApexPages.StandardController sc = new ApexPages.StandardController(AA); 
   PageRouter pr = new PageRouter(sc);
   pr.redirectPage();
   pr.redirectUrl='test@1234';

	}

}