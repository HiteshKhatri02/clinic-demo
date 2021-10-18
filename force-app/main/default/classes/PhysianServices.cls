/**
 * @description       : 
 * @author            : Hitesh Khatri
 * @group             : 
 * @last modified on  : 10-16-2021
 * @last modified by  : Hitesh Khatri
**/
public with sharing class PhysianServices {
 
    /**
    * @description 
    * @author Hitesh Khatri | 10-14-2021 
    * @param departmentId 
    * @return List<Contact> 
    **/
    public static List<PhysianWrapper> getPhysians(String departmentId){
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
}
