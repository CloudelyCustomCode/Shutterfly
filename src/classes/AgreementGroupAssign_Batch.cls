global class AgreementGroupAssign_Batch implements Database.Batchable<sObject> {
    
    ID groupId = [select id from Group where Name = 'Employee Group'].id;
    global AgreementGroupAssign_Batch(){ }
    
    global Database.QueryLocator start(Database.BatchableContext bc) {
        string query = 'select Id, Private__c from Apttus__APTS_Agreement__c where Private__c = false';
        return  Database.getQueryLocator(query);   
    }

    global void execute(Database.BatchableContext bc, List<Apttus__APTS_Agreement__c> AgreementList){
        List<Apttus__APTS_Agreement__Share> lstAgreementShare = new List<Apttus__APTS_Agreement__Share>(); 
        for (Apttus__APTS_Agreement__c agree : AgreementList) {
	        if(agree.Private__c == false){
	            Apttus__APTS_Agreement__Share AgreementShare = new Apttus__APTS_Agreement__Share();
	            AgreementShare.AccessLevel = 'Edit';
	            AgreementShare.ParentID = agree.Id;
	            AgreementShare.UserOrGroupId =  groupId;
	            lstAgreementShare.add(AgreementShare);
	        }
        }
        insert lstAgreementShare;
    } 

    global void finish(Database.BatchableContext bc){
        //execute any post-processing operations.
    }    

}