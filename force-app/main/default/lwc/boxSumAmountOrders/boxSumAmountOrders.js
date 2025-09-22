import { LightningElement, api, wire } from 'lwc';
import getSumOrdersByAccount from '@salesforce/apex/OrdersController.getSumOrdersByAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class BoxSumAmountOrders extends LightningElement {

    sumOrdersAccount;
    isLoading = true;
    @api recordId;

    @wire(getSumOrdersByAccount, {accountId: '$recordId'})
    wiredSumOrdersByAccount({error,data}) {

    if (data) {

        this.sumOrdersAccount = data;

    } else if (error) {
        this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error while fetching Data',
                    message: error.body?.message || JSON.stringify(error),
                    variant: 'error'
                })
            );
    }
    this.isLoading = false;
    }
}