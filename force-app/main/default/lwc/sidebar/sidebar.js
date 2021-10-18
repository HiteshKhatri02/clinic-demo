import { LightningElement, api } from 'lwc';
import {
    getSteps
}from "c/clinicConstants";


export default class Sidebar extends LightningElement {
    getSteps = getSteps();
    selectedItem = 'pateintInformation';
    disableSteps = {};

    onNavigationBarClicked(event){
        
        if (event && event.target) {
            let certificateEvent = new CustomEvent('navigationevent',{detail:event.target.dataset.navigatepage});
            this.dispatchEvent(certificateEvent);
        }
    }

    @api changeSelectedItemNavigation(value){
        this.selectedItem = value;
    }
}