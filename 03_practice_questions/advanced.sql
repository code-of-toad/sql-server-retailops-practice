/*
    advanced.sql

    Purpose:
    Advanced SQL practice questions for RetailOpsPractice.

    Focus:
    - CTEs
    - subqueries
    - correlated subqueries
    - window functions
    - ranking
    - running totals
    - percent-of-total calculations
    - customer/product segmentation
    - multi-step analytics logic

    Write your answers under each question.
*/

USE RetailOpsPractice;
GO


/* ============================================================
   1. Subqueries
   ============================================================ */

-- Q1.
-- Show products whose UnitPrice is greater than the average product UnitPrice.


-- Q2.
-- Show customers who have placed at least one order.


-- Q3.
-- Show customers who have never placed an order.


-- Q4.
-- Show orders whose total is greater than the average order total.


-- Q5.
-- Show products that have never appeared in an order item.


/* ============================================================
   2. Correlated subqueries
   ============================================================ */

-- Q6.
-- For each customer, show their most recent order.
-- Return CustomerID, FirstName, LastName, OrderID, and OrderDate.


-- Q7.
-- For each product, show the most recent order date where that product was purchased.


-- Q8.
-- Show customers whose total spending is greater than the average customer spending.


-- Q9.
-- Show products whose total revenue is greater than the average product revenue.


/* ============================================================
   3. CTE practice
   ============================================================ */

-- Q10.
-- Use a CTE to calculate order totals.
-- Then select all orders with OrderTotal greater than 200.


-- Q11.
-- Use a CTE to calculate customer spending.
-- Then show customers with TotalSpent greater than 300.


-- Q12.
-- Use a CTE to calculate product revenue.
-- Then show the top 5 products by revenue.


-- Q13.
-- Use multiple CTEs:
-- First CTE: calculate order totals.
-- Second CTE: calculate average order total.
-- Final query: show orders above the average order total.


/* ============================================================
   4. Window functions
   ============================================================ */

-- Q14.
-- Show each product with its price rank from most expensive to least expensive.


-- Q15.
-- Show each customer order with a row number based on OrderDate.
-- The first order per customer should be row number 1.


-- Q16.
-- Show each customer's orders with:
-- OrderID,
-- OrderDate,
-- OrderTotal,
-- RunningTotalSpent.


-- Q17.
-- Show each product's revenue and its rank by revenue.


-- Q18.
-- Show each sales channel's revenue and its percentage of total revenue.


/* ============================================================
   5. Ranking and top-N per group
   ============================================================ */

-- Q19.
-- Show the most expensive product in each category.


-- Q20.
-- Show the highest-spending customer in each loyalty tier.


-- Q21.
-- Show the top 2 products by revenue within each category.


-- Q22.
-- Show each customer's largest order.


/* ============================================================
   6. Date analytics
   ============================================================ */

-- Q23.
-- Show monthly revenue with a running total across months.


-- Q24.
-- Show monthly order count and previous month's order count.
-- Use LAG.


-- Q25.
-- Show monthly revenue and previous month's revenue.
-- Then calculate the month-over-month revenue difference.


-- Q26.
-- For each customer, calculate the number of days between their first and most recent order.


/* ============================================================
   7. CASE-based segmentation
   ============================================================ */

-- Q27.
-- Segment customers by total spending:
-- 0                  -> 'No Spend'
-- 0.01 to 199.99      -> 'Low Value'
-- 200 to 499.99       -> 'Medium Value'
-- 500 or more         -> 'High Value'


-- Q28.
-- Segment products by total quantity sold:
-- 0                  -> 'Never Sold'
-- 1 to 2              -> 'Low Volume'
-- 3 to 5              -> 'Medium Volume'
-- 6 or more           -> 'High Volume'


-- Q29.
-- Segment orders by OrderTotal:
-- under 100           -> 'Small Order'
-- 100 to 249.99       -> 'Medium Order'
-- 250 or more         -> 'Large Order'


/* ============================================================
   8. Percent-of-total calculations
   ============================================================ */

-- Q30.
-- Show each product's revenue and percentage of total revenue.


-- Q31.
-- Show each category's revenue and percentage of total revenue.


-- Q32.
-- Show each customer's spending and percentage of total customer spending.


-- Q33.
-- Show each sales channel's order count and percentage of total orders.


/* ============================================================
   9. Data quality / audit-style questions
   ============================================================ */

-- Q34.
-- Find orders that have no order items.


-- Q35.
-- Find order items where DiscountAmount is greater than 50% of the original line price.


-- Q36.
-- Find products where StandardCost is more than 80% of UnitPrice.


-- Q37.
-- Find customers with duplicate phone numbers.
-- Ignore NULL phone numbers.


/* ============================================================
   10. Business-style advanced questions
   ============================================================ */

-- Q38.
-- Calculate gross profit per order.
-- Gross profit means:
-- SUM((OrderItem.UnitPrice - Product.StandardCost) * Quantity - DiscountAmount)


-- Q39.
-- Calculate gross profit margin per product.
-- Gross profit margin means:
-- TotalProfit / TotalRevenue


-- Q40.
-- Find the customer with the highest lifetime value.
-- Exclude cancelled orders.


-- Q41.
-- Find the category with the highest average order-item revenue.


-- Q42.
-- For each customer, show:
-- TotalOrders,
-- TotalSpent,
-- AverageOrderValue,
-- FirstOrderDate,
-- MostRecentOrderDate,
-- CustomerValueSegment.


-- Q43.
-- For each product, show:
-- TotalQuantitySold,
-- TotalRevenue,
-- TotalProfit,
-- RevenueRank,
-- ProfitRank.


-- Q44.
-- Find customers whose first order was over 200.


-- Q45.
-- Find products that have revenue above average but profit margin below average.