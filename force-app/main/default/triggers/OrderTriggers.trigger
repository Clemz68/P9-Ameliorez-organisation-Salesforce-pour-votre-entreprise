trigger OrderTriggers on Order (before update, after update) {

    OrderTriggerHandler orderHandler = new OrderTriggerHandler();

    if(Trigger.isBefore) {
        orderHandler.beforeTriggerUpdateNetAmount (Trigger.new, Trigger.oldMap);
    }
    else {
        orderHandler.afterTriggerUpdateCA (Trigger.new, Trigger.oldMap);
    }
}

