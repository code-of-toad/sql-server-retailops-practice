/*
    intermediate.sql

    Purpose:
    Intermediate SQL practice questions for RetailOpsPractice.

    Focus:
    - INNER JOIN
    - LEFT JOIN
    - GROUP BY
    - HAVING
    - CASE
    - date functions
    - multi-table business questions
    - aggregate calculations across tables

    Write your answers under each question.
*/

USE RetailOpsPractice;
GO


/* ============================================================
   1. Basic joins
   ============================================================ */

-- Q1.
-- Show each order with the customer's first name, last name, email,
-- order date, order status, and sales channel.


-- Q2.
-- Show each order item with:
-- OrderID, ProductName, SKU, Quantity, UnitPrice, DiscountAmount.


-- Q3.
-- Show each product with its category name.


-- Q4.
-- Show each product with its supplier name.


-- Q5.
-- Show each product with both its category name and supplier name.


/* ============================================================
   2. Order totals
   ============================================================ */

-- Q6.
-- Show each order item with a calculated LineTotal:
-- Quantity * UnitPrice - DiscountAmount.


-- Q7.
-- Show total revenue per order.
-- Include OrderID, OrderDate, OrderStatus, and OrderTotal.


-- Q8.
-- Show total revenue per order, but include customer first and last name.


-- Q9.
-- Show only delivered orders and their order totals.


-- Q10.
-- Show orders where the order total is greater than 200.


/* ============================================================
   3. Customer-level analysis
   ============================================================ */

-- Q11.
-- Show total number of orders per customer.


-- Q12.
-- Show total revenue per customer.
-- Exclude cancelled orders.


-- Q13.
-- Show customers who have placed more than one order.


-- Q14.
-- Show customers who have never placed an order.


-- Q15.
-- Show each customer's most recent order date.


/* ============================================================
   4. Product-level analysis
   ============================================================ */

-- Q16.
-- Show total quantity sold per product.


-- Q17.
-- Show total revenue per product.


-- Q18.
-- Show the top 5 products by total revenue.


-- Q19.
-- Show total quantity sold per category.


-- Q20.
-- Show total revenue per supplier.


/* ============================================================
   5. GROUP BY and HAVING
   ============================================================ */

-- Q21.
-- Show loyalty tiers with more than 2 customers.


-- Q22.
-- Show sales channels with more than 3 orders.


-- Q23.
-- Show products with total quantity sold greater than 2.


-- Q24.
-- Show customers whose total spending is greater than 300.
-- Exclude cancelled orders.


/* ============================================================
   6. CASE expressions
   ============================================================ */

-- Q25.
-- Show products with a PriceBand column:
-- UnitPrice < 50        -> 'Budget'
-- UnitPrice 50 to 149.99 -> 'Standard'
-- UnitPrice >= 150       -> 'Premium'


-- Q26.
-- Show orders with an OrderOutcome column:
-- Delivered -> 'Successful'
-- Returned  -> 'Problem'
-- Cancelled -> 'Problem'
-- Pending   -> 'In Progress'
-- Shipped   -> 'In Progress'


-- Q27.
-- Show customers with a MarketingStatus column:
-- MarketingOptIn = 1 -> 'Subscribed'
-- MarketingOptIn = 0 -> 'Not Subscribed'


/* ============================================================
   7. Date practice
   ============================================================ */

-- Q28.
-- Show all orders placed in June 2025.


-- Q29.
-- Show total revenue by month.
-- Display OrderYear, OrderMonth, and MonthlyRevenue.
-- Exclude cancelled orders.


-- Q30.
-- Show number of orders by month.


-- Q31.
-- Show customers who signed up before June 1, 2025.


-- Q32.
-- Show how many days passed between each customer's SignupDate
-- and their first OrderDate.


/* ============================================================
   8. LEFT JOIN practice
   ============================================================ */

-- Q33.
-- Show all customers and their orders.
-- Include customers even if they have no orders.


-- Q34.
-- Show all products and their order items.
-- Include products even if they have never been ordered.


-- Q35.
-- Show products that have never been ordered.


/* ============================================================
   9. Business-style questions
   ============================================================ */

-- Q36.
-- Which sales channel generated the most revenue?
-- Exclude cancelled orders.


-- Q37.
-- Which loyalty tier generated the most revenue?
-- Exclude cancelled orders.


-- Q38.
-- Which category generated the most revenue?


-- Q39.
-- What is the average order value?
-- Exclude cancelled orders.


-- Q40.
-- For each customer, show:
-- Customer name,
-- TotalOrders,
-- TotalSpent,
-- AverageOrderValue.