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
        Factory.FactoryData();
    }

    /** 
     * @name testPositiveSelector
     * @description Test positif de la classe OrdersSelector
     */
    @isTest
    static void testPositiveSelector() {
        
        Account acc = [SELECT Id FROM Account LIMIT 1];
        List<Order> orders = [SELECT Id, TotalAmount, AccountId, StatusCode, Status FROM Order];
        Id accountId = acc.Id;

        Test.startTest(); 

        for (Order o : orders) {
            o.StatusCode = 'Activated';
            o.Status = 'Livraison_creee';
        }
        update orders;

        AggregateResult grpResults = OrdersSelector.getSumOrdersByAccountSelector(accountId);

        Test.stopTest();

        Decimal sum = (Decimal) grpResults.get('total'); 
        System.assertEquals(300, sum);
    }
}