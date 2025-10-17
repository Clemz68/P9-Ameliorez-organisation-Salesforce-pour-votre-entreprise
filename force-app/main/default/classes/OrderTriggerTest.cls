/** 
* @author Clem
* @date 2025
*/

@isTest
private class OrderTriggerTest {

    /** 
    * @name makeData
    * @description Annoté avec TestSetup pour génération de data en appelant la classe Factory
    */

    @TestSetup
    static void makeData() {

        Factory.FactoryDataUniqueAccount();

    }

    /** 
    * @name TestPositiveAfterTrigger
    * @description Test positif de la classe OrderTriggerHandler
    */

    @IsTest
    static void TestPositiveAfterTrigger() {

        List<Order> orders = [SELECT Id, TotalAmount, AccountId, Status FROM Order];

        Test.startTest();

        for (Order o : orders) {
            o.ShipmentCost__c = 0.5;
            o.Status = 'ActivatedP9';
        }
        update orders;

        Test.stopTest();

        Account acc = [SELECT Id, Chiffre_d_affaire__c FROM Account LIMIT 1];
        System.assertEquals(150, acc.Chiffre_d_affaire__c, 'TestPositiveTrigger is failed');
    }

    /** 
    * @name TestPositiveBeforeTrigger
    * @description Test positif de la classe OrderTriggerHandler
    */

    @IsTest
    static void TestPositiveBeforeTrigger() {

        Test.startTest();

        List<Order> ordsUpdate = new List<Order>();
        List<Order> ords = [SELECT Id, TotalAmount, NetAmount__c, ShipmentCost__c, AccountId FROM Order];

        for (Order o : ords) {
            o.ShipmentCost__c = 0.5;
            ordsUpdate.add(o);
        }

        update ordsUpdate;

        Test.stopTest();

        List<Order> ordsAfter = [SELECT NetAmount__c FROM Order];

        System.assertEquals(0.5, ordsAfter[1].NetAmount__c);
        System.assertEquals(0.5, ordsAfter[15].NetAmount__c);
        System.assertEquals(0.5, ordsAfter[155].NetAmount__c);
        System.assertEquals(0.5, ordsAfter[299].NetAmount__c);
    }
}
