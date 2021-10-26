/**
 * @description       : 
 * @author            : Hitesh Khatri
 * @group             : 
 * @last modified on  : 10-26-2021
 * @last modified by  : Hitesh Khatri
**/
public with sharing class GCalendarEventWrapper {
    public End_Z end_Z {get;set;} // in json: end
	public End_Z start {get;set;} 
	public String summary {get;set;} 
	public String location {get;set;} 
	public String description {get;set;} 

	public GCalendarEventWrapper(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'end') {
						end_Z = new End_Z(parser);
					} else if (text == 'start') {
						start = new End_Z(parser);
					} else if (text == 'summary') {
						summary = parser.getText();
					} else if (text == 'location') {
						location = parser.getText();
					} else if (text == 'description') {
						description = parser.getText();
					} else {
						System.debug(LoggingLevel.WARN, 'GCalendarEventWrapper consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class End_Z {
		public String dateTime_Z {get;set;} // in json: dateTime
		public String timeZone {get;set;} 

		public End_Z(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'dateTime') {
							dateTime_Z = parser.getText();
						} else if (text == 'timeZone') {
							timeZone = parser.getText();
						} else {
							System.debug(LoggingLevel.WARN, 'End_Z consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	
	public static GCalendarEventWrapper parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new GCalendarEventWrapper(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
	


}
