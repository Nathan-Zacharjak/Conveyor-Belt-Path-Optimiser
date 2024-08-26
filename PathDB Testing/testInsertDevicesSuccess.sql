-- This script will test the functionality of performing insertion queries
-- This will test the insertion of a new device

-- Here we will test insertion 2 devices with filled parameters
-- Declare variables for the 2 test devices we add to the database.
DECLARE @testDeviceInsertion1 INT 
DECLARE @testDeviceInsertion2 INT
-- Insert 2 new devices into the database and store their IDs
EXEC insert_device @deviceName = 'Drop-off point', @deviceType = 'source', @usable = 1
SET @testDeviceInsertion1 = SCOPE_IDENTITY()
EXEC insert_device @deviceName = 'Process point', @deviceType = 'process', @usable = 1 
SET @testDeviceInsertion2 = SCOPE_IDENTITY()

-- create variable to retrieve inserted devices
DECLARE @assertDeviceInsertion1 INT
DECLARE @assertDeviceInsertion2 INT
-- retrieve newly inserted device
SET @assertDeviceInsertion1 = (SELECT deviceID FROM path.Devices WHERE deviceID = @testDeviceInsertion1) 
SET @assertDeviceInsertion2 = (SELECT deviceID FROM path.Devices WHERE deviceID = @testDeviceInsertion2) 

-- check if the assertDeviceInsertion1 & 2 are not equal to respective counterparts, then insertion failed
IF((@assertDeviceInsertion1 != @assertDeviceInsertion1) OR (@assertDeviceInsertion2 != @assertDeviceInsertion2))
    PRINT('Insertion of device failed!')
ELSE
    PRINT('Insertion of device succeeded!')