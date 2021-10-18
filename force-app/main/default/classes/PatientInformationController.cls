/**
 * @description       : 
 * @author            : Hitesh Khatri
 * @group             : 
 * @last modified on  : 10-16-2021
 * @last modified by  : Hitesh Khatri
**/
public with sharing class PatientInformationController {

  /**
  * @description 
  * @author Hitesh Khatri | 10-16-2021 
  * @param jsonString 
  * @return string 
  **/
  @AuraEnabled
  public static PatientInformationWrapper savePatientInformation(String jsonString){
    
    
      try {
        PatientServices ps = new PatientServices();
        PatientInformationWrapper wrapper = ps.createPatientInformation(jsonString);
        return wrapper;
      } catch (Exception e) {
          throw new AuraHandledException(e.getMessage());
      }
  }
}
