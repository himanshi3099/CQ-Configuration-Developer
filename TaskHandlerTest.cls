@isTest
private class TaskHandlerTest {

    static testMethod void testCompleteTaskAndUpdateAccount_AdminUser_PositiveScenario() {
        Test.startTest();
        // Create a test admin user
        Profile adminProfile = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
        User testAdminUser = new User(
            ProfileId = adminProfile.Id,
            Username = 'adminhimanshi@example.com',
            Email = 'admin@example.com',
            LastName = 'Test',
            FirstName = 'Admin',
            Alias = 'admin',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            TimeZoneSidKey = 'America/Los_Angeles'
        );
        insert testAdminUser;

        // Create a test account owned by the admin user
        Account acc = new Account(
            Name = 'Test Account',
            Active__c = false,
            OwnerId = testAdminUser.Id
        );
        insert acc;

        // Create a test task associated with the account
        Task oldTask = new Task(
            Subject = 'Review Account - ' + acc.AccountNumber,
            Status = 'Not Started',
            Description = 'Test Comments',
            WhatId = acc.Id
        );
        insert oldTask;

        // Change the status of the task to 'Completed'
        oldTask.Status = 'Completed';
        update oldTask;

        // Verify that the account is updated to active
        Account updatedAccount = [SELECT Id, Active__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(true, updatedAccount.Active__c);
        Test.stopTest();
    }

    static testMethod void testCompleteTaskAndUpdateAccount_StandardUser_PositiveScenario() {
        Test.startTest();
        // Create a test standard user
        Profile standardProfile = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        User testStandardUser = new User(
            ProfileId = standardProfile.Id,
            Username = 'standard1@example.com',
            Email = 'standard@example.com',
            LastName = 'Test',
            FirstName = 'Standard',
            Alias = 'standard',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            TimeZoneSidKey = 'America/Los_Angeles'
        );
        insert testStandardUser;

        // Create a test account owned by the standard user
        Account acc = new Account(
            Name = 'Test Account',
            Active__c = false,
            Description = 'Test Comments',
            OwnerId = testStandardUser.Id
        );
        insert acc;

        // Create a test task associated with the account
        Task oldTask = new Task(
            Subject = 'Review Account - ' + acc.AccountNumber,
            Status = 'Not Started',
            WhatId = acc.Id
        );
        insert oldTask;

        // Change the status of the task to 'Completed'
        oldTask.Status = 'Completed';
        update oldTask;

        // Verify that the account is updated to active
        Account updatedAccount = [SELECT Id, Active__c FROM Account WHERE Id = :acc.Id];
        System.assertEquals(true, updatedAccount.Active__c);
        Test.stopTest();
    }
}