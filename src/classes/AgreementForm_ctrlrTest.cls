@isTest
public class AgreementForm_ctrlrTest {
    static testMethod void test() {
	    Account acc = new Account();
        acc.Name='test';
        insert acc;
        Apttus__APTS_Agreement__c AA = new Apttus__APTS_Agreement__c();
        AA.Name='Agrement Request';
        AA.Apttus__Account__c=acc.id;
        AA.Payment_Terms__c='Special';
        AA.State_of_Incorporation__c='test';
        AA.Contract_Month__c='June';
        AA.Contract_Day__c='04';
        AA.Contract_Year__c='2011';
        insert AA;
       
        RecordType Rtype = [Select id,Name From RecordType where SobjectType = 'Apttus__APTS_Agreement__c' and Name='New Request'];
        AgreementForm_ctrlr Ac = new AgreementForm_ctrlr();
	    AgreementForm_ctrlr.submitForm('test','testid','bssid',true);
	    AgreementForm_ctrlr.RedirectPage();
    }
}