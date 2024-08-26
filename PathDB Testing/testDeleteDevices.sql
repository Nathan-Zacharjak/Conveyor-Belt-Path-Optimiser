-- This file will test deletion of a device from the devices table
-- If the device with max deviceID has a connection in the connections
-- table, then it will not successfull delete. However, if not, it 
-- should successfully delete from the devices table. 
    
-- store deviceID to be deleted 
DECLARE @testDeviceDeletion INT
-- variable to check if device still exists
DECLARE @assertDeviceDeletion INT
-- choose largest device number
SET @testDeviceDeletion = (SELECT MAX(deviceID) FROM path.Devices) 
-- attempt to delete device from database
EXEC delete_device @testDeviceDeletion
SET @assertDeviceDeletion = (SELECT deviceID FROM path.Devices WHERE deviceID = @testDeviceDeletion)
 
-- if assertDeviceConnectionDeletion is null, then we have successful Deletion
IF (@assertDeviceDeletion IS NULL)
    PRINT('Success! You have successfully delete device from the database!') 
ELSE
    PRINT('Failed! Device Deletion failed! It could be because the device you are trying to delete has a connection!')


