
/*
============================================================
              CREATE DATABASE AND SCHEMAS
============================================================

Project Name : Data Warehouse
Database Name: DataWarehouse

PURPOSE:
--------
This script creates a database named 'DataWarehouse'
and three schemas inside it:

1. bronze - Stores raw data from source systems.
2. silver - Stores cleaned and transformed data.
3. gold   - Stores final, business-ready data.

------------------------------------------------------------
IMPORTANT NOTES:
------------------------------------------------------------
1. If the database already exists, it will NOT be recreated.
2. If a schema already exists, it will NOT be recreated.
3. Existing tables and data will NOT be deleted.
4. This script can be executed multiple times safely.

============================================================
*/


-- =========================================================
-- STEP 1: SWITCH TO MASTER DATABASE
-- =========================================================

-- 'master' is a system database in SQL Server.
-- We use it to check whether our DataWarehouse database
-- already exists before attempting to create it.

USE master;
GO


-- =========================================================
-- STEP 2: CREATE DATABASE IF IT DOES NOT EXIST
-- =========================================================

-- sys.databases contains information about databases
-- available in the SQL Server instance.
--
-- IF NOT EXISTS checks whether 'DataWarehouse' is absent.
-- If absent, CREATE DATABASE creates it.
-- If present, nothing happens.

IF NOT EXISTS (
    SELECT 1
    FROM sys.databases
    WHERE name = 'DataWarehouse'
)
BEGIN
    CREATE DATABASE DataWarehouse;
END;
GO


-- =========================================================
-- STEP 3: SWITCH TO DATAWAREHOUSE DATABASE
-- =========================================================

-- All schemas created below will belong to DataWarehouse.

USE DataWarehouse;
GO


-- =========================================================
-- STEP 4: CREATE BRONZE SCHEMA
-- =========================================================

-- Bronze Layer:
-- Stores raw data extracted from source systems.
-- Data is generally kept in its original format.

IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'bronze'
)
BEGIN
    EXEC('CREATE SCHEMA bronze');
END;
GO


-- =========================================================
-- STEP 5: CREATE SILVER SCHEMA
-- =========================================================

-- Silver Layer:
-- Stores cleaned, validated, and transformed data.
-- Examples: removing duplicates and handling NULL values.

IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'silver'
)
BEGIN
    EXEC('CREATE SCHEMA silver');
END;
GO


-- =========================================================
-- STEP 6: CREATE GOLD SCHEMA
-- =========================================================

-- Gold Layer:
-- Stores business-ready data for reporting and analytics.
-- Examples: fact tables, dimension tables, and aggregates.

IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'gold'
)
BEGIN
    EXEC('CREATE SCHEMA gold');
END;
GO


-- =========================================================
-- STEP 7: VERIFY DATABASE AND SCHEMAS
-- =========================================================

-- Display the current database name.

SELECT DB_NAME() AS DatabaseName;

-- Display the three Data Warehouse schemas.
-- If everything worked, bronze, silver, and gold
-- should appear in the result.

SELECT name AS SchemaName
FROM sys.schemas
WHERE name IN ('bronze', 'silver', 'gold')
ORDER BY name;

-- =========================================================
-- END OF SCRIPT
-- =========================================================
