--Create Data Directory if not exists

EXECUTE master.dbo.xp_create_subdir 'C:\DATA\'

--Create Database

if not exists (select* from sys.databases where name = 'DesignerInventoryCatalog')
BEGIN

CREATE DATABASE [DesignerInventoryCatalog]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DesignerInventoryCatalog', FILENAME = N'C:\DATA\DesignerInventoryCatalog.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DesignerInventoryCatalog_log', FILENAME = N'C:\DATA\DesignerInventoryCatalog_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
END
GO
ALTER DATABASE [DesignerInventoryCatalog] SET COMPATIBILITY_LEVEL = 150
GO
ALTER DATABASE [DesignerInventoryCatalog] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DesignerInventoryCatalog] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DesignerInventoryCatalog] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DesignerInventoryCatalog] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DesignerInventoryCatalog] SET ARITHABORT OFF 
GO
ALTER DATABASE [DesignerInventoryCatalog] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DesignerInventoryCatalog] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DesignerInventoryCatalog] SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF)
GO
ALTER DATABASE [DesignerInventoryCatalog] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DesignerInventoryCatalog] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DesignerInventoryCatalog] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DesignerInventoryCatalog] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DesignerInventoryCatalog] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DesignerInventoryCatalog] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DesignerInventoryCatalog] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DesignerInventoryCatalog] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DesignerInventoryCatalog] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DesignerInventoryCatalog] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DesignerInventoryCatalog] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DesignerInventoryCatalog] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DesignerInventoryCatalog] SET  READ_WRITE 
GO
ALTER DATABASE [DesignerInventoryCatalog] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DesignerInventoryCatalog] SET  MULTI_USER 
GO
ALTER DATABASE [DesignerInventoryCatalog] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DesignerInventoryCatalog] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DesignerInventoryCatalog] SET DELAYED_DURABILITY = DISABLED 
GO
USE [DesignerInventoryCatalog]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = On;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = Primary;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = Off;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = Primary;
GO
USE [DesignerInventoryCatalog]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'PRIMARY') ALTER DATABASE [DesignerInventoryCatalog] MODIFY FILEGROUP [PRIMARY] DEFAULT
GO

--Drop Table Statements

drop table if exists [dbo].[TeamMembers];
drop table if exists [dbo].[Inventories];
drop table if exists [dbo].[Teams];
drop table if exists [dbo].[Products];
drop table if exists [dbo].[People];

-- Create People Table
​
create table [dbo].[People](
	[Id] int not null identity(1,1) Primary Key,
	[FirstName] varchar(50) not null,
	[LastName] varchar(50) not null,
	[SignUpDate] DateTime not null,
);

-- Create Teams Table
​
create table [dbo].[Teams](
	[Id] int not null identity(1,1) Primary Key,
	[Name] varchar(50) not null,
	[TeamLeaderPersonId] int not null,
	FOREIGN KEY (TeamLeaderPersonId) REFERENCES People(Id)
);

-- Create TeamMembers Table
​
create table [dbo].[TeamMembers](
	[Id] int not null identity(1,1) Primary Key,
	[PersonId] int not null,
	[TeamId] int not null,
	FOREIGN KEY (PersonId) REFERENCES People(Id),
	FOREIGN KEY (TeamId) REFERENCES Teams(Id),
	CONSTRAINT TeamPerson UNIQUE (PersonId, TeamId)
);

-- Create Products Table
​
create table [dbo].[Products](
	[Id] int not null identity(1,1) Primary Key,
	[Name] varchar(50) not null,
	[Size] varchar(1) not null,
	[Wholesale] int not null,
	[MSRP] int not null,
);

-- Create Inventories Table
​
create table [dbo].[Inventories](
	[Id] int not null identity(1,1) Primary Key,
	[PersonId] int not null,
	[ProductId] int not null,
	[Quantity] int not null,
	FOREIGN KEY (PersonId) REFERENCES People(Id),
	FOREIGN KEY (ProductId) REFERENCES Products(Id),
	CONSTRAINT PersonProduct UNIQUE (PersonId, ProductId)
);

--Delete Table Data

DELETE FROM [dbo].[TeamMembers];
DELETE FROM [dbo].[Inventories];
DELETE FROM [dbo].[Teams];
DELETE FROM [dbo].[Products];
DELETE FROM [dbo].[People];

--Insert Data into People Table

SET IDENTITY_INSERT dbo.People ON;

INSERT INTO People (Id, FirstName, LastName, SignUpDate)
VALUES (1, 'Jessica', 'Rabbit', '2017-06-21'),
	   (2, 'Mandy', 'Patinkin', '2016-04-07'),
	   (3, 'Brenda', 'Bee', '2015-03-11'),
	   (4, 'David', 'Tennant', '2017-10-31'),
	   (5, 'Christopher', 'Walken', '2018-09-18'),
	   (6, 'Coral', 'Reef', '2017-06-21'),
	   (7, 'Buffy', 'Summers', '2015-08-13'),
	   (8, 'Princess', 'Leia', '2016-11-20'),
	   (9, 'Hermione', 'Granger', '2020-07-22'),
	   (10, 'Dorothy', 'Gale', '2014-02-28'),
	   (11, 'Cry', 'Baby', '2019-01-20'),
	   (12, 'Dummy', 'Person', '2020-09-20'),
	   (13, 'Johnny', 'Five', '2017-08-03');

SET IDENTITY_INSERT dbo.People OFF;

--Insert Data into Teams Table

SET IDENTITY_INSERT dbo.Teams ON;

INSERT INTO Teams (Id, Name, TeamLeaderPersonId)
VALUES (1, 'Princess', 8),
	   (2, 'Pirate', 2),
	   (3, 'Doctor', 4),
	   (4, 'Muggle', 9),
	   (5, 'CowBell', 5);

SET IDENTITY_INSERT dbo.Teams OFF;

--Insert Data into TeamMembers Table

SET IDENTITY_INSERT dbo.TeamMembers ON;

INSERT INTO TeamMembers (Id, PersonId, TeamId)
VALUES (1, 1, 1),
	   (2, 2, 2),
	   (3, 3, 4),
	   (4, 4, 3),
	   (5, 5, 5),
	   (6, 6, 2),
	   (7, 7, 5),
	   (8, 8, 1),
	   (9, 9, 4),
	   (10, 10, 3),
	   (11, 13, 2);

SET IDENTITY_INSERT dbo.TeamMembers OFF;

--Insert Data into Products Table

SET IDENTITY_INSERT dbo.Products ON;

INSERT INTO Products (Id, [Name], Size, Wholesale, MSRP)
VALUES (1, 'Buzzz Transfer', 'A', 999, 1599),
	   (2, 'Dread Pirate Transfer', 'C', 1799, 2199),
	   (3, 'No Place Like Home Transfer', 'D', 2199, 2799),
	   (4, 'Inconceivable Transfer', 'B', 1399, 1799),
	   (5, 'More Cow Bell Transfer', 'A', 999, 1599),
	   (6, 'Expelliarmous Transfer', 'B', 1399, 1799),
	   (7, 'Finding Nemo Transfer', 'C', 1799, 2199),
	   (8, 'Allonsy Transfer', 'A', 999, 1599),
	   (9, 'I''m Not Bad Transfer', 'A', 999, 1599),
	   (10, 'Love You Transfer', 'D', 2199, 2799 ),
	   (11, 'No Mans Land Transfer', 'C', 1799, 2199);

SET IDENTITY_INSERT dbo.Products OFF;

--Insert Data into Inventories Table

SET IDENTITY_INSERT dbo.Inventories ON;

INSERT INTO Inventories (Id, PersonId, ProductId, Quantity)
VALUES (1, 1, 9, 2),
	   (2, 1, 10, 1),
	   (3, 2, 2, 2),
	   (4, 2, 4, 1),
	   (5, 3, 1, 2),
	   (6, 3, 10, 1),
	   (7, 4, 8, 3),
	   (8, 4, 3, 1),
	   (9, 5, 5, 5),
	   (10, 5, 9, 1),
	   (11, 6, 7, 2),
	   (12, 6, 3, 1),
	   (13, 6, 2, 1),
	   (14, 7, 9, 3),
	   (15, 7, 4, 1),
	   (16, 8, 10, 3),
	   (17, 8, 1, 1),
	   (18, 9, 6, 3),
	   (19, 9, 8, 1),
	   (20, 10, 3, 4),
	   (21, 10, 4, 1);

SET IDENTITY_INSERT dbo.Inventories OFF;

--Query and Index Requirements

--Write a SELECT query that uses a WHERE clause

SELECT * 
FROM People
WHERE FirstName = 'Mandy'
AND LastName = 'Patinkin';

--Write a  SELECT query that uses an OR and an AND operator

SELECT *
FROM People
INNER JOIN TeamMembers
ON TeamMembers.PersonId = People.Id
INNER JOIN Inventories
ON Inventories.PersonId = People.Id
WHERE (TeamId = 3 OR TeamId = 4)
AND ProductId = 8

--Write a  SELECT query that filters NULL rows using IS NOT NULL

SELECT *
FROM Inventories
WHERE Quantity IS NOT NULL;

--Write a DML statement that UPDATEs a set of rows with a WHERE clause. The values used in the WHERE clause should be a variable

DECLARE @price as int;
SET @price = 999;

UPDATE Products
SET Wholesale = 1199
WHERE Wholesale = @price;

--Write a DML statement that DELETEs a set of rows with a WHERE clause. The values used in the WHERE clause should be a variable

DECLARE @personid as int;
SET @personid = 11;

DELETE FROM People
WHERE Id = @personid;

--Write a DML statement that DELETEs rows from a table that another table references. This script will have to also DELETE any records that reference these rows. Both of the DELETE statements need to be wrapped in a single TRANSACTION.

BEGIN TRANSACTION;

DELETE FROM Inventories
WHERE ProductId = 1;

DELETE FROM Products
WHERE Id = 1;

COMMIT;

--Write a  SELECT query that utilizes a JOIN

SELECT People.*, Teams.Name AS TeamName 
FROM Teams
INNER JOIN People
ON Teams.TeamLeaderPersonId = People.Id

--Write a  SELECT query that utilizes a JOIN with 3 or more tables

SELECT FirstName, LastName, Products.Name, Quantity
FROM People
INNER JOIN Inventories
ON Inventories.PersonId = People.Id
INNER JOIN Products
ON Products.Id = Inventories.ProductId

--Write a  SELECT query that utilizes a LEFT JOIN

SELECT FirstName, LastName, TeamMembers.Id AS TeamMemberId
FROM People
LEFT JOIN TeamMembers
ON People.Id = TeamMembers.PersonId
WHERE TeamMembers.Id IS NULL

--Write a  SELECT query that utilizes a variable in the WHERE clause

DECLARE @productname as varchar(50);
SET @productname = 'pirate';

SELECT *
FROM Products
WHERE LOWER([Name]) LIKE '%'+ LOWER(@productname) + '%'

--Write a  SELECT query that utilizes aN ORDER BY clause

SELECT [Name], Size, Wholesale, MSRP
FROM Products
ORDER BY MSRP desc, Name asc; 

--Write a  SELECT query that utilizes a GROUP BY clause along with an aggregate function

SELECT Size, Wholesale, MSRP, COUNT([Size]) AS ProductCount
FROM Products
GROUP BY Size, Wholesale, MSRP
ORDER BY MSRP desc; 

--Write a SELECT query that utilizes a CALCULATED FIELD

SELECT FirstName, LastName, Products.Name, Quantity, '$' + FORMAT(MSRP/100.0, 'N') AS MSRP, '$' +  FORMAT((Quantity * MSRP)/100.0, 'N') AS ProductInventoryTotal
FROM People
INNER JOIN Inventories
ON Inventories.PersonId = People.Id
INNER JOIN Products
ON Products.Id = Inventories.ProductId

--Write a SELECT query that utilizes a SUBQUERY

SELECT *
FROM Products
WHERE Id NOT IN (SELECT ProductId FROM Inventories)

--Write a SELECT query that utilizes a JOIN, at least 2 OPERATORS (AND, OR, =, IN, BETWEEN, ETC) AND A GROUP BY clause with an aggregate function

SELECT Teams.[Name] AS TeamName, TeamLeader.FirstName + ' ' + TeamLeader.LastName as TeamLeaderName, COUNT (*) AS TeamSize
FROM People AS TeamLeader
INNER JOIN Teams
ON Teams.TeamLeaderPersonId = TeamLeader.Id
INNER JOIN TeamMembers
ON Teams.Id = TeamMembers.TeamId
WHERE TeamLeader.SignUpDate BETWEEN '2016-01-01' AND '2019-05-12'
GROUP BY Teams.[Name], TeamLeader.FirstName + ' ' + TeamLeader.LastName 
HAVING COUNT (*) > 2

--Write a SELECT query that utilizes a JOIN with 3 or more tables, at 2 OPERATORS (AND, OR, =, IN, BETWEEN, ETC), a GROUP BY clause with an aggregate function, and a HAVING clause

WITH TeamQuantities AS (SELECT Teams.Id AS TeamId, Teams.[Name] AS TeamName, Products.Id AS ProductId, Products.[Name] AS ProductName, SUM(Quantity) AS Quantity
FROM People AS TeamMember
INNER JOIN TeamMembers
ON TeamMember.Id = TeamMembers.PersonId
INNER JOIN Teams
ON Teams.Id = TeamMembers.TeamId
LEFT JOIN Inventories
ON TeamMember.Id = Inventories.PersonId
LEFT JOIN Products
ON Products.Id = Inventories.ProductId
GROUP BY Teams.Id, Teams.[Name], Products.Id, Products.[Name]
HAVING SUM(Quantity) BETWEEN 3 AND 5)

SELECT TeamQuantities.ProductName, TeamQuantities.TeamName, TeamQuantities.Quantity AS TeamQuantity, TeamMember.FirstName, TeamMember.LastName, Inventories.Quantity
FROM TeamQuantities
INNER JOIN TeamMembers 
ON TeamMembers.TeamId = TeamQuantities.TeamId
INNER JOIN People AS TeamMember
ON TeamMember.Id = TeamMembers.PersonId
LEFT JOIN Inventories
ON Inventories.PersonId = TeamMember.Id AND Inventories.ProductId = TeamQuantities.ProductId
WHERE Inventories.Quantity IS NOT NULL
ORDER BY ProductName, TeamName, TeamQuantity desc, Quantity desc

--Design a NONCLUSTERED INDEX with ONE KEY COLUMN that improves the performance of one of the above queries

/*
DECLARE @price as int;
SET @price = 999;

UPDATE Products
SET Wholesale = 1199
WHERE Wholesale = @price;
*/

CREATE NONCLUSTERED INDEX IX_Products_Wholesale ON Products
(
    Wholesale
)

--Design a NONCLUSTERED INDEX with TWO KEY COLUMNS that improves the performance of one of the above queries

/*
SELECT * 
FROM People
WHERE FirstName = 'Mandy'
AND LastName = 'Patinkin';
*/

CREATE NONCLUSTERED INDEX IX_People_FirstNameLastName ON People
(
    FirstName, LastName
)
--
--Design a NONCLUSTERED INDEX with AT LEAST ONE KEY COLUMN and AT LEAST ONE INCLUDED COLUMN that improves the performance of one of the above queries

/*
SELECT Teams.[Name] AS TeamName, TeamLeader.FirstName + ' ' + TeamLeader.LastName as TeamLeaderName, COUNT (*) AS TeamSize
FROM People AS TeamLeader
INNER JOIN Teams
ON Teams.TeamLeaderPersonId = TeamLeader.Id
INNER JOIN TeamMembers
ON Teams.Id = TeamMembers.TeamId
WHERE TeamLeader.SignUpDate BETWEEN '2016-01-01' AND '2019-05-12'
GROUP BY Teams.[Name], TeamLeader.FirstName + ' ' + TeamLeader.LastName 
HAVING COUNT (*) > 2
*/

CREATE NONCLUSTERED INDEX IX_People_SignUpDate ON People
(
  SignUpDate
) 
INCLUDE
(
  FirstName, LastName
)

	   
