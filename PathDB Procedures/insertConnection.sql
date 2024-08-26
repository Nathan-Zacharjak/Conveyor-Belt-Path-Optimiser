


--A procedure to insert a new connection between devices into the connections table
/*
Parameters:
    @fromName: Name of the device to be connected from
    @toName: Name of the device to be connected to
    @connectionName: Name of the connection to be added
*/
USE [PathDB]
GO

DROP PROCEDURE IF EXISTS insert_connection
GO

CREATE PROCEDURE insert_connection @fromName NVARCHAR(100), @toName NVARCHAR(100), @connectionName NVARCHAR(100)
AS

IF (@connectionName = '' OR @connectionName IS NULL)
    THROW 52000, 'Please ensure that insert connection parameters are valid/non-empty!', 1
ELSE IF NOT EXISTS (SELECT $node_id FROM path.Devices WHERE deviceName = @fromName)
    THROW 52001, 'Please ensure that fromName device exists in devices table!', 1
ELSE IF NOT EXISTS (SELECT $node_id FROM path.Devices WHERE deviceName = @toName)
    THROW 52002, 'Please ensure that toName device exists in devices table!', 1
ELSE
    INSERT INTO path.Connections VALUES((SELECT $node_id FROM path.Devices WHERE deviceName = @fromName), (SELECT $node_id FROM path.Devices WHERE deviceName = @toName), @connectionName)
GO