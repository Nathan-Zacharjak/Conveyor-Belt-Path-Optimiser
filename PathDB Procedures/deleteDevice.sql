--A procedure to delete any device from the database, along with all connections to and from this device
/*
Parameters:
    @deviceID: ID of the device to be deleted
*/
USE [PathDB]
GO

DROP PROCEDURE IF EXISTS delete_device
GO

CREATE PROCEDURE delete_device @deviceID INT
AS
-- check if device id is null
IF (@deviceID IS NULL)
    THROW 51003, 'deviceID is null!', 1
ELSE IF NOT EXISTS (SELECT deviceID FROM path.Devices WHERE deviceID = @deviceID)
    THROW 51004, 'deviceID does not exist!', 1
ELSE
    delete from path.Connections where $to_id=(select $edge_id from path.Devices where deviceID=@deviceID);
    delete from path.Connections where $from_id=(select $edge_id from path.Devices where deviceID=@deviceID);
    delete from path.Devices where deviceID=@deviceID;
GO