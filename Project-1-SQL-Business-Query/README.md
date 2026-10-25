# 📊 Project 1: Banking Customer Account Activity & Cohort Retention Study

## 📌 Executive Summary
This project analyzes customer deposit accounts, cross-product holdings, and transaction dynamics for a commercial retail bank. Leveraging MySQL, the analysis addresses critical executive questions around client portfolio valuation, high-value deposit events, and month-over-month customer activity trends.

---

## 🎯 Business Context & Objectives
Retail banking institutions face key operational challenges regarding customer retention and relationship depth:
1. **Portfolio Value Concentration:** Identifying high-net-worth clients holding multiple products to optimize cross-selling strategies.
2. **Transaction Behavior:** Tracking single largest deposit/withdrawal movements across account tiers.
3. **Cohort Retention:** Measuring account dormancy and customer activity decay relative to signup dates.

**Key Technical Focus:** Complex `JOIN` operations, aggregate conditional logic, ranking window functions (`DENSE_RANK`), and date truncation/formatting (`DATE_FORMAT`).

---

## 🛠️ Data Architecture & Schema
The relational database (`BankAnalyticsDB`) consists of three primary entities:
- **`Customers`**: Master customer profiles (ID, Name, Signup Date, Branch Location).
- **`Accounts`**: Product holding data (Savings, Current, Investment) and opening balance records.
- **`Transactions`**: Transaction ledger tracking deposits, withdrawals, and movement timestamps.

---

## 💡 Key Business Queries & Analytical Insights

### 1. Customer Cross-Holdings & Portfolio Value
* **Objective:** Determine total accounts held and aggregate deposit portfolio value per customer.
* **SQL Focus:** `JOIN`, `COUNT()`, `SUM()`, `GROUP BY`, `HAVING`.

```sql
SELECT 
    c.customer_id,
    c.customer_name,
    c.branch_location,
    COUNT(a.account_id) AS total_accounts_held,
    SUM(a.opening_balance) AS total_portfolio_value
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.customer_name, c.branch_location
HAVING COUNT(a.account_id) >= 1
ORDER BY total_portfolio_value DESC;
Insight: Fatima Bello holds the highest single portfolio value ($1,200,000.00) in an Investment account (Abuja branch), while Amina Yusuf exhibits the deepest product cross-sell holding 2 active accounts (Savings + Current in Lagos Island).

2. High-Value Transaction Ranking
Objective: Rank transactions within each account to flag major liquidity events.

SQL Focus: Window function DENSE_RANK() OVER (PARTITION BY account_id ORDER BY amount DESC).

SQL
SELECT 
    transaction_id,
    account_id,
    transaction_date,
    amount,
    transaction_type,
    DENSE_RANK() OVER (PARTITION BY account_id ORDER BY amount DESC) AS transaction_rank
FROM Transactions;
Insight: Largest single transaction was a $500,000.00 deposit into account 104, highlighting key account funding patterns for wealth management prioritization.

3. Monthly Signup Cohort & Activity Retention
Objective: Group customer signup cohorts and evaluate monthly transaction volumes and active client counts.

SQL Focus: DATE_FORMAT(), COUNT(DISTINCT), multi-table JOIN.

SQL
SELECT 
    DATE_FORMAT(c.signup_date, '%Y-%m') AS signup_cohort,
    DATE_FORMAT(t.transaction_date, '%Y-%m') AS transaction_month,
    COUNT(DISTINCT c.customer_id) AS active_customers,
    COUNT(t.transaction_id) AS total_transactions,
    SUM(t.amount) AS total_transaction_volume
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
JOIN Transactions t ON a.account_id = t.account_id
GROUP BY signup_cohort, transaction_month
ORDER BY signup_cohort, transaction_month;
Insight: January 2025 signup cohort drove the highest total transaction volume ($135,000 across 3 transactions), demonstrating strong initial engagement in Q1.

📈 Strategic Business Recommendations
Based on the SQL analysis, the following actionable recommendations are proposed for bank management:

Targeted Cross-Selling: Clients holding single account types (e.g., Savings only) with balances over $50,000 should be routed to Relationship Managers for investment/current account upgrades.

Early Retention Intervention: Establish automated triggers for accounts showing zero transaction activity within 30 days of signup to prevent early churn.

Branch Resource Allocation: Focus relationship management resources on top-performing branches (Lagos Island & Abuja) driving peak portfolio value.

📂 Project Repository Structure
Plaintext
Project-1-SQL-Business-Query/
├── business_queries.sql      # Full SQL Script (Schema, Seed Data & Business Queries)
└── README.md                 # Executive Case Study & Findings
