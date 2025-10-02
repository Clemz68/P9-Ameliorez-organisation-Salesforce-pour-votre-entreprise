/** 
 * @author Clem
 * @date 2025
 * testcom 
 */
public with sharing class OrdersSelector {
    
    /** 
     * @name getSumOrdersByAccountSelector
     * @description Requête SOQL pour récupérer les data (somme des orders avec status activé)
     * @param Id du record 
     * @return AggregateResult (roll up/summary) somme des commandes sous status 'activé' liées à l'account Id
     */
    public static AggregateResult getSumOrdersByAccountSelector(Id accountId) {
        
        AggregateResult groupedResults = [
            SELECT SUM(TotalAmount) total 
            FROM Order 
            WHERE Status = 'livraison_creee' 
              AND accountId = :accountId
        ];
        
        return groupedResults;
    }
}