/**
 * @description       : 
 * @author            : Hitesh Khatri
 * @group             : 
 * @last modified on  : 10-19-2021
 * @last modified by  : Hitesh Khatri
**/
public with sharing class GoogleCalendarServices {
    
    public static String getClanderId() {
    
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('callout:Google_API/calendar/v3/users/me/calendarList');
 
        HTTPResponse response = http.send(request);
    
        CalendarListResponseWrapper responseWrapper = CalendarListResponseWrapper.parse(response.getBody());
        String calId;
        if(response.getStatusCode() == 200){
            calId = responseWrapper.items[0].id;
        }
        return calId;
        
    }

    @future(callout = true)
    public static void createEvent(GoogleCalendarEvent calEvent){
        String calId = getClanderId();

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setEndpoint('callout:Google_API/calendar/v3/calendars/'+calId+'/events');
 
        HTTPResponse response = http.send(request);
    
        CalendarListResponseWrapper responseWrapper = CalendarListResponseWrapper.parse(response.getBody());
        String calId;
        if(response.getStatusCode() == 200){
            calId = responseWrapper.items[0].id;
        }
    }

    
}
