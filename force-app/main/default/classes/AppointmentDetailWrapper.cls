/**
 * @description       : 
 * @author            : Hitesh Khatri
 * @group             : 
 * @last modified on  : 10-19-2021
 * @last modified by  : Hitesh Khatri
**/
public with sharing class AppointmentDetailWrapper {
   
    @AuraEnabled public String physianId;
    @AuraEnabled public String patientId;
}
