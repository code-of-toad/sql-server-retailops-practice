/*
    04_insert_order_items.sql

    Purpose:
    Insert sample order-item data into sales.OrderItem.

    Important:
    sales.[Order] stores the order header.
    sales.OrderItem stores the products inside each order.

    Example:
    One row in sales.[Order]:
        OrderID = 1

    Multiple rows in sales.OrderItem:
        OrderID = 1, Product = Headphones
        OrderID = 1, Product = Mouse
*/

USE RetailOpsPractice;
GO


/* ============================================================
   1. Insert order items
   ============================================================ */

-- Only insert order items if the table is empty.
-- This prevents duplicate line items if this file is run twice.
IF NOT EXISTS (
    SELECT 1
    FROM sales.OrderItem
)
BEGIN

    /*
        We avoid hard-coding OrderID and ProductID.

        Instead:
        - Customer email + order date identifies the order.
        - SKU identifies the product.

        This is safer because OrderID and ProductID are generated
        automatically by SQL Server.
    */

    INSERT INTO sales.OrderItem (
        OrderID,
        ProductID,
        Quantity,
        UnitPrice,
        DiscountAmount
    )
    SELECT
        o.OrderID,
        p.ProductID,
        v.Quantity,

        -- Store the product price at the time of purchase.
        -- This is copied from product.Product.UnitPrice.
        p.UnitPrice,

        v.DiscountAmount
    FROM (
        VALUES
            -- Daniel's first order
            ('daniel.brooks@example.com', '2025-06-01T09:15:00', 'AUD-1001', 1, 15.00),
            ('daniel.brooks@example.com', '2025-06-01T09:15:00', 'CMP-2002', 1, 0.00),

            -- Priya's first order
            ('priya.kapoor@example.com', '2025-06-03T14:20:00', 'CMP-2001', 1, 0.00),
            ('priya.kapoor@example.com', '2025-06-03T14:20:00', 'OFF-3001', 1, 0.00),

            -- Marcus's cancelled order
            ('marcus.johnson@example.com', '2025-06-05T18:45:00', 'AUD-1002', 1, 0.00),

            -- Emily's first order
            ('emily.nguyen@example.com', '2025-06-08T11:10:00', 'FIT-5001', 1, 25.00),
            ('emily.nguyen@example.com', '2025-06-08T11:10:00', 'FIT-5002', 2, 0.00),

            -- Sarah's first order
            ('sarah.miller@example.com', '2025-06-11T16:30:00', 'KIT-4001', 1, 0.00),

            -- Jason's shipped order
            ('jason.lee@example.com', '2025-06-13T10:05:00', 'OFF-3002', 2, 0.00),
            ('jason.lee@example.com', '2025-06-13T10:05:00', 'CMP-2002', 1, 0.00),

            -- Fatima's returned order
            ('fatima.ali@example.com', '2025-06-15T19:25:00', 'AUD-1002', 1, 10.00),
            ('fatima.ali@example.com', '2025-06-15T19:25:00', 'AUD-1001', 1, 0.00),

            -- Chris's order
            ('chris.taylor@example.com', '2025-06-18T08:50:00', 'FIT-5002', 3, 0.00),

            -- Hannah's first order
            ('hannah.wilson@example.com', '2025-06-21T13:40:00', 'CMP-2001', 1, 13.00),
            ('hannah.wilson@example.com', '2025-06-21T13:40:00', 'CMP-2002', 1, 0.00),

            -- Omar's pending order
            ('omar.hassan@example.com', '2025-06-23T17:55:00', 'KIT-4002', 1, 0.00),

            -- Daniel's second order
            ('daniel.brooks@example.com', '2025-07-02T12:35:00', 'KIT-4001', 1, 20.00),
            ('daniel.brooks@example.com', '2025-07-02T12:35:00', 'OFF-3002', 1, 0.00),

            -- Emily's second order
            ('emily.nguyen@example.com', '2025-07-04T15:15:00', 'AUD-1001', 1, 0.00),
            ('emily.nguyen@example.com', '2025-07-04T15:15:00', 'AUD-1002', 1, 0.00),

            -- Sarah's second order
            ('sarah.miller@example.com', '2025-07-07T09:30:00', 'FIT-5001', 1, 30.00),

            -- Hannah's second order
            ('hannah.wilson@example.com', '2025-07-09T20:10:00', 'OFF-3001', 2, 0.00),
            ('hannah.wilson@example.com', '2025-07-09T20:10:00', 'OFF-3002', 1, 0.00),

            -- Priya's returned order
            ('priya.kapoor@example.com', '2025-07-12T10:45:00', 'KIT-4002', 1, 15.00),
            ('priya.kapoor@example.com', '2025-07-12T10:45:00', 'KIT-4001', 1, 0.00)
    ) AS v (
        Email,
        OrderDateText,
        SKU,
        Quantity,
        DiscountAmount
    )
    JOIN sales.Customer AS c
        ON c.Email = v.Email
    JOIN sales.[Order] AS o
        ON o.CustomerID = c.CustomerID
       AND o.OrderDate = CONVERT(datetime2(0), v.OrderDateText)
    JOIN product.Product AS p
        ON p.SKU = v.SKU;

END;
GO


/* ============================================================
   2. Confirmation queries
   ============================================================ */

-- Show order items with customer and product details.
SELECT
    oi.OrderItemID,
    o.OrderID,
    c.FirstName,
    c.LastName,
    o.OrderDate,
    o.OrderStatus,
    p.SKU,
    p.ProductName,
    oi.Quantity,
    oi.UnitPrice,
    oi.DiscountAmount,

    -- Calculate line total for display.
    -- This is not stored in the table yet.
    (oi.Quantity * oi.UnitPrice) - oi.DiscountAmount AS LineTotal
FROM sales.OrderItem AS oi
JOIN sales.[Order] AS o
    ON o.OrderID = oi.OrderID
JOIN sales.Customer AS c
    ON c.CustomerID = o.CustomerID
JOIN product.Product AS p
    ON p.ProductID = oi.ProductID
ORDER BY
    o.OrderID,
    oi.OrderItemID;
GO

-- Count how many order items exist.
SELECT COUNT(*) AS OrderItemCount
FROM sales.OrderItem;
GO

-- Show total revenue by order.
SELECT
    o.OrderID,
    c.FirstName,
    c.LastName,
    o.OrderDate,
    o.OrderStatus,
    SUM((oi.Quantity * oi.UnitPrice) - oi.DiscountAmount) AS OrderTotal
FROM sales.[Order] AS o
JOIN sales.Customer AS c
    ON c.CustomerID = o.CustomerID
JOIN sales.OrderItem AS oi
    ON oi.OrderID = o.OrderID
GROUP BY
    o.OrderID,
    c.FirstName,
    c.LastName,
    o.OrderDate,
    o.OrderStatus
ORDER BY
    o.OrderID;
GO