-- ============================================================
-- PROJECT 1: BANKING CUSTOMER & TRANSACTION ANALYTICS
-- Database Setup, Data Insertion, and Business Intelligence Queries
-- ============================================================

-- ------------------------------------------------------------
-- STEP 1: DATABASE & SCHEMA CREATION
-- ------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS BankAnalyticsDB;
USE BankAnalyticsDB;

-- 1. Customers Table
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    signup_date DATE,
    branch_location VARCHAR(50)
);

-- 2. Accounts Table
CREATE TABLE IF NOT EXISTS Accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(30),
    opening_balance DECIMAL(12, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 3. Transactions Table
CREATE TABLE IF NOT EXISTS Transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    transaction_date DATE,
    amount DECIMAL(10, 2),
    transaction_type VARCHAR(20)
);

-- ------------------------------------------------------------
-- STEP 2: DATA INSERTION
-- ------------------------------------------------------------
INSERT IGNORE INTO Customers VALUES 
(1, 'Amina Yusuf', '2025-01-10', 'Lagos Island'),
(2, 'Chidi Okeke', '2025-01-15', 'Ikeja'),
(3, 'Fatima Bello', '2025-02-01', 'Abuja'),
(4, 'Tunde Bakare', '2025-02-20', 'Lagos Island'),
(5, 'Grace Effiong', '2025-03-05', 'Port Harcourt');

INSERT IGNORE INTO Accounts VALUES 
(101, 1, 'Savings', 150000.00),
(102, 1, 'Current', 450000.00),
(103, 2, 'Savings', 75000.00),
(104, 3, 'Investment', 1200000.00),
(105, 4, 'Savings', 30000.00),
(106, 5, 'Current', 600000.00);

INSERT IGNORE INTO Transactions VALUES 
(1001, 101, '2025-01-12', 25000.00, 'Deposit'),
(1002, 102, '2025-01-18', 100000.00, 'Deposit'),
(1003, 103, '2025-01-20', 10000.00, 'Withdrawal'),
(1004, 104, '2025-02-05', 500000.00, 'Deposit'),
(1005, 105, '2025-02-22', 5000.00, 'Withdrawal'),
(1006, 106, '2025-03-10', 150000.00, 'Deposit');

-- ------------------------------------------------------------
-- STEP 3: BUSINESS QUERIES & ANALYSIS
-- ------------------------------------------------------------

-- QUERY 1: Customer Portfolio & Cross-Holdings Analysis
-- Business Question: Identify total accounts held and total balance per customer.
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


-- QUERY 2: High-Value Transaction Ranking
-- Business Question: Rank transactions within each account to identify top funding events.
SELECT 
    transaction_id,
    account_id,
    transaction_date,
    amount,
    transaction_type,
    DENSE_RANK() OVER (PARTITION BY account_id ORDER BY amount DESC) AS transaction_rank
FROM Transactions;


-- QUERY 3: Monthly Cohort Retention & Transaction Activity Study
-- Business Question: Track active users, transaction counts, and total volume by signup cohort.
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