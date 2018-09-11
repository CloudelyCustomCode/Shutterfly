public with sharing class TA_Approve_Request_AC {
    public id AggrementId{get;set;}
    public Apttus__APTS_Agreement__c AggRec{get;set;}
    
    
    public TA_Approve_Request_AC(ApexPages.StandardController stdController) {
    	AggrementId = ApexPages.currentPage().getParameters().get('id');
    }
    
    public PageReference AggRedirect(){
   		if(AggrementId != null){
    	AggRec = [Select id,TA_Approver__c From Apttus__APTS_Agreement__c Where id=:AggrementId];
    	if(AggRec.TA_Approver__c != null){
    		AggRec.OwnerID = AggRec.TA_Approver__c;
    	}
    	update AggRec;
    	
    	PageReference retURL = new PageReference('/'+AggrementId);
	    retURL.setRedirect(true);
	    return retURL;
  		}
  		return null;   	
    }   
}