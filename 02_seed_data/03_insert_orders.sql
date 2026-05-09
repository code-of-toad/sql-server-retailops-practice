/*
    03_insert_orders.sql

    Purpose:
    Insert sample order data into sales.[Order].

    Important:
    sales.[Order] stores the overall order.
    It does NOT store the individual products inside the order.

    Individual products will be inserted later into sales.OrderItem.
*/

USE RetailOpsPractice;
GO


/* ============================================================
   1. Insert orders
   ============================================================ */

-- Only insert orders if the table is empty.
-- This prevents duplicate rows if this file is accidentally run twice.
IF NOT EXISTS (
    SELECT 1
    FROM sales.[Order]
)
BEGIN

    /*
        We are inserting orders by looking up customers using Email.

        Why not hard-code CustomerID values?

        Because CustomerID is an IDENTITY column.
        SQL Server generates it automatically.

        Looking up customers by Email makes the script easier to understand
        and safer than assuming Daniel Brooks is always CustomerID = 1.
    */

    INSERT INTO sales.[Order] (
        CustomerID,
        OrderDate,
        OrderStatus,
        SalesChannel,
        CustomerNote
    )
    SELECT
        c.CustomerID,

        -- Convert the text date into a datetime2(0) value.
        CONVERT(datetime2(0), v.OrderDateText),

        v.OrderStatus,
        v.SalesChannel,
        v.CustomerNote
    FROM (
        VALUES
            ('daniel.brooks@example.com', '2025-06-01T09:15:00', 'Delivered', 'Website', NULL),
            ('priya.kapoor@example.com', '2025-06-03T14:20:00', 'Delivered', 'Mobile App', NULL),
            ('marcus.johnson@example.com', '2025-06-05T18:45:00', 'Cancelled', 'Website', 'Customer cancelled before payment'),
            ('emily.nguyen@example.com', '2025-06-08T11:10:00', 'Delivered', 'Retail Store', NULL),
            ('sarah.miller@example.com', '2025-06-11T16:30:00', 'Delivered', 'Website', NULL),
            ('jason.lee@example.com', '2025-06-13T10:05:00', 'Shipped', 'Marketplace', NULL),
            ('fatima.ali@example.com', '2025-06-15T19:25:00', 'Returned', 'Website', NULL),
            ('chris.taylor@example.com', '2025-06-18T08:50:00', 'Delivered', 'Mobile App', NULL),
            ('hannah.wilson@example.com', '2025-06-21T13:40:00', 'Delivered', 'Website', NULL),
            ('omar.hassan@example.com', '2025-06-23T17:55:00', 'Pending', 'Phone', 'Awaiting payment confirmation'),

            ('daniel.brooks@example.com', '2025-07-02T12:35:00', 'Delivered', 'Website', NULL),
            ('emily.nguyen@example.com', '2025-07-04T15:15:00', 'Delivered', 'Mobile App', NULL),
            ('sarah.miller@example.com', '2025-07-07T09:30:00', 'Delivered', 'Website', NULL),
            ('hannah.wilson@example.com', '2025-07-09T20:10:00', 'Delivered', 'Retail Store', NULL),
            ('priya.kapoor@example.com', '2025-07-12T10:45:00', 'Returned', 'Website', NULL)
    ) AS v (
        Email,
        OrderDateText,
        OrderStatus,
        SalesChannel,
        CustomerNote
    )
    JOIN sales.Customer AS c
        ON c.Email = v.Email;

END;
GO


/* ============================================================
   2. Confirmation queries
   ============================================================ */

-- Show orders with customer names.
SELECT
    o.OrderID,
    c.FirstName,
    c.LastName,
    c.Email,
    o.OrderDate,
    o.OrderStatus,
    o.SalesChannel,
    o.CustomerNote
FROM sales.[Order] AS o
JOIN sales.Customer AS c
    ON c.CustomerID = o.CustomerID
ORDER BY o.OrderID;
GO

-- Count how many orders exist.
SELECT COUNT(*) AS OrderCount
FROM sales.[Order];
GO