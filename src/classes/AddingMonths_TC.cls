@isTest
private class AddingMonths_TC {

	private static testMethod void test() {
	    Account acc = new Account();
	    acc.name='test';
	    insert acc;
	    
	    Apttus__APTS_Agreement__c AA = new Apttus__APTS_Agreement__c();
	    AA.name='testname';
	    AA.Apttus__Account__c=acc.id;
	    AA.Start_Date_of_Services__c = system.today();
	    AA.Apttus__Contract_Start_Date__c=system.today();
	    //AA.Apttus__Contract_End_Date__c= ;
	    AA.Cldy_Term_Months__c=1;
	    insert AA;
	    

	}

}