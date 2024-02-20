@isTest
private class AccountHandlerTest {

    static testMethod void testCreateTaskForAccount_AdminUser_PositiveScenario() {
        // Create a test admin user
        Profile adminProfile = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1];
        User testAdminUser = new User(
            ProfileId = adminProfile.Id,
            Username = 'adminhimi@example.com',
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

        System.runAs(testAdminUser) {
            // Create a new account
            Account acc = new Account(
                Name = 'Test Account',
                AccountNumber = 'TEST123',
                Active__c = false,
                OwnerId = testAdminUser.Id
            );
            insert acc;

            // Verify that a task is created for the inactive account
            List<Task> tasks = [SELECT Id FROM Task WHERE WhatId = :acc.Id];
            System.assertEquals(1, tasks.size());
        }
    }

    static testMethod void testCreateTaskForAccount_StandardUser_PositiveScenario() {
        // Create a test standard user
        Profile standardProfile = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1];
        User testStandardUser = new User(
            ProfileId = standardProfile.Id,
            Username = 'standardhimi@example.com',
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

        System.runAs(testStandardUser) {
            // Create a new account
            Account acc = new Account(
                Name = 'Test Account',
                AccountNumber = 'TEST123',
                Active__c = false,
                OwnerId = testStandardUser.Id
            );
            insert acc;

            // Verify that task is created for the inactive account
            List<Task> tasks = [SELECT Id FROM Task WHERE WhatId = :acc.Id];
            System.assertEquals(1, tasks.size());
        }
    }

    static testMethod void testCreateTaskForAccount_ActiveAccount_NoTaskCreated() {
        // Create a test admin user
        Profile adminProfile = [SELECT Id FROM Profile WHERE Name = 'Custom: Support Profile' LIMIT 1];
        User testAdminUser = new User(
            ProfileId = adminProfile.Id,
            Username = 'adminhimi1@example.com',
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

        System.runAs(testAdminUser) {
            // Create a new active account
            Account acc = new Account(
                Name = 'Test Account',
                AccountNumber = 'TEST123',
                Active__c = true,
                OwnerId = testAdminUser.Id
            );
            insert acc;

            // Verify that no task is created for the active account
            List<Task> tasks = [SELECT Id FROM Task WHERE WhatId = :acc.Id];
            System.assertEquals(0, tasks.size());
        }
    }
}