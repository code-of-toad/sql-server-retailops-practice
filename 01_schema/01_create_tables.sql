/*
01_create_tables.sqp

Purpose:
Create schemas and empty tables for RetailOpsPractice.

This file creates table structure only.
Primary kets, foreign keys, checks, defaults, and indexes
will be added in later files.
*/

USE RetailOpsPractice;
GO

/* ============================================================
   1. Create schemas
   ============================================================ */

-- A schema is like a logical folder/namespace inside a database.
-- E.g., sales.Customer means: schema = sales
--                             table  = Customer

-- Create the sales schema only if it DNE already.
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'sales')
	EXEC('CREATE SCHEMA sales');
GO

-- Create the product schema only it DNE already.
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'product')
	EXEC('CREATE SCHEMA product');
GO

/* ============================================================
   2. Product tables
   ============================================================ */

-- Category stores product categories.
-- Example categories: Audio, Fitness, Kitchen, Computer Accessories.
CREATE TABLE product.Category (
	-- IDENTITY(1,1) means SQL Server auto-generates the number.
	-- It starts at 1 and increase by 1 for each new row.
	CategoryID       INT IDENTITY(1,1) NOT NULL,
	-- Stores the human-readable category name.
	CategoryName     VARCHAR(100)      NOT NULL,
	-- Allows categories to be nested.
	-- Example: Electronics could be parent of Audio.
	--          This is nullable because top-level categories have no parent.
	ParentCategoryID INT                   NULL
);
GO

-- Supplier stores companies that provide products.
CREATE TABLE product.Supplier (
	SupplierID   INT IDENTITY(1,1) NOT NULL,
	SupplierName VARCHAR(120)      NOT NULL,
	Country      VARCHAR(80)       NOT NULL,
	-- Estimated number of days it takes the supplier to deliver inventory.
	LeadTimeDays INT               NOT NULL,
	-- bit stores 0 or 1.
	-- 0=false, 1=true.
	-- Here, it means whether this upplier is preferred.
	IsPreferred  BIT               NOT NULL
);
GO

-- Product stores individual products being sold.
CREATE TABLE product.Product (
	ProductID INT IDENTITY(1,1) NOT NULL,
	-- SKU = Stock Keeping Unit. This is a business-facing product code.
	SKU          VARCHAR(40)    NOT NULL,
	ProductName  VARCHAR(160)   NOT NULL,
	CategoryID   INT            NOT NULL,
	SupplierID   INT            NOT NULL,
	-- Selling price charged to the customer.
	UnitPrice    DECIMAL(10,2)  NOT NULL,
	-- Internal cost to the business.
	StandardCost DECIMAL(10,2)  NOT NULL,
	-- Date the product launched.
	LaunchDate   DATE           NOT NULL,
	-- 1=active, 0=inactive.
	IsActive     BIT            NOT NULL

);
GO

/* ============================================================
   3. Sales tables
   ============================================================ */

-- Customer stores people who buy from the store.
CREATE TABLE sales.Customer (
	CustomerID     INT IDENTITY(1,1) NOT NULL,
	FirstName      VARCHAR(60)       NOT NULL,
	LastName       VARCHAR(60)       NOT NULL,
	Email          VARCHAR(160)      NOT NULL,
	-- Nullable, since not every customer provides one.
	Phone          VARCHAR(40)           NULL,
	SignupDate     DATE              NOT NULL,
	-- Loyalty tier: Bronze, Silver, Gold, Platinum.
	LoyaltyTier    VARCHAR(20)       NOT NULL,
	MarketingOptin BIT               NOT NULL,
);
GO

-- Order stores one purchase transaction/header.
-- It represents the overall order, not the individual products inside it.
--
-- NOTE: Square brackets are used because ORDER is a SQL keyword!!!!!
--       I.e., sales.[Order] instead of sales.Order
CREATE TABLE sales.[Order](
	OrderID      INT IDENTITY(1,1) NOT NULL,
	CustomerID   INT               NOT NULL,
	-- datetime2(0) stores date/time with 0 fractional seconds.
	OrderDate    datetime2(0)      NOT NULL,
	-- Order status: Pending, Paid, Shipped, Delivered, Cancelled.
	OrderStatus  VARCHAR(20)       NOT NULL,
	-- Where the sale happened.
	-- Example: Website, Mobile App, Retail Store.
	SalesChannel VARCHAR(30)       NOT NULL,
	-- Optional note from the customer.
	CustomerNote VARCHAR(300)          NULL,
);
GO

-- OrderItem stores the individual products inside an order.
--
-- Example:
-- One order can contain:
--   1 keyboard
--   2 speakers
--   1 mouse
--
-- That would be one row in sales.[Order],
-- but three rows in sales.OrderItem.
CREATE TABLE sales.OrderItem (
    OrderItemID    INT IDENTITY(1,1) NOT NULL,
    OrderID        INT               NOT NULL,
    ProductID      INT               NOT NULL,
    -- Number of units purchased.
    Quantity       INT               NOT NULL,
    -- Product price at the time of purchase.
    -- We store it here because product prices can change later.
    UnitPrice      DECIMAL(10,2)     NOT NULL,
    -- Discount applied to this line item.
    DiscountAmount DECIMAL(10,2)     NOT NULL
);
GO

/* ============================================================
   4. Confirmation query
   ============================================================ */

-- This query checks which tables were created.
-- sys.tables  = a SQL Server system view containing database tables.
-- sys.schemas = a SQL Server system view containing schemas.
SELECT 
    -- Show the schema name, such as sales or product.
    s.name AS SchemaName,
    -- Show the table name, such as Customer or Product.
    t.name AS TableName,
    -- Show when the table was created.
    t.create_date AS CreatedAt
FROM sys.tables AS t
-- Join each table to its schema so we can display the schema name.
JOIN sys.schemas AS s
    ON s.schema_id = t.schema_id
-- Only show tables from the schemas we created in this script.
WHERE s.name IN ('sales', 'product')
-- Sort the output neatly.
ORDER BY 
    s.name,
    t.name;
GO
