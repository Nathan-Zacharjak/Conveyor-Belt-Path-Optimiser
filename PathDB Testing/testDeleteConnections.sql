-- This script will test the functionality of deleting a connection

-- store connectionID to be deleted
DECLARE @edgeID NVARCHAR(100) 
-- get the largest current connection ID so that we can compare
-- the id of the deleted connection to the expected id 
SET @edgeID = (SELECT MAX($edge_id) FROM path.Connections)
-- attempt to delete connection from database using max $edge_id
EXEC delete_connection @edgeID

DECLARE @testDeleteConnection NVARCHAR(100)
SET @testDeleteConnection = (SELECT $edge_id FROM path.Connections WHERE $edge_id = @edgeID)

IF(@testDeleteConnection IS NULL)
    PRINT('Successfully deleted connection!')
ELSE
    PRINT('Connection was not deleted. Failed!')
/*
    If the connection exists, then it will delete it, otherwise
    it will return an connection null/does not exist error
*/
