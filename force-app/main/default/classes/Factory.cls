/** 
 * @author Clem
 * @date 2025 
 */
public with sharing class Factory {
    
    /** 
     * @name FactoryData
     * @description Classe pour générer les data de l'environnement de test 
     * Objets insérés: Account, Opportunity, Product2, PricebookEntry, Order, OrderItems
     * test
     */
    public static void FactoryDataUniqueAccount() {
        
        Account acc = new Account();
        acc.Name = 'Test Controller Selector';
        acc.Phone = '01020302';
        acc.Chiffre_d_affaire__c = 0;
        acc.CurrencyIsoCode = 'EUR';
        acc.Industry = 'Agriculture';
        insert acc;

        Opportunity opp = new Opportunity();
        opp.Name = 'Factory OppA';
        opp.StageName = 'Prospecting';
        opp.CloseDate = System.today().addDays(30);
        opp.AccountId = acc.Id;
        insert opp;
        
        Id standardPricebookId = Test.getStandardPricebookId();
        
        Product2 testProduct = new Product2(
            Name = 'Test Product for Factory',
            IsActive = true
        );
        insert testProduct;
        
        PricebookEntry testPricebookEntry = new PricebookEntry(
            Pricebook2Id = standardPricebookId,
            Product2Id = testProduct.Id,
            UnitPrice = 100,
            IsActive = true
        );
        insert testPricebookEntry;
        
        List<Order> orders = new List<Order>();
        for (Integer i = 0; i < 300; i++) {
            Order ord = new Order();
            ord.AccountId = acc.Id;
            ord.OpportunityId = opp.Id;
            ord.Client_Type__c = 'Particulier';
            ord.Status = 'Draft';
            ord.EffectiveDate = System.today();
            ord.Pricebook2Id = standardPricebookId;
            ord.CurrencyIsoCode = 'EUR';
            orders.add(ord);
        }
        insert orders;
        
        List<OrderItem> orderItems = new List<OrderItem>();
        for (Order o : orders) {
            OrderItem testOrdIt = new OrderItem();
            testOrdIt.UnitPrice = 1;
            testOrdIt.Quantity = 1;
            testOrdIt.Product2Id = testProduct.Id;
            testOrdIt.PricebookEntryId = testPricebookEntry.Id;
            testOrdIt.OrderId = o.Id;
            orderItems.add(testOrdIt);
        }
        insert orderItems;
    }
    
    //Créer 10 comptes, 10 opp, 30 order, et 30 order items 
    public static void FactoryDataMultipleAccounts() {

        Integer numberOfAccounts = 10;
        Integer numberOfOrders = 3;

        List <Account> accs = new List <Account>();
        for (Integer i = 0; i < numberOfAccounts; i++) {
            Account acc = new Account();
        acc.Name = 'Test Controller Selector' + i;
        acc.Phone = '01020302';
        acc.Chiffre_d_affaire__c = 0;
        acc.CurrencyIsoCode = 'EUR';
        acc.Industry = 'Agriculture';
        accs.add(acc);
        }
        insert accs;
        

        List <Opportunity> opps = new List <Opportunity>();
        for (Account acc: accs) {
        Opportunity opp = new Opportunity();
        opp.Name = 'Factory Opp';
        opp.StageName = 'Prospecting';
        opp.CloseDate = System.today().addDays(30);
        opp.AccountId = acc.Id;
        opps.add(opp);
        }
        insert opps;
        
        Id standardPricebookId = Test.getStandardPricebookId();
        
        Product2 testProduct = new Product2(
            Name = 'Test Product for Factory',
            IsActive = true
        );
        insert testProduct;
        
        PricebookEntry testPricebookEntry = new PricebookEntry(
            Pricebook2Id = standardPricebookId,
            Product2Id = testProduct.Id,
            UnitPrice = 100,
            IsActive = true
        );
        insert testPricebookEntry;

        List<Order> orders = new List<Order>();
        for (Opportunity opp: opps) {
            for (Integer i = 0; i < numberOfOrders; i++) {
                Order ord = new Order();
                ord.AccountId = opp.AccountId;
                ord.OpportunityId = opp.Id;
                ord.Client_Type__c = 'Particulier';
                ord.NetAmount__c = 0;
                ord.Status = 'Draft';
                ord.EffectiveDate = System.today();
                ord.Pricebook2Id = standardPricebookId;
                ord.CurrencyIsoCode = 'EUR';
                orders.add(ord);
            }
        }
        insert orders;
        
        List<OrderItem> orderItems = new List<OrderItem>();
        for (Order o : orders) {
            OrderItem testOrdIt = new OrderItem();
            testOrdIt.UnitPrice = 1;
            testOrdIt.Quantity = 1;
            testOrdIt.Product2Id = testProduct.Id;
            testOrdIt.PricebookEntryId = testPricebookEntry.Id;
            testOrdIt.OrderId = o.Id;
            orderItems.add(testOrdIt);
        }
        insert orderItems;
        } 

}