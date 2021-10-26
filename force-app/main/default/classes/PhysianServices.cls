/**
 * @description       : 
 * @author            : Hitesh Khatri
 * @group             : 
 * @last modified on  : 10-26-2021
 * @last modified by  : Hitesh Khatri
**/
public with sharing class PhysianServices {
 
    /**
    * @description 
    * @author Hitesh Khatri | 10-14-2021 
    * @param departmentId 
    * @return List<Contact> 
    **/
    public List<PhysianWrapper> getPhysians(String departmentId){
        List<PhysianWrapper> physians = new List<PhysianWrapper>();
        List<Contact> cons = DAO_Contact.getPhysisans(departmentId);

        
        for(Contact con : cons){
            PhysianWrapper wrap = new PhysianWrapper();
            wrap.id = con.Id;
            wrap.name = con.name;
            wrap.availability = con.Working_Days__c;
            Datetime startTime = Datetime.newInstanceGmt(System.today(), con.Start_Time__c);
            Datetime endTime = Datetime.newInstanceGmt(System.today(), con.End_Time__c);
            wrap.startTime = startTime.format('h:mm a');
            wrap.endTime = endTime.format('h:mm a');
            wrap.maxAppointment = String.valueOf(con.Max_Appointment__c);
            physians.add(wrap);
        }


        return physians;
    }


    @AuraEnabled
    public static void postCalendarEvent(String userEmail){
        try {
            GoogleCalendarService.postCalendarEvent(userEmail);
        } catch (Exception err) {
            throw new AuraHandledException(err.getMessage());
        }
    }

    @AuraEnabled
    public static String callWebService(String appointmentId){
        try {
            List<Appointment__c> apps = [SELECT Id, Start_Date_Time__c, End_Date_Time__c, Patient__r.Name, Patient__r.Email, Physician__r.Name, Physician__r.Email, Physician__r.Account.ShippingStreet FROM Appointment__c WHERE Id = :appointmentId WITH SECURITY_ENFORCED LIMIT 1];
            if(apps.isEmpty()){ return null;} 

            String jsonString=		'{'+
            '"end" : {'+
            '"dateTime" : "'+ String.valueOf(apps[0].End_Date_Time__c.formatGMT('YYYY-MM-DD\'T\'hh:mm:ss+00:00'))+'",'+
            '"timeZone" : "Asia/Kolkata"'+
            '},'+
            '"start" : {'+
            '"dateTime" : "'+String.valueOf(apps[0].Start_Date_Time__c.formatGMT('YYYY-MM-DD\'T\'hh:mm:ss+00:00'))+'",'+
            '"timeZone" : "Asia/Kolkata"'+
            '},'+
            '"summary" : "Your appointment has booked with '+apps.get(0).Patient__r.Name+'",'+
            '"location" : "'+apps[0].Physician__r.Account.ShippingStreet.replace('\\n', ' ').replaceAll('\\r', ' ')+'",'+
            '"description" : "Your appointment has booked with '+apps.get(0).Patient__r.Name+'" }';
        
          
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/json');
            System.debug('Request Bod is:' + JSON.serializePretty(jsonString.replaceAll('\\"','"')));
            request.setBody(JSON.serialize(jsonString.unescapeJava()));
            request.setEndpoint('callout:Google_API/calendar/v3/calendars/primary/events');
     
            HTTPResponse response = http.send(request); 
            return JSON.serialize(response);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}