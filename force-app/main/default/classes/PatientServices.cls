/**
 * @description       : 
 * @author            : Hitesh Khatri
 * @group             : 
 * @last modified on  : 10-19-2021
 * @last modified by  : Hitesh Khatri
**/
public with sharing class PatientServices {
    private static final Id Patient_Infor_RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get('Patient')?.getRecordTypeId(); 
   
    public PatientInformationWrapper createPatientInformation(String jsonString){
        PatientInformationWrapper wrapper = (PatientInformationWrapper) JSON.deserialize(jsonString, PatientInformationWrapper.class);
        
        Contact con = new Contact();
        con.salutation = wrapper.salutation;
        con.firstName = wrapper.firstName;
        con.lastName = wrapper.lastName;
        con.email = wrapper.email;
        con.phone = wrapper.phone;
        con.birthdate = wrapper.dob;

        con.mailingStreet = wrapper.mailingStreet;
        con.mailingCity = wrapper.mailingCity;
        con.mailingState = wrapper.mailingState;
        con.mailingCountry = wrapper.mailingCountry;
        con.mailingPostalCode = wrapper.mailingZipCode;
        con.recordTypeId = Patient_Infor_RecordTypeId;
        con.Title = 'Patient';

        List<Contact> cons = DAO_Contact.getDuplicateContact(con);
        if(cons.isEmpty()){
            SObjectAccessDecision securityDecesion = CRUD_SecurityChecks.getAccessibleData('Contact',new List<sObject>{con},'insert');
            con = (Contact)securityDecesion.getRecords()[0];
            Database.DMLOptions dml = new Database.DMLOptions(); 
            dml.DuplicateRuleHeader.allowSave = true;
            dml.DuplicateRuleHeader.runAsCurrentUser = true;
            Database.SaveResult sr = Database.insert(con, dml);                                
            wrapper.recordId = sr.getId();
        }else {
            wrapper.recordId = cons[0].Id;
        }
        
       
        return wrapper;
    }
}
