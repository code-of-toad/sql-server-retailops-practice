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

SELECT *
FROM product.Category;
GO
SELECT *
FROM product.Supplier;
GO
SELECT *
FROM product.Product;
GO
SELECT *
FROM sales.Customer;
GO
SELECT *
FROM sales.[Order];
GO
SELECT *
FROM sales.OrderItem;
GO

/* ============================================================
   1. Basic joins
   ============================================================ */

-- Q1.
-- Show each order with the customer's first name, last name, email,
-- order date, order status, and sales channel.
SELECT
    o.OrderId,
    c.FirstName,
    c.LastName,
    c.Email,
    o.OrderDate,
    o.OrderStatus,
    o.SalesChannel
FROM sales.Customer AS c
JOIN sales.[Order] AS o
    ON c.CustomerID = o.CustomerID;
GO

-- Q2.
-- Show each order item with:
-- OrderID, ProductName, SKU, Quantity, UnitPrice, DiscountAmount.
SELECT
    oi.OrderID,
    p.ProductName,
    p.SKU,
    oi.Quantity,
    oi.UnitPrice,
    oi.DiscountAmount
FROM sales.OrderItem AS oi
JOIN product.Product AS p
    ON oi.ProductID = p.ProductID;
GO

-- Q3.
-- Show each product with its category name.
SELECT
    c.CategoryName AS ProductCategory,
    p.*
FROM product.Product AS p
JOIN product.Category AS c
    ON p.CategoryID = c.CategoryID;
GO

-- Q4.
-- Show each product with its supplier name.
SELECT
    s.SupplierName AS ProductSupplier,
    p.*
FROM product.Product AS p
JOIN product.Supplier AS s
    ON p.SupplierID = s.SupplierID;
GO

-- Q5.
-- Show each product with both its category name and supplier name.
SELECT
    c.CategoryName AS ProductCategory,
    s.SupplierName AS ProductSupplier,
    p.*
FROM product.Product AS p
JOIN product.Supplier AS s
    ON p.SupplierID = s.SupplierID
JOIN product.Category AS c
    ON p.CategoryID = c.CategoryID;
GO

/* ============================================================
   2. Order totals
   ============================================================ */

-- Q6.
-- Show each order item with a calculated LineTotal:
-- Quantity * UnitPrice - DiscountAmount.
SELECT
    *,
    ((Quantity * UnitPrice) - DiscountAmount) AS LineTotal
FROM sales.OrderItem;
GO

-- Q7.
-- Show total revenue per order.
-- Include OrderID, OrderDate, OrderStatus, and OrderTotal.
SELECT
    o.OrderID,
    o.OrderDate,
    o.OrderStatus,
    SUM((oi.Quantity * oi.UnitPrice) - oi.DiscountAmount) AS OrderTotal
FROM sales.[Order] AS o
JOIN sales.OrderItem AS oi
    ON o.OrderID = oi.OrderID
GROUP BY
    o.OrderID,
    o.OrderDate,
    o.OrderStatus
ORDER BY o.OrderID;
GO

-- Q8.
-- Show total revenue per order, but include customer first and last name.
SELECT
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.OrderDate,
    o.OrderStatus,
    SUM((oi.Quantity * oi.UnitPrice) - oi.DiscountAmount) AS OrderTotal
FROM sales.[Order] AS o
JOIN sales.OrderItem AS oi
    ON o.OrderID = oi.OrderID
JOIN sales.Customer AS c
    ON o.CustomerID = c.CustomerID
GROUP BY
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.OrderDate,
    o.OrderStatus;
GO

-- Q9.
-- Show only delivered orders and their order totals.
SELECT
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.OrderDate,
    o.OrderStatus,
    SUM((oi.Quantity * oi.UnitPrice) - oi.DiscountAmount) AS OrderTotal
FROM sales.[Order] AS o
JOIN sales.OrderItem AS oi
    ON o.OrderID = oi.OrderID
JOIN sales.Customer AS c
    ON o.CustomerID = c.CustomerID
WHERE o.OrderStatus = 'Delivered'
GROUP BY
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.OrderDate,
    o.OrderStatus;
GO

-- Q10.
-- Show orders where the order total is greater than 200.
SELECT
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.OrderDate,
    o.OrderStatus,
    SUM((oi.Quantity * oi.UnitPrice) - oi.DiscountAmount) AS OrderTotal
FROM sales.[Order] AS o
JOIN sales.OrderItem AS oi
    ON o.OrderID = oi.OrderID
JOIN sales.Customer AS c
    ON o.CustomerID = c.CustomerID
GROUP BY
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.OrderDate,
    o.OrderStatus
HAVING SUM((oi.Quantity * oi.UnitPrice) - oi.DiscountAmount) > 200;
GO

/* ============================================================
   3. Customer-level analysis
   ============================================================ */

-- Q11.
-- Show total number of orders per customer.
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    COUNT(o.OrderID) AS OrderCount
FROM sales.Customer AS c
LEFT JOIN sales.[Order] AS o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName;
GO

-- Q12.
-- Show total revenue per customer.
-- Exclude cancelled orders.
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    COALESCE(SUM((oi.UnitPrice * oi.Quantity) - oi.DiscountAmount), 0.00) AS TotalRevenue
FROM sales.Customer AS c
LEFT JOIN sales.[Order] AS o
    ON c.CustomerID = o.CustomerID
    AND o.OrderStatus <> 'Cancelled'
LEFT JOIN sales.OrderItem AS oi
    ON o.OrderID = oi.OrderID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName;
GO

-- Q13.
-- Show customers who have placed more than one order.
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    COUNT(o.OrderID) AS OrderCount
FROM sales.Customer AS c
JOIN sales.[Order] AS o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName
HAVING COUNT(o.OrderID) > 1;
GO

-- Q14.
-- Show customers who have never placed an order.
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    COUNT(o.OrderID) AS OrderCount
FROM sales.Customer AS c
LEFT JOIN sales.[Order] AS o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName
HAVING COUNT(o.OrderID) = 0;
GO

-- Q15.
-- Show each customer's most recent order date.
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    MAX(o.OrderDate) AS LastOrderDate
FROM sales.Customer AS c
LEFT JOIN sales.[Order] AS o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.FirstName,
    c.LastName;
GO

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