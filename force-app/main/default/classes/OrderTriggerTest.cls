/** 
     * @author Clem
     * @date 2025
     */

@isTest
private class OrderTriggerTest{
//testing
    @TestSetup
    static void makeData(){
    
    Factory.FactoryData();

    }

    @IsTest
    static void TestPositiveAfterTrigger(){

    List <Order> orders = [SELECT Id, TotalAmount, AccountId, StatusCode, Status FROM Order];

        Test.startTest();

            for (Order o: orders){
                o.StatusCode = 'Activated';
                o.Status = 'Livraison_creee';
            }
            update orders;

        Test.stopTest();

        Account acc = [ SELECT Id, Chiffre_d_affaire__c  FROM Account LIMIT 1];
        System.assertEquals(310, acc.Chiffre_d_affaire__c, 'TestPositiveTrigger is failed');
    }

    @IsTest
    static void TestPositiveBeforeTrigger() {

        Test.startTest();
        
        List <Order> ordsUpdate = new List <Order> ();
        List <Order> ords = [SELECT Id, TotalAmount, NetAmount__c, ShipmentCost__c, AccountId FROM Order];

        for (Order o: ords){
            o.shipmentCost__c = 0.5;
            ordsUpdate.add(o);
        }

        update ordsUpdate;

        Test.stopTest();
        // relire après le commit de ma transaction test
        List<Order> ordsAfter = [ SELECT NetAmount__c FROM Order];

        System.assertEquals(0.5, ordsAfter[1].NetAmount__c);
        System.assertEquals(0.5, ordsAfter[15].NetAmount__c);
        System.assertEquals(0.5, ordsAfter[155].NetAmount__c);
        System.assertEquals(0.5, ordsAfter[299].NetAmount__c);
    }
}
