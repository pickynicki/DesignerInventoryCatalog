--1st File (See Read Me)
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
	FOREIGN KEY (TeamId) REFERENCES Teams(Id)
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
	FOREIGN KEY (ProductId) REFERENCES Products(Id)
);