import { LightningElement, track } from 'lwc';
import {
    getSteps
}from "c/clinicConstants";

export default class BookAppointment extends LightningElement {
    bookAppointment= {
        patientInformation : {
            firstName : '',
            lastName : '',
            salutation : '',
            email : '',
            phone:'',
            mailingStreet : '',
            mailingCity : '',
            mailingState : '',
            mailingCountry : '',
            mailingZipCode : '',
            dob : null,
        },
        appointmentDetails : {
            physianId : '',
            patientId:''
        },
    }

    appointmentNumber;

  
    @track navigationsTabs = {
        isVisiblePateintInformation :  true,
        isVisibleAppointmentBooking : false,
        isVisibleConfirmation : false
    }

    steps = getSteps();

    handleNavigationEvent(event){
        this.handleChangeActiveStep(event.detail);
    }

    handleChangeActiveStep(activeStepName){
        switch (activeStepName) {
            case this.steps.patientInformation:
                this.resetNavigations();
                this.navigationsTabs.isVisiblePateintInformation = true;
                this.changeActiveNavigationItem(this.steps.patientInformation);
                
            case this.steps.bookAppointment:
                this.resetNavigations();
                this.navigationsTabs.isVisibleAppointmentBooking = true;
                this.changeActiveNavigationItem(this.steps.bookAppointment);
            break;
            case this.steps.confirmation:
                this.resetNavigations();
                this.navigationsTabs.isVisibleConfirmation = true;
                this.changeActiveNavigationItem(this.steps.confirmation);
            break;
        }
    }

    resetNavigations(){
        this.navigationsTabs.isVisiblePateintInformation = false;
        this.navigationsTabs.isVisibleAppointmentBooking = false;
        this.navigationsTabs.isVisibleConfirmation = false;
    }

    handlePatientSavedEvent(event){
        this.bookAppointment.appointmentDetails.patientId = event.detail;
        this.handleChangeActiveStep(this.steps.bookAppointment);
    }

    changeActiveNavigationItem(stepName){
        let sidebar = this.template.querySelector('c-sidebar');
        if(sidebar) { sidebar.changeSelectedItemNavigation(stepName); }
    }

    handleAppointmentCreation(event){
        this.appointmentNumber = event.detail;
        this.handleChangeActiveStep(this.steps.confirmation);
    }
}