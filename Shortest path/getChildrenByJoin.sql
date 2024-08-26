USE [PathDB]
GO

SELECT parent.deviceName AS parent, children.deviceName AS child 
FROM 
    path.Devices parent 
    INNER JOIN path.Connections con
    ON parent.$node_id = con.$from_id
    INNER JOIN path.Devices children
    ON children.$node_id = con.$to_id
WHERE parent.deviceName = 'Diverter'