@isTest
public class ResubmitAgreementControllerTest {

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
        AA.OwnerId=UserInfo.getUserId();
        AA.Cldy_Contracts_Manager__c=UserInfo.getUserId();
        insert AA;
        ApexPages.currentPage().getParameters().put('id',AA.id);
   ApexPages.StandardController sc = new ApexPages.StandardController(AA); 
   ResubmitAgreementController Ra = new ResubmitAgreementController(sc);
   Ra.gotoAgreement();
   Ra.isPermission=true;
   Ra.submitRequest();

	}

}