--A procedure to insert a new device into the Devices table
/*
Parameters:
    @deviceName: Name of the device to be added
    @deviceType: Type of the device to be added
    @usable: Whether the device is usable or not
*/
USE [PathDB]
GO

DROP PROCEDURE IF EXISTS insert_device
GO

CREATE PROCEDURE insert_device @deviceName NVARCHAR(50) = NULL, @deviceType NVARCHAR(50) = NULL, @usable BIT = NULL
AS
IF((@deviceName = '' OR @deviceName IS NULL))
    THROW 51000, 'Please ensure that deviceName is valid/non-empty!', 1
ELSE IF (@deviceType = '' OR @deviceType IS NULL) 
    THROW 51001, 'Please ensure that deviceType are valid/non-empty!', 1
ELSE IF (@usable IS NULL)
    THROW 51002, 'Please ensure usable state is not null!', 1
ELSE
    INSERT INTO path.Devices(deviceName, deviceType, usable) VALUES(@deviceName, @deviceType, @usable)
GO