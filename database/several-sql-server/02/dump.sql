USE [master]
CREATE DATABASE UmbrellaCorp
GO
USE [UmbrellaCorp]
CREATE LOGIN umbrella_dev_team_login WITH PASSWORD = 'OTk5YjRiMDZkOTllYjJmZWJhMjEwM';
CREATE USER umbrella_dev_team_usr FOR LOGIN umbrella_dev_team_login;
EXEC sp_addrolemember N'db_owner', N'umbrella_dev_team_usr'

USE [master]
CREATE DATABASE StartLabs
GO
USE [StartLabs]
CREATE LOGIN time_team_login WITH PASSWORD = 'M2ZmOWM4ZTQ3NGU0YzM3YmNiZjVhN';
CREATE USER time_team_usr FOR LOGIN time_team_login;
EXEC sp_addrolemember N'db_owner', N'time_team_usr'