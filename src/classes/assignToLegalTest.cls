@isTest
public without sharing class assignToLegalTest{
    static testMethod void myUnitTest() {
        Account acc = new Account();
        acc.Name='test';
        insert acc;
        Apttus__APTS_Agreement__c AA = new Apttus__APTS_Agreement__c();
        AA.Apttus__Account__c=acc.id;
        AA.Payment_Terms__c='Special';
        AA.State_of_Incorporation__c='test';
        AA.Contract_Month__c='June';
        AA.Contract_Day__c='04';
        AA.Contract_Year__c='2011';
        insert AA;
        
   ApexPages.StandardController sc = new ApexPages.StandardController(AA); 
   assignToLegal at = new assignToLegal(sc);
   at.AssignToAttorney();
   
   
         
    }
    
     static testMethod void myUnitTest1() {
        Account acc = new Account();
        acc.Name='test';
        insert acc;
        Apttus__APTS_Agreement__c AA = new Apttus__APTS_Agreement__c();
        AA.Apttus__Account__c=acc.id;
        AA.Payment_Terms__c='Special';
        AA.State_of_Incorporation__c='test';
        AA.Contract_Month__c='June';
        AA.Contract_Day__c='04';
        AA.Contract_Year__c='2011';
        AA.Cldy_Attorney__c=UserInfo.getUserId();	
        insert AA;
        
   ApexPages.StandardController sc = new ApexPages.StandardController(AA); 
   assignToLegal at = new assignToLegal(sc);
   at.AssignToAttorney();
   
   
         
    }
    
}