public with sharing class RequestController_AC {
    public id AggrementId{get;set;}
    public Apttus__APTS_Agreement__c AggRec{get;set;}
    
    
    public RequestController_AC(ApexPages.StandardController stdController) {
    	AggrementId = ApexPages.currentPage().getParameters().get('id');
    }
    
    public PageReference AggRedirect(){
   		if(AggrementId != null){
    	AggRec = [Select id,Apttus__Status__c,Approve_Requested_by__c From Apttus__APTS_Agreement__c Where id=:AggrementId];
    	AggRec.Apttus__Status__c = 'Approved Request';
    	AggRec.Approve_Requested_by__c = UserInfo.getUserId();
    	AggRec.OwnerID = UserInfo.getUserId();
    	update AggRec;
    	
    	PageReference retURL = new PageReference('/'+AggrementId);
	    retURL.setRedirect(true);
	    return retURL;
  		}
  		return null;   	
    }
}