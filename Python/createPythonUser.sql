-- Creates a new login and user for Python to connect to and use

-- You will need to change a setting in SQL Server Management Studio to allow SQL logins and not just Windows logins
-- (No, I can't write a script that does this for you, this is changing a registry setting on your computer)
-- 1. Open SQL Server Management Studio on your computer
-- 2. Login and Right-click your computer's name on the left and select "Properties"
-- 3. Select "Security"
-- 4. Select "SQL Server and Windows Authentication mode"
-- 5. Press OK and right-click on your computer's name again on the right
-- 6. Click "Restart"
-- The same steps with some images are here: https://www.top-password.com/knowledge/sql-server-authentication-mode.html

USE [master]
GO

CREATE LOGIN python
    WITH PASSWORD    = 'mypooppassword123',
    CHECK_POLICY     = OFF,
    CHECK_EXPIRATION = OFF;
GO

USE [PathDB]
GO

CREATE USER python FOR LOGIN python
GO

GRANT CONTROL ON DATABASE::PathDB TO python
GO
