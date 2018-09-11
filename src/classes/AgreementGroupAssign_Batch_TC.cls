@isTest
private class AgreementGroupAssign_Batch_TC {

    private static testMethod void test() {
    	//Account Insert
    	Account acc = new Account();
    	acc.Name ='testAccount';
    	insert acc;
    	
    	//Agreement__c inserting.
    	List<Apttus__APTS_Agreement__c> Agrements = new List<Apttus__APTS_Agreement__c>();
    	Apttus__APTS_Agreement__c Agrement = new Apttus__APTS_Agreement__c();
    	Agrement.Name='TestAccount';
    	Agrement.Apttus__Account__c= acc.Id;
    	Agrement.Private__c=false;
    	Agrements.add(Agrement);
    	insert Agrements;
    	
    	Test.StartTest();
    	AgreementGroupAssign_Batch ObjAgreementBatch = new AgreementGroupAssign_Batch();
		
		Database.executeBatch(ObjAgreementBatch,1);
		Test.StopTest();
    }
}