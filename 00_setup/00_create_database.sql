/*
00_create_database.sql

Purpose:
Create the RetailOpsPractice database if it does not already exist.

Run this first.
*/

USE master;
GO

IF DB_ID(N'RetailOpsPractice') IS NULL
BEGIN
	CREATE DATABASE RetailOpsPractice;
END;
GO

SELECT
	name AS DatabaseName,
	create_date AS CreatedAt
FROM sys.databases
WHERE name = N'RetailOpsPractice';
GO
