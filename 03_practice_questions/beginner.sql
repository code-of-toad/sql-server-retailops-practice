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


-- Q2.
-- Show only FirstName, LastName, Email, and LoyaltyTier
-- from sales.Customer.


-- Q3.
-- Show all products from product.Product.


-- Q4.
-- Show only ProductName, UnitPrice, and StandardCost
-- from product.Product.


/* ============================================================
   2. Sorting
   ============================================================ */

-- Q5.
-- Show all customers ordered by SignupDate from oldest to newest.


-- Q6.
-- Show all products ordered by UnitPrice from highest to lowest.


-- Q7.
-- Show all orders ordered by OrderDate from newest to oldest.


/* ============================================================
   3. Filtering with WHERE
   ============================================================ */

-- Q8.
-- Show all customers whose LoyaltyTier is 'Gold'.


-- Q9.
-- Show all customers who opted into marketing.


-- Q10.
-- Show all products with UnitPrice greater than 100.


-- Q11.
-- Show all products with UnitPrice between 50 and 150.


-- Q12.
-- Show all orders with OrderStatus equal to 'Delivered'.


-- Q13.
-- Show all orders that are not 'Delivered'.


/* ============================================================
   4. Multiple conditions
   ============================================================ */

-- Q14.
-- Show all Gold customers who opted into marketing.


-- Q15.
-- Show all products that are active and cost more than 100.


-- Q16.
-- Show all orders from the Website channel with status Delivered.


-- Q17.
-- Show all products where UnitPrice is greater than 100
-- and StandardCost is less than 100.


/* ============================================================
   5. DISTINCT
   ============================================================ */

-- Q18.
-- Show all unique loyalty tiers from sales.Customer.


-- Q19.
-- Show all unique order statuses from sales.[Order].


-- Q20.
-- Show all unique sales channels from sales.[Order].


/* ============================================================
   6. TOP
   ============================================================ */

-- Q21.
-- Show the top 5 most expensive products.


-- Q22.
-- Show the 3 newest customers.


-- Q23.
-- Show the 5 most recent orders.


/* ============================================================
   7. Calculated columns
   ============================================================ */

-- Q24.
-- Show ProductName, UnitPrice, StandardCost, and ProfitPerUnit.
-- ProfitPerUnit should be UnitPrice - StandardCost.


-- Q25.
-- Show ProductName, UnitPrice, StandardCost, and ProfitMargin.
-- ProfitMargin should be:
-- (UnitPrice - StandardCost) / UnitPrice


-- Q26.
-- Show OrderItemID, Quantity, UnitPrice, DiscountAmount, and LineTotal.
-- LineTotal should be:
-- Quantity * UnitPrice - DiscountAmount


/* ============================================================
   8. Basic aggregate functions
   ============================================================ */

-- Q27.
-- Count how many customers exist.


-- Q28.
-- Count how many products exist.


-- Q29.
-- Find the cheapest product price.


-- Q30.
-- Find the most expensive product price.


-- Q31.
-- Find the average product price.


-- Q32.
-- Find the total revenue from sales.OrderItem.
-- Revenue means:
-- Quantity * UnitPrice - DiscountAmount