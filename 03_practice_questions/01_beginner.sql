/*
    beginner.sql

    Purpose:
    Beginner SQL practice questions for RetailOpsPractice.

    Focus:
    - SELECT
    - FROM
    - WHERE
    - ORDER BY
    - TOP
    - DISTINCT
    - basic calculated columns
    - simple filtering
    - COUNT, MIN, MAX, AVG, SUM

    Write your answers under each question.
*/

USE RetailOpsPractice;
GO

/* ============================================================
   1. Basic SELECT queries
   ============================================================ */

-- Q1.
-- Show all columns from sales.Customer.
SELECT *
FROM sales.Customer;
GO

-- Q2.
-- Show only FirstName, LastName, Email, and LoyaltyTier
-- from sales.Customer.
SELECT
    FirstName,
    LastName,
    Email,
    LoyaltyTier
FROM sales.Customer;
GO

-- Q3.
-- Show all products from product.Product.
SELECT *
FROM product.Product;
GO

-- Q4.
-- Show only ProductName, UnitPrice, and StandardCost
-- from product.Product.
SELECT
    ProductName,
    UnitPrice,
    StandardCost
FROM product.Product;
GO

/* ============================================================
   2. Sorting
   ============================================================ */

-- Q5.
-- Show all customers ordered by SignupDate from oldest to newest.
SELECT *
FROM sales.Customer
ORDER BY SignupDate;
GO

-- Q6.
-- Show all products ordered by UnitPrice from highest to lowest.
SELECT *
FROM product.Product
ORDER BY UnitPrice DESC;
GO

-- Q7.
-- Show all orders ordered by OrderDate from newest to oldest.
SELECT *
FROM sales.[Order]
ORDER BY OrderDate DESC;
GO

/* ============================================================
   3. Filtering with WHERE
   ============================================================ */

-- Q8.
-- Show all customers whose LoyaltyTier is 'Gold'.
SELECT *
FROM sales.Customer
WHERE LoyaltyTier = 'Gold';
GO

-- Q9.
-- Show all customers who opted into marketing.
SELECT *
FROM sales.Customer
WHERE MarketingOptin = 1;
GO

-- Q10.
-- Show all products with UnitPrice greater than 100.
SELECT *
FROM product.Product
WHERE UnitPrice > 100;
GO

-- Q11.
-- Show all products with UnitPrice between 50 and 150.
SELECT *
FROM product.Product
WHERE UnitPrice BETWEEN 50 AND 150;
GO

-- Q12.
-- Show all orders with OrderStatus equal to 'Delivered'.
SELECT *
FROM sales.[Order]
WHERE OrderStatus = 'Delivered';
GO

-- Q13.
-- Show all orders that are not 'Delivered'.
SELECT *
FROM sales.[Order]
WHERE OrderStatus <> 'Delivered';
GO

/* ============================================================
   4. Multiple conditions
   ============================================================ */

-- Q14.
-- Show all Gold customers who opted into marketing.
SELECT *
FROM sales.Customer
WHERE LoyaltyTier = 'Gold'
  AND MarketingOptin = 1;
GO

-- Q15.
-- Show all products that are active and cost more than 100.
SELECT *
FROM product.Product
WHERE IsActive = 1
  AND StandardCost > 100;
GO

-- Q16.
-- Show all orders from the Website channel with status Delivered.
SELECT *
FROM sales.[Order]
WHERE SalesChannel = 'Website'
  AND OrderStatus = 'Delivered';
GO

-- Q17.
-- Show all products where UnitPrice is greater than 100
-- and StandardCost is less than 100.
SELECT *
FROM product.Product
WHERE UnitPrice > 100
  AND StandardCost < 100;
GO

/* ============================================================
   5. DISTINCT
   ============================================================ */

-- Q18.
-- Show all unique loyalty tiers from sales.Customer.
SELECT DISTINCT LoyaltyTier
FROM sales.Customer;
GO

-- Q19.
-- Show all unique order statuses from sales.[Order].
SELECT DISTINCT OrderStatus
FROM sales.[Order];
GO

-- Q20.
-- Show all unique sales channels from sales.[Order].
SELECT DISTINCT SalesChannel
FROM sales.[Order];
GO

/* ============================================================
   6. TOP
   ============================================================ */

-- Q21.
-- Show the top 5 most expensive products.
SELECT TOP(5) *
FROM product.Product
ORDER BY UnitPrice DESC;
GO

-- Q22.
-- Show the 3 newest customers.
SELECT TOP(3) *
FROM sales.Customer
ORDER BY SignupDate DESC;
GO

-- Q23.
-- Show the 5 most recent orders.
SELECT TOP(5) *
FROM sales.[Order]
ORDER BY OrderDate DESC;
GO

/* ============================================================
   7. Calculated columns
   ============================================================ */

-- Q24.
-- Show ProductName, UnitPrice, StandardCost, and ProfitPerUnit.
-- ProfitPerUnit should be UnitPrice - StandardCost.
SELECT
    ProductName,
    UnitPrice,
    StandardCost,
    (UnitPrice - StandardCost) AS ProfitPerUnit
FROM product.Product;
GO

-- Q25.
-- Show ProductName, UnitPrice, StandardCost, and ProfitMargin.
-- ProfitMargin should be:
-- (UnitPrice - StandardCost) / UnitPrice
SELECT
    ProductName,
    UnitPrice,
    StandardCost,
    (UnitPrice - StandardCost) AS ProfitPerUnit,
    ((UnitPrice - StandardCost) / NULLIF(UnitPrice, 0)) AS ProfitMargin,
    CASE
        WHEN UnitPrice = 0 THEN 'Invalid: UnitPrice is 0'
        WHEN UnitPrice IS NULL THEN 'Invalid: UnitPrice is NULL'
        ELSE 'Valid'
    END AS ProfitMarginStatus
FROM product.Product
ORDER BY ProfitMargin;
GO

-- Q26.
-- Show OrderItemID, Quantity, UnitPrice, DiscountAmount, and LineTotal.
-- LineTotal should be:
-- Quantity * UnitPrice - DiscountAmount
SELECT
    OrderItemID,
    Quantity,
    UnitPrice,
    DiscountAmount,
    ((Quantity * UnitPrice) - DiscountAmount) AS LineTotal
FROM sales.OrderItem;
GO

/* ============================================================
   8. Basic aggregate functions
   ============================================================ */

-- Q27.
-- Count how many customers exist.
SELECT COUNT(*) AS CustomerCount
FROM sales.Customer;
GO

-- Q28.
-- Count how many products exist.
SELECT COUNT(*) AS ProductCount
FROM product.Product;
GO

-- Q29.
-- Find the cheapest product price.
SELECT MIN(UnitPrice) AS LowestProductPrice
FROM product.Product;
GO

-- Q30.
-- Find the most expensive product price.
SELECT MAX(UnitPrice) AS HighestProductPrice
FROM product.Product;
GO

-- Q31.
-- Find the average product price.
SELECT AVG(UnitPrice) AS AverageProductPrice
FROM product.Product;
GO

-- Q32.
-- Find the total revenue from sales.OrderItem.
-- Revenue means:
-- Quantity * UnitPrice - DiscountAmount
SELECT SUM((Quantity * UnitPrice) - DiscountAmount) AS TotalRevenue
FROM sales.OrderItem;
GO