USE [master]
CREATE DATABASE AcmeEnterprises
GO
USE [AcmeEnterprises]
CREATE LOGIN dev_team_login WITH PASSWORD = '5454VuSE1ux3';
CREATE USER dev_team_usr FOR LOGIN dev_team_login;
EXEC sp_addrolemember N'db_owner', N'dev_team_usr'
