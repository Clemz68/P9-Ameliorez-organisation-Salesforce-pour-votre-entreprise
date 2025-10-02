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
    static void makeData(){
    
    Factory.FactoryData();

    }

     /** 
     * @name testPositiveController
     * @description Test positif de la classe OrderController
    */

    @isTest
    static void testPositiveController() {
        
        Account acc = [SELECT Id FROM Account LIMIT 1];
        List <Order> orders = [SELECT Id, TotalAmount, AccountId, StatusCode, Status FROM Order];
        Id AccountId = acc.id;

        Test.startTest(); 

            for (Order o: orders){
                o.StatusCode = 'Activated';
                o.Status = 'Livraison_creee';
            }

            update orders;
            Decimal totalToTest = OrdersController.getSumOrdersByAccount(accountId);

        Test.stopTest();
        System.assertEquals(300, totalToTest);
        
    }
}