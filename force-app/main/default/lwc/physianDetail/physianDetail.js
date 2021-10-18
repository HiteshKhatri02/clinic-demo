import { LightningElement, api } from 'lwc';

export default class PhysianDetail extends LightningElement {
    
    loadComponent = false;

    @api detailOfPhysisan;
    physianDetail;


    connectedCallback(){
        
        if(this.detailOfPhysisan){
            this.physianDetail =  {...this.detailOfPhysisan};
            this.physianDetail.availablDaysArray =  this.physianDetail.availability.split(";");
            this.loadComponent = true;
        }
    }

    get listItemClass(){
        let cls = "slds-border_top slds-border_bottom";
        if (this.mouseIsOver) {
            cls += ' c-mouseover-border'
        }
    }
}