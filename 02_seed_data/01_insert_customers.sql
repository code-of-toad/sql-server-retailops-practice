/*
    01_insert_customers.sql

    Purpose:
    Insert sample customer data into sales.Customer.

    This is our first seed-data file.

    Seed data means:
    - fake/sample data
    - used for practice
    - not production data
*/

-- Make sure we are working inside the correct database.
USE RetailOpsPractice;
GO


/* ============================================================
   1. Insert customers
   ============================================================ */

-- This IF statement prevents duplicate inserts if you accidentally
-- run this file more than once.
--
-- It says:
-- "Only insert these customers if the sales.Customer table is empty."
IF NOT EXISTS (
    SELECT 1
    FROM sales.Customer
)
BEGIN

    -- INSERT INTO tells SQL Server which table we are adding rows to.
    INSERT INTO sales.Customer (
        FirstName,
        LastName,
        Email,
        Phone,
        SignupDate,
        LoyaltyTier,
        MarketingOptIn
    )
    VALUES
        -- Each parenthesized group is one new customer row.
        ('Daniel', 'Brooks', 'daniel.brooks@example.com', '416-555-0101', '2025-01-05', 'Gold', 1),
        ('Priya', 'Kapoor', 'priya.kapoor@example.com', '647-555-0102', '2025-01-18', 'Silver', 1),
        ('Marcus', 'Johnson', 'marcus.johnson@example.com', '905-555-0103', '2025-02-02', 'Bronze', 0),
        ('Emily', 'Nguyen', 'emily.nguyen@example.com', '416-555-0104', '2025-02-25', 'Platinum', 1),
        ('Sarah', 'Miller', 'sarah.miller@example.com', '289-555-0105', '2025-03-03', 'Gold', 1),
        ('Jason', 'Lee', 'jason.lee@example.com', '778-555-0106', '2025-03-21', 'Bronze', 0),
        ('Fatima', 'Ali', 'fatima.ali@example.com', '514-555-0107', '2025-04-01', 'Silver', 1),
        ('Chris', 'Taylor', 'chris.taylor@example.com', '604-555-0108', '2025-04-14', 'Bronze', 1),
        ('Hannah', 'Wilson', 'hannah.wilson@example.com', '416-555-0109', '2025-05-08', 'Gold', 1),
        ('Omar', 'Hassan', 'omar.hassan@example.com', '905-555-0110', '2025-05-19', 'Silver', 0);

END;
GO


/* ============================================================
   2. Confirmation query
   ============================================================ */

-- Check that customer rows now exist.
SELECT
    CustomerID,
    FirstName,
    LastName,
    Email,
    SignupDate,
    LoyaltyTier,
    MarketingOptIn
FROM sales.Customer
ORDER BY CustomerID;
GO

-- Count how many customers exist.
SELECT COUNT(*) AS CustomerCount
FROM sales.Customer;
GO