--A Procedure to update the connection details in the connection table
/*
Parameters:
    @connectionName: Name of the connection to be updated (Optional)
    @connectionType: Type of the connection to be updated (Optional)
    @usable: Whether the connection is usable or not (Optional)
Usage:
    EXEC update_connection @connectionName = *your connectionName*,
    @fromID = *your fromID*,
    @toID = *your toID*
Usage:

*/

USE [PathDB]
GO

DROP PROCEDURE IF EXISTS update_connection
GO

-- Updates the connection via the unique connectionName. If no connectionName given, then return error message.
CREATE PROCEDURE update_connection @connectionName NVARCHAR(50)='', @newName NVARCHAR(50)='', @fromID INT, @toID INT
AS
IF (@connectionName = '' OR @connectionName IS NULL OR @newName = '' OR @newName IS NULL)
    THROW 52000, 'Please ensure the connection name and new name is valid/non-empty.', 1

ELSE
    DELETE FROM path.Connections WHERE connectionName = @connectionName;
    INSERT INTO path.Connections VALUES((SELECT $node_id FROM path.Devices WHERE deviceID = @fromID), (SELECT $node_id FROM path.Devices WHERE deviceID = @toID), @newName)
GO