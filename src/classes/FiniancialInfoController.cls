public without sharing class FiniancialInfoController {
	public String proposalId;
    public Apttus__APTS_Agreement__c proposal {get; set;}
    public FiniancialInfoController(ApexPages.StandardController stdController) {
        try{
    	    proposal = new Apttus__APTS_Agreement__c();
        	proposalId = ApexPages.currentPage().getParameters().get(EncodingUtil.urlEncode('id','UTF-8'));
        	proposal = [Select Id, Name, 
                    		Payment_Terms__c,
                    		Finance_Type__c,
                    		EFI_Quote__c,
                    		Non_Standard_Accounting__c,
                    		Change_Request_Hourly_Rate__c,
                    		Accounting_Comments__c
                    		FROM 
                    		Apttus__APTS_Agreement__c 
                    		WHERE Id =: proposalId];
    	}
    	catch(Exception exp){
    		ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, exp.getMessage());
            ApexPages.addMessage(myMsg);
    	}
    }
    public Pagereference saveFinancialInfo() {
        try{
			Apttus__APTS_Agreement__c quote = new Apttus__APTS_Agreement__c();
	        quote.id = proposal.id;
	        quote.Payment_Terms__c = proposal.Payment_Terms__c;
	        quote.Finance_Type__c = proposal.Finance_Type__c;
	        quote.EFI_Quote__c = proposal.EFI_Quote__c;
	        quote.Finance_Type__c = proposal.Finance_Type__c;
	        quote.Change_Request_Hourly_Rate__c = proposal.Change_Request_Hourly_Rate__c;
	        quote.Accounting_Comments__c = proposal.Accounting_Comments__c;
	        quote.Non_Standard_Accounting__c = proposal.Non_Standard_Accounting__c;
	        update quote;
	        Pagereference agreementPage = new Pagereference('/' + quote.Id);
	        agreementPage.setRedirect(true);
	        return agreementPage;
    	}
    	catch(Exception exp){
    	    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, exp.getMessage());
            ApexPages.addMessage(myMsg);
    	}
        return null; 
	}
	public Pagereference gotoAgreement(){
		Pagereference agreementPage = new Pagereference('/' + proposalId);
	   	agreementPage.setRedirect(true);
	    return agreementPage;
	}
}