/*
    reset_database.sql

    Purpose:
    Drop and recreate the RetailOpsPractice database.

    Warning:
    This deletes all existing data and gives you a clean database again.

    After running this file, you still need to rerun:
    - 01_schema/01_create_tables.sql
    - 01_schema/02_create_constraints.sql
    - 01_schema/03_create_indexes.sql
    - 02_seed_data/01_insert_customers.sql
    - 02_seed_data/02_insert_products.sql
    - 02_seed_data/03_insert_orders.sql
    - 02_seed_data/04_insert_order_items.sql
*/

USE master;
GO

IF DB_ID(N'RetailOpsPractice') IS NOT NULL
BEGIN
    -- Force-close active connections to the database.
    ALTER DATABASE RetailOpsPractice
    SET SINGLE_USER
    WITH ROLLBACK IMMEDIATE;

    -- Delete the database.
    DROP DATABASE RetailOpsPractice;
END;
GO

-- Recreate the database.
CREATE DATABASE RetailOpsPractice;
GO

-- Switch into the recreated database.
USE RetailOpsPractice;
GO

-- Confirm that we are inside the correct database.
SELECT DB_NAME() AS CurrentDatabase;
GO