/** 
 * @author Clem
 * @date 2025
 */
public with sharing class OrdersController {
    
    /** 
     * @name getSumOrdersByAccount
     * @description Appelle la méthode de la classe selector pour récupérer les data
     *              et les retourner au composant grâce à @AuraEnabled
     * @param Id du record 
     * @return Decimal somme des commandes sous status 'activé' liées à l'account Id
     */
    @AuraEnabled(cacheable=true)
    public static Decimal getSumOrdersByAccount(Id accountId) {
        
        AggregateResult groupedResults = MyTeamOrdersSelector.getSumOrdersByAccountSelector(accountId);
        return (Decimal) groupedResults.get('total'); 
    }
}