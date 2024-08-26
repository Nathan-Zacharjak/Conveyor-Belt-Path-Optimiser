USE [PathDB]
GO

EXEC update_device @deviceID = 9, @deviceName = 'htreh'; --updating device name
EXEC update_device @deviceID = 9, @deviceType = 'Destination'; --updating device type
EXEC update_device @deviceID = 9, @usable = 0; --updating device usability to false

EXEC update_connection @connectionName = 'Conveyor 1', @newName = 'WOOOOOO', @fromID=0, @toID=1;