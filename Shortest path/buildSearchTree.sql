USE [PathDB]
GO

DROP PROCEDURE IF EXISTS shortest_paths
GO

CREATE PROCEDURE shortest_paths @fromName NVARCHAR(100), @toName NVARCHAR(100)
AS

WITH buildTree(parent, parentID, child, childID, pathway, jumps) --CTE containing parent, child, path taken to reach child
AS (
    --Anchor query
    SELECT 
        parent.deviceName, 
        parent.$node_id,
        children.deviceName,
        children.$node_id,
        CAST(parent.deviceName + '->' + children.deviceName AS VARCHAR(1000)) AS pathway,
        1
    FROM 
        path.Devices parent 
        INNER JOIN path.Connections con
        ON parent.$node_id = con.$from_id
        INNER JOIN path.Devices children
        ON children.$node_id = con.$to_id
    WHERE parent.deviceName = @fromName AND children.usable = 1

    UNION ALL

    --Subsequent queries
    SELECT 
        child, 
        childID,
        children.deviceName,
        children.$node_id,
        CAST(buildTree.pathway + '->' + children.deviceName AS VARCHAR(1000)) AS pathway,
        buildTree.jumps + 1
    FROM 
        buildTree 
        INNER JOIN path.Connections con
        ON buildTree.childID = con.$from_id
        INNER JOIN path.Devices children
        ON children.$node_id = con.$to_id
    WHERE children.usable = 1
)

SELECT DISTINCT TOP(5)  pathway, jumps
FROM buildTree
WHERE child = @toName
ORDER BY jumps
GO