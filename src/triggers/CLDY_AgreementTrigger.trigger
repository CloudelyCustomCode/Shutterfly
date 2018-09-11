trigger CLDY_AgreementTrigger on Apttus__APTS_Agreement__c (after insert, after update, before update) { 
    AgreementTriggerHandler handler = new AgreementTriggerHandler();
    if(Trigger.isInsert && trigger.isafter){
        handler.afterInsert(Trigger.new);
    }
    if (Trigger.isUpdate && Trigger.isAfter) { 
        handler.afterupdate(Trigger.new, Trigger.oldMap);
    }   
    if (Trigger.isbefore && Trigger.isUpdate) {
         handler.beforeUpdate(Trigger.new, Trigger.oldMap);
    } 
}