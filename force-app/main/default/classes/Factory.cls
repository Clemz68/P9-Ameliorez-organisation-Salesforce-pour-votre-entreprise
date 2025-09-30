public with sharing class Factory {
// It worked?? TestCommit 1234545fef timz to shineeeeezzzeeee
    public static void FactoryData() {

        Account acc = new Account();
        acc.Name = 'Factory Account 1';
        acc.Phone = '01020302';
        acc.Chiffre_d_affaire__c = 10;
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
        
        Product2 testProduct = new Product2(Name = 'Test Product for Factory', IsActive = true);
        insert testProduct;

        PricebookEntry testPricebookEntry = new PricebookEntry(
            Pricebook2Id = standardPricebookId,
            Product2Id = testProduct.Id,
            UnitPrice = 100,
            IsActive = true
        );
        insert testPricebookEntry;

        List <Order> orders = new List <Order>();
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

        List <OrderItem> orderItems = new List <OrderItem>();
        for (Order o: orders){
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
