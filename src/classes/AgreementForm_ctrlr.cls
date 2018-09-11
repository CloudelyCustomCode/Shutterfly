global without sharing class AgreementForm_ctrlr{
    
    public String returnURL {get; set;} 
    
    public Apttus__APTS_Agreement__c agreement{get;set;}
    
    static Apttus__APTS_Agreement__c agreementRec
    {
        get
        {
            if (agreementRec == null)
            {
                agreementRec = new Apttus__APTS_Agreement__c();
            }
            return agreementRec;
        }
        private set;
    }
    public AgreementForm_ctrlr(){
        if(system.currentPageReference().getParameters().get('importOfflineDoc') != null && system.currentPageReference().getParameters().get('importOfflineDoc') != ''){
            importOfflineDocument = Boolean.valueOf(system.currentPageReference().getParameters().get('importOfflineDoc'));    
        }
    }
    
    public boolean importOfflineDocument{get;set;}
    
    public class fromJSON{
        public String businessOwner;
        public String vendorName;
        public String aka;
        public String source;
        public String counterPartyName;
        public String counterPartyEmail;    
        public boolean existingAgCheckbox;
        public String existingAgText;   
        public String ProposedEffectiveDate;
        public string termMonths;
        public String serviceStartDate; 
        public String serviceEndDate;   
        public String agreementType;    
        public String description;  
        public boolean brandSFLYINC;
        public boolean brandSFLY;
        public boolean brandTP;
        public boolean brandWPD;
        public boolean brandBorrowLenses;
        public boolean brandMyPub;
        public boolean bradGrooveBook;
        public String eStaff;   
        public String TransactionType;  
        public String agreementValue;   
        public String paymentTerms; 
        public boolean poRequired;   
        public String poRequiredText;   
        public boolean withinBudgetYes;
        public boolean withinBudgetNo;
        public String capex;    
        public boolean capitalCommitteApproval;
        public boolean perLicense;   
        public String additionalInformation;    
        public boolean rush;
        public String rushText; 
        public string FPAContact;
    }
    
    @remoteAction
    global static String submitForm(string data, string vendorId, string businessId, Boolean importOfflineDocument){
        try{
            fromJSON  responseAfterParsing = (fromJSON) System.JSON.deserialize(data, fromJSON.class);
            agreementRec.Name = 'Agrement Request';
            
            List<RecordType> recordTypeLst = [SELECT Id,Name,SobjectType FROM RecordType where Name = 'New Request' and SobjectType = 'Apttus__APTS_Agreement__c'];
            if(recordTypeLst.size()>0){
                agreementRec.RecordTypeId = recordTypeLst[0].Id;
            }
            
            if(vendorId != null && vendorId != ''){
                agreementRec.Apttus__Account__c = vendorId;            
            }
            if(businessId != null && businessId != ''){
                agreementRec.Cldy_Business_Owner__c = businessId;            
            }   
            agreementRec.Counterparty__c = responseAfterParsing.counterPartyName;
            agreementRec.Counterparty_E_mail__c = responseAfterParsing.counterPartyEmail;
            agreementRec.Existing_Agreement__c = responseAfterParsing.existingAgCheckbox;
            agreementRec.Counterparty__c = responseAfterParsing.counterPartyName;
            agreementRec.AKA_s__c = responseAfterParsing.aka;
            agreementRec.Counterparty_E_mail__c = responseAfterParsing.counterPartyEmail;
            agreementRec.Cldy_Existing_Agreement_Details__c = responseAfterParsing.existingAgText;
            if(responseAfterParsing.ProposedEffectiveDate != null){
                agreementRec.Proposed_Effective_Date__c = date.valueOf(responseAfterParsing.ProposedEffectiveDate);
                agreementRec.Apttus__Contract_Start_Date__c = date.valueOf(responseAfterParsing.ProposedEffectiveDate);
            }
            if(responseAfterParsing.serviceStartDate != null){
                agreementRec.Start_Date_of_Services__c = date.valueOf(responseAfterParsing.serviceStartDate);
            }
            if(responseAfterParsing.termMonths != '' ){
                agreementRec.Cldy_Term_Months__c = double.valueOf(responseAfterParsing.termMonths);
                agreementRec.Apttus__Term_Months__c = double.valueOf(responseAfterParsing.termMonths);
            }
            if(responseAfterParsing.serviceEndDate != null){
                agreementRec.End_Date_of_Services__c = date.valueOf(responseAfterParsing.serviceEndDate);
                //if(agreementRec.Cldy_Term_Months__c != null){
                agreementRec.Apttus__Contract_End_Date__c = date.valueOf(responseAfterParsing.serviceEndDate);
                //}
                //else{
                    //agreementRec.Apttus__Contract_End_Date__c = date.valueOf(responseAfterParsing.serviceEndDate);
                //}
            }
            agreementRec.Agreement_Type__c = responseAfterParsing.agreementType;
            agreementRec.Apttus__Source__c = responseAfterParsing.source;
            agreementRec.Description__c = responseAfterParsing.description;
            string brandString = '';
            if(responseAfterParsing.brandSFLYINC == true){
                if(brandString == ''){
                    brandString = 'SFLY, inc (All)';
                }
                else{
                    brandString = brandString + ';SFLY, inc (All)';
                }
            }
            if(responseAfterParsing.brandSFLY == true){
                if(brandString == ''){
                    brandString = 'SFLY';
                }
                else{
                    brandString = brandString + ';SFLY';
                }
            }
            if(responseAfterParsing.brandTP == true){
                if(brandString == ''){
                    brandString = 'TP';
                }
                else{
                    brandString = brandString + ';TP';
                }
            }
            if(responseAfterParsing.brandWPD == true){
                if(brandString == ''){
                    brandString = 'WPD';
                }
                else{
                    brandString = brandString + ';WPD';
                }
            }
            if(responseAfterParsing.brandBorrowLenses == true){
                if(brandString == ''){
                    brandString = 'Borrow Lenses';
                }
                else{
                    brandString = brandString + ';Borrow Lenses';
                }
            }
            if(responseAfterParsing.brandMyPub == true){
                if(brandString == ''){
                    brandString = 'My Pub';
                }
                else{
                    brandString = brandString + ';My Pub';
                }
            }
            if(responseAfterParsing.bradGrooveBook == true){
                if(brandString == ''){
                    brandString = 'Groovebook';
                }
                else{
                    brandString = brandString + ';Groovebook';
                }
            }
            if(brandString != ''){
                agreementRec.Brand__c =  brandString;
            }
            agreementRec.E_Staff__c = responseAfterParsing.eStaff;
            if(agreementRec.E_Staff__c != null){
                List<User> userRecords = [Select Id from User Where Name =: agreementRec.E_Staff__c];
                if(userRecords.size()>0){
                    agreementRec.E_Staff_Approver__c = userRecords[0].Id;
                }
                else{
                }
            }
            agreementRec.Transaction_Type__c = responseAfterParsing.TransactionType;
            
            if(responseAfterParsing.agreementValue != null && responseAfterParsing.agreementValue != ''){
                responseAfterParsing.agreementValue = responseAfterParsing.agreementValue.replace(',','');
                agreementRec.Agreement_Value__c = double.valueOf(responseAfterParsing.agreementValue);    
            }
            if(responseAfterParsing.poRequiredText != null && responseAfterParsing.poRequiredText != ''){
                agreementRec.PO_Number__c = responseAfterParsing.poRequiredText; 
            }
            agreementRec.Po_Required__c = responseAfterParsing.poRequired;
            
            if(responseAfterParsing.withinBudgetYes == true){
                agreementRec.Within_Budget__c = 'Yes';
            }
            else{
                agreementRec.Within_Budget__c = 'No';
            }
            if(responseAfterParsing.capex != null && responseAfterParsing.capex != ''){
                responseAfterParsing.capex = responseAfterParsing.capex.replace(',','');
                agreementRec.Employee_Estimated_Capex__c = integer.valueOf(responseAfterParsing.capex);    
            }
            
            if(responseAfterParsing.FPAContact != null && responseAfterParsing.FPAContact != ''){
                agreementRec.FP_A_Contact__c = responseAfterParsing.FPAContact;
            }
            agreementRec.Capital_Commitee_Approval__c = responseAfterParsing.capitalCommitteApproval;
            agreementRec.If_Software_it_is_a_perpetual_License__c = responseAfterParsing.perLicense;
            agreementRec.Additional_information_Comments__c = responseAfterParsing.additionalInformation;
            agreementRec.Rush__c = responseAfterParsing.rush;
            agreementRec.Explanation_For_Delay__c = responseAfterParsing.rushText;
            agreementRec.Payment_Terms__c = responseAfterParsing.paymentTerms;
            agreementRec.Cldy_Requestor__c = UserInfo.getUserId();
            insert agreementRec;
            if(importOfflineDocument){
                return 'true1;' + URL.getSalesforceBaseUrl().toExternalForm() +'/apex/Apttus__OfflineDocumentImport?id=' + agreementRec.id;
            }
            else{
                return 'true;' + agreementRec.id; 
            }
        }
        catch(Exception exp){
            return 'false;' + string.valueOf(exp);
        }
    }
    
    @RemoteAction
    global static string RedirectPage() {
        DescribeSObjectResult result = Schema.SObjectType.Apttus__APTS_Agreement__c;
        String route = '/'+ string.valueOf(result.getKeyPrefix()) +'/o';
        system.debug('the route is' + route);
        return route;
    }
}