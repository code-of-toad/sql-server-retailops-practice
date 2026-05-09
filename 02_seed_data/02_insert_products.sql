/*
    02_insert_products.sql

    Purpose:
    Insert sample product-related data.

    This file inserts data into:
    - product.Category
    - product.Supplier
    - product.Product

    Run this after:
    - 01_create_tables.sql
    - 02_create_constraints.sql
*/

USE RetailOpsPractice;
GO


/* ============================================================
   1. Insert categories
   ============================================================ */

-- Only insert categories if the table is empty.
IF NOT EXISTS (
    SELECT 1
    FROM product.Category
)
BEGIN

    -- First insert top-level categories.
    -- These have no parent category, so ParentCategoryID is NULL.
    INSERT INTO product.Category (
        CategoryName,
        ParentCategoryID
    )
    VALUES
        ('Electronics', NULL),
        ('Home Office', NULL),
        ('Kitchen', NULL),
        ('Fitness', NULL);

    -- Now insert child categories.
    -- Instead of hard-coding ParentCategoryID values like 1, 2, 3,
    -- we look up the parent category by name.
    INSERT INTO product.Category (
        CategoryName,
        ParentCategoryID
    )
    SELECT
        'Audio',
        CategoryID
    FROM product.Category
    WHERE CategoryName = 'Electronics';

    INSERT INTO product.Category (
        CategoryName,
        ParentCategoryID
    )
    SELECT
        'Computer Accessories',
        CategoryID
    FROM product.Category
    WHERE CategoryName = 'Electronics';

    INSERT INTO product.Category (
        CategoryName,
        ParentCategoryID
    )
    SELECT
        'Desk Accessories',
        CategoryID
    FROM product.Category
    WHERE CategoryName = 'Home Office';

    INSERT INTO product.Category (
        CategoryName,
        ParentCategoryID
    )
    SELECT
        'Small Appliances',
        CategoryID
    FROM product.Category
    WHERE CategoryName = 'Kitchen';

    INSERT INTO product.Category (
        CategoryName,
        ParentCategoryID
    )
    SELECT
        'Workout Gear',
        CategoryID
    FROM product.Category
    WHERE CategoryName = 'Fitness';

END;
GO


/* ============================================================
   2. Insert suppliers
   ============================================================ */

-- Only insert suppliers if the table is empty.
IF NOT EXISTS (
    SELECT 1
    FROM product.Supplier
)
BEGIN

    INSERT INTO product.Supplier (
        SupplierName,
        Country,
        LeadTimeDays,
        IsPreferred
    )
    VALUES
        ('Northline Components', 'Canada', 8, 1),
        ('Summit Home Goods', 'United States', 12, 1),
        ('BluePeak Imports', 'Japan', 21, 0),
        ('Atlas Audio Manufacturing', 'South Korea', 18, 1),
        ('Evergreen Fitness Supply', 'Canada', 10, 0),
        ('Nova Desk Systems', 'Germany', 24, 1);

END;
GO


/* ============================================================
   3. Insert products
   ============================================================ */

-- Only insert products if the table is empty.
IF NOT EXISTS (
    SELECT 1
    FROM product.Product
)
BEGIN

    /*
        Instead of hard-coding CategoryID and SupplierID,
        each product row looks up the correct CategoryID and SupplierID
        using category and supplier names.

        This makes the script safer and easier to understand.
    */

    INSERT INTO product.Product (
        SKU,
        ProductName,
        CategoryID,
        SupplierID,
        UnitPrice,
        StandardCost,
        LaunchDate,
        IsActive
    )
    SELECT
        'AUD-1001',
        'Wireless Studio Headphones',
        c.CategoryID,
        s.SupplierID,
        149.99,
        82.00,
        '2025-01-15',
        1
    FROM product.Category AS c
    JOIN product.Supplier AS s
        ON s.SupplierName = 'Atlas Audio Manufacturing'
    WHERE c.CategoryName = 'Audio';

    INSERT INTO product.Product (
        SKU,
        ProductName,
        CategoryID,
        SupplierID,
        UnitPrice,
        StandardCost,
        LaunchDate,
        IsActive
    )
    SELECT
        'AUD-1002',
        'Portable Bluetooth Speaker',
        c.CategoryID,
        s.SupplierID,
        89.99,
        47.50,
        '2025-02-10',
        1
    FROM product.Category AS c
    JOIN product.Supplier AS s
        ON s.SupplierName = 'Atlas Audio Manufacturing'
    WHERE c.CategoryName = 'Audio';

    INSERT INTO product.Product (
        SKU,
        ProductName,
        CategoryID,
        SupplierID,
        UnitPrice,
        StandardCost,
        LaunchDate,
        IsActive
    )
    SELECT
        'CMP-2001',
        'Mechanical Keyboard',
        c.CategoryID,
        s.SupplierID,
        129.99,
        69.00,
        '2025-01-20',
        1
    FROM product.Category AS c
    JOIN product.Supplier AS s
        ON s.SupplierName = 'Northline Components'
    WHERE c.CategoryName = 'Computer Accessories';

    INSERT INTO product.Product (
        SKU,
        ProductName,
        CategoryID,
        SupplierID,
        UnitPrice,
        StandardCost,
        LaunchDate,
        IsActive
    )
    SELECT
        'CMP-2002',
        'Wireless Ergonomic Mouse',
        c.CategoryID,
        s.SupplierID,
        59.99,
        28.00,
        '2025-01-25',
        1
    FROM product.Category AS c
    JOIN product.Supplier AS s
        ON s.SupplierName = 'Northline Components'
    WHERE c.CategoryName = 'Computer Accessories';

    INSERT INTO product.Product (
        SKU,
        ProductName,
        CategoryID,
        SupplierID,
        UnitPrice,
        StandardCost,
        LaunchDate,
        IsActive
    )
    SELECT
        'OFF-3001',
        'Adjustable Laptop Stand',
        c.CategoryID,
        s.SupplierID,
        74.99,
        36.00,
        '2025-03-02',
        1
    FROM product.Category AS c
    JOIN product.Supplier AS s
        ON s.SupplierName = 'Nova Desk Systems'
    WHERE c.CategoryName = 'Desk Accessories';

    INSERT INTO product.Product (
        SKU,
        ProductName,
        CategoryID,
        SupplierID,
        UnitPrice,
        StandardCost,
        LaunchDate,
        IsActive
    )
    SELECT
        'OFF-3002',
        'LED Desk Lamp',
        c.CategoryID,
        s.SupplierID,
        44.99,
        21.00,
        '2025-03-12',
        1
    FROM product.Category AS c
    JOIN product.Supplier AS s
        ON s.SupplierName = 'Nova Desk Systems'
    WHERE c.CategoryName = 'Desk Accessories';

    INSERT INTO product.Product (
        SKU,
        ProductName,
        CategoryID,
        SupplierID,
        UnitPrice,
        StandardCost,
        LaunchDate,
        IsActive
    )
    SELECT
        'KIT-4001',
        'Smart Coffee Grinder',
        c.CategoryID,
        s.SupplierID,
        139.99,
        79.00,
        '2025-04-09',
        1
    FROM product.Category AS c
    JOIN product.Supplier AS s
        ON s.SupplierName = 'Summit Home Goods'
    WHERE c.CategoryName = 'Small Appliances';

    INSERT INTO product.Product (
        SKU,
        ProductName,
        CategoryID,
        SupplierID,
        UnitPrice,
        StandardCost,
        LaunchDate,
        IsActive
    )
    SELECT
        'KIT-4002',
        'Compact Air Fryer',
        c.CategoryID,
        s.SupplierID,
        99.99,
        55.00,
        '2025-04-20',
        1
    FROM product.Category AS c
    JOIN product.Supplier AS s
        ON s.SupplierName = 'Summit Home Goods'
    WHERE c.CategoryName = 'Small Appliances';

    INSERT INTO product.Product (
        SKU,
        ProductName,
        CategoryID,
        SupplierID,
        UnitPrice,
        StandardCost,
        LaunchDate,
        IsActive
    )
    SELECT
        'FIT-5001',
        'Adjustable Dumbbell Pair',
        c.CategoryID,
        s.SupplierID,
        249.99,
        151.00,
        '2025-05-12',
        1
    FROM product.Category AS c
    JOIN product.Supplier AS s
        ON s.SupplierName = 'Evergreen Fitness Supply'
    WHERE c.CategoryName = 'Workout Gear';

    INSERT INTO product.Product (
        SKU,
        ProductName,
        CategoryID,
        SupplierID,
        UnitPrice,
        StandardCost,
        LaunchDate,
        IsActive
    )
    SELECT
        'FIT-5002',
        'Yoga Mat Pro',
        c.CategoryID,
        s.SupplierID,
        49.99,
        18.50,
        '2025-05-18',
        1
    FROM product.Category AS c
    JOIN product.Supplier AS s
        ON s.SupplierName = 'Evergreen Fitness Supply'
    WHERE c.CategoryName = 'Workout Gear';

END;
GO


/* ============================================================
   4. Confirmation queries
   ============================================================ */

-- Show categories.
SELECT
    CategoryID,
    CategoryName,
    ParentCategoryID
FROM product.Category
ORDER BY CategoryID;
GO

-- Show suppliers.
SELECT
    SupplierID,
    SupplierName,
    Country,
    LeadTimeDays,
    IsPreferred
FROM product.Supplier
ORDER BY SupplierID;
GO

-- Show products with their category and supplier names.
SELECT
    p.ProductID,
    p.SKU,
    p.ProductName,
    c.CategoryName,
    s.SupplierName,
    p.UnitPrice,
    p.StandardCost,
    p.LaunchDate,
    p.IsActive
FROM product.Product AS p
JOIN product.Category AS c
    ON c.CategoryID = p.CategoryID
JOIN product.Supplier AS s
    ON s.SupplierID = p.SupplierID
ORDER BY p.ProductID;
GO

-- Count products.
SELECT COUNT(*) AS ProductCount
FROM product.Product;
GO