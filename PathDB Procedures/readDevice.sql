-- A procedure to read details of any device from the database
/*

*/

USE [PathDB]
GO

DROP PROCEDURE IF EXISTS read_device
GO

CREATE PROCEDURE read_device @deviceID INT
AS
SELECT * FROM path.Devices WHERE deviceID = @deviceID
GO

--EXEC read_device @deviceID = 18