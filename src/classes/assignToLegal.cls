public class assignToLegal {
    public boolean disableAttorney {get;set;}
    public Apttus__APTS_Agreement__c agreement {get;set;}
    public boolean shouldRedirect {get;set;}
    public string parentURL {get;set;}
    public boolean doNotUpdateOwner = false;
    public assignToLegal(ApexPages.StandardController stdController) {
        Apttus__APTS_Agreement__c loadedAgt =  (Apttus__APTS_Agreement__c)stdController.getRecord();
        agreement = [select Id, OwnerId, Apttus__Status__c, Cldy_Attorney__c, Apttus__Status_Category__c, Cldy_Contracts_Manager__c from Apttus__APTS_Agreement__c where Id = :loadedAgt.Id][0];
        if(agreement.Cldy_Attorney__c != null){
            doNotUpdateOwner = true;
        }
        init();
    }
    
    void init() {
        disableAttorney = isAttorneydDisabled();
    }
    
    private boolean isAttorneydDisabled(){
        Profile userProfileRec = [select Name from profile where id = :userinfo.getProfileId()];  
        if(agreement.Apttus__Status__c == 'Submitted Request' && agreement.Apttus__Status_Category__c == 'Request' && (userProfileRec.Name == 'Contracts Manager' || userProfileRec.Name == 'System Administrator') && agreement.Cldy_Attorney__c == null){
            return false;
        }
        else if(userinfo.getName() == Label.Assign_To_Attorney_User_Name){
            return false;
        }
        else{
            return true;
        }
        
    }
    
    
    public void AssignToAttorney(){  
        try{
            if(agreement.Cldy_Attorney__c == null){
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please Select Attorney.'));
            }
            else {
                if(!doNotUpdateOwner){
                    agreement.Cldy_Contracts_Manager__c = agreement.OwnerId;
                    
                }
                update agreement;
                parentURL = getCurrentUrl();
                shouldRedirect = true;
            }
        }
        catch(Exception exp){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'' + exp));
        }
    }
    
    private String getCurrentUrl() {
        String hostVal  = ApexPages.currentPage().getHeaders().get('Host');
        return 'https://' + hostVal+ '/' + agreement.id;
    }
}