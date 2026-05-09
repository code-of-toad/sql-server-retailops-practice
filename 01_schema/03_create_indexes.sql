/*
    03_create_indexes.sql

    Purpose:
    Add helpful nonclustered indexes to common lookup/filter columns.

    Important:
    - Primary keys already create indexes automatically.
    - Unique constraints already create indexes automatically.
    - This file adds extra indexes for common query patterns.
*/

USE RetailOpsPractice;
GO


/* ============================================================
   1. Product indexes
   ============================================================ */

-- Helps queries that join/filter products by category.
-- Example:
-- SELECT * FROM product.Product WHERE CategoryID = 1;
IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_Product_CategoryID'
      AND object_id = OBJECT_ID(N'product.Product')
)
BEGIN
    CREATE INDEX IX_Product_CategoryID
    ON product.Product (CategoryID);
END;
GO

-- Helps queries that join/filter products by supplier.
IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_Product_SupplierID'
      AND object_id = OBJECT_ID(N'product.Product')
)
BEGIN
    CREATE INDEX IX_Product_SupplierID
    ON product.Product (SupplierID);
END;
GO

-- Helps queries that filter active products and sort/filter by launch date.
IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_Product_IsActive_LaunchDate'
      AND object_id = OBJECT_ID(N'product.Product')
)
BEGIN
    CREATE INDEX IX_Product_IsActive_LaunchDate
    ON product.Product (IsActive, LaunchDate);
END;
GO


/* ============================================================
   2. Customer indexes
   ============================================================ */

-- Helps queries that group/filter customers by loyalty tier.
-- Example:
-- SELECT LoyaltyTier, COUNT(*) FROM sales.Customer GROUP BY LoyaltyTier;
IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_Customer_LoyaltyTier'
      AND object_id = OBJECT_ID(N'sales.Customer')
)
BEGIN
    CREATE INDEX IX_Customer_LoyaltyTier
    ON sales.Customer (LoyaltyTier);
END;
GO

-- Helps queries that filter customers by signup date.
IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_Customer_SignupDate'
      AND object_id = OBJECT_ID(N'sales.Customer')
)
BEGIN
    CREATE INDEX IX_Customer_SignupDate
    ON sales.Customer (SignupDate);
END;
GO


/* ============================================================
   3. Order indexes
   ============================================================ */

-- Helps queries that find all orders for a customer.
-- Also useful for sorting each customer's orders by date.
--
-- Example:
-- SELECT *
-- FROM sales.[Order]
-- WHERE CustomerID = 5
-- ORDER BY OrderDate DESC;
IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_Order_CustomerID_OrderDate'
      AND object_id = OBJECT_ID(N'sales.[Order]')
)
BEGIN
    CREATE INDEX IX_Order_CustomerID_OrderDate
    ON sales.[Order] (CustomerID, OrderDate DESC);
END;
GO

-- Helps queries that filter by order date and status.
--
-- Example:
-- SELECT *
-- FROM sales.[Order]
-- WHERE OrderDate >= '2025-01-01'
--   AND OrderStatus = 'Delivered';
IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_Order_OrderDate_OrderStatus'
      AND object_id = OBJECT_ID(N'sales.[Order]')
)
BEGIN
    CREATE INDEX IX_Order_OrderDate_OrderStatus
    ON sales.[Order] (OrderDate, OrderStatus);
END;
GO

-- Helps queries that group/filter orders by sales channel.
IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_Order_SalesChannel'
      AND object_id = OBJECT_ID(N'sales.[Order]')
)
BEGIN
    CREATE INDEX IX_Order_SalesChannel
    ON sales.[Order] (SalesChannel);
END;
GO


/* ============================================================
   4. Order item indexes
   ============================================================ */

-- Helps queries that find all line items for one order.
--
-- Example:
-- SELECT *
-- FROM sales.OrderItem
-- WHERE OrderID = 10;
IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_OrderItem_OrderID'
      AND object_id = OBJECT_ID(N'sales.OrderItem')
)
BEGIN
    CREATE INDEX IX_OrderItem_OrderID
    ON sales.OrderItem (OrderID);
END;
GO

-- Helps queries that analyze sales by product.
--
-- Example:
-- SELECT ProductID, SUM(Quantity)
-- FROM sales.OrderItem
-- GROUP BY ProductID;
IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_OrderItem_ProductID'
      AND object_id = OBJECT_ID(N'sales.OrderItem')
)
BEGIN
    CREATE INDEX IX_OrderItem_ProductID
    ON sales.OrderItem (ProductID);
END;
GO

-- Helps revenue calculations by order.
-- INCLUDE stores extra columns at the leaf level of the index.
-- These columns are not part of the search key, but SQL Server can read them
-- directly from the index without going back to the full table.
IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes
    WHERE name = 'IX_OrderItem_OrderID_IncludeFinancials'
      AND object_id = OBJECT_ID(N'sales.OrderItem')
)
BEGIN
    CREATE INDEX IX_OrderItem_OrderID_IncludeFinancials
    ON sales.OrderItem (OrderID)
    INCLUDE (Quantity, UnitPrice, DiscountAmount);
END;
GO


/* ============================================================
   5. Confirmation query
   ============================================================ */

-- Show indexes created on our practice tables.
SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    i.name AS IndexName,
    i.type_desc AS IndexType,
    i.is_unique AS IsUnique
FROM sys.indexes AS i
JOIN sys.tables AS t
    ON t.object_id = i.object_id
JOIN sys.schemas AS s
    ON s.schema_id = t.schema_id
WHERE s.name IN ('product', 'sales')
  AND i.name IS NOT NULL
ORDER BY
    s.name,
    t.name,
    i.name;
GO