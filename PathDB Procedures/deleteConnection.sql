/* A procedure to delete any connection from the database,
Parameters:
    @edgeID
Usage:
    EXEC delete_connection @edgeID = *your edgeID*
*/
USE [PathDB]
GO

DROP PROCEDURE IF EXISTS delete_connection
GO

CREATE PROCEDURE delete_connection @connectionName NVARCHAR(100)
AS

IF (@connectionName IS NULL)
    THROW 52003, 'connection name is null!', 1
ELSE IF NOT EXISTS (SELECT $edge_id FROM path.Connections WHERE connectionName = @connectionName)
    THROW 52004, 'connection does not exist!', 1
ELSE 
    DELETE FROM path.Connections WHERE connectionName = @connectionName;
GO