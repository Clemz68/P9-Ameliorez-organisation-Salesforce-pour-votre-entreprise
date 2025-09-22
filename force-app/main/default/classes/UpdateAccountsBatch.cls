global with sharing class UpdateAccountsBatch implements Database.Batchable<sObject>, Schedulable{
    
 /**
     * Méthode start - Point d'entrée du batch
     * Prépare la requête SOQL pour récupérer les enregistrement Account
     * @param info, info du batch 
     * @return QueryLocator pour paginer les résultats
     */

     
    global Database.QueryLocator start(Database.BatchableContext info){ 
        String query = 'SELECT Id, FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE StatusCode = Activated)';
        return Database.getQueryLocator(query);
 
    }

/**
     * Méthode execute - Traite chaque lot d'enregistrements
     * Appelle une méthode pour mettre à jour le CA des accounts
     * @param info, info du batch
     * @param scope Liste des Account traités dans ce lot
     */

    global void execute(Database.BatchableContext info, List<Account> scope){
        Set<Id> setAccountIds = (new Map<Id,SObject>(scope)).keySet();
       

/**
     * Méthode finish - S'exécute après le traitement de tous les lots
     * Peut être utilisée pour envoyer une notification ou enregistrer un log
     * @param info, info du batch
     */
   
    }    
     
    global void finish(Database.BatchableContext info){     
        
    }     
    
/**
     * Méthode execute du Scheduler - Lance l'exécution du batch via un scheduler
     * Elle instancie la classe batch et exécute le batch avec une taille de lot de 200
     * @param sc Contexte du scheduler
     */
    public void execute(SchedulableContext sc) {
        CheckDateTripBatchatableSchedule batch = new CheckDateTripBatchatableSchedule();
        Database.executeBatch(batch, 200);
    }
 }