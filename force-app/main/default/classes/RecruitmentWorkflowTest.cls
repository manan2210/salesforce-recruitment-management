@IsTest
private class RecruitmentWorkflowTest {
    @TestSetup
    static void seedRecords() {
        insert new Candidate__c(
            Name = 'Avery Demo',
            Email__c = 'avery@example.test',
            Source__c = 'Referral'
        );
        insert new Job_Opening__c(
            Name = 'Business Analyst Internship',
            Department__c = 'Technology',
            Status__c = 'Open'
        );
    }

    @IsTest
    static void shouldDefaultStageAndTrackStageChange() {
        Id candidateId = [SELECT Id FROM Candidate__c LIMIT 1].Id;
        Id openingId = [SELECT Id FROM Job_Opening__c LIMIT 1].Id;

        Application__c application = new Application__c(
            Candidate__c = candidateId,
            Job_Opening__c = openingId
        );
        insert application;

        Application__c created = [
            SELECT Status__c, Stage_Changed_On__c
            FROM Application__c WHERE Id = :application.Id
        ];
        System.assertEquals('Applied', created.Status__c);
        System.assertEquals(Date.today(), created.Stage_Changed_On__c);

        created.Status__c = 'Interview';
        update created;

        Application__c updated = [
            SELECT Status__c, Stage_Changed_On__c
            FROM Application__c WHERE Id = :application.Id
        ];
        System.assertEquals('Interview', updated.Status__c);
        System.assertEquals(Date.today(), updated.Stage_Changed_On__c);
    }

    @IsTest
    static void shouldRejectApplicationWithoutRelationships() {
        try {
            insert new Application__c(Status__c = 'Applied');
            System.assert(false, 'Expected missing candidate/job validation.');
        } catch (DmlException expected) {
            System.assert(
                expected.getMessage().contains('both a candidate and a job opening')
            );
        }
    }

    @IsTest
    static void shouldLinkInterviewToApplication() {
        Id candidateId = [SELECT Id FROM Candidate__c LIMIT 1].Id;
        Id openingId = [SELECT Id FROM Job_Opening__c LIMIT 1].Id;
        Application__c application = new Application__c(
            Candidate__c = candidateId,
            Job_Opening__c = openingId
        );
        insert application;

        Interview__c interview = new Interview__c(
            Application__c = application.Id,
            Scheduled_On__c = System.now().addDays(2),
            Outcome__c = 'Pending'
        );
        insert interview;
        System.assertEquals(1, [SELECT COUNT() FROM Interview__c WHERE Application__c = :application.Id]);
    }
}
