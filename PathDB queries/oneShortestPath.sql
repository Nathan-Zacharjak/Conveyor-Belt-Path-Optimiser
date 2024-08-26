USE [PathDB]
GO

SELECT devName, connections
FROM (
    SELECT
        device1.deviceName AS devName,
        STRING_AGG(device2.deviceName, '->') WITHIN GROUP (GRAPH PATH) AS connections,
        LAST_VALUE(device2.deviceName) WITHIN GROUP (GRAPH PATH) AS lastNode
    FROM
        path.Devices AS device1,
        path.Connections FOR PATH AS fo,
        path.Devices FOR PATH AS device2
    WHERE MATCH(SHORTEST_PATH(device1(-(fo)->device2)+))
    AND device1.deviceName = 'Drop-off point'
) AS Q
WHERE Q.lastNode = 'Storage 1'