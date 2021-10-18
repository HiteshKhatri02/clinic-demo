/**
 * @description       : 
 * @author            : Hitesh Khatri
 * @group             : 
 * @last modified on  : 10-19-2021
 * @last modified by  : Hitesh Khatri
**/
public with sharing class CalendarListResponseWrapper {
    public String kind;
	public String etag;
	public String nextSyncToken;
	public List<Items> items;

	public class NotificationSettings {
		public List<Notifications> notifications;
	}

	public class DefaultReminders {
		public String method;
		public Integer minutes;
	}

	public class ConferenceProperties {
		public List<String> allowedConferenceSolutionTypes;
	}

	public class Items {
		public String kind;
		public String etag;
		public String id;
		public String summary;
		public String timeZone;
		public String colorId;
		public String backgroundColor;
		public String foregroundColor;
		public Boolean selected;
		public String accessRole;
		public List<DefaultReminders> defaultReminders;
		public NotificationSettings notificationSettings;
		public Boolean primary;
		public ConferenceProperties conferenceProperties;
	}

	public class Notifications {
		public String type;
		public String method;
	}

	
	public static CalendarListResponseWrapper parse(String json) {
		return (CalendarListResponseWrapper) System.JSON.deserialize(json, CalendarListResponseWrapper.class);
	}
}
