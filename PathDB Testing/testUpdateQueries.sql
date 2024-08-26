-- I named my db testdb, but go ahead and change the name to whatever the name of your db is 
--USE [PathDB]
--GO

-- This is the testing script for the db. This will test the update functionality of the table
-- Set the usable state of device with deviceID 1 to false

-- unit testing updating the usable status of the device
-- we are going to compare the expected value of the update
-- with the actual value of the update

DECLARE @testDeviceReadexpected1 BIT
DECLARE @testDeviceReadoutput1 BIT
SET @testDeviceReadexpected1 = 0;

EXEC update_device @deviceID = 2, @usable=@testDeviceReadexpected1;

SET @testDeviceReadoutput1 = (SELECT usable FROM path.Devices WHERE deviceID = 2);

-- check value matches expected value of 0
IF(@testDeviceReadexpected1=@testDeviceReadoutput1)
    PRINT('SUCCESS! updating usable status works');
ELSE
    PRINT('FAILURE! updating usable status failed');


-- FOR TESTING THE UPDATING OF DEVICE TYPE

DECLARE @testDeviceReadexpected2 NVARCHAR
DECLARE @testDeviceReadoutput2 NVARCHAR(50)


SET @testDeviceReadexpected2 = 'Hacked :p';
EXEC update_device @deviceID = 1, @deviceType = @testDeviceReadexpected2;

SET @testDeviceReadoutput2 = (SELECT deviceType FROM path.Devices WHERE deviceID = 1);

-- check value matches expected value of 0
IF(@testDeviceReadexpected2=@testDeviceReadoutput2)
    PRINT('SUCCESS! updating deviceType status works');
ELSE
    PRINT('FAILURE! updating deviceType status failed');


-- FOR TESTING ON UPDATING THE DEVICE NAME
DECLARE @testDeviceReadexpected3 NVARCHAR
DECLARE @testDeviceReadoutput3 NVARCHAR(50)


SET @testDeviceReadexpected3 = 'EHEHEHEHE';
EXEC update_device @deviceID = 2, @deviceType = @testDeviceReadexpected3;

SET @testDeviceReadoutput3 = (SELECT deviceName FROM path.Devices WHERE deviceID = 2);

-- check value matches expected value of 0
IF(@testDeviceReadexpected3=@testDeviceReadoutput3)
    PRINT('SUCCESS! updating deviceName status works');
ELSE
    PRINT('FAILURE! updating deviceName status failed');

-- Here we update a connection in the connection table

DECLARE @testConnectionReadexpected2 NVARCHAR
DECLARE @testConnectionReadoutput2 NVARCHAR(50)


SET @testDeviceReadexpected2 = 'Hacked :p';
EXEC update_connection @connectionName = 'Conveyor 2', @newName = @testDeviceReadexpected2, @fromID=0, @toID=1;

SET @testDeviceReadoutput2 = (SELECT connectionName FROM path.Connections);

-- check value matches expected value of 0s
IF(@testDeviceReadexpected2=@testDeviceReadoutput2)
    PRINT('SUCCESS! updating connectionName status works');
ELSE
    PRINT('FAILURE! updating connectionName status failed');