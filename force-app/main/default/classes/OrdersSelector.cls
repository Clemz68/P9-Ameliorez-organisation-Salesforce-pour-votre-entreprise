public with sharing class OrdersSelector {

    /** 
   * @name getSumOrdersByAccountSelector
   * @description Requête SOQL pour récupérer les data (somme des orders avec status activé)
                  Méthode utilisée par la classe controller pour le composant LWC
   * @param Id du record 
   * @return AggregateResult (roll up/summary) somme des commandes sous status 'activé' liées à l'account Id
   */
   public static AggregateResult getSumOrdersByAccountSelector(Id accountId) {
  
   AggregateResult groupedResults = [
      SELECT SUM(NetAmount__c) total 
      FROM Order 
      WHERE Status = 'ActivatedP9' 
        AND accountId = :accountId
   ];
  return groupedResults;
  }

  /**
   * @name getSumOrdersByListAccountsSelector
   * @description Requête SOQL pour récupérer les data (somme des orders groupé par account)
                  Methode utilisée par la classe batch
   * @param Liste account Id
   * @return Liste AggregateResult (roll up/summary) somme des commandes sous status 'livraison_creee' groupés par account Id
   */
  public static List<AggregateResult> getSumOrdersByListAccountsSelector(List<Id> accountIds) {
      
      List<AggregateResult> listGroupedResults = [
          SELECT AccountId, SUM(NetAmount__c) total 
          FROM Order 
          WHERE Status = 'ActivatedP9' 
            AND AccountId IN :accountIds
          GROUP BY AccountId
      ];
      return listGroupedResults;
  }
}