public with sharing class FetechQuizData {
    @AuraEnabled
    public static List<Quiz_Question__c> CheckQuizID(String input){
        try {
           Quiz__c lstofquiz=[SELECT Name,Id FROM Quiz__c WHERE Name=:input LIMIT 1];
           List<Quiz_Question__c> data = New List<Quiz_Question__c>();
            if(lstofquiz!=null){
               data=[SELECT Question_Number__c, Question_Questoin__c, Quiz_Related__c, Correct_Answer_Index__c, (SELECT Option_Number__c, Option_Info__c FROM Quiz_Options__r ORDER BY Option_Number__c) FROM Quiz_Question__c WHERE Quiz_Related__c = :lstofquiz.Id];
               return data;
            }else{
                throw new AuraHandledException('No quiz found with the specified name: ' + input);
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        } 
    }
}