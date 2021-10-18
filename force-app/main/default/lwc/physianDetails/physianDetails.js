import { LightningElement, api, track } from 'lwc';
import getPhysians from '@salesforce/apex/AvailableAppoinmentsController.getPhysians';

export default class PhysianDetails extends LightningElement {
    
    @track physianDetails;
    @api departmentId;
    @api mouseIsOver;
    selectedRowId;


    connectedCallback(){
        //this.onChangeDepartment();
    }

   @api onChangeDepartment(departmentId){
        if(departmentId){
            getPhysians({ departmentId : departmentId }).then(result => {
                this.physianDetails = result;
                this.physianDetails.forEach(element => {
                    element.selectedItem = false;
                });
            }).catch(error => {
                console.error('Error : ' + error);
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



}