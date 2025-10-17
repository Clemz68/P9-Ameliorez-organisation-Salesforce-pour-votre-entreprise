/** 
 * @author Clem
 * @date 2025
 */
@isTest
private class OrdersControllerTest {
    
    /** 
     * @name makeData
     * @description Annoté avec TestSetup pour génération de data en appelant la classe Factory
     */
    @TestSetup
    static void makeData() {
        Factory.FactoryDataUniqueAccount();
    }
    
    /** 
     * @name testPositiveController
     * @description Test positif de la classe OrdersController
     */
    @isTest
    static void testPositiveController() {
        
        Account acc = [SELECT Id FROM Account LIMIT 1];
        List<Order> orders = [SELECT Id, AccountId, StatusCode, Status FROM Order];
        Id accountId = acc.Id;
        
        Test.startTest(); 
        
        for (Order o : orders) {
            o.ShipmentCost__c = 0.5;
            o.Status = 'ActivatedP9';
        }
        
        update orders;
        Decimal totalToTest = OrdersController.getSumOrdersByAccount(accountId);
        
        Test.stopTest();
        
        System.assertEquals(150, totalToTest);
    }
}