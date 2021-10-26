({
	onInit : function( component, event, helper ) {    
        
        let action = component.get( "c.callWebService" );  
        action.setParams({  
            appointmentId: 'a015j000003No7TAAS'
        });  
        action.setCallback(this, function(response) {  
            let state = response.getState();  
            if ( state === "SUCCESS" ) {  
                
                $A.get("e.force:closeQuickAction").fire();  
                $A.get('e.force:refreshView').fire();   
                
            }  else {
                
                let showToast = $A.get( "e.force:showToast" );
                showToast.setParams({
                    title : 'Testing Toast!!!',
                    message : 'Record Not Saved due to error.' ,
                    type : 'error',
                    mode : 'sticky',
                    message : 'Some error occured'
                });
                showToast.fire();
                
            }
        });  
        $A.enqueueAction( action );         
        
    }
})