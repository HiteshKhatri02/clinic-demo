/**
 * @description       : 
 * @author            : Hitesh Khatri
 * @group             : 
 * @last modified on  : 10-14-2021
 * @last modified by  : Hitesh Khatri
**/
public with sharing class DepartmentServices {

    /**
    * @description To get the all the departments available in the clinic
    * @author Hitesh Khatri | 10-14-2021 
    * @return Department__c 
    **/
    public static List<OptionsWrapper> getDepartments(){
        List<OptionsWrapper> depOptions = new List<OptionsWrapper>();
        List<Department__c> departments = [SELECT Id, Name FROM Department__c WHERE Clinic__c = '0015j000002z4trAAA' WITH SECURITY_ENFORCED LIMIT 100];
        for (Department__c dep : departments) {
            OptionsWrapper opt = new OptionsWrapper();
            opt.label = dep.Name;
            opt.value = dep.Id;
            depOptions.add(opt);
        }
        return  depOptions; 
    }
}
