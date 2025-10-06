/** 
* @author Clem
* @date 2025
* @description Update des accounts => calcul du CA suite à import de masse de données (comme des orders déja validées par exemple)
*/

global with sharing class UpdateAccountsBatch implements Database.Batchable<sObject> {
    
    /**
     * Méthode start - Point d'entrée du batch
     * Prépare la requête SOQL pour récupérer les enregistrement Account
     * @param info, info du batch 
     * @return QueryLocator pour paginer les résultats
     */

     
    global Database.QueryLocator start(Database.BatchableContext info){ 
        String query = 'SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE StatusCode = \'Activated\')';
        System.debug('Accounts récupérés' + query);
        return Database.getQueryLocator(query);
        // 'SELECT Id, FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE StatusCode = Activated)'
    }
    /**
     * Méthode execute - Traite chaque lot d'enregistrements
     * Appelle une méthode pour mettre à jour le CA des accounts
     * @param info, info du batch
     * @param scope Liste des Account traités dans ce lot
     */

    global void execute(Database.BatchableContext info, List<Account> scope){
    
        List <Id> accountIds = new List <Id> ((new Map<Id,SObject>(scope)).keySet());
        Map<Id, Decimal> totalById = new Map<Id, Decimal>();
        List <AggregateResult> listGroupedResults = OrdersSelector.getSumOrdersByListAccountsSelector(accountIds);

        for (AggregateResult ar : listGroupedResults){
    
            Decimal total = (Decimal) ar.get('total'); 
            Id accId = (Id) ar.get('AccountId');
            totalById.put(accId, total);
            System.debug('Account Id : ' + accId + ' Total : ' + total);
        }

        List <Account> accToUpdate = new List <Account>();
 
        for (Account acc : scope) { 

            Decimal newTotal = totalById.get(acc.Id);
            if (acc.Chiffre_d_affaire__c != newTotal) {

            acc.Chiffre_d_affaire__c = newTotal;
            accToUpdate.add(acc);
            }
        }

        if (!accToUpdate.isEmpty()){

            update accToUpdate;
        }
    } 
    /**
     * Méthode finish - S'exécute après le traitement de tous les lots
     * Peut être utilisée pour envoyer une notification ou enregistrer un log
     * @param info, info du batch
     */
     
    global void finish(Database.BatchableContext info){     
        
    }     
    
}