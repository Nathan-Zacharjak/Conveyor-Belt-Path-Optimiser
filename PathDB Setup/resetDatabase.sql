-- A script to quickly reset the entire database

-- Create DB if it does not exist
USE master
GO
IF NOT EXISTS (
   SELECT name
   FROM sys.databases
   WHERE name = N'PathDB'
)
CREATE DATABASE [PathDB]
GO

USE [PathDB]
GO

-- drop tables
DROP TABLE IF EXISTS path.Connections;
DROP TABLE IF EXISTS path.Devices;

-- drop the schema
DROP SCHEMA IF EXISTS path;

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

-- Create table of devices within path schema
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

-- Create table of connections within path schema
CREATE TABLE path.Connections (
	connectionName	[NVARCHAR](50)	NOT NULL,
) AS EDGE;
GO

-- Filler data for pathDB

USE [PathDB]
GO

-- Devices
EXEC insert_device @deviceName = 'CLEAN101', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'CLEAN102', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'CLEAN103', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'CLEAN104', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'PRESSURE106', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'PRESSURE107', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'PRESSURE108', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'CALIBRATE111', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'CONVEYOR1', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'CONVEYOR2', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'WEIGHT2', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'PROCESSOR2', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'CONVEYOR3', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'WEIGHT3', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'PROCESSOR3', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'CONVEYOR4', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'CONVEYOR5', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'CONVEYOR6', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'WEIGHT6', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'DUST6', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'PROCESSOR6', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'CONVEYOR7', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'WEIGHT7', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'DUST7', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'PROCESSOR7', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'CONVEYOR8', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'WEIGHT8', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'CONVEYOR9', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'CONVEYOR10', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'WEIGHT10', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'CONVEYOR11', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'CONVEYOR12', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'WEIGHT12', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'CONVEYOR14', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'WEIGHT14', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'DEST1', @deviceType = 'destination', @usable = 1
EXEC insert_device @deviceName = 'DEST6', @deviceType = 'destination', @usable = 1
EXEC insert_device @deviceName = 'DEST11', @deviceType = 'destination', @usable = 1
EXEC insert_device @deviceName = 'DEST_CLEAN', @deviceType = 'destination', @usable = 1
EXEC insert_device @deviceName = 'DEST4', @deviceType = 'destination', @usable = 1
EXEC insert_device @deviceName = 'DEST5', @deviceType = 'destination', @usable = 1
EXEC insert_device @deviceName = 'DEST14', @deviceType = 'destination', @usable = 1
EXEC insert_device @deviceName = 'DEST_LOAD', @deviceType = 'destination', @usable = 1
EXEC insert_device @deviceName = 'DEST_WEIGH', @deviceType = 'destination', @usable = 1
EXEC insert_device @deviceName = 'LINK1', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'LINK2', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'LINK3', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'LINK4', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'LINK5', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'LINK6', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'LINK7', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'LINK8', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'DIVERTER1', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'DIVERTER2', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'DIVERTER3', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'DIVERTER6', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'DIVERTER7', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'DIVERTER8', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'ELEVATOR_PATH_1', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'ELEVATOR_PATH_2', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'ELEVATOR_PATH_3', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'ELEVATOR_PATH_4', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'ELEVATOR1', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'ELEVATOR_SWICTH_1', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'ELEVATOR2', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'ELEVATOR_SWICTH_2', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'ELEVATOR3', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'ELEVATOR_SWICTH_3', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'ELEVATOR4', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'ELEVATOR_SWICTH_4', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'FLOW5', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'FLOW6', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'FLOW7', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'PRESS1', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'CHUTE1', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'SEPARATOR1', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'SEPARATOR2', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'SEPARATOR3', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'DRIVE1', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'DRIVE2', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'DRIVE3', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'PVC', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'DISTRIBUTOR1', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'DISTRIBUTOR2', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'SCREEN1', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'SCREEN2', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'LOAD1', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'SOURCE_11', @deviceType = 'source', @usable = 1
EXEC insert_device @deviceName = 'SOURCE_1', @deviceType = 'source', @usable = 1
EXEC insert_device @deviceName = 'SOURCE_3', @deviceType = 'source', @usable = 1
EXEC insert_device @deviceName = 'SOURCE_6', @deviceType = 'source', @usable = 1
EXEC insert_device @deviceName = 'SOURCE_7', @deviceType = 'source', @usable = 1
EXEC insert_device @deviceName = 'SOURCE_8', @deviceType = 'source', @usable = 1
EXEC insert_device @deviceName = 'SOURCE_WEIGH', @deviceType = 'source', @usable = 1
EXEC insert_device @deviceName = 'SPLITTER1', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'SPLITTER1A', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'SPLITTER1B', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'SPLITTER2', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'SPLITTER2A', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'SPLITTER2B', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'SPLITTER3', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'SPLITTER3A', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'SPLITTER3B', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'SPLITTER4', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'SPLITTER4A', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'SPLITTER4B', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'SPLITTER5', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'SPLITTER5A', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'TRIPPER1', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'TRIPPER2', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'MAIN_WEIGHTER1', @deviceType = 'process', @usable = 1
EXEC insert_device @deviceName = 'MAIN_WEIGHTER2', @deviceType = 'process', @usable = 1

-- Connections
EXEC insert_connection @fromName = 'ELEVATOR_SWICTH_1', @toName = 'CLEAN101', @connectionName = '0'
EXEC insert_connection @fromName = 'CLEAN101', @toName = 'DISTRIBUTOR1', @connectionName = '1'
EXEC insert_connection @fromName = 'ELEVATOR_SWICTH_2', @toName = 'CLEAN102', @connectionName = '2'
EXEC insert_connection @fromName = 'CLEAN102', @toName = 'DISTRIBUTOR2', @connectionName = '3'
EXEC insert_connection @fromName = 'ELEVATOR_SWICTH_3', @toName = 'CLEAN103', @connectionName = '4'
EXEC insert_connection @fromName = 'CLEAN103', @toName = 'SCREEN2', @connectionName = '5'
EXEC insert_connection @fromName = 'ELEVATOR_SWICTH_4', @toName = 'CLEAN104', @connectionName = '6'
EXEC insert_connection @fromName = 'CLEAN104', @toName = 'DIVERTER3', @connectionName = '7'
EXEC insert_connection @fromName = 'SOURCE_6', @toName = 'PRESSURE106', @connectionName = '8'
EXEC insert_connection @fromName = 'PRESSURE106', @toName = 'CONVEYOR6', @connectionName = '9'
EXEC insert_connection @fromName = 'SOURCE_7', @toName = 'PRESSURE107', @connectionName = '10'
EXEC insert_connection @fromName = 'PRESSURE107', @toName = 'CONVEYOR7', @connectionName = '11'
EXEC insert_connection @fromName = 'SOURCE_8', @toName = 'PRESSURE108', @connectionName = '12'
EXEC insert_connection @fromName = 'PRESSURE108', @toName = 'DIVERTER8', @connectionName = '13'
EXEC insert_connection @fromName = 'FLOW6', @toName = 'CALIBRATE111', @connectionName = '14'
EXEC insert_connection @fromName = 'CALIBRATE111', @toName = 'PVC', @connectionName = '15'
EXEC insert_connection @fromName = 'SOURCE_11', @toName = 'CALIBRATE111', @connectionName = '16'
EXEC insert_connection @fromName = 'SOURCE_1', @toName = 'CONVEYOR1', @connectionName = '17'
EXEC insert_connection @fromName = 'CONVEYOR1', @toName = 'LINK1', @connectionName = '18'
EXEC insert_connection @fromName = 'LINK1', @toName = 'CONVEYOR2', @connectionName = '19'
EXEC insert_connection @fromName = 'CONVEYOR2', @toName = 'WEIGHT2', @connectionName = '20'
EXEC insert_connection @fromName = 'WEIGHT2', @toName = 'SEPARATOR2', @connectionName = '21'
EXEC insert_connection @fromName = 'DRIVE2', @toName = 'PROCESSOR2', @connectionName = '22'
EXEC insert_connection @fromName = 'PROCESSOR2', @toName = 'SPLITTER1', @connectionName = '23'
EXEC insert_connection @fromName = 'LINK2', @toName = 'CONVEYOR3', @connectionName = '24'
EXEC insert_connection @fromName = 'CONVEYOR3', @toName = 'WEIGHT3', @connectionName = '25'
EXEC insert_connection @fromName = 'WEIGHT3', @toName = 'SEPARATOR3', @connectionName = '26'
EXEC insert_connection @fromName = 'SEPARATOR3', @toName = 'PROCESSOR3', @connectionName = '27'
EXEC insert_connection @fromName = 'PROCESSOR3', @toName = 'DIVERTER7', @connectionName = '28'
EXEC insert_connection @fromName = 'DISTRIBUTOR2', @toName = 'CONVEYOR4', @connectionName = '29'
EXEC insert_connection @fromName = 'CONVEYOR4', @toName = 'PRESS1', @connectionName = '30'
EXEC insert_connection @fromName = 'DISTRIBUTOR1', @toName = 'CONVEYOR4', @connectionName = '31'
EXEC insert_connection @fromName = 'DISTRIBUTOR1', @toName = 'CONVEYOR5', @connectionName = '32'
EXEC insert_connection @fromName = 'CONVEYOR5', @toName = 'PRESS1', @connectionName = '33'
EXEC insert_connection @fromName = 'DISTRIBUTOR2', @toName = 'CONVEYOR5', @connectionName = '34'
EXEC insert_connection @fromName = 'CONVEYOR6', @toName = 'WEIGHT6', @connectionName = '35'
EXEC insert_connection @fromName = 'DIVERTER8', @toName = 'CONVEYOR6', @connectionName = '36'
EXEC insert_connection @fromName = 'WEIGHT6', @toName = 'DUST6', @connectionName = '37'
EXEC insert_connection @fromName = 'DUST6', @toName = 'PROCESSOR6', @connectionName = '38'
EXEC insert_connection @fromName = 'PROCESSOR6', @toName = 'DIVERTER1', @connectionName = '39'
EXEC insert_connection @fromName = 'CONVEYOR7', @toName = 'WEIGHT7', @connectionName = '40'
EXEC insert_connection @fromName = 'WEIGHT7', @toName = 'DUST7', @connectionName = '41'
EXEC insert_connection @fromName = 'DUST7', @toName = 'PROCESSOR7', @connectionName = '42'
EXEC insert_connection @fromName = 'PROCESSOR7', @toName = 'DIVERTER2', @connectionName = '43'
EXEC insert_connection @fromName = 'MAIN_WEIGHTER2', @toName = 'CONVEYOR8', @connectionName = '44'
EXEC insert_connection @fromName = 'CONVEYOR8', @toName = 'WEIGHT8', @connectionName = '45'
EXEC insert_connection @fromName = 'WEIGHT8', @toName = 'CONVEYOR9', @connectionName = '46'
EXEC insert_connection @fromName = 'CONVEYOR9', @toName = 'SEPARATOR1', @connectionName = '47'
EXEC insert_connection @fromName = 'DRIVE1', @toName = 'CONVEYOR10', @connectionName = '48'
EXEC insert_connection @fromName = 'CONVEYOR10', @toName = 'WEIGHT10', @connectionName = '49'
EXEC insert_connection @fromName = 'WEIGHT10', @toName = 'CONVEYOR11', @connectionName = '50'
EXEC insert_connection @fromName = 'CONVEYOR11', @toName = 'LINK6', @connectionName = '51'
EXEC insert_connection @fromName = 'LINK8', @toName = 'CONVEYOR12', @connectionName = '52'
EXEC insert_connection @fromName = 'CONVEYOR12', @toName = 'WEIGHT12', @connectionName = '53'
EXEC insert_connection @fromName = 'WEIGHT12', @toName = 'DEST_LOAD', @connectionName = '54'
EXEC insert_connection @fromName = 'DIVERTER8', @toName = 'CONVEYOR14', @connectionName = '55'
EXEC insert_connection @fromName = 'CONVEYOR14', @toName = 'WEIGHT14', @connectionName = '56'
EXEC insert_connection @fromName = 'WEIGHT14', @toName = 'LINK5', @connectionName = '57'
EXEC insert_connection @fromName = 'DISTRIBUTOR2', @toName = 'DEST1', @connectionName = '58'
EXEC insert_connection @fromName = 'DISTRIBUTOR1', @toName = 'DEST1', @connectionName = '59'
EXEC insert_connection @fromName = 'DISTRIBUTOR2', @toName = 'DEST6', @connectionName = '60'
EXEC insert_connection @fromName = 'DISTRIBUTOR1', @toName = 'DEST6', @connectionName = '61'
EXEC insert_connection @fromName = 'PVC', @toName = 'DEST11', @connectionName = '62'
EXEC insert_connection @fromName = 'LINK6', @toName = 'DEST_CLEAN', @connectionName = '63'
EXEC insert_connection @fromName = 'TRIPPER1', @toName = 'DEST4', @connectionName = '64'
EXEC insert_connection @fromName = 'TRIPPER2', @toName = 'DEST5', @connectionName = '65'
EXEC insert_connection @fromName = 'CHUTE1', @toName = 'DEST14', @connectionName = '66'
EXEC insert_connection @fromName = 'SCREEN1', @toName = 'DEST_WEIGH', @connectionName = '67'
EXEC insert_connection @fromName = 'SCREEN2', @toName = 'DEST_WEIGH', @connectionName = '68'
EXEC insert_connection @fromName = 'SOURCE_3', @toName = 'LINK2', @connectionName = '69'
EXEC insert_connection @fromName = 'DIVERTER7', @toName = 'LINK3', @connectionName = '70'
EXEC insert_connection @fromName = 'LINK3', @toName = 'ELEVATOR2', @connectionName = '71'
EXEC insert_connection @fromName = 'LINK3', @toName = 'ELEVATOR1', @connectionName = '72'
EXEC insert_connection @fromName = 'SPLITTER1', @toName = 'LINK3', @connectionName = '73'
EXEC insert_connection @fromName = 'LINK3', @toName = 'SPLITTER1A', @connectionName = '74'
EXEC insert_connection @fromName = 'LINK3', @toName = 'SPLITTER1B', @connectionName = '75'
EXEC insert_connection @fromName = 'DIVERTER3', @toName = 'LINK3', @connectionName = '76'
EXEC insert_connection @fromName = 'SPLITTER2', @toName = 'LINK3', @connectionName = '77'
EXEC insert_connection @fromName = 'LINK3', @toName = 'SPLITTER2A', @connectionName = '78'
EXEC insert_connection @fromName = 'LINK3', @toName = 'SPLITTER2B', @connectionName = '79'
EXEC insert_connection @fromName = 'SPLITTER3', @toName = 'LINK3', @connectionName = '80'
EXEC insert_connection @fromName = 'LINK3', @toName = 'SPLITTER3A', @connectionName = '81'
EXEC insert_connection @fromName = 'LINK3', @toName = 'SPLITTER3B', @connectionName = '82'
EXEC insert_connection @fromName = 'SPLITTER4', @toName = 'LINK4', @connectionName = '83'
EXEC insert_connection @fromName = 'LINK4', @toName = 'SPLITTER4A', @connectionName = '84'
EXEC insert_connection @fromName = 'LINK4', @toName = 'SPLITTER4B', @connectionName = '85'
EXEC insert_connection @fromName = 'SPLITTER5', @toName = 'LINK4', @connectionName = '86'
EXEC insert_connection @fromName = 'LINK4', @toName = 'SPLITTER5A', @connectionName = '87'
EXEC insert_connection @fromName = 'LINK4', @toName = 'SPLITTER3B', @connectionName = '88'
EXEC insert_connection @fromName = 'LINK5', @toName = 'CHUTE1', @connectionName = '89'
EXEC insert_connection @fromName = 'LINK6', @toName = 'LOAD1', @connectionName = '90'
EXEC insert_connection @fromName = 'LOAD1', @toName = 'LINK7', @connectionName = '91'
EXEC insert_connection @fromName = 'LINK7', @toName = 'LINK8', @connectionName = '92'
EXEC insert_connection @fromName = 'DIVERTER1', @toName = 'SPLITTER4', @connectionName = '93'
EXEC insert_connection @fromName = 'DIVERTER1', @toName = 'SPLITTER2', @connectionName = '94'
EXEC insert_connection @fromName = 'DIVERTER2', @toName = 'SPLITTER3', @connectionName = '95'
EXEC insert_connection @fromName = 'DIVERTER2', @toName = 'SPLITTER5', @connectionName = '96'
EXEC insert_connection @fromName = 'DIVERTER3', @toName = 'SCREEN1', @connectionName = '97'
EXEC insert_connection @fromName = 'FLOW5', @toName = 'DIVERTER6', @connectionName = '98'
EXEC insert_connection @fromName = 'DIVERTER6', @toName = 'MAIN_WEIGHTER2', @connectionName = '99'
EXEC insert_connection @fromName = 'ELEVATOR1', @toName = 'ELEVATOR_PATH_1', @connectionName = '100'
EXEC insert_connection @fromName = 'ELEVATOR_PATH_1', @toName = 'ELEVATOR_SWICTH_1', @connectionName = '101'
EXEC insert_connection @fromName = 'ELEVATOR2', @toName = 'ELEVATOR_PATH_2', @connectionName = '102'
EXEC insert_connection @fromName = 'ELEVATOR_PATH_2', @toName = 'ELEVATOR_SWICTH_2', @connectionName = '103'
EXEC insert_connection @fromName = 'ELEVATOR3', @toName = 'ELEVATOR_PATH_3', @connectionName = '104'
EXEC insert_connection @fromName = 'ELEVATOR_PATH_3', @toName = 'ELEVATOR_SWICTH_3', @connectionName = '105'
EXEC insert_connection @fromName = 'ELEVATOR4', @toName = 'ELEVATOR_PATH_4', @connectionName = '106'
EXEC insert_connection @fromName = 'ELEVATOR_PATH_4', @toName = 'ELEVATOR_SWICTH_4', @connectionName = '107'
EXEC insert_connection @fromName = 'SPLITTER1B', @toName = 'ELEVATOR1', @connectionName = '108'
EXEC insert_connection @fromName = 'SPLITTER2A', @toName = 'ELEVATOR1', @connectionName = '109'
EXEC insert_connection @fromName = 'SPLITTER3A', @toName = 'ELEVATOR1', @connectionName = '110'
EXEC insert_connection @fromName = 'SPLITTER1A', @toName = 'ELEVATOR2', @connectionName = '111'
EXEC insert_connection @fromName = 'SPLITTER2B', @toName = 'ELEVATOR2', @connectionName = '112'
EXEC insert_connection @fromName = 'SPLITTER3B', @toName = 'ELEVATOR2', @connectionName = '113'
EXEC insert_connection @fromName = 'SPLITTER4A', @toName = 'ELEVATOR3', @connectionName = '114'
EXEC insert_connection @fromName = 'SPLITTER5A', @toName = 'ELEVATOR3', @connectionName = '115'
EXEC insert_connection @fromName = 'FLOW7', @toName = 'ELEVATOR4', @connectionName = '116'
EXEC insert_connection @fromName = 'SPLITTER4B', @toName = 'ELEVATOR4', @connectionName = '117'
EXEC insert_connection @fromName = 'SPLITTER3B', @toName = 'ELEVATOR4', @connectionName = '118'
EXEC insert_connection @fromName = 'MAIN_WEIGHTER1', @toName = 'FLOW5', @connectionName = '119'
EXEC insert_connection @fromName = 'MAIN_WEIGHTER2', @toName = 'FLOW6', @connectionName = '120'
EXEC insert_connection @fromName = 'PVC', @toName = 'FLOW7', @connectionName = '121'
EXEC insert_connection @fromName = 'PRESS1', @toName = 'TRIPPER2', @connectionName = '122'
EXEC insert_connection @fromName = 'PRESS1', @toName = 'TRIPPER1', @connectionName = '123'
EXEC insert_connection @fromName = 'SEPARATOR1', @toName = 'DRIVE1', @connectionName = '124'
EXEC insert_connection @fromName = 'SEPARATOR2', @toName = 'DRIVE2', @connectionName = '125'
EXEC insert_connection @fromName = 'SEPARATOR3', @toName = 'DRIVE3', @connectionName = '126'
EXEC insert_connection @fromName = 'DRIVE3', @toName = 'PROCESSOR3', @connectionName = '127'
EXEC insert_connection @fromName = 'SCREEN1', @toName = 'MAIN_WEIGHTER1', @connectionName = '128'
EXEC insert_connection @fromName = 'SCREEN2', @toName = 'MAIN_WEIGHTER1', @connectionName = '129'
EXEC insert_connection @fromName = 'SOURCE_WEIGH', @toName = 'MAIN_WEIGHTER1', @connectionName = '130'



-- Show tables
USE [PathDB]
GO

SELECT * FROM path.Devices;

SELECT * FROM path.Connections;