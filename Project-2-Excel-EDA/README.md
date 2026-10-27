# 📊 Project 2: Retail Banking Loan Portfolio Cleaning & Exploratory Data Analysis (EDA)

## 📌 Executive Summary
This project demonstrates end-to-end spreadsheet data engineering and Exploratory Data Analysis (EDA) on a retail bank's loan performance dataset containing 50 loan records. Using advanced Excel transformations and Pivot Tables, raw operational data was cleaned, restructured, and analyzed to evaluate regional branch performance, portfolio health, and credit risk exposure.

---

## 🛠️ Data Cleaning & Engineering Process
Raw banking extracts often contain data quality issues that distort reporting. The following steps were executed to transform the raw data into a reliable source of truth:
1. **Duplicate Removal:** Identified and eliminated redundant duplicate rows (e.g., duplicated customer loan IDs) to ensure accurate headcounts and totals.
2. **Text & Casing Standardization:** Standardized customer names, trimming trailing whitespace, and unifying branch nomenclature (e.g., standardizing text casing for *Lagos Island*, *Abuja*, *Ikeja*, and *Port Harcourt*).
3. **Missing Value Management:** Audited and handled missing transaction/loan attributes to prevent calculation errors.
4. **Structural Separation:** Organized the workbook into systematic layers:
   - `Raw_Data`: Preserved original unedited operational extracts.
   - `Cleaned_Data`: The finalized, audit-ready data table.
   - `Summary_EDA`: Dynamic Pivot Tables and multi-dimensional aggregations.

---

## 📈 Exploratory Data Analysis (EDA) & Key Findings
Using Excel Pivot Tables, the portfolio was aggregated to uncover critical retail banking insights:

### 1. Overall Portfolio Scale & Asset Distribution
* The bank's total active portfolio volume stands at **₦90,800,000** across 50 loan records.
* **Active Loans:** ₦61,350,000 (67.6% of the portfolio).
* **Closed/Repaid Loans:** ₦13,300,000 (14.6%).
* **Defaulted Loans (Risk Exposure):** ₦16,150,000 (17.8%).

### 2. Regional Branch Concentration & Revenue Drivers
* **Lagos Island** is the top-performing branch by volume, commanding **₦33,100,000** in total loans (₦25.4M active, ₦2.6M closed, ₦5.1M default).
* **Abuja** follows closely as the secondary primary growth driver with **₦30,600,000** in total portfolio value (₦20.55M active, ₦6.5M closed, ₦3.55M default).
* Together, Lagos Island and Abuja represent over **69%** of the bank's total asset exposure.

### 3. Credit Risk & Non-Performing Loan (NPL) Hotspots
* **Lagos Island** carries the highest default volume at **₦5,100,000**, followed by **Port Harcourt** at **₦4,550,000** (totaling ₦18,650,000 with ₦14.1M active). 
* *Risk Takeaway:* High-volume branches require stricter upfront credit risk vetting and proactive early-warning collections protocols.

### 4. Lifecycle & Origination Trends
* **Ikeja** shows a mature or slowing loan book, showing a lower active balance (**₦1,300,000**) compared to a high volume of closed/repaid loans (**₦4,200,000**) out of its ₦8,450,000 total book, indicating an urgent need for new loan acquisition campaigns by the sales team.

---

## 💡 Strategic Recommendations for Management
1. **Targeted Risk Mitigation:** Deploy focused recovery teams to Lagos Island and Port Harcourt to address high absolute default volumes.
2. **Sales Acquisition Campaigns:** Re-energize lending activity in the Ikeja branch to replace mature and fully closed portfolios.
3. **Automated Data Pipelines:** Transition manual spreadsheet cleanup workflows into automated Power Query or SQL ingestion pipelines for enterprise scalability.

---

## 📂 Project Repository Structure
```text
Project-2-Excel-EDA/
├── Cleaned_Banking_Portfolio.xlsx    # Full Excel Workbook (Raw, Cleaned, & Summary_EDA tabs)
└── README.md                         # Executive Case Study & Analytical Findings
