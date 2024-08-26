-- This script tests the functionality of reading a device 
-- or connection from the database


-- read a device and print out its details

DECLARE @testDeviceRead1 INT

SET @testDeviceRead1 = (SELECT MAX(deviceID) FROM path.Devices)

IF (@testDeviceRead1 IS NULL)
    PRINT('FAILURE! Device not read :(')
ELSE
    EXEC read_device @testDeviceRead1
    PRINT('SUCCESS! Device Read successfully!')




-- read a connection and print out its details

DECLARE @testConnectionRead1 NVARCHAR(50)

SET @testConnectionRead1 = (SELECT connectionName FROM path.Connections WHERE connectionName='Conveyor 1')

IF (@testConnectionRead1 is NULL)
    PRINT('FAILURE! connection not read :(');

ELSE 
    PRINT('SUCCESS! Connection read successfully')
    EXEC read_connection @testConnectionRead1;
    