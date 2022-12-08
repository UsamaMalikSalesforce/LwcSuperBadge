public with sharing class BoatDataService {
    public BoatDataService() {

    }
    @AuraEnabled(cacheable=true)
    public static List<Boat__c> getBoats(string boatTypeId)
    {
        List<Boat__c> allBoats = new List<Boat__c>();
        if(String.isBlank(boatTypeId))
        {
            allBoats = [Select
                                     Name,Description__c, Length__c, Picture__c, Price__c,
                                     Geolocation__c, Year_Built__c,
                                     BoatType__r.Name, Contact__r.Name 
                                from Boat__c
                               
                                ] ;
        }
        else {
            allBoats = [Select
                                     Name,Description__c, Length__c, Picture__c, Price__c,
                                     Geolocation__c, Year_Built__c,
                                     BoatType__r.Name, Contact__r.Name 
                                from Boat__c
                                where BoatType__c =: boatTypeId
                                ] ;
        }
        return allBoats;
                                
    }
    @AuraEnabled(cacheable=true)
    public static List<Boat__c> getSimilarBoats(string boatId, string similarBy) {
        List<Boat__c> boats = [Select Id, Name, Price__c, length__c, BoatType__r.Name, BoatType__c from Boat__c
                                 where Id=:boatId];
        return boats;
        
    }

    @AuraEnabled(cacheable=true)
    public static List<BoatType__c> getBoatTypes(){
       return [select Id, Name from BoatType__c];
    }

    @AuraEnabled(cacheable=false)
    public static List<BoatReview__c> getAllReviews(Id boatId){
       return [Select Id, Name, Comment__c,Rating__c from BoatReview__c where Boat__c =: boatId];
    }
    
    @AuraEnabled(cacheable=true)
    public static string getBoatsByLocation(string boatTypeId){
        if(String.isBlank(boatTypeId))
        {
            return JSON.serialize( [
                    Select  Id, Name,Geolocation__c, Price__c, length__c, BoatType__r.Name, BoatType__c from Boat__c
                   ]);
        }
        else{
            return JSON.serialize( [Select  Id, Name,Geolocation__c, Price__c, length__c, BoatType__r.Name, BoatType__c from Boat__c
            where BoatType__c =: boatTypeId]);
        }
    }
}