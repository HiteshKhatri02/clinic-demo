/**
 * @description       : 
 * @author            : Hitesh Khatri
 * @group             : 
 * @last modified on  : 10-19-2021
 * @last modified by  : Hitesh Khatri
**/
public with sharing class AppointmentServices {

    public String createAppointment(String jsonString){
        
        AppointmentDetailWrapper wrapper = (AppointmentDetailWrapper) JSON.deserialize(jsonString, AppointmentDetailWrapper.class);
       
        Appointment__c app = new Appointment__c();
        app.Physician__c = wrapper.physianId;
        app.Patient__c = wrapper.patientId;
        app.Status__c = 'Scheduled';
        SObjectAccessDecision securityDecesion = CRUD_SecurityChecks.getAccessibleData('Appointment__c',new List<sObject>{app},'insert');
        app = (Appointment__c)securityDecesion.getRecords()[0];
    
        insert app;

        Appointment__c app2 = [SELECT Id, Name FROM Appointment__c WHERE Id = :app.Id WITH SECURITY_ENFORCED LIMIT 1];
        return app2.name;            
    }
}
