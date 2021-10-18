/**
 * @description       : 
 * @author            : Hitesh Khatri
 * @group             : 
 * @last modified on  : 10-16-2021
 * @last modified by  : Hitesh Khatri
**/
public with sharing class CRUD_SecurityChecks {
   
    public static Boolean crudCheck(String sObjectName,String permissionToCheck){
        Boolean securityPass = true;
        permissionToCheck = permissionToCheck.toLowerCase();
        Schema.DescribesObjectResult sObjectDescribeResult;
        
        try{
            sObjectDescribeResult = Schema.getGlobalDescribe().get(sObjectName).getDescribe();
        }catch(Exception e){
            throw new CustomSecurityException('');
        }
        
        switch on permissionToCheck {
            when 'query'{
                if (!sObjectDescribeResult.isAccessible()){
                    securityPass = false;
                }
            }
            when 'insert'{
                if (!sObjectDescribeResult.isCreateable()){
                    securityPass = false;
                }
            }
            when 'update'{
                if (!sObjectDescribeResult.isUpdateable()){
                    securityPass = false;
                }
            }
            when 'upsert'{
                if ((!sObjectDescribeResult.isUpdateable()) || (!sObjectDescribeResult.isCreateable())){
                    securityPass = false;
                }
            } 
            when 'delete'{
                if (!sObjectDescribeResult.isDeletable()){
                    securityPass = false;
                }
            }
            when else{
                throw new CustomSecurityException('Unsupported permission type : '+permissionToCheck);
            }
        }
        
        return securityPass;
    }

    public static SObjectAccessDecision getAccessibleData(String sObjectName, List<sObject> sObjList, String dmlAction){
        dmlAction = dmlAction.toLowerCase();
        SObjectAccessDecision securityDecision;
        
        if(!crudCheck(sObjectName,dmlAction)){
            throw new CustomSecurityException('Access Denied');
        }
        
        switch on dmlAction {
            when 'query'{
                securityDecision = Security.stripInaccessible(
                    AccessType.READABLE, sObjList);
            }
            when 'insert'{
                securityDecision = Security.stripInaccessible(
                    AccessType.CREATABLE, sObjList);
            }
            when 'update'{
                securityDecision = Security.stripInaccessible(
                    AccessType.UPDATABLE, sObjList);
            }
            when 'upsert'{
                securityDecision = Security.stripInaccessible(
                    AccessType.UPSERTABLE, sObjList);
            }           
        }
       return securityDecision;
    }
}
