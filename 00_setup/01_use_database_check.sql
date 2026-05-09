/*
01_use_database_check.sql

Purpose:
Switch into RetailOpsPractice and confirm that future scripts
are running against the correct database.
*/

USE RetailOpsPractice;
GO

SELECT DB_NAME() AS CurrentDatabase;
GO
