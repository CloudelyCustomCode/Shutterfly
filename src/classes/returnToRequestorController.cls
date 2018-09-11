public class returnToRequestorController {
    
    public string agreementRecordId{get;set;}
    public boolean hasErrors{get;set;}
    
    public PageReference returnToRequestor(){
        String AgreementId = system.currentPageReference().getParameters().get('AgreementId');
        agreementRecordId = AgreementId;
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
        if(agreementRecord.size() > 0){
            if(UserInfo.getUserId() == agreementRecord[0].OwnerId){
                hasErrors = false;
                agreementRecord[0].Cldy_Contracts_Manager__c = agreementRecord[0].OwnerId;
                agreementRecord[0].Apttus__Status__c = 'Returned to Requestor';
                agreementRecord[0].Apttus__Status_Category__c = 'Request';
                agreementRecord[0].OwnerId = agreementRecord[0].Apttus__Requestor__c;
                update agreementRecord[0];
                
                PageReference pf = new PageReference('/'+agreementRecord[0].Id);
                pf.setredirect(true);
                return pf;
            }
            else{
                hasErrors = true;
                return null;
            }
        }
        return null;
    }
    
    public PageReference gotoAgreement(){
        PageReference pf = new PageReference('/'+agreementRecordId);
        pf.setredirect(true);
        return pf;
    }
    
    
}