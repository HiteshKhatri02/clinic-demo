import { LightningElement, api, track } from 'lwc';
import getAvailableDepartments from '@salesforce/apex/AvailableAppoinmentsController.getAvailableDepartments';
import createAppointment from '@salesforce/apex/AvailableAppoinmentsController.createAppointment';



export default class AvailableAppointments extends LightningElement {
    appointmentDetails;
    @api patientId;
    @track departments;
    @track physians;
    @api appointmentDetail;
    departmentId;
    showSpinner = false;

    connectedCallback(){
        this.appointmentDetails = {...this.appointmentDetail}
      

        getAvailableDepartments().then(result => {
            this.departments = result;
        }).catch(error => {
            console.error('Error : ' + error);
        });
    }

    onDepartmentValueChange(event){
        this.departmentId = event.target.value;
        let physianDetails = this.template.querySelector('c-physian-details');
        if(physianDetails) { physianDetails.onChangeDepartment(this.departmentId); }
    }


    handlePhysisanSelected(event){
        let rowId = event.detail;
        this.appointmentDetails.physianId = rowId;
    }

    handleNext(){
        this.showSpinner = true;
        //save conta
        createAppointment({jsonString:JSON.stringify(this.appointmentDetails)}).then(result => {
            this.showSpinner = false;
            if(result){
                
                this.departments = result;
                this.dispatchEvent(new CustomEvent('appointmentcreated',{detail:result}));
            }
        }).catch(error => {
            this.showSpinner = false;
       
            console.error('Error : ' + error);
        });
    }
}