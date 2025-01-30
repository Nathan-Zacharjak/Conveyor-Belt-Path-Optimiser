# Conveyor Belt Path Optimiser

This is a collection of scripts, mainly written in T-SQL, to be used with a MS SQL Server database. It is currently capable of returning the shortest path from 2 devices, but it is planned to expand this to returning the 5 shortest paths out of 1 starting node and many ending nodes.

The connected "devices" stored in the database have either direct, converging or diverging connections, where converging devices have multiple inputs, and diverging devices have multiple output connections.

## First time setup

Connect to your MS SQL server, run all scripts inside PathDB Procedures and inside the "PathDB Setup" directory execute "resetDatabase.sql". This performs all of the first time setup, and fills the database with a large filler data set automatically.

If you do not want filler data, you can execute the following files in order instead:

1. All scripts inside the folder "PathDB Procedures"
2. "drop Tables and Schema.sql" (Clears any existing database values)
3. "createPathDB.sql" (Creates an empty database)
4. "createPathTables.sql" (Creates empty tables within the database)
5. Add your data to the Excel spreadsheet in Python/Device List.xlsx as formatted
6. Run the "deviceListGenerator.py" Python script (pandas and openpyxl Python packages need to be installed)
7. Run the generated "insertDeviceList.sql" file to insert your devices and connections into the database

## Usage

In "PathDB queries" you can run "showTables.sql" to view the values of the database tables.

You can now execute queries to manipulate the database using SQL scripts located in "PathDB queries".

To get shortest paths between two devices, a stored procedure has been provided. Details on this procedure are below.

## Stored Procedures

A number of stored procedures have been included in the "PathDB Procedures" folder which are designed to make it easier to interact with the database.

A list of these procedures has been included below, along with a description of their functionality.

### Shortest paths

Get the 5 shortest paths between two devices.

Usage:

```SQL
EXEC shortest_paths @fromName = "Source device name", @toName = "Destination device name";
```

### Insert device

Create a new device in the database.

Usage:

```SQL
EXEC insert_device @deviceName = "New device name", @deviceType = "New device type", @usable = 1 or 0;
```

### Insert connection

Create a new connection in the database.

Usage:

```SQL
EXEC insert_connection @fromName = "Name of device to connect from", @toName = "Name of device to connect to", @connectionName = "New connection name";
```

### Delete device

Delete an existing device from the database.

This procedure will also delete any connections to or from this device.

Usage:

```SQL
EXEC delete_device @deviceID = ID number of device to be deleted;
```

### Delete connection

Delete an existing connection from the database.

Usage:

```SQL
EXEC delete_connection @connectionName = "Name of the connection to be deleted";
```

### Update device

Update the details of an existing device in the database.

Device ID is a required value and cannot be changed. Name, type and usable are optional fields and will be the new updated values. Fields not included will not be changed.

Usage:

```SQL
EXEC update_device @deviceID = ID of device to be updated, @deviceName = "New device name", @deviceType = "New device type", @usable = New value, can only be 1 or 0;
```

### Update connection

Update the details of an existing connection in the database.

All fields are required.

Usage:

```SQL
EXEC update_connection @connectionName = "Current connection name", @newName = "New connection name", @fromID = ID of device to connect from, @toID = ID of device to connect to;
```

## Python Shortest Path Comparison Scripts

To verify the shortest path provided by the SQL shortest path stored procedure is correct, Python and SQL scripts have been provided in the "Python" directory.

Here you can compare the output of a 1-source to 1-destination third-party shortest path algorithm with the SQL sorted procedure providing your own input source and destination node in the python command line. Alternatively, simply see the output of the third-party shortest path algorithm, i.e. what it outputs as the 5 shortest paths.

Running "python shortestPath.py" asks the user to input the name of a starting node and ending node, and outputs the 5 shortest paths.

```python
python shortestPath.py
Starting node name: SOURCE_1
Ending node name: DEST1

Path 1:
SOURCE_1->CONVEYOR1->LINK1->CONVEYOR2->WEIGHT2->SEPARATOR2->DRIVE2->PROCESSOR2->SPLITTER1->LINK3->ELEVATOR1->ELEVATOR_PATH_1->ELEVATOR_SWICTH_1->CLEAN101->DISTRIBUTOR1->DEST1
Jumps: 15

Path 2:
SOURCE_1->CONVEYOR1->LINK1->CONVEYOR2->WEIGHT2->SEPARATOR2->DRIVE2->PROCESSOR2->SPLITTER1->LINK3->ELEVATOR2->ELEVATOR_PATH_2->ELEVATOR_SWICTH_2->CLEAN102->DISTRIBUTOR2->DEST1
Jumps: 15

...
```

Running "python shortestPathCompare.py" asks the user to input the name of a starting node and ending node, and through a third-party Python 5-shortest path algorithm and our SQL 5-shortest path algorithm, checks to see if their output is the same.

```txt
python shortestPathCompare.py
Starting node name: SOURCE_1
Ending node name: DEST1

This might take a while...

Python path 1 found in SQL paths!
Python path 2 found in SQL paths!
Python path 3 found in SQL paths!
...
```

**To Install:**

1. Install networkx package: ```python -m pip install networkx```
2. Install Python package that utilises the SQL driver: pip install pyodbc
3. Install SQL<->Python driver: <https://learn.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server?view=sql-server-ver16>
4. You need to run "createPythonUser.sql" and change a setting in your database as noted in that file
