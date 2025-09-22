public with sharing class OrdersController {
    
    @AuraEnabled (cacheable=true)
    public static Decimal getSumOrdersByAccount(Id accountId) {

       AggregateResult groupedResults =  MyTeamOrdersSelector.getSumOrdersByAccountSelector(accountId);
       return (Decimal)groupedResults.get('total'); 
    }
}