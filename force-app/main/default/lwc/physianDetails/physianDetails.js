import { LightningElement, api, track } from 'lwc';
import getPhysians from '@salesforce/apex/AvailableAppoinmentsController.getPhysians';
import {
    ShowToastEvent
} from 'lightning/platformShowToastEvent';

export default class PhysianDetails extends LightningElement {
    
    @track physianDetails;
    @api departmentId;
    @api mouseIsOver;
    selectedRowId;
    showSpinner = false;


    connectedCallback(){
        //this.onChangeDepartment();
    }

   @api onChangeDepartment(departmentId){
        if(departmentId){
            this.showSpinner = true;
            getPhysians({ departmentId : departmentId }).then(result => {
                this.showSpinner = false;
                if(result.length > 0){
                    this.physianDetails = result;
                    this.physianDetails.forEach(element => {
                        element.selectedItem = false;
                    });
                }
                
            }).catch(error => {
                this.showSpinner = false;
                this.showAsyncErrorMessage(error);
               
            });
        }
   }

   handleRowItemClick(event){
       try{

        let rowId = event.currentTarget.dataset.id;
        this.physianDetails.forEach(element => {
            if(element.id === rowId){
                console.log('Reached in 1st');
                    element.selectedItem = true;
            }else{
                console.log('Reached in 2nd');
                    element.selectedItem = false;
            }
            });

        this.dispatchEvent(new CustomEvent('physianselected',{detail:rowId}));

       }catch(err){
        console.log(JSON.stringify(err));
       }
       
   }

   showAsyncErrorMessage(component, err) {
    let message = (err) ? ((err.message) ? err.message : ((err.body) ? ((err.body.message) ? err.body.message : JSON.stringify(err)) : JSON.stringify(err))) : "Something went wrong!";
   
    component.dispatchEvent(new ShowToastEvent({
        mode : 'pester',
        title: 'Error',
        message: message,
        variant: 'error',
    }));
   
}


}