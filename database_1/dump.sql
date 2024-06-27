USE [master]
CREATE DATABASE AcmeEnterprises
GO
USE [AcmeEnterprises]
CREATE LOGIN acme_dev_team_login WITH PASSWORD = '5454VuSE1ux3';
CREATE USER acme_dev_team_usr FOR LOGIN acme_dev_team_login;
EXEC sp_addrolemember N'db_owner', N'acme_dev_team_usr'

CREATE TABLE [Employee] (
  Id INT NOT NULL IDENTITY(1,1),
  FirstName VARCHAR(50) NOT null,
  LastName VARCHAR(50) NOT NULL,
  DateOfBirth DATETIME NOT NULL
  CONSTRAINT PK_User_Id PRIMARY KEY (Id ASC)
);
INSERT INTO [Employee] VALUES ('Jane', 'Doe', '2018-01-01');

USE [master]
CREATE DATABASE StarkEnterprises
GO
USE [StarkEnterprises]
CREATE LOGIN stark_dev_team_login WITH PASSWORD = 'YWY0NjJmOThkZGUwNjU5MmNiMTFlN';
CREATE USER stark_dev_team_usr FOR LOGIN stark_dev_team_login;
EXEC sp_addrolemember N'db_owner', N'stark_dev_team_usr'

CREATE TABLE [Employee] (
  Id INT NOT NULL IDENTITY(1,1),
  FirstName VARCHAR(50) NOT null,
  LastName VARCHAR(50) NOT NULL,
  DateOfBirth DATETIME NOT NULL
  CONSTRAINT PK_User_Id PRIMARY KEY (Id ASC)
);
INSERT INTO [Employee] VALUES ('Jane', 'Doe', '2018-01-01');