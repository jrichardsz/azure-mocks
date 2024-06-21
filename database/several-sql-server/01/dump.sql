USE [master]
CREATE DATABASE AcmeEnterprises
GO
USE [AcmeEnterprises]
CREATE LOGIN acme_dev_team_login WITH PASSWORD = '5454VuSE1ux3';
CREATE USER acme_dev_team_usr FOR LOGIN acme_dev_team_login;
EXEC sp_addrolemember N'db_owner', N'acme_dev_team_usr'

USE [master]
CREATE DATABASE StarkEnterprises
GO
USE [StarkEnterprises]
CREATE LOGIN stark_dev_team_login WITH PASSWORD = 'YWY0NjJmOThkZGUwNjU5MmNiMTFlN';
CREATE USER stark_dev_team_usr FOR LOGIN stark_dev_team_login;
EXEC sp_addrolemember N'db_owner', N'stark_dev_team_usr'