public class TaskHandler {
  public static void completeTaskAndUpdateAccount(List<Task> completedTasksList, Map<Id,Task> oldTasksMap) {
    List<Account> accountsToUpdate = new List<Account>();

    for (Task tsk : completedTasksList) {
        if (oldTasksMap.get(tsk.Id).Status != tsk.Status && tsk.Status == 'Completed') {
            
            Account acc = new Account(Id = tsk.WhatId, Active__c = true, Description = tsk.Description);
            accountsToUpdate.add(acc);
        }
    }

    if (!accountsToUpdate.isEmpty()) {
        update accountsToUpdate;
    }
}
}