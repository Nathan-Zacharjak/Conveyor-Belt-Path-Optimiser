-- This script is for first time setup
-- If it has been run before and you need to run it again
-- then run the drop tables and schema script first, followed by this one

-- Create the tables within PathDB
USE [PathDB]
GO

CREATE SCHEMA path;
GO

-- Drop table if it already exists
IF OBJECT_ID('path.Devices', 'U') IS NOT NULL
DROP TABLE path.Devices
GO

--Create table of devices within path schema
CREATE TABLE path.Devices (
	deviceID	INT				IDENTITY(0, 1) PRIMARY KEY, -- identity = auto increment
	deviceName  [NVARCHAR](50)	NOT NULL,
	deviceType	[NVARCHAR](50)	NOT NULL,
	usable		BIT				NOT NULL -- Has to be 1 or 0 -- 1 = usable, 0 = unavaliable
) AS NODE;
GO


-- Drop table if it already exists
IF OBJECT_ID('path.Connections', 'U') IS NOT NULL
DROP TABLE path.Connections
GO

--Create table of connections within path schema
CREATE TABLE path.Connections (
	connectionName	[NVARCHAR](50)	NOT NULL,
) AS EDGE;
GO