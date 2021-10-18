/**
 * @description       : 
 * @author            : Hitesh Khatri
 * @group             : 
 * @last modified on  : 10-19-2021
 * @last modified by  : Hitesh Khatri
**/
public with sharing class AvailableAppoinmentsController {

    /**
    * @description 
    * @author Hitesh Khatri | 10-14-2021 
    * @return List<OptionsWrapper> 
    **/
    @AuraEnabled
    public static List<OptionsWrapper> getAvailableDepartments(){
        try {
           return DepartmentServices.getDepartments();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
    * @description 
    * @author Hitesh Khatri | 10-14-2021 
    * @param departmentId 
    * @return string 
    **/
    @AuraEnabled
    public static List<PhysianWrapper> getPhysians(String departmentId){
        
        try {
           return PhysianServices.getPhysians(departmentId);
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static String createAppointment(String jsonString){
        try {
            AppointmentServices appServices = new AppointmentServices();
            String result = appServices.createAppointment(jsonString);
            System.debug('Appointment Name : '+result);
            return result;
           
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
