public with sharing class ResubmitAgreementController {
    public Boolean isPermission { get; set; }
    public String agreementId;
    
    public ResubmitAgreementController(ApexPages.StandardController stdController){
    }
    
    public PageReference gotoAgreement() {
        Pagereference p = new Pagereference('/' + AgreementId);
        return p;
    }
    
    public PageReference submitRequest() {
        isPermission = true;
        agreementId = apexpages.currentpage().getparameters().get('id');
        
        List<Apttus__APTS_Agreement__c> agreementRecord = [Select 
                                                                Id, 
                                                                OwnerId, 
                                                                Apttus__Status__c,
                                                                Apttus__Status_Category__c,
                                                                Cldy_Contracts_Manager__c,
                                                                Apttus__Requestor__c
                                                                from
                                                                Apttus__APTS_Agreement__c
                                                                Where
                                                                Id =: AgreementId];
        if(agreementRecord.size()>0){
            agreementRecord[0].OwnerId = agreementRecord[0].Cldy_Contracts_Manager__c;
            agreementRecord[0].Apttus__Status__c = 'Submitted Request';
            agreementRecord[0].Apttus__Status_Category__c = 'Request';
            //agreementRecord[0].Is_Attorney_Assigned__c = false;
            update agreementRecord[0];
            return new Pagereference('/'+agreementId);
        }
        //return new Pagereference('/'+agreementId);
        return null;
    }
}