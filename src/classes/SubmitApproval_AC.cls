public with sharing class SubmitApproval_AC {
    
    public id AggrementId{get;set;}
    public id userid {get;set;}
    public Apttus__APTS_Agreement__c AggRec{get;set;}
    public SubmitApproval_AC(){
    	AggrementId = ApexPages.currentPage().getParameters().get('id');
    	userid = UserInfo.getUserId();
    	
    }
    
    public PageReference AggRedirect(){
    	if(AggrementId != null){
    		AggRec = [Select id,Submit_Approval__c From Apttus__APTS_Agreement__c Where id=:AggrementId];
    		AggRec.Submit_Approval__c = true;
    		AggRec.OwnerID = userid;
    		update AggRec;
	      PageReference retURL = new PageReference('/'+AggrementId);
	      retURL.setRedirect(true);
	      return retURL;
    	}
	   return null;

 }
   
}