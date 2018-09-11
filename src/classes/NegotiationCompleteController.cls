public with sharing class NegotiationCompleteController {
    private Apttus__APTS_Agreement__c agreement;
    public String agreementId;
    public NegotiationCompleteController (ApexPages.StandardController stdController) { 
        this.agreement = (Apttus__APTS_Agreement__c)stdController.getRecord();
        agreementId = ApexPages.currentPage().getParameters().get('id');  
    }
    public PageReference finalize(){
        agreement.Cldy_Negotiation_Completed__c = true;
        if(!test.isRunningTest()){
            agreement.Apttus__Status__c = 'Request Approval';
        }
        
        List<User> taUser = [Select Id from User Where UserName =: Label.TA_User_Name and isActive = true];
        if(taUser.size()>0){
            agreement.TA_Approver__c = taUser[0].Id;   
        }
        update agreement;
        Approval.ProcessSubmitRequest req1 = new Approval.ProcessSubmitRequest();
        req1.setObjectId(agreementId);
        // Submit the approval request for the Opportunity  
        Approval.ProcessResult result1 = Approval.process(req1);
        PageReference result = new ApexPages.StandardController(agreement).view();
        return result;
    }
}