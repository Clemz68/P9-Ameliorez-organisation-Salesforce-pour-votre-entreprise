/** 
 * @author Clem
 * @date 2025
 */

import { LightningElement, api, wire } from 'lwc';
import getSumOrdersByAccount from '@salesforce/apex/OrdersController.getSumOrdersByAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class BoxSumAmountOrders extends LightningElement {

    sumOrdersAccount;
    isLoading = true;
    @api recordId;

/**  
 * @description Décorateur @Wire de la méthode Apex pour récupérer les données de manière réactif (total amount des commandes actives pour l'Account).
 *             
 * @param {Function} getSumOrdersByAccount Méthode Apex utilisée comme adaptateur @wire.
 * @param {Object} config Objet de configuration contenant les paramètres passés à Apex.
 * @param {String} config.accountId Id de l’Account utilisé pour filtrer les données.
 *                                  Préfixé par '$' pour indiquer que la valeur est réactive.
 * @param {Object} result Objet contenant les données ou une erreur renvoyée par Apex.
 * @param {Array} result.data Somme du total amount des commandes (Oder) actives liées au compte
 * @param {Error} result.error Erreur en cas d'échec de récupération des données 
 */

    @wire(getSumOrdersByAccount, { accountId: '$recordId' })
    wiredSumOrdersByAccount({ error, data }) {
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