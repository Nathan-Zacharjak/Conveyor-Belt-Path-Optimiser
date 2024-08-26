# Asks the user to input the name of a starting node and ending node,
# and through a third-party Python 5-shortest path algorithm and our SQL 5-shortest path algorithm, checks to see if their output is the same

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

### SQL Shortest Path

# Ask the user for the start and end node names
startName = input("Starting node name: ")
startID = nameToID[startName]
endName = input("Ending node name: ")
endID = nameToID[endName]
print("\nThis might take a while...\n")

# Grabbing the reported SQL shortest path
SQL_QUERY = f"""
EXEC shortest_paths @fromName = '{startName}', @toName = '{endName}'
"""
cursor = conn.cursor()
cursor.execute(SQL_QUERY)
shortestPathRows = cursor.fetchall()

# Formatting the SQL shortest paths into something that can be compared with the Python output
SQLPaths = []
for columns in shortestPathRows:
    SQLPaths.append(columns[0])

### Printing Result

# Prints the 5 shortest paths from the two device ids given
paths = nx.shortest_simple_paths(graph, startID, endID)
noOfPaths = 5
pathNumber = 0
for path in paths:
    nodeNumber = 0
    pathString = ""
    found = False

    for node in path:
        pathString = pathString + IDToName[node]
        nodeNumber = nodeNumber + 1
        if nodeNumber != len(path):
            pathString = pathString + "->"

    for SQLPath in SQLPaths:
        if SQLPath == pathString:
            found = True
            break

    if found:
        print(f"Python path {pathNumber + 1} found in SQL paths!")
    else:
        print(f"Python path {pathNumber + 1} not found in SQL paths...")
        print("\nPython:\n")
        print(pathString)
        print("\nSQL:\n")
        SQLPathNumber = 1
        for SQLPath in SQLPaths:
            print(SQLPathNumber)
            print(SQLPath)
            SQLPathNumber = SQLPathNumber + 1
        
    pathNumber = pathNumber + 1
    if pathNumber >= noOfPaths:
        break
