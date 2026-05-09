# SQL Server RetailOps Practice

A beginner-to-advanced SQL Server practice project using a fictional retail/e-commerce operations database.

The goal of this project is to learn SQL Server from the ground up, including:

- Database creation
- Schemas
- Tables
- Constraints
- Indexes
- Seed data
- SELECT queries
- Joins
- Aggregation
- CTEs
- Window functions
- Business-style analytics queries

## Domain

This project uses a fictional retail operations database.

Main entities:

- Customers
- Products
- Categories
- Suppliers
- Orders
- Order items

## Folder Structure

```text
sql-server-retailops-practice/
│
├── README.md
├── .gitignore
│
├── 00_setup/
│   ├── 00_create_database.sql
│   └── 01_use_database_check.sql
│
├── 01_schema/
│   ├── 01_create_tables.sql
│   ├── 02_create_constraints.sql
│   └── 03_create_indexes.sql
│
├── 02_seed_data/
│   ├── 01_insert_customers.sql
│   ├── 02_insert_products.sql
│   ├── 03_insert_orders.sql
│   └── 04_insert_order_items.sql
│
├── 03_practice_questions/
│   ├── beginner.sql
│   ├── intermediate.sql
│   └── advanced.sql
│
├── 04_solutions/
│   ├── beginner_solutions.sql
│   ├── intermediate_solutions.sql
│   └── advanced_solutions.sql
│
└── 99_reset/
    ├── drop_database.sql
    └── reset_database.sql