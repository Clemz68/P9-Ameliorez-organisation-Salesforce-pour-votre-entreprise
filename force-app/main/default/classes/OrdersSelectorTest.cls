/** 
 * @author Clem
 * @date 2025
 */
@isTest
private class OrdersSelectorTest {

    /** 
     * @name makeData
     * @description Annoté avec TestSetup pour génération de data en appelant la classe Factory
     */
    @TestSetup
    static void makeData() {
        Factory.FactoryDataUniqueAccount();
    }

    /** 
     * @name testPositiveSelector
     * @description Test positif de la classe OrdersSelector
     */
    @isTest
    static void testPositiveSelector() {
        
        Account acc = [SELECT Id FROM Account LIMIT 1];
        List<Order> orders = [SELECT Id, AccountId, StatusCode, Status FROM Order];
        Id accountId = acc.Id;
        List <Id> accountIds = new List <Id>();
        accountIds.add(accountId);

        Test.startTest(); 

        for (Order o : orders) {
            o.ShipmentCost__c = 0.5;
            o.Status = 'ActivatedP9';
        }
        update orders;

        AggregateResult grpResults = OrdersSelector.getSumOrdersByAccountSelector(accountId);
        List <AggregateResult> listGrpResult = OrdersSelector.getSumOrdersByListAccountsSelector(accountIds);

        Test.stopTest();

        Decimal sum = (Decimal) grpResults.get('total'); 
        Decimal sums = (Decimal) listGrpResult[0].get('total');
        System.assertEquals(150, sum);
        System.assertEquals(150, sums);
    }
}