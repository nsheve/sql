USE master
GO

CREATE DATABASE MySession ON  PRIMARY 
( NAME = MySession, FILENAME = "C:\Program Files\Microsoft SQL Server\MSSQL14.SQLSHEVE\MSSQL\DATA\MySession.mdf" , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = MySession_log, FILENAME = "C:\Program Files\Microsoft SQL Server\MSSQL14.SQLSHEVE\MSSQL\DATA\MySession_log.ldf" , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE MySession SET COMPATIBILITY_LEVEL = 100
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC MySession.dbo.sp_fulltext_database @action = 'enable'
end
GO

ALTER DATABASE MySession SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE MySession SET ANSI_NULLS OFF 
GO

ALTER DATABASE MySession SET ANSI_PADDING OFF 
GO

ALTER DATABASE MySession SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE MySession SET ARITHABORT OFF 
GO

ALTER DATABASE MySession SET AUTO_CLOSE OFF 
GO

ALTER DATABASE MySession SET AUTO_CREATE_STATISTICS ON 
GO

ALTER DATABASE MySession SET AUTO_SHRINK OFF 
GO

ALTER DATABASE MySession SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE MySession SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE MySession SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE MySession SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE MySession SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE MySession SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE MySession SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE MySession SET  DISABLE_BROKER 
GO

ALTER DATABASE MySession SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE MySession SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE MySession SET TRUSTWORTHY OFF 
GO

ALTER DATABASE MySession SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE MySession SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE MySession SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE MySession SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE MySession SET  READ_WRITE 
GO

ALTER DATABASE MySession SET RECOVERY FULL 
GO

ALTER DATABASE MySession SET  MULTI_USER 
GO

ALTER DATABASE MySession SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE MySession SET DB_CHAINING OFF 
GO
USE MySession
GO
Create table Directions
( NumDir int PRIMARY KEY,
  Title varchar(30)NOT NULL,
  Quantity int );
GO
Create Table Groups
(NumGr varchar(10) PRIMARY KEY,
 NumDir int NOT NULL REFERENCES Directions, 
 NumSt int,
 Quantity int);
GO
Create table Students
(NumSt int IDENTITY (1,1) PRIMARY KEY,
 FIO varchar(30)NOT NULL, 
 NumGr varchar(10) REFERENCES Groups);
 GO
Create table Disciplines
(NumDisc int IDENTITY(1,1) PRIMARY KEY, 
Name varchar(30) NOT NULL);
GO
Create table Uplans
(IdDisc int IDENTITY(1,1) PRIMARY KEY, 
 NumDir int REFERENCES Directions,
 NumDisc int REFERENCES Disciplines,
 Semestr smallint);
 GO
Create table Balls
(IdBall int IDENTITY(1,1) PRIMARY KEY, 
 IdDisc int NOT NULL REFERENCES Uplans, 
 NumSt int NOT NULL REFERENCES Students,
 Ball smallint, 
 DateEx date);

