/**
 * @description       : 
 * @author            : Hitesh Khatri
 * @group             : 
 * @last modified on  : 10-16-2021
 * @last modified by  : Hitesh Khatri
**/
public with sharing class PhysianWrapper {
    @AuraEnabled
    public String name;

    @AuraEnabled 
    public String id;

    @AuraEnabled 
    public String availability;

    @AuraEnabled 
    public String maxAppointment;

    @AuraEnabled 
    public String startTime;

    @AuraEnabled 
    public String endTime;
}
