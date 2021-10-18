import { LightningElement, api,track } from 'lwc';

import savePatientInformation from '@salesforce/apex/PatientInformationController.savePatientInformation';
import {
    ShowToastEvent
} from 'lightning/platformShowToastEvent';

export default class PatientInformation extends LightningElement {
    @api patientInformation;
    @track patientRecordInfo;

    showSpinner = false;
    salutationsList = [
        { label: 'Mr.', value: 'Mr.' },
        { label: 'Ms.', value: 'Ms.' },
        { label: 'Mrs.', value: 'Mrs.' },
        { label: 'Dr.', value: 'Dr.' },
        { label: 'Prof.', value: 'Prof.' },
    ];

    connectedCallback(){
        this.patientRecordInfo = {...this.patientInformation};
    }

    onChangeHandler(event){
        console.log(event.currentTarget.dataset.id);
        switch (event.currentTarget.dataset.id) {
            case "pSalutation":
                this.patientRecordInfo.salutation = event.target.value;
                break;
                case "pfirstName":
                    this.patientRecordInfo.firstName = event.target.value;
                
                break;
                case "pLastName":
                    this.patientRecordInfo.lastName = event.target.value;
                
                break;
                case "pDOB":
                    this.patientRecordInfo.dob = event.target.value;
                
                break;
                case "pEmail":
                    this.patientRecordInfo.email = event.target.value;
                break;
                case "pPhone":
                    this.patientRecordInfo.phone = event.target.value;
                
                break;
                case "pStreetAddress":
                    this.patientRecordInfo.mailingStreet = event.target.value;
                
                break;
                
                case "pMailingCity":
                    this.patientRecordInfo.mailingCity = event.target.value;
                
                    break;
                case "pMailingState":
                    this.patientRecordInfo.mailingState = event.target.value;
            
                break;
                case "mailingCountry":
                    this.patientRecordInfo.mailingCountry = event.target.value;
        
                break;
                case "pMailingZipCode":
                    this.patientRecordInfo.mailingZipCode = event.target.value;
                break;
            default:
                break;
        }
    }

    handleNext(){
        if(this.validateInput()){
            this.showSpinner = true;
            savePatientInformation({
                jsonString: JSON.stringify(this.patientRecordInfo)
            }).then(result => {
                this.showSpinner = false;
                if(result){
                    this.dispatchEvent(new CustomEvent('patientinfosaved',{detail:result.recordId}));
                }
                
            }).catch(error => {
                this.showSpinner = false;
                this.showAsyncErrorMessage(this, error);
            });
        }
       
    }


    validateInput() {
        let isAllValid = [...this.template.querySelectorAll('lightning-input')]
            .reduce((validSoFar, inputCmp) => {
                inputCmp.reportValidity();
                return validSoFar && inputCmp.checkValidity();
            }, true);

        return isAllValid;
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