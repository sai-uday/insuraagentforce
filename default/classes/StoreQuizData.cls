public with sharing class StoreQuizData {
    @AuraEnabled
    public static Integer storeData(String  inputData){
        System.debug('hi');
        try {
            List<Object> questionList= (List<Object>) JSON.deserializeUntyped(inputData);
            System.debug('questionList'+questionList);
            Quiz__c tt = new Quiz__c();
            insert tt;
            List<Quiz_Question__c> listofQuestions = new List<Quiz_Question__c>();
            for(object iter:questionList){
                Quiz_Question__c temp = new Quiz_Question__c();
                temp.Quiz_Related__c = tt.id;
                temp.Question_Questoin__c = (String)((Map<String, object >) iter).get('questionDetails');
                temp.Question_Number__c = (String)((Map<String, object >) iter).get('questionNumber');
                temp.Correct_Answer_Index__c = (String)((Map<String, object >) iter).get('correctAnswerIndex');
                listofQuestions.add(temp);
            }
            insert listofQuestions;
            for (Integer i = 0; i < questionList.size(); i++) {
                Map<String, Object> questionData = (Map<String, Object>) questionList[i];
                questionData.put('questionid', listofQuestions[i].Id);
            }

            // Optional: Log the updated questionList for verification
            System.debug('Updated question list with IDs: ' + questionList);
            //List<Quiz_Question__c> questionList = (List<Quiz_Question__c>)(JSON.deserializeUntyped(inputData));
            // for(Quiz_Question__c iter:listofQuestions){
            //     System.debug(iter);
            // }
            List<Quiz_Options__c> rqoptions = new List<Quiz_Options__c>();
            for(object iter:questionList){
                List<object> optList = (List<Object>)((Map<String, object >) iter).get('options');
                String reqId= (String)((Map<String, object >) iter).get('questionid');
                System.debug(reqId);
                for(object optIter:optList){
                    Quiz_Options__c tempOpt = new Quiz_Options__c();
                    tempOpt.Quiz_Question__c = reqId ; 
                    tempOpt.Option_Info__c = (String)((Map<String, object >) optIter).get('value');
                    tempOpt.Option_Number__c = (Decimal)((Map<String, object >) optIter).get('index');
                //    // tempOpt.Is_Correct__c = (Boolean)((Map<String, object > ) optIter).get('isCorrect');
                //     tempOpt.Quiz_Question__c = (String)((Map<String, object >) iter).get('_id');
                //     insert tempOpt;
                System.debug(tempOpt);
                System.debug('tessst');
                rqoptions.add(tempOpt);
                }      
            }
            insert rqoptions;
            return 1;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());  
        } 
    }
}