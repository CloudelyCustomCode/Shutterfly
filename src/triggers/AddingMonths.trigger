trigger AddingMonths on Apttus__APTS_Agreement__c (before insert, before update) {
    /*for(Apttus__APTS_Agreement__c Agreementrec: trigger.new){
        if(Agreementrec.Start_Date_of_Services__c != null && Agreementrec.Apttus__Contract_End_Date__c == Null && agreementRec.End_Date_of_Services__c == Null){
            if(agreementRec.Cldy_Term_Months__c != Null){
                agreementRec.End_Date_of_Services__c = Agreementrec.Start_Date_of_Services__c.addMonths(Integer.valueof(Agreementrec.Cldy_Term_Months__c));
                agreementRec.Apttus__Contract_End_Date__c = Agreementrec.Start_Date_of_Services__c.addMonths(Integer.valueof(Agreementrec.Cldy_Term_Months__c));
            }
        }  
        if(agreementRec.End_Date_of_Services__c != Null || agreementRec.End_Date_of_Services__c == Null){
            agreementRec.Apttus__Contract_End_Date__c = agreementRec.End_Date_of_Services__c ;
        }
        if(agreementRec.Proposed_Effective_Date__c != Null || agreementRec.Proposed_Effective_Date__c == Null){
            agreementRec.Apttus__Contract_Start_Date__c = agreementRec.Proposed_Effective_Date__c ;
        }
    }*/
}