# Salesforce Recruitment Management & Automation

A **Salesforce DX portfolio prototype** for a recruiting team: structured candidate and job records, application-stage tracking, interview records, and a small, testable Apex automation. Designed to demonstrate **CRM data modeling, process analysis, and business automation** relevant to entry-level technology consulting.

> **Status: source-code demonstration.** This is a newly assembled Salesforce DX starter, not a deployment, a live CRM, or a copy of an existing volunteer organization’s system. No Salesforce org connection or deployment test has been performed. It uses fictional example scenarios and contains no personal candidate data. Review and adapt before presenting it as your work.

## Included

- Four Salesforce custom objects: `Candidate__c`, `Job_Opening__c`, `Application__c`, `Interview__c`.
- Lookups connecting applications to candidates and openings, and interviews to applications.
- Recruiting pipeline statuses: Applied → Screening → Interview → Offer → Hired / Rejected.
- Apex trigger + handler that defaults the pipeline stage and records the last stage-change date.
- Apex test class with example stage-transition assertions.
- A sample SOQL pipeline report, a process map, and future enhancement proposals.
- A Python/XML source-layout check in GitHub Actions (**not** a Salesforce deployment or Apex runtime test).

## Folder guide

| Folder | Purpose |
|---|---|
| `force-app/main/default/objects/` | Salesforce DX metadata for four custom objects |
| `force-app/main/default/classes/` | Apex automation handler and tests |
| `force-app/main/default/triggers/` | Application before-save trigger |
| `scripts/soql/` | Sample SOQL reporting query |
| `docs/` | Recruitment workflow, assumptions, setup, and dashboard specifications |

## How to try it in a Salesforce Developer Edition or scratch org

Install the [Salesforce CLI](https://developer.salesforce.com/tools/salesforcecli), then authenticate to an org you control:

```bash
sf org login web --alias recruitment-demo
sf project deploy start --source-dir force-app --target-org recruitment-demo
sf apex run test --tests RecruitmentWorkflowTest --target-org recruitment-demo --result-format human
```

**Deployment and Apex tests have not been verified in an org here.** The example is for a sandbox/developer org: deployment may require metadata or permissions adjustments based on the org. Never deploy unreviewed code to production.

## Example workflow

1. Create a Candidate and a Job Opening.
2. Create an Application relating the two; status is set to **Applied** if omitted.
3. Move the Application to **Interview**; Apex stamps the date of the stage change.
4. Record interview activities on the related Interview record.
5. Use SOQL or Salesforce reports to summarize pipeline stages by job opening.

## Consulting-oriented opportunities

**Current:** basic data model, stage tracking, transparent workflow logic.

**Proposed, not implemented:** recruiting dashboards with conversion rates and time-to-stage, Salesforce Flow follow-up reminders, data quality audits, and a human-reviewed AI-assisted interview-summary feature (privacy/security approval required).

**Technology:** Salesforce DX, Custom Objects, Apex, SOQL, XML metadata, business process design.

**References:** [Salesforce DX source format](https://developer.salesforce.com/docs/platform/sfdx-dev/guide/sfdx-dev-source-file-format.html) · [Salesforce CLI](https://developer.salesforce.com/tools/salesforcecli).
