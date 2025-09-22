public with sharing class OrderTriggerHandler {
    
    public void afterTriggerUpdateCA (List<Order> triggerNew, Map<Id, Order> triggerOldMap){

         Map<Id, Decimal> totalByAccount = new Map<Id, Decimal>();

        for (Order newOrd : triggerNew) {
        Order oldOrd = triggerOldMap.get(newOrd.Id);

        if (newOrd.StatusCode == 'Activated' && oldOrd.StatusCode != 'Activated' ) {
            
            Decimal total = (newOrd.TotalAmount != null ? newOrd.TotalAmount : 0);

            if (totalByAccount.containsKey(newOrd.AccountId)) {

                totalByAccount.put(newOrd.AccountId, totalByAccount.get(newOrd.AccountId) + total);

            } else {

            totalByAccount.put(newOrd.AccountId, total);
            
            }
        }
    }

    if (totalByAccount.isEmpty()) return;

    List<Account> accsToUpdate = [ SELECT Id, Chiffre_d_affaire__c FROM Account WHERE Id IN :totalByAccount.keySet()
    ];

    for (Account acc : accsToUpdate) {
        acc.Chiffre_d_affaire__c = (acc.Chiffre_d_affaire__c != null ? acc.Chiffre_d_affaire__c : 0) +
                                   totalByAccount.get(acc.Id);
    }

    update accsToUpdate;
}


     public void beforeTriggerUpdateNetAmount (List<Order> triggerNew, Map<Id, Order> triggerOldMap){


    List <Order> ordTriggerUpdate = new List <Order>();

	for (Order newOrd : triggerNew) {
        Order oldOrd = triggerOldMap.get(newOrd.Id);

 	 if (newOrd.ShipmentCost__c != null && newOrd.TotalAmount != oldOrd.TotalAmount ||
	  newOrd.ShipmentCost__c != null && newOrd.ShipmentCost__c != oldOrd.ShipmentCost__c) {
           
		ordTriggerUpdate.add(newOrd);

        }
	}

	for (Order ord : ordTriggerUpdate) {

		ord.NetAmount__c = ord.TotalAmount - ord.ShipmentCost__c;
	}
}
}