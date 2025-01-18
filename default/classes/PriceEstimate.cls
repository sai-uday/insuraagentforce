public with sharing class PriceEstimate {
    public static void getPriceEstimate(List<String> data) {
        Plan_Types__c temp = [SELECT Id, Name, CurrencyIsoCode, CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, MayEdit, IsLocked, LastViewedDate, LastReferencedDate, Benefits__c, Maximum_Price__c, Minimum_price__c, Minimum_Age__c, Maximum_Age__c, Max_no_of_people__c, Children__c, Adults__c, Middle_aged__c, Seniors__c, Exclusions__c, Coverage_upto__c FROM Plan_Types__cName =: data[0]];
    }
}