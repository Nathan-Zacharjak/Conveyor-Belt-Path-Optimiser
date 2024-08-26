

USE [PathDB]
GO

DROP PROCEDURE IF EXISTS read_connection
GO

CREATE PROCEDURE read_connection @connectname NVARCHAR(50)
AS
SELECT * FROM path.Connections WHERE connectionName = @connectname
GO

--EXEC read_connection 'Conveyor 5'