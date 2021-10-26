/**
 * @description       : 
 * @author            : Hitesh Khatri
 * @group             : 
 * @last modified on  : 10-25-2021
 * @last modified by  : Hitesh Khatri
**/
public with sharing class DAO_Contact {

    private static final Id PATIENT_INFO_RECORD_TYPE_ID = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Patient')?.getRecordTypeId(); 
    private static final Id PHYSIAN_INFO_RECORD_TYPE_ID = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Physician')?.getRecordTypeId(); 

    /**
    * @description 
    * @author Hitesh Khatri | 10-14-2021 
    * @param departmentId 
    * @return List<contact> 
    **/
    public static List<contact> getPhysisans(Id departmentId){
        //CreatedDate < "First-Returned-Created-Date" ORDER BY CreatedDate DESC LIMIT 2000
        return [SELECT Id, Name, Start_Time__c, End_Time__c, Max_Appointment__c, Working_Days__c FROM Contact WHERE RecordType.DeveloperName = 'Physician' AND Department__c = :departmentId WITH SECURITY_ENFORCED ORDER BY CreatedDate LIMIT 5];
    }

    /**
    * @description 
    * @author Hitesh Khatri | 10-14-2021 
    * @param departmentId 
    * @param lastReturnedCreatedDate 
    * @return List<contact> 
    **/
    public static List<contact> getPhysisansWithNextPressed(Id departmentId, Date lastReturnedCreatedDate){
        //CreatedDate < "First-Returned-Created-Date" ORDER BY CreatedDate DESC LIMIT 2000
        return [SELECT Id, Name, Start_Time__c, End_Time__c, Max_Appointment__c, Working_Days__c FROM Contact WHERE RecordType.DeveloperName = 'Physician' AND Department__c = :departmentId AND CreatedDate > :lastReturnedCreatedDate WITH SECURITY_ENFORCED ORDER BY CreatedDate LIMIT 5];
    }

    /**
    * @description 
    * @author Hitesh Khatri | 10-14-2021 
    * @param departmentId 
    * @param firstReturnedCreatedDate 
    * @return List<contact> 
    **/
    public static List<contact> getPhysisansWithPrevPressed(Id departmentId, Date firstReturnedCreatedDate){
        //CreatedDate < "First-Returned-Created-Date" ORDER BY CreatedDate DESC LIMIT 2000
        return [SELECT Id, Name, Start_Time__c, End_Time__c, Max_Appointment__c, Working_Days__c FROM Contact WHERE RecordType.DeveloperName = 'Physician' AND Department__c = :departmentId AND CreatedDate < :firstReturnedCreatedDate WITH SECURITY_ENFORCED ORDER BY CreatedDate LIMIT 5];
    }

    
    
    public static List<contact> getDuplicateContact(Contact notInsertedCon){
        String firstName = notInsertedCon.firstName;
        String lastName = notInsertedCon.lastName;
        String email = notInsertedCon.email;
        String mailingCity = notInsertedCon.mailingCity;
        String mailingPostalCode = notInsertedCon.mailingPostalCode;
        String mailingStreet = notInsertedCon.mailingStreet;
        String phone = notInsertedCon.phone;
        String title = notInsertedCon.Title;
        String query = 'SELECT Id, Name, Start_Time__c, End_Time__c, Max_Appointment__c, Working_Days__c FROM Contact '; 
        query += 'WHERE account.Name = \'Be Well Health Care\' '; 
        query += 'AND firstName = :firstName '; 
        query += 'AND lastName = :lastName '; 
        if(String.isNotBlank(notInsertedCon.email)) { query += 'AND email = :email '; }
        if(String.isNotBlank(notInsertedCon.mailingCity)) { query += 'AND mailingCity = :mailingCity ';} 
        if(String.isNotBlank(notInsertedCon.mailingStreet)) { query += 'AND mailingStreet = :mailingStreet '; }                   
        if(String.isNotBlank(notInsertedCon.mailingPostalCode)) { query += 'AND mailingPostalCode = :mailingPostalCode '; }
        query += 'AND phone = :phone '; 
        query += 'AND Title = :title '; 
        query += 'WITH SECURITY_ENFORCED LIMIT 1 ';
        return Database.query(query);
    }

    public static List<Contact> getPhysianDetail(String recordId){
        return [SELECT Id, Name, Email FROM Contact WHERE Id = :recordId AND RecordTypeId = :PHYSIAN_INFO_RECORD_TYPE_ID WITH SECURITY_ENFORCED LIMIT 1];
    }

    
}
