public Without Sharing class AgreementTriggerHandler {
    
    ID groupId = [select id from Group where Name = 'Employee Group'].id;
    
    public void afterInsert(List<Apttus__APTS_Agreement__c> agreementList){
        List<Apttus__APTS_Agreement__Share> sharesToCreate = new List<Apttus__APTS_Agreement__Share>(); 
        sharesToCreate.addAll(shareRecordsToGroup(agreementList));
        if(!sharesToCreate.isEmpty()){ 
            insert sharesToCreate; 
        } 
    }
    
    public void afterupdate(list<Apttus__APTS_Agreement__c> agreementList, Map<id,Apttus__APTS_Agreement__c> oldMap){
        Set<ID> shareIdsToDelete = new Set<ID>();
        List<Apttus__APTS_Agreement__Share> sharesToCreate = new List<Apttus__APTS_Agreement__Share>(); 
        List<Apttus__APTS_Agreement__c> agreementToShare = new List<Apttus__APTS_Agreement__c>();
        List<Apttus__APTS_Agreement__c> agreementToShareRequestor = new List<Apttus__APTS_Agreement__c>();
        for (Apttus__APTS_Agreement__c agree : agreementList) {
            if(oldMap.get(agree.id).Private__c == false && agree.Private__c == true) {
                shareIdsToDelete.add(agree.id);
            }
            if(oldMap.get(agree.id).Apttus__Status__c != 'Submitted Request' && agree.Apttus__Status__c == 'Submitted Request' ){
                if(agree.Apttus__Requestor__c != null){
                    agreementToShareRequestor.add(agree);
                }
                if(agree.Private__c == false){
                    agreementToShare.add(agree);
                }
            }
            if(oldMap.get(agree.id).OwnerId != agree.OwnerId){
                if(agree.Apttus__Requestor__c != null){
                    agreementToShareRequestor.add(agree);
                }
                agreementToShare.add(agree);
            }
            if(oldMap.get(agree.id).Private__c == true && agree.Private__c == false){
                agreementToShare.add(agree);
            }
            
        }
        if(!agreementToShare.isEmpty()){
            sharesToCreate.addAll(shareRecordsToGroup(agreementToShare));
        }
        if(!shareIdsToDelete.isEmpty()){
            deleteShareRecords(shareIdsToDelete);
        } 
        if(!agreementToShareRequestor.isEmpty()){
            sharesToCreate.addAll(shareRecordsToRequestor(agreementToShareRequestor));
        }
        if(!sharesToCreate.isEmpty()){
            insert sharesToCreate; 
        }
    }
    
    public void beforeUpdate(list<Apttus__APTS_Agreement__c> agreementList, Map<id,Apttus__APTS_Agreement__c> oldMap){
        Set<String> EstaffNames = new Set<String>();
        for(Apttus__APTS_Agreement__c agmt : agreementList){
            if(agmt.E_Staff__c != null){
                EstaffNames.add(agmt.E_Staff__c);
            }
        }   
        Map<String,Id> userMap = New Map<String,Id>();
        for(User userRec : [select id,Name from User where Name IN : EstaffNames]){
            userMap.put(userRec.Name, userRec.id);
        }
        for(Apttus__APTS_Agreement__c agmt : agreementList){  
            if(agmt.E_Staff__c != null){
                if(agmt.E_Staff__c != oldMap.get(agmt.Id).E_Staff__c){ 
                    if(userMap.get(agmt.E_Staff__c) != null){
                        agmt.E_Staff_Approver__c = userMap.get(agmt.E_Staff__c); 
                    }
                }
            } 
        }
    }
    
    public List<Apttus__APTS_Agreement__Share> shareRecordsToGroup(List<Apttus__APTS_Agreement__c> agreementList){
        List<Apttus__APTS_Agreement__Share> sharesToCreate = new List<Apttus__APTS_Agreement__Share>(); 
        for (Apttus__APTS_Agreement__c agree : agreementList) { 
            if(agree.Private__c == false){
                Apttus__APTS_Agreement__Share AgreementShare = new Apttus__APTS_Agreement__Share();
                AgreementShare.AccessLevel = 'Edit';
                AgreementShare.ParentID = agree.Id;
                AgreementShare.UserOrGroupId =  groupId;
                sharesToCreate.add(AgreementShare); 
            }
        } 
        return sharesToCreate;
    }
    
    public List<Apttus__APTS_Agreement__Share> shareRecordsToRequestor(List<Apttus__APTS_Agreement__c> agreementList){
        List<Apttus__APTS_Agreement__Share> sharesToCreate = new List<Apttus__APTS_Agreement__Share>(); 
        for (Apttus__APTS_Agreement__c agree : agreementList) { 
            if(agree.OwnerId != agree.Apttus__Requestor__c){
                Apttus__APTS_Agreement__Share AgreementShare = new Apttus__APTS_Agreement__Share();
                AgreementShare.AccessLevel = 'Edit';
                AgreementShare.ParentID = agree.Id;
                AgreementShare.UserOrGroupId =  agree.Apttus__Requestor__c;
                sharesToCreate.add(AgreementShare); 
            }
        } 
        return sharesToCreate;
    }
    
    public void deleteShareRecords(Set<Id> shareIdsToDelete){
        delete [select id from Apttus__APTS_Agreement__Share where ParentID IN: shareIdsToDelete AND UserOrGroupId =: groupId];
    }
    
}