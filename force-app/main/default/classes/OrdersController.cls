    /** 
     * @author Clem
     * @date 2025
     */

public with sharing class OrdersController {

    /** 
     * @name getSumOrdersByAccount
     * @description Appele la méthode de la classe sélector pour récupérer les data pour les retourner au composant grace à @auraEnabled
     * @param Id du record 
     * @return Decimal somme des commandes sous status 'activé' liées à l'account Id
    */

    @AuraEnabled (cacheable=true)
    public static Decimal getSumOrdersByAccount(Id accountId) {

       AggregateResult groupedResults =  MyTeamOrdersSelector.getSumOrdersByAccountSelector(accountId);
       return (Decimal)groupedResults.get('total'); 
    }
}