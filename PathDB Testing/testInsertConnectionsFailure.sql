-- This file will test insertion of a connection into the connections 
-- table with invalid parameters

-- Insert connection into the database and store ID
EXEC insert_connection @connectionName = 'Conveyor 1', @fromName = '', @toName = 'CLEAN102'; 
/* This line will throw 'Msg 52000, Level 16, State 1, Procedure insert_connection, Line 8
Please ensure that insert connection parameters are valid/non-empty!'
*/
EXEC insert_connection @connectionName = 'Conveyor 1', @fromName = 'CLEAN420', @toName = 'CLEAN101';
/* This line will throw 'Msg 52002, Level 16, State 1, Procedure insert_connection, Line 12
Please ensure that fromName device exists in devices table!'
*/