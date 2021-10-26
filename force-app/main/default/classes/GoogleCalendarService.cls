/**
 * @description       : 
 * @author            : Hitesh Khatri
 * @group             : 
 * @last modified on  : 10-26-2021
 * @last modified by  : Hitesh Khatri
**/
public with sharing class GoogleCalendarService {
   
    @future(callout = true)
    public static void postCalendarEvent(String userEmail){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setMethod('GET');
        request.setEndpoint('callout:Google_API/gmail/v1/users/' + userEmail + '/profile');
 
        HTTPResponse response = http.send(request); 
        System.debug(JSON.serialize(response));
        
    }
}