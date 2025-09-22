@isTest
private class OrdersControllerTest {

     @TestSetup
    static void makeData(){
    
    Factory.FactoryData();

    }

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