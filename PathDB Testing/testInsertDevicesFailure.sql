-- Here we will test the insertion of 2 devices with invalid parameters
-- This script should throw an error for invalid/empty parameters

-- Declare variables for the 2 test devices we add to the database.
DECLARE @testDeviceInsertion3 INT = NULL
DECLARE @testDeviceInsertion4 INT = NULL
-- Insert 2 new devices into the database and store their IDs
-- first device missing deviceName and incorrect type for deviceType
EXEC insert_device @deviceName = '', @deviceType = 200, @usable = 1
SET @testDeviceInsertion3 = SCOPE_IDENTITY()
-- 2nd is device missing device type
EXEC insert_device @deviceName = 'Process point', @deviceType = '', @usable = 1 
SET @testDeviceInsertion4 = SCOPE_IDENTITY()