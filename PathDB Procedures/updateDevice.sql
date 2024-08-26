--A Procedure to update the device details in the device table
/*
Parameters:
    @deviceID: ID of the device to be updated
    @deviceName: Name of the device to be updated (Optional)
    @deviceType: Type of the device to be updated (Optional)
    @usable: Whether the device is usable or not (Optional)
*/

USE [PathDB]
GO

DROP PROCEDURE IF EXISTS update_device
GO

CREATE PROCEDURE update_device @deviceID INT, @deviceName NVARCHAR(50)='', @deviceType NVARCHAR(50)='', @usable BIT=NULL
AS
IF (@deviceID IS NULL)
    THROW 51003, 'deviceID is null!', 1
ELSE IF NOT EXISTS (SELECT deviceID FROM path.Devices WHERE deviceID = @deviceID)
    THROW 51004, 'deviceID does not exist!', 1
    
IF (@deviceName != '')
BEGIN
    UPDATE path.Devices SET deviceName = @deviceName WHERE deviceID = @deviceID;
END
IF (@deviceType != '')
BEGIN
    UPDATE path.Devices SET deviceType = @deviceType WHERE deviceID = @deviceID;
END
IF (@usable IS NOT NULL)
BEGIN
    UPDATE path.Devices SET usable = @usable WHERE deviceID = @deviceID;
END
GO
