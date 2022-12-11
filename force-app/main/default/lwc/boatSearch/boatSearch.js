import { LightningElement,api, wire, track } from 'lwc';
import searchBoat from '@salesforce/apex/BoatDataService.getBoats';
export default class BoatSearch extends LightningElement {
    @api isLoading = false;
    boatTypeId = '';
     returnedBoats = [];  
    connectedCallback()
    {
       // debugger;
        this.handleLoading();
    }
    renderedCallback(){
        //code
       // debugger;
       // this.handleDoneLoading();
    }

    // Handles loading event
    handleLoading() {
        this.isLoading = true;
     }
    
    // Handles done loading event
    handleDoneLoading() {
        this.isLoading = false;
     }
    
    // Handles search boat event
    // This custom event comes from the form
    
    @wire(searchBoat,{boatTypeId:'$boatTypeId'})
    getBoats({ error, data })
    {
        this.returnedBoats = data;
        //alert(this.boats);
        debugger;
    }    
    handleSearchBoats(event) {
        debugger;
       this.boatTypeId = event.detail.boatTypeId;
        this.getBoats();
     }

    
    createNewBoat() { }
  }