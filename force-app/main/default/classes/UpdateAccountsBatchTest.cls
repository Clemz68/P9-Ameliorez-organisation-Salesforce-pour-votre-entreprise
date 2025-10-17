/** 
* @author Clem
* @date 2025
*/

@isTest
public with sharing class UpdateAccountsBatchTest {

    @TestSetup
    static void makeData() {
        
    Factory.FactoryDataMultipleAccounts();

    }

    @IsTest
    static void testPositiveUpdateAccountsBatch () {

        List<Order> orders = [SELECT Id, TotalAmount, AccountId, StatusCode, Status FROM Order];
        List<OrderItem> orderItems = [SELECT Id, UnitPrice FROM OrderItem];

        // activation des orders, le trigger order est déclenché CA de l'account = 3
        for (Order o : orders) {
            o.ShipmentCost__c = 5;
            o.Status = 'ActivatedP9';
        }
        update orders;

        Test.startTest(); 
            
        // mise à jour du prix, trigger non déclenché, le CA reste le même
        // mise à jour des accounts alors nécessaire pour avoir 30 en CA
        for (OrderItem o : orderItems) {
            o.UnitPrice = 10;
        }
        update orderItems;

        orders = [SELECT Id, TotalAmount FROM Order WHERE Id IN :orders];
        System.debug('After update: ' + orders[0].TotalAmount);

        UpdateAccountsBatch uab = new UpdateAccountsBatch();
        Id batchId = Database.executeBatch(uab);
                
        Test.stopTest();
            
        List <Account> accs = [SELECT Id, Chiffre_d_affaire__c FROM Account];
        
        System.assertEquals(15, accs[0].Chiffre_d_affaire__c);
        System.assertEquals(15, accs[2].Chiffre_d_affaire__c);
        System.assertEquals(15, accs[5].Chiffre_d_affaire__c);
        System.assertEquals(15, accs[7].Chiffre_d_affaire__c);
        
    }
}