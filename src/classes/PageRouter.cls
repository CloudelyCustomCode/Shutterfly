public with sharing class PageRouter {
    public String redirectUrl {get; set;} 
	public String returnURL {get; set;} 
	
	public PageRouter(ApexPages.StandardController stdController){
	}
	
	public pagereference redirectPage(){
	    Id recordTypeId = System.currentPageReference().getParameters().get('RecordType');
	    returnURL = ApexPages.currentPage().getParameters().get('retURL');
	    if(recordTypeId != null){
	        RecordType Rtype = [Select id,Name From RecordType Where id=:recordTypeId];
	        DescribeSObjectResult result = Schema.SObjectType.Apttus__APTS_Agreement__c;
	        if(Rtype.Name == 'New Request'){
		        pagereference requestorPage = new pagereference('/apex/AgreementForm_LGT_VF?RecordType='+ Rtype.Id + '&retURL=' + returnURL + '&ent=01I80000000Qxz7&save_new=1&sfdc.override=1');
		        requestorPage.setredirect(true);
		        return requestorPage;  
	        }
	        else{
	            pagereference requestorPage = new pagereference('/apex/Apttus__AgreementNew?RecordType='+ Rtype.Id + '&retURL=' + returnURL + '&ent=01I80000000Qxz7&save_new=1&sfdc.override=1');
		        requestorPage.setredirect(true);
		        return requestorPage;
	        }
	    }
	    else{
	        return null;
	    }
	}
}