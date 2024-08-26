# Takes a device list Excel spreadsheet and generates an SQL script to insert all devices and connections
# into the SQL database

# SETUP: Install 2 Python packages, pandas and openpyxl, for reading excel files:
# python -m pip install pandas
# python -m pip install openpyxl


### Initialising
import pandas as pd
import math
# Only importing "Plant item", "Connect from" and "Connect to" columns
data = pd.read_excel("Device List.xlsx",usecols=[0,3,4])


### Reading spreadsheet
# Getting python lists of devices and connections
devices = {}
connections = []

for i, row in data.iterrows():
    connection = {}
    deviceName = ""

    for j, col in enumerate(row):
        # Device name
        if j == 0:
            # Getting dictionary of devices, defaulting to labeling a device as a "process"
            devices[col] = "process"
            # Getting the origin device's name
            deviceName = col
            connection["middle"] = col
        # Device connected from
        elif j == 1:
            # Checking if "from" connection cell is empty, then mark device and connection as a source
            if type(col) == float and math.isnan(col):
                devices[deviceName] = "source"
                col = None
            # Inserting connection from middle device to current device,
            # which is the value of this column
            connection["from"] = col
        # Device connected to
        else:
            # Checking if "to" connection cell is empty, then mark device and connection as a destination
            if type(col) == float and math.isnan(col):
                devices[deviceName] = "destination"
                col = None
            # Inserting connection from origin device to its connected device,
            # which is the value of this column
            connection["to"] = col
    
    connections.append(connection)


### Formatting SQL query string
sqlQuery = "-- Devices\n"

# Device inserting queries
for device, typ in devices.items():
    sqlQuery = sqlQuery + f"EXEC insert_device @deviceName = '{device}', @deviceType = '{typ}', @usable = 1\n"
sqlQuery = sqlQuery + "\n-- Connections\n"

# Connection inserting queries
insertedConnections = {}
id = 0

for connection in connections:
    fromMiddleValid = True
    middleToValid = True

    # If either the "from" or "to" connection for a device is empty, it is a source or destination
    # so there is no connection to add there
    if connection["from"] == None:
        fromMiddleValid = False
    else:
        # If a connection from the node, or to the node is a duplicate, skip it
        # else record this connection as inserted
        if connection["from"] + connection["middle"] in insertedConnections:
            fromMiddleValid = False
        else:
            insertedConnections[connection["from"] + connection["middle"]] = True


    if connection["to"] == None:
        middleToValid = False
    else:
        if connection["middle"] + connection["to"] in insertedConnections:
            middleToValid = False
        else:
            insertedConnections[connection["middle"] + connection["to"]] = True


    # Only add a connection if it is valid
    if fromMiddleValid:
        sqlQuery = sqlQuery + f"EXEC insert_connection @fromName = '{connection['from']}', @toName = '{connection['middle']}', @connectionName = '{id}'\n"
        id += 1
    if middleToValid:
        sqlQuery = sqlQuery + f"EXEC insert_connection @fromName = '{connection['middle']}', @toName = '{connection['to']}', @connectionName = '{id}'\n"
        id += 1


### Output
# Writing output to an sql script file
file = open("insertDeviceList.sql","w")
file.write(sqlQuery)
file.close()