# Recruiting dashboard proposal (not implemented)

A Salesforce report/dashboard can be built in an authorized developer org once the custom objects and sample data are deployed.

## KPIs

- Applications by stage and opening (count).
- Interview-to-offer conversion (requires stage history, not available in this prototype).
- Hiring cycle time (requires timestamped stage history, not available here).
- Open jobs by department (count).
- Interviews upcoming this week (filter by Scheduled On).

## Integrity and interpretation

- This repository includes one **SOQL pipeline count query**, not a deployed Salesforce dashboard.
- Do not calculate historical conversion or cycle time from only the current stage; that would misrepresent the underlying data.
- Before adding data, implement profiles, sharing, consent, retention and governance suitable for applicant information.

## Suggested demo

Create fictitious candidates and job openings in a Salesforce Developer Edition org. Enter sample applications at each stage. Run the SOQL query in Developer Console to see counts. Review next improvements with a mock business stakeholder.
