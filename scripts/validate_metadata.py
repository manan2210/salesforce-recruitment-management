"""Local XML/static checks only. Does not compile Apex or deploy to Salesforce."""
from pathlib import Path
import xml.etree.ElementTree as ET

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "force-app/main/default"
NS = {"sf": "http://soap.sforce.com/2006/04/metadata"}
OBJECTS = ["Candidate__c", "Job_Opening__c", "Application__c", "Interview__c"]

def check():
    assert (ROOT / "sfdx-project.json").is_file()
    for obj in OBJECTS:
        obj_file = SOURCE / "objects" / obj / f"{obj}.object-meta.xml"
        assert obj_file.exists(), f"Missing {obj_file}"
        root = ET.parse(obj_file).getroot()
        assert root.find("sf:label", NS) is not None

    fields = list((SOURCE / "objects").glob("*/fields/*.field-meta.xml"))
    assert len(fields) >= 12, "Expected the core recruitment fields"
    for file in fields:
        node = ET.parse(file).getroot()
        name = node.find("sf:fullName", NS)
        assert name is not None and name.text == file.name.replace(".field-meta.xml", "")
        target = node.find("sf:referenceTo", NS)
        if target is not None:
            assert target.text in OBJECTS, f"Unknown lookup target in {file}"

    for path in (SOURCE / "classes").glob("*-meta.xml"):
        ET.parse(path)
    for path in (SOURCE / "triggers").glob("*-meta.xml"):
        ET.parse(path)

    assert (SOURCE / "triggers/ApplicationTrigger.trigger").exists()
    assert (SOURCE / "classes/RecruitmentWorkflow.cls").exists()
    assert (SOURCE / "classes/RecruitmentWorkflowTest.cls").exists()

    print(f"Static source check passed: {len(OBJECTS)} objects, {len(fields)} custom fields.")
    print("Salesforce deployment and Apex test execution NOT performed.")

if __name__ == "__main__":
    check()
