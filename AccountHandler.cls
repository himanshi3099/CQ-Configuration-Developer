public class AccountHandler {
    public static void createTaskForAccount(Map<Id, Account> newAccounts) {
        List<Task> tasksToInsert = new List<Task>();
        
        for (Account acc : newAccounts.values()) {
            if (!acc.Active__c) {
                tasksToInsert.add(new Task(
                    Subject = 'Review Account - ' + acc.AccountNumber,
                    ActivityDate = Date.today().addDays(7),
                    OwnerId = acc.OwnerId,
                    Status = 'Not Started',
                    WhatId = acc.Id
                ));
            }
        }
        
        if (!tasksToInsert.isEmpty()) {
            insert tasksToInsert;
        }
    }

 

}