public Without Sharing class CLDY_SubmitRequestController {
    
    public boolean agreementSubmitResponse {get; set;}
    public string ownerName {get; set;}
    public string agreementId {get; set;}
    
    public void onPageLoad(){
        try{
            agreementId = system.currentPageReference().getParameters().get('id');
            if(agreementId != ''){
                agreementSubmitResponse = Apttus.AgreementWebService.submitRequestToQueue(agreementId);
                if(agreementSubmitResponse){
                    List<Apttus__APTS_Agreement__c> agreementList = [Select Id, 
                                                                            Owner.Name
                                                                            from 
                                                                            Apttus__APTS_Agreement__c
                                                                            where 
                                                                            Id =: agreementId
                                                                            ];
                    if(agreementList.size() > 0){
                        ownerName = agreementList[0].Owner.Name;
                    }
                }
                //pagereference agreementPage = new pagereference('/' + agreementId);
                //return agreementPage;
            }
        }
        catch(Exception exp){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, exp.getmessage());
            ApexPages.addMessage(myMsg);
        }
        //return null;
    }
    
    public pagereference backToAgreement(){
        agreementId = system.currentPageReference().getParameters().get('id');
        pagereference agreementPage = new pagereference('/' + agreementId);
        return agreementPage;
    }

}