/** 
* @author Clem
* @date 2025
*/

@isTest
public with sharing class UpdateAccountsBatchTest {

    /** 
     * @name makeData
     * @description Annoté avec TestSetup pour génération de data en appelant la classe Factory
     */

    @TestSetup
    static void makeData() {
        
    Factory.FactoryDataMultipleAccounts();

    }


    /** 
     * @name testPositiveUpdateAccountBatch
     * @description Test des data insérés par makeData en exécutant le batch à tester 
     * @return void  
     */

    @IsTest
    static void testPositiveUpdateAccountsBatch () {

        List<Order> orders = [SELECT Id, TotalAmount, AccountId, StatusCode, Status FROM Order];
        List<OrderItem> orderItems = [SELECT Id, UnitPrice FROM OrderItem];

        for (Order o : orders) {
            o.ShipmentCost__c = 5;
            o.Status = 'ActivatedP9';
        }
        update orders;

        Test.startTest(); 

        for (OrderItem o : orderItems) {
            o.UnitPrice = 10;
        }
        update orderItems;

        orders = [SELECT Id, TotalAmount FROM Order WHERE Id IN :orders];
        
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