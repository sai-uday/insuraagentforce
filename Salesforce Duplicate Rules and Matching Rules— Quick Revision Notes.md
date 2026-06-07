# **Salesforce Duplicate Rules and Matching Rules— Quick Revision Notes**

---

# **1\. Core Concepts**

| Component | Purpose |
| ----- | ----- |
| Matching Rule | Identifies duplicates |
| Duplicate Rule | Decides what action to take |

|  |  |   |   |
| ----: | :---- | ----- | :---- |
| **Record-Level Security** |  \-Enforce sharing rules \-Bypass sharing rules |  |  |

---

# **2\. Matching Rule**

Defines:

* which fields to compare  
* how comparison happens

Example:

* Email → Exact Match  
* Name → Fuzzy Match

---

# **3\. Duplicate Rule**

Controls:

* Allow  
* Alert  
* Block  
* Report

---

# 

# **4\. Difference**

| Matching Rule | Duplicate Rule |
| ----- | ----- |
| Detects duplicate | Controls behavior |
| Comparison logic | Action logic |

---

# **5\. Matching Methods**

| Type | Example |
| ----- | ----- |
| Exact | Email |
| Fuzzy | Name, Company |

Example:

* Jon ≈ John

---

# **6\. Standard Objects Supported**

Mainly:

* Leads  
* Contacts  
* Accounts

---

# **7\. Cross-Object Matching**

Meaning:

* compare records across different objects

Example:

* Lead email vs Contact email

---

# **8\. How Cross-Object Matching Works**

Configured in:

## **Duplicate Rule**

Example:

Lead Duplicate Rule  
   ↓  
Compare against:  
\- Leads  
\- Contacts

Matching Rules define:

* Email  
* Phone  
* Name logic

---

# **9\. Potential Duplicates Component**

Type:  
✅ Standard Lightning Component

Used to:

* show duplicate warnings on record page

Added through:

## **Lightning App Builder**

---

# **10\. Duplicate Rule Actions**

| Action | Meaning |
| ----- | ----- |
| Allow | Save record |
| Alert | Warn user |
| Block | Prevent save |
| Report | Log duplicate info |

---

# **11\. What is “Report”?**

Salesforce stores duplicates in:

* Duplicate Record Sets  
* Duplicate Record Items

Used for:

* reports  
* dashboards  
* cleanup

---

# **12\. Where to Check Duplicate Reports**

Search:

## **Duplicate Record Sets**

or create reports using:

* Duplicate Record Sets  
* Duplicate Record Items

---

# 

# **13\. Data Import Wizard vs Data Loader**

| Tool | Duplicate Rules |
| ----- | ----- |
| Data Import Wizard | Usually enforced |
| Data Loader | Depends on API/config |

---

# **14\. Important Clarification**

Duplicate Rules are:  
✅ enforced by default

for:

* UI  
* API  
* imports

---

# **15\. How Duplicate Bypass Happens**

Bypass is:  
❌ NOT automatic

It must be:  
✅ explicitly configured

---

# **16\. Ways to Bypass Duplicate Rules**

## **A. Duplicate Rule \= Allow**

User sees warning:

“Possible duplicate exists.”

Can click:

## **Save Anyway**

---

## **B. Apex Bypass**

Database.DMLOptions dml \= new Database.DMLOptions();  
dml.DuplicateRuleHeader.allowSave \= true;

Purpose:

* bypass duplicate block

---

## **C. API Header Bypass**

External API can send:

allowSave=true

Then:

* Salesforce allows insert

---

## **D. Temporarily Deactivate Rule**

Used during:

* migration  
* bulk load

---

# **17\. By Default**

| Scenario | Duplicate Rule Applied? |
| ----- | ----- |
| UI Save | YES |
| REST API | YES |
| Data Import Wizard | YES |
| Apex with allowSave=true | NO |
| API Header allowSave=true | NO |

---

# **18\. Real-Time Usage**

| Situation | Recommended Action |
| ----- | ----- |
| Sales users | Allow \+ Alert |
| Customer master data | Block |
| Bulk migration | Disable temporarily |
| Integrations | Controlled bypass |

---

# **19\. Common Interview Question**

## **Q:**

Can duplicate rules work without matching rules?

## **A:**

❌ No.

Duplicate Rules depend on Matching Rules.

---

# **20\. Important Interview Line**

“Matching Rules identify duplicates, while Duplicate Rules define system behavior like alerting or blocking.”

---

# **21\. Best Practice**

Start with:  
✅ Allow \+ Alert

Later move to:  
✅ Block

after users get familiar.

---

# **22\. Troubleshooting Checklist**

If duplicate rule not working:

Check:

* Matching Rule active?  
* Duplicate Rule active?  
* Correct object selected?  
* API bypass happening?  
* User permissions?  
* Rule action \= Allow or Block?

---

# **23\. Most Important Real-Time Understanding**

Duplicate bypass is:  
❌ not automatic

It happens only when:

* Allow action used  
* Apex explicitly bypasses  
* API explicitly bypasses  
* Rules deactivated

That’s the key architectural concept.

---

# **24\. Troubleshooting Duplicate Rules**

## **Scenario**

Customer says:

“Duplicate contacts are still getting created.”

---

# **Troubleshooting Checklist**

## **1\. Check Matching Rule**

Verify:  
 ✅ Matching Rule is Active

Path:

Setup → Matching Rules

Without active matching rule:

* duplicate detection won’t work.

---

## **2\. Check Duplicate Rule**

Verify:  
 ✅ Duplicate Rule is Active

Path:

Setup → Duplicate Rules  
---

## **3\. Verify Rule Action**

Check whether rule is:

| Action | Result |
| ----- | ----- |
| Allow | Duplicates can still save |
| Block | Prevent duplicates |

Sometimes duplicates happen simply because:

* rule configured as Allow.

---

## **4\. Check User Permissions**

Verify whether user has:

* Modify All Data  
* admin-level access  
* integration profile

These users may bypass enforcement in some operations.

---

## **5\. Check API / Integration Inserts**

Ask:

“Are records coming from API/Data Loader/integration?”

Possible sources:

* MuleSoft  
* Informatica  
* REST API  
* Bulk API

Check whether:

allowSave=true

is being used.

---

## **6\. Check Apex Code**

Developers may use:

Database.DMLOptions

with:

allowSave=true

which bypasses duplicate block.

---

## **7\. Check Record-Level Sharing**

Sometimes duplicate detection depends on:

* user visibility  
* sharing settings

If user cannot see existing record:

* duplicate may not be detected properly.

---

# **Strong Interview Answer**

“I would verify active matching and duplicate rules, confirm whether the rule is Allow or Block, check user permissions and integrations, and validate whether APIs or Apex are bypassing duplicate enforcement.”

