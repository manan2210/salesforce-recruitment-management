trigger ApplicationTrigger on Application__c (before insert, before update) {
    RecruitmentWorkflow.beforeSave(
        Trigger.new,
        Trigger.isUpdate ? Trigger.oldMap : null
    );
}
