@isTest
private class OrdersSelectorTest {

     @TestSetup
    static void makeData(){
    
    Factory.FactoryData();

    }

    @isTest
    static void testPositiveSelector() {
        
        Account acc = [SELECT Id FROM Account LIMIT 1];
        List <Order> orders = [SELECT Id, TotalAmount, AccountId, StatusCode, Status FROM Order];
        Id AccountId = acc.id;

        Test.startTest(); 

            for (Order o: orders){
                o.StatusCode = 'Activated';
                o.Status = 'Livraison_creee';
            }
            update orders;
            AggregateResult grpResults = OrdersSelector.getSumOrdersByAccountSelector(accountId);

        Test.stopTest();

        Decimal sum = (Decimal)grpResults.get('total'); 
        System.assertEquals (300, sum);

    }
}