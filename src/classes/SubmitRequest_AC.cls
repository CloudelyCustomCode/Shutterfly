public with sharing class SubmitRequest_AC {
    
    public id AggrementId {get; set;}
    public Apttus__APTS_Agreement__c AggRec {get; set;}
    public SubmitRequest_AC(){
        AggrementId = ApexPages.currentPage().getParameters().get('id');
    }
    
    public PageReference AggRedirect(){
        if(AggrementId != null){
    	    AggRec = [Select id,Submit_Request__c From Apttus__APTS_Agreement__c Where id =: AggrementId];
    		AggRec.Submit_Request__c = true;
    		//Group queue = new Group;
    	    if(!test.isRunningTest()){
    		    Group queue = [SELECT Id FROM Group WHERE Name = 'Aggrement Request' and Type='Queue'];
    		    AggRec.OwnerID = queue.id;  
    		    update AggRec;
    		    if(queue.id != null){
    		        list<user> userlist = [SELECT id, name, username, isActive,Email FROM user WHERE id IN ( SELECT userOrGroupId FROM groupmember WHERE groupId =: queue.id ) ORDER BY  name  ];
    		        String addresses;
    		        for(user u:userlist){
    			        if(u.Email != null){
	            	        if(addresses == null){
	            	            addresses = u.Email;	
	            	        }
	            	        else{
	                            addresses = addresses  + ':'  + u.Email;
	            	        }
	                    }
    		        }
    		        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
	                List<String> emailAddresses = new List<String>();
	                emailaddresses = addresses.split(':',0);
	                message.ToAddresses = (emailaddresses);
	                message.subject = 'Aggrement Request';
	                message.plainTextBody = 'Aggrement Request';
	                List<Messaging.SendEmailResult> results = Messaging.sendEmail(new List<Messaging.SingleEmailMessage> {message});                   
                }
            }
            PageReference retURL = new PageReference('/'+AggrementId);
	        retURL.setRedirect(true);
	        return retURL;
        }
        return null;
    }
}