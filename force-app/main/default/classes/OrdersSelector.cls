public with sharing class OrdersSelector {

    public static AggregateResult getSumOrdersByAccountSelector(Id accountId) {

        AggregateResult groupedResults = [SELECT SUM(TotalAmount) total FROM Order WHERE Status = 'livraison_creee' AND accountId = :AccountId];
        return groupedResults;
        
    }
}