/**
 * Basic recruitment pipeline business rules.
 * Before-save only: no DML, SOQL, or external calls in the trigger.
 */
public with sharing class RecruitmentWorkflow {
    public static void beforeSave(
        List<Application__c> currentRecords,
        Map<Id, Application__c> previousById
    ) {
        for (Application__c application : currentRecords) {
            if (application.Candidate__c == null || application.Job_Opening__c == null) {
                application.addError(
                    'An application must reference both a candidate and a job opening.'
                );
            }

            if (String.isBlank(application.Status__c)) {
                application.Status__c = 'Applied';
            }

            Application__c previous = previousById == null
                ? null
                : previousById.get(application.Id);

            if (previous == null || previous.Status__c != application.Status__c) {
                application.Stage_Changed_On__c = Date.today();
            }
        }
    }
}
