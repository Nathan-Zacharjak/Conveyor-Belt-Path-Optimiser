-- Create DB if it does not exist
USE master
GO
IF NOT EXISTS (
   SELECT name
   FROM sys.databases
   WHERE name = N'PathDB'
)
CREATE DATABASE [PathDB]
GO