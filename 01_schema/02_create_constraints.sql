/*
    02_create_constraints.sql

    Purpose:
    Add rules to the empty tables created in 01_create_tables.sql.

    This file adds:
    - Primary keys
    - Unique constraints
    - Foreign keys
    - Default constraints
    - CHECK constraints
*/

USE RetailOpsPractice;
GO


/* ============================================================
   1. Primary keys
   ============================================================ */

-- Primary keys uniquely identify each row in a table.

ALTER TABLE product.Category
ADD CONSTRAINT PK_Category
PRIMARY KEY (CategoryID);
GO

ALTER TABLE product.Supplier
ADD CONSTRAINT PK_Supplier
PRIMARY KEY (SupplierID);
GO

ALTER TABLE product.Product
ADD CONSTRAINT PK_Product
PRIMARY KEY (ProductID);
GO

ALTER TABLE sales.Customer
ADD CONSTRAINT PK_Customer
PRIMARY KEY (CustomerID);
GO

ALTER TABLE sales.[Order]
ADD CONSTRAINT PK_Order
PRIMARY KEY (OrderID);
GO

ALTER TABLE sales.OrderItem
ADD CONSTRAINT PK_OrderItem
PRIMARY KEY (OrderItemID);
GO


/* ============================================================
   2. Unique constraints
   ============================================================ */

-- Unique constraints prevent duplicate business values.

-- No two categories should have the same name.
ALTER TABLE product.Category
ADD CONSTRAINT UQ_Category_CategoryName
UNIQUE (CategoryName);
GO

-- No two suppliers should have the same name.
ALTER TABLE product.Supplier
ADD CONSTRAINT UQ_Supplier_SupplierName
UNIQUE (SupplierName);
GO

-- No two products should have the same SKU.
ALTER TABLE product.Product
ADD CONSTRAINT UQ_Product_SKU
UNIQUE (SKU);
GO

-- No two customers should have the same email address.
ALTER TABLE sales.Customer
ADD CONSTRAINT UQ_Customer_Email
UNIQUE (Email);
GO


/* ============================================================
   3. Default constraints
   ============================================================ */

-- Default constraints provide automatic values when INSERT statements
-- do not explicitly provide a value.

-- New suppliers are not preferred unless specified.
ALTER TABLE product.Supplier
ADD CONSTRAINT DF_Supplier_IsPreferred
DEFAULT 0 FOR IsPreferred;
GO

-- New products are active unless specified.
ALTER TABLE product.Product
ADD CONSTRAINT DF_Product_IsActive
DEFAULT 1 FOR IsActive;
GO

-- New customers start at Bronze unless specified.
ALTER TABLE sales.Customer
ADD CONSTRAINT DF_Customer_LoyaltyTier
DEFAULT 'Bronze' FOR LoyaltyTier;
GO

-- New customers are not opted into marketing unless specified.
ALTER TABLE sales.Customer
ADD CONSTRAINT DF_Customer_MarketingOptIn
DEFAULT 0 FOR MarketingOptIn;
GO

-- Order-item discounts default to zero.
ALTER TABLE sales.OrderItem
ADD CONSTRAINT DF_OrderItem_DiscountAmount
DEFAULT 0 FOR DiscountAmount;
GO


/* ============================================================
   4. CHECK constraints
   ============================================================ */

-- CHECK constraints restrict what values are allowed.

-- Supplier lead time must be realistic.
ALTER TABLE product.Supplier
ADD CONSTRAINT CK_Supplier_LeadTimeDays
CHECK (LeadTimeDays BETWEEN 1 AND 90);
GO

-- Product prices and costs cannot be negative.
ALTER TABLE product.Product
ADD CONSTRAINT CK_Product_UnitPrice
CHECK (UnitPrice >= 0);
GO

ALTER TABLE product.Product
ADD CONSTRAINT CK_Product_StandardCost
CHECK (StandardCost >= 0);
GO

-- Standard cost should not be higher than selling price.
ALTER TABLE product.Product
ADD CONSTRAINT CK_Product_CostNotAbovePrice
CHECK (StandardCost <= UnitPrice);
GO

-- LoyaltyTier must be one of these valid values.
ALTER TABLE sales.Customer
ADD CONSTRAINT CK_Customer_LoyaltyTier
CHECK (LoyaltyTier IN ('Bronze', 'Silver', 'Gold', 'Platinum'));
GO

-- OrderStatus must be one of these valid values.
ALTER TABLE sales.[Order]
ADD CONSTRAINT CK_Order_OrderStatus
CHECK (OrderStatus IN ('Pending', 'Paid', 'Shipped', 'Delivered', 'Cancelled', 'Returned'));
GO

-- SalesChannel must be one of these valid values.
ALTER TABLE sales.[Order]
ADD CONSTRAINT CK_Order_SalesChannel
CHECK (SalesChannel IN ('Website', 'Mobile App', 'Marketplace', 'Retail Store', 'Phone'));
GO

-- Quantity must be positive.
ALTER TABLE sales.OrderItem
ADD CONSTRAINT CK_OrderItem_Quantity
CHECK (Quantity > 0);
GO

-- Unit price cannot be negative.
ALTER TABLE sales.OrderItem
ADD CONSTRAINT CK_OrderItem_UnitPrice
CHECK (UnitPrice >= 0);
GO

-- Discount cannot be negative.
ALTER TABLE sales.OrderItem
ADD CONSTRAINT CK_OrderItem_DiscountAmount
CHECK (DiscountAmount >= 0);
GO

-- Discount cannot exceed the original line price.
ALTER TABLE sales.OrderItem
ADD CONSTRAINT CK_OrderItem_DiscountNotAboveLine
CHECK (DiscountAmount <= Quantity * UnitPrice);
GO


/* ============================================================
   5. Foreign keys
   ============================================================ */

-- Foreign keys connect tables together.

-- A category may have a parent category.
-- Example:
-- Electronics
--     Audio
ALTER TABLE product.Category
ADD CONSTRAINT FK_Category_ParentCategory
FOREIGN KEY (ParentCategoryID)
REFERENCES product.Category(CategoryID);
GO

-- Each product belongs to one category.
ALTER TABLE product.Product
ADD CONSTRAINT FK_Product_Category
FOREIGN KEY (CategoryID)
REFERENCES product.Category(CategoryID);
GO

-- Each product comes from one supplier.
ALTER TABLE product.Product
ADD CONSTRAINT FK_Product_Supplier
FOREIGN KEY (SupplierID)
REFERENCES product.Supplier(SupplierID);
GO

-- Each order belongs to one customer.
ALTER TABLE sales.[Order]
ADD CONSTRAINT FK_Order_Customer
FOREIGN KEY (CustomerID)
REFERENCES sales.Customer(CustomerID);
GO

-- Each order item belongs to one order.
ALTER TABLE sales.OrderItem
ADD CONSTRAINT FK_OrderItem_Order
FOREIGN KEY (OrderID)
REFERENCES sales.[Order](OrderID);
GO

-- Each order item refers to one product.
ALTER TABLE sales.OrderItem
ADD CONSTRAINT FK_OrderItem_Product
FOREIGN KEY (ProductID)
REFERENCES product.Product(ProductID);
GO


/* ============================================================
   6. Confirmation query
   ============================================================ */

-- Show the constraints that now exist in the database.

SELECT
    s.name AS SchemaName,
    t.name AS TableName,
    o.name AS ConstraintName,
    o.type_desc AS ConstraintType
FROM sys.objects AS o
JOIN sys.tables AS t
    ON t.object_id = o.parent_object_id
JOIN sys.schemas AS s
    ON s.schema_id = t.schema_id
WHERE o.type IN ('PK', 'UQ', 'F', 'C', 'D')
  AND s.name IN ('product', 'sales')
ORDER BY
    s.name,
    t.name,
    o.type_desc,
    o.name;
GO