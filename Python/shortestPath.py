# Asks the user to input the name of a starting node and ending node, and outputs the 5 shortest paths

# 1. Install networkx package: python -m pip install networkx
# 2. Install Python package that utilises the SQL driver: pip install pyodbc
# 3. Install SQL<->Python driver: https://learn.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server?view=sql-server-ver16
# 4. You need to run "createPythonUser.sql" and change a setting in your database as noted in that file

### Setup

import networkx as nx
import pyodbc as sql

SERVER = 'LOCALHOST'
DATABASE = 'PathDB'
USERNAME = 'python'
PASSWORD = 'mypooppassword123'

# Connecting to SQL database
connectionString = f'DRIVER={{ODBC Driver 18 for SQL Server}};SERVER={SERVER};DATABASE={DATABASE};UID={USERNAME};PWD={PASSWORD};TrustServerCertificate=yes'
conn = sql.connect(connectionString)

# Grabbing all connections from the SQL database and putting them in a list called "rows"
# Note: Must remove all "USE" and "GO" statements!
SQL_QUERY = """
SELECT * FROM path.Connections
"""
cursor = conn.cursor()
cursor.execute(SQL_QUERY)
connectionRows = cursor.fetchall()

# Grabbing all device names from the SQL database in order to translate device ids into readable device names
SQL_QUERY = """
SELECT deviceName FROM path.Devices
"""
cursor = conn.cursor()
cursor.execute(SQL_QUERY)
deviceRows = cursor.fetchall()

### Formatting

# Creates a big connections list
connections = []
for columns in connectionRows:
    connection = []
    for column in columns:
        column = str(column)
        index = column.find("\"Devices\",\"id\":")
        if index != -1:
            id = column.split("\"Devices\",\"id\":")[1]
            id = id.rstrip("}")
            connection.append(int(id))
    connections.append(connection)

# Creates a graph object and puts all of the connections into the graph
graph = nx.DiGraph()

for connection in connections:
    nx.add_path(graph, connection)

# Creates a big device ID -> device name dictionary
nameToID = {}
IDToName = {}
deviceID = 0
for columns in deviceRows:
    for column in columns:
        nameToID[column] = deviceID
        IDToName[deviceID] = column
        deviceID = deviceID + 1

### Printing Result

# Ask the user for the start and end node names
startName = input("Starting node name: ")
startID = nameToID[startName]
endName = input("Ending node name: ")
endID = nameToID[endName]

# Prints the 5 shortest paths from the two device ids given
paths = nx.shortest_simple_paths(graph, startID, endID)
noOfPaths = 5
pathNumber = 1
printMessage = ""
for path in paths:
    print(f"\nPath {pathNumber}:")
    nodeNumber = 0
    for node in path:
        printMessage = printMessage + IDToName[node]
        nodeNumber = nodeNumber + 1
        if nodeNumber != len(path):
            printMessage = printMessage + "->"

    printMessage = printMessage + f"\nJumps: {len(path) - 1}"
    print(printMessage)
    printMessage = ""
    pathNumber = pathNumber + 1
    if pathNumber > noOfPaths:
        break
