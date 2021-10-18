/**
 * @description       : 
 * @author            : Hitesh Khatri
 * @group             : 
 * @last modified on  : 10-16-2021
 * @last modified by  : Hitesh Khatri
**/
public with sharing class PatientInformationWrapper {
    @AuraEnabled public String salutation;
    @AuraEnabled public String firstName;
    @AuraEnabled public String lastName;
    @AuraEnabled public String email;
    @AuraEnabled public String phone;
    @AuraEnabled public Date dob;
    @AuraEnabled public String mailingStreet;
    @AuraEnabled public String mailingCity;
    @AuraEnabled public String mailingState;
    @AuraEnabled public String mailingCountry;
    @AuraEnabled public String mailingZipCode;
    @AuraEnabled public String recordId;

}
