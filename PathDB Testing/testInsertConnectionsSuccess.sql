-- This file will test insertion of a connection into the connections 
-- table with valid parameters

DECLARE @edgeID NVARCHAR(100)
-- Insert connection into the database and store ID
EXEC insert_connection @connectionName = 'Conveyor 1', @fromName = 'CLEAN101', @toName = 'CLEAN102'
SET @edgeID = (SELECT $edge_id FROM path.Connections WHERE connectionName = 'Conveyor 1'
    AND $from_id = (SELECT $node_id FROM path.Devices WHERE deviceName = 'CLEAN101') 
    AND $to_id = (SELECT $node_id FROM path.Devices WHERE deviceName = 'CLEAN102'))

IF(@edgeID IS NOT NULL)
    PRINT('Successfully inserted connection!')
ELSE
    PRINT('Connection was not inserted. Failed!')
-- The output should be '(1 row affected)' for success