/*

Created By: Sydnee Williams
Due: 05/06/2022
*/


USE [master]
GO

------------------------------------------------------------------------------------
----	Drop TennisB Database and Create TennisDB Database
------------------------------------------------------------------------------------

/****** Object:  Database [TennisDB]    Script Date: 3/20/2022 ******/
--Drop the database if it exists
PRINT 'Dropping TennisDB database'

IF EXISTS (SELECT 1 FROM sys.databases WHERE [Name] = N'TennisDB')
DROP DATABASE [TennisDB]
GO

-- Create the TennisDB database
CREATE DATABASE [TennisDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RiverviewSW_Data', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\TennisDB_Data.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 10%)
 LOG ON 
( NAME = N'RiverviewSW_Log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\TennisDB_Log.ldf' , SIZE = 13312KB , MAXSIZE = 2048GB , FILEGROWTH = 1024KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO

USE TennisDB
GO

------------------------------------------------------------------------------------
----	Drop TennisDB tables
------------------------------------------------------------------------------------

--Drop Children First

PRINT 'Dropping Rankings table'
--If Rankings table exists, then drop
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Rankings]') AND type in (N'U'))
DROP TABLE [Rankings]
GO


PRINT 'Dropping MatchStats table'
--If MatchStats table exists, then drop
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MatchStats]') AND type in (N'U'))
DROP TABLE [MatchStats]
GO


PRINT 'Dropping MatchScores table'
--If MatchScores table exists, then drop
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[MatchScores]') AND type in (N'U'))
DROP TABLE [MatchScores]
GO

--Drop Parents


PRINT 'Dropping PlayerInfo table'
--If PlayerInfo table exists, then drop
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[PlayerInfo]') AND type in (N'U'))
DROP TABLE [PlayerInfo]
GO


PRINT 'Dropping TournamentsData table'
--If  table exists, then drop
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[TournamentsData]') AND type in (N'U'))
DROP TABLE [TournamentsData]
GO



------------------------------------------------------------------------------------
----	Create PlayerInfo Table and Bulk Insert Data
------------------------------------------------------------------------------------


/****** Object: Create Tables			Script Date: 3/20/2022 ******/

PRINT 'Creating PlayerInfo table'

CREATE TABLE [dbo].[PlayerInfo] (
	[PlayerID]			nvarchar(10),
	[PlayerSlug]		nvarchar(100),
	[FirstName]			nvarchar(100),
	[LastName]			nvarchar(100),
	[FlagCode]			nvarchar(100),
	[Residence]			nvarchar(100),
	[BirthPlace]		nvarchar(100),
	[BirthDate]			nvarchar(100),
	[BirthYear]			nvarchar(100),
	[BirthMonth]		int,
	[BirthDay]			int,
	[TurnedPro]			int,
	[Weight_Pounds]		int,
	[Weight_Kgs]		int,
	[Height_Feet]		nvarchar(10),
	[Height_Inches]		nvarchar(10),
	[Height_Cm]			nvarchar(10),
	[Handedness]		nvarchar(100),
	[Backhand]			nvarchar(100)

)
GO

PRINT 'Loading Data into PlayerInfo table'

BULK INSERT PlayerInfo
FROM 'C:\TennisDW\PlayerData.csv'
WITH (
	FORMAT = 'csv',
	FIRSTROW = 2
	)



------------------------------------------------------------------------------------
----	Create TournamentsData and Bulk Insert Data
------------------------------------------------------------------------------------

PRINT 'Creating TournamentsData table'

CREATE TABLE [dbo].[TournamentsData] (
	[TourneyYear]					nvarchar(15),	
	[TourneyOrder]					int,	
	[TourneyName]					nvarchar(100),	
	[TourneyID]					int,	
	[TourneySlug]					nvarchar(50),	
	[TourneyLocation]				nvarchar(100),		
	[TourneyMonth]					int,	
	[TourneyDay]					int,	
	[Tourney_Singles_Draw]			int,	
	[Tourney_Doubles_Draw]			int,	
	[TourneyConditions]			nvarchar(50),	
	[TourneySurface]				nvarchar(50),	
	[Tourney_Fin_Commit]			nvarchar(100),	
	[Tourney_Url_Suffix]			nvarchar(100),	
	[Singles_Winner_Name]			nvarchar(100),	
	[Singles_Winner_Url]			nvarchar(100),	
	[Singles_Winner_Player_Slug]	nvarchar(100),	
	[Singles_Winner_PlayerID]		nvarchar(10),	
	[Doubles_Winner_1_Name]			nvarchar(100),	
	[Doubles_Winner_1_Url]			nvarchar(100),	
	[Doubles_Winner_1_Player_Slug]	nvarchar(100),	
	[Doubles_Winner_1_PlayerID]	nvarchar(10),	
	[Doubles_Winner_2_Name]			nvarchar(100),	
	[Doubles_Winner_2_Url]			nvarchar(100),	
	[Doubles_Winner_2_Player_Slug]	nvarchar(100),	
	[Doubles_Winner_2_PlayerID]	nvarchar(10),	
	[TourneyYearID]				nvarchar(10)

)


PRINT 'Loading Data into TournamentsData table'

BULK INSERT TournamentsData
FROM 'C:\TennisDW\TournamentsData_1877_2017_ed.csv'
WITH (
	FORMAT = 'csv',
	FIRSTROW = 2,
	FIELDTERMINATOR = ','
	)




------------------------------------------------------------------------------------
----	Create Rankings Table and Bulk Insert Data
------------------------------------------------------------------------------------

PRINT 'Creating Rankings table'

CREATE TABLE [dbo].[Rankings] (
	[WeekTitle]			nvarchar(100),
	[WeekYear]			int,
	[WeekMonth]			int,
	[WeekDay]			int,
	[RankText]			nvarchar(100),
	[RankNumber]		int,
	[MovePositions]		nvarchar(100),
	[MoveDirection]		nvarchar(100),
	[PlayerAge]			int,
	[RankingPoints]		int,
	[TourneysPlayed]	int,
	[PlayerURL]			nvarchar(100),
	[PlayerSlug]		nvarchar(100),
	[PlayerID]			nvarchar(10)
)
GO


PRINT 'Loading Data into Rankings table'

BULK INSERT Rankings
FROM 'C:\TennisDW\Rankings_1973_2017.csv'
WITH (
	FORMAT = 'csv',
	FIRSTROW = 2
	)




------------------------------------------------------------------------------------
----	Create MatchScores Table and Bulk Insert Data
------------------------------------------------------------------------------------

PRINT 'Creating MatchScores table'

CREATE TABLE [dbo].[MatchScores] (
	[TourneyYearID]			nvarchar(10),
	[TourneyOrder]			int,	
	[TourneySlug]			nvarchar(100),	
	[Tourney_Url_Suffix]	nvarchar(100),	
	[Tourney_Round_Name]	nvarchar(100),	
	[RoundOrder]			int,	
	[MatchOrder]			int,	
	[WinnerName]			nvarchar(100),	
	[WinnerPlayerID]		nvarchar(10),	
	[WinnerSlug]			nvarchar(100),	
	[LoserName]				nvarchar(100),	
	[LoserPlayerID]			nvarchar(10),	
	[LoserSlug]				nvarchar(100),	
	[WinnerSeed]			nvarchar(100),	
	[LoserSeed]				nvarchar(100),	
	[Match_Score_Tiebreaks]	nvarchar(100),	
	[Winner_Sets_Won]		int,	
	[Loser_Sets_Won]		int,	
	[Winner_Games_Won]		int,	
	[Loser_Games_Won]		int,	
	[Winner_Tiebreaks_Won]	int,	
	[Loser_Tiebreaks_Won]	int,	
	[MatchID]				nvarchar(50),
	[Match_Stats_Url_Suffix]nvarchar(100)

)


PRINT 'Loading Data into MatchScores table'

BULK INSERT MatchScores
FROM 'C:\TennisDW\MatchScores_1991_2017.csv'
WITH (
	FORMAT = 'csv',
	FIRSTROW = 2
	)



------------------------------------------------------------------------------------
----	Create MatchStats Table and Bulk Insert Data
------------------------------------------------------------------------------------

PRINT 'Creating MatchStats table'

CREATE TABLE [dbo].[MatchStats] (
	[TourneyOrder]						nvarchar(50),
	[MatchID]							nvarchar(50),
	[MatchStatsURL]						nvarchar(100),
	[MatchTime]							time,
	[MatchDuration]						int,
	[WinnerAces]						int,
	[Winner_Double_Faults]				int,
	[Winner_First_Serves_In]			int,
	[Winner_First_Serves_Total]			int,
	[Winner_First_Serve_Points_Won]		int,
	[Winner_First_Serve_Points_Total]	int,
	[Winner_Second_Serve_Points_Won]	int,
	[Winner_Second_Serve_Points_Total]	int,
	[Winner_Break_Points_Saved]			int,
	[Winner_Break_Points_Serve_Total]	int,
	[Winner_Service_Points_Won]			int,
	[Winner_Service_Points_Total]		int,
	[Winner_First_Serve_Return_Won]		int,
	[Winner_First_Serve_Return_Total]	int,
	[Winner_Second_Serve_Return_Won]	int,
	[Winner_Second_Serve_Return_Total]	int,
	[Winner_Break_Points_Converted]		int,
	[Winner_Break_Points_Return_Total]	int,
	[Winner_Service_Games_Played]		int,
	[Winner_Return_Games_Played]		int,
	[Winner_Return_Points_Won]			int,
	[Winner_Return_Points_Total]		int,		
	[Winner_Total_Points_Won]			int,
	[Winner_Total_Points_Total]			int,
	[Loser_Aces]						int,
	[Loser_Double_Faults]				int,
	[Loser_First_Serves_In]				int,
	[Loser_First_Serves_Total]			int,	
	[Loser_First_Serve_Points_Won]		int,
	[Loser_First_Serve_Points_Total]	int,
	[Loser_Second_Serve_Points_Won]		int,
	[Loser_Second_Serve_Points_Total]	int,
	[Loser_Break_Points_Saved]			int,
	[Loser_Break_Points_Serve_Total]	int,
	[Loser_Service_Points_Won]			int,
	[Loser_Service_Points_Total]		int,
	[Loser_First_Serve_Return_Won]		int, 
	[Loser_First_Serve_Return_Total]	int,
	[Loser_Second_Serve_Return_Won]		int,
	[Loser_Second_Serve_Return_Total]	int,
	[Loser_Break_Points_Converted]		int,	
	[Loser_Break_Points_Return_Total]	int,
	[Loser_Service_Games_Played]		int,
	[Loser_Return_Games_Played]			int,
	[Loser_Return_Points_Won]			int,
	[Loser_Return_Points_Total]			int,	
	[Loser_Total_Points_Won]			int,	
	[Loser_Total_Points_Total]			int

)
GO


PRINT 'Loading Data into MatchStats table'

BULK INSERT MatchStats
FROM 'C:\TennisDW\MatchStats_1991_2017.csv'
WITH (
	FORMAT = 'csv',
     FIRSTROW = 2,
     FIELDTERMINATOR = ',', 
     ROWTERMINATOR = '0x0a'
	)


------------------------------------------------------------------------------------
----	Remove Rows of Data
------------------------------------------------------------------------------------
DELETE FROM PlayerInfo
WHERE BirthYear < 1972

DELETE FROM PlayerInfo
WHERE Height_Inches = 0 or Height_Inches IS NULL


DELETE FROM TournamentsData
WHERE TourneyYear <1991


DELETE FROM Rankings
WHERE WeekYear <1991



------------------------------------------------------------------------------------
----	Alter Tables to Delete Unneeded Columns
------------------------------------------------------------------------------------
PRINT 'Altering Tables'

ALTER TABLE PlayerInfo
DROP COLUMN PlayerSlug, Weight_Kgs
GO

ALTER TABLE TournamentsData
DROP COLUMN Singles_Winner_Url, Tourney_Url_Suffix, Doubles_Winner_1_Url, Doubles_Winner_2_Url,
Singles_Winner_Player_Slug, TourneySlug, Doubles_Winner_1_Player_Slug, Doubles_Winner_2_Player_Slug
GO

ALTER TABLE Rankings
DROP COLUMN PlayerURL, PlayerSlug
GO

ALTER TABLE MatchScores
DROP COLUMN Tourney_Url_Suffix, TourneySlug, WinnerSlug, LoserSlug, Match_Stats_Url_Suffix
GO

ALTER TABLE MatchStats
DROP COLUMN MatchStatsURL
GO



------------------------------------------------------------------------------------
----	Transactions for Constraints
------------------------------------------------------------------------------------

-- These transactions are in place due to PlayerID (FK) data in Rankings table not appearing as a PlayerID (PK) in PlayerInfo table
-- The same occurs for the MatchID (FK) in MatchStats table and the MatchID (PK) in MatchScores table
-- The transactions find the IDs that don't match in each table, and then remove them from the table with the foreign key
-- This allows us to create a correct FK constraint without errors

--SELECT *
--FROM Rankings
--WHERE PlayerID NOT IN
--	(SELECT PlayerID
--	FROM PlayerInfo)


--SELECT *
--FROM MatchStats
--WHERE MatchID NOT IN
--	(SELECT MatchID
--	FROM MatchScores)

PRINT 'Starting Ranking Transaction'

BEGIN TRAN
DELETE FROM Rankings
WHERE PlayerID NOT IN
	(SELECT PlayerID
	FROM PlayerInfo)
COMMIT TRAN
PRINT 'Finished Ranking Transaction'

PRINT 'Starting MatchStats Transaction'

BEGIN TRAN
DELETE FROM MatchStats
WHERE MatchID NOT IN
	(SELECT MatchID
	FROM MatchScores)
COMMIT TRAN

PRINT 'Finished MatchStats Transaction'




------------------------------------------------------------------------------------
----	Create Fact Tables
------------------------------------------------------------------------------------
PRINT 'Dropping Fact Tables'

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[factRankings]') AND TYPE IN (N'U'))
DROP TABLE factRankings
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[factMatchStats]') AND TYPE IN (N'U'))
DROP TABLE factMatchStats
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[factMatches]') AND TYPE IN (N'U'))
DROP TABLE factMatches
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[factPlayer]') AND TYPE IN (N'U'))
DROP TABLE factPlayer
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[factTournaments]') AND TYPE IN (N'U'))
DROP TABLE factTournaments
GO

PRINT 'Creating Fact Tables'


CREATE TABLE [dbo].[factPlayer] (
	[PlayerID]			nvarchar(10),
		CONSTRAINT PK_factPlayer PRIMARY KEY CLUSTERED (PlayerID),
	[FirstName]			nvarchar(100),
	[LastName]			nvarchar(100),
	[FlagCode]			nvarchar(100),
	[Residence]			nvarchar(100),
	[BirthPlace]		nvarchar(100),
	[BirthDate]			nvarchar(100),
	[BirthYear]			nvarchar(100),
	[BirthMonth]		int,
	[BirthDay]			int,
	[TurnedPro]			int,
	[Weight_Pounds]		int,
	[Height_Inches]		nvarchar(10),
	[Handedness]		nvarchar(100),
	[Backhand]			nvarchar(100)

)


INSERT INTO factPlayer
SELECT PlayerID, FirstName, LastName, FlagCode, Residence, BirthPlace, BirthDate, BirthYear, BirthMonth, BirthDay, TurnedPro, Weight_Pounds, Height_Inches, Handedness, Backhand
FROM PlayerInfo

--SELECT *
--FROM PlayerInfo







CREATE TABLE [dbo].[factTournaments] (
	[TourneyYear]					nvarchar(15),	
	[TourneyOrder]					int,	
	[TourneyName]					nvarchar(100),	
	[TourneyID]						int,			
	[TourneyMonth]					int,	
	[TourneyDay]					int,	
	[Tourney_Singles_Draw]			int,	
	[Tourney_Doubles_Draw]			int,	
	[TourneyConditions]				nvarchar(50),	
	[TourneySurface]				nvarchar(50),	
	[Singles_Winner_Name]			nvarchar(100),	
	[Singles_Winner_PlayerID]		nvarchar(10),	
	[Doubles_Winner_1_Name]			nvarchar(100),		
	[Doubles_Winner_1_PlayerID]		nvarchar(10),	
	[Doubles_Winner_2_Name]			nvarchar(100),		
	[Doubles_Winner_2_PlayerID]		nvarchar(10),	
	[TourneyYearID]					nvarchar(10)
		CONSTRAINT PK_factTournaments PRIMARY KEY CLUSTERED (TourneyYearID)

)


INSERT INTO factTournaments
SELECT TourneyYear, TourneyOrder, TourneyName, TourneyID, TourneyMonth, TourneyDay, Tourney_Singles_Draw, Tourney_Doubles_Draw, TourneyConditions, 
	TourneySurface, Singles_Winner_Name, Singles_Winner_PlayerID, Doubles_Winner_1_Name, Doubles_Winner_1_PlayerID, Doubles_Winner_2_Name, Doubles_Winner_2_PlayerID, TourneyYearID
FROM TournamentsData




CREATE TABLE [dbo].[factRankings] (
	[WeekTitle]			nvarchar(100),
	[WeekYear]			int,
	[WeekMonth]			int,
	[WeekDay]			int,
	[RankText]			nvarchar(100),
	[RankNumber]		int,
	[MovePositions]		nvarchar(100),
	[MoveDirection]		nvarchar(100),
	[PlayerAge]			int,
	[RankingPoints]		int,
	[TourneysPlayed]	int,
	[PlayerID]			nvarchar(10)
		CONSTRAINT FK_factPlayer_factRankings FOREIGN KEY (PlayerID)
		REFERENCES factPlayer (PlayerID)
)


INSERT INTO factRankings
SELECT WeekTitle, WeekYear, WeekMonth, WeekDay, RankText, RankNumber, MovePositions, MoveDirection, PlayerAge, RankingPoints, TourneysPlayed, PlayerID
FROM Rankings




CREATE TABLE [dbo].[factMatches] (
	[TourneyYearID]			nvarchar(10),
		CONSTRAINT FK_factTournaments_factMatches FOREIGN KEY (TourneyYearID)
		REFERENCES factTournaments (TourneyYearID),
	[TourneyOrder]			int,	
	[Tourney_Round_Name]	nvarchar(100),	
	[RoundOrder]			int,	
	[MatchOrder]			int,	
	[WinnerName]			nvarchar(100),	
	[WinnerPlayerID]		nvarchar(10),
	[LoserName]				nvarchar(100),	
	[LoserPlayerID]			nvarchar(10),	
	[WinnerSeed]			nvarchar(100),	
	[LoserSeed]				nvarchar(100),	
	[Match_Score_Tiebreaks]	nvarchar(100),	
	[Winner_Sets_Won]		int,	
	[Loser_Sets_Won]		int,	
	[Winner_Games_Won]		int,	
	[Loser_Games_Won]		int,	
	[Winner_Tiebreaks_Won]	int,	
	[Loser_Tiebreaks_Won]	int,	
	[MatchID]				nvarchar(50),
		CONSTRAINT PK_factMatches PRIMARY KEY CLUSTERED (MatchID)
)


INSERT INTO factMatches
SELECT TourneyYearID, TourneyOrder, Tourney_Round_Name, RoundOrder, MatchOrder, WinnerName, WinnerPlayerID, LoserName, LoserPlayerID, WinnerSeed,
		LoserSeed, Match_Score_Tiebreaks, Winner_Sets_Won, Loser_Sets_Won, Winner_Games_Won, Loser_Games_Won, Winner_Tiebreaks_Won, Loser_Tiebreaks_Won, MatchID
FROM MatchScores






CREATE TABLE [dbo].[factMatchStats] (
	[TourneyOrder]						nvarchar(50),
	[MatchID]							nvarchar(50),
		CONSTRAINT FK_factMatches_factMatchStats FOREIGN KEY (MatchID)
		REFERENCES factMatches (MatchID),
	[MatchTime]							time,
	[MatchDuration]						int,
	[WinnerAces]						int,
	[Winner_Double_Faults]				int,
	[Winner_First_Serves_In]			int,
	[Winner_First_Serves_Total]			int,
	[Winner_First_Serve_Points_Total]	int,
	[Winner_Second_Serve_Points_Total]	int,
	[Winner_Break_Points_Saved]			int,
	[Winner_Break_Points_Serve_Total]	int,
	[Winner_Service_Points_Total]		int,
	[Winner_First_Serve_Return_Total]	int,
	[Winner_Second_Serve_Return_Total]	int,
	[Winner_Break_Points_Converted]		int,
	[Winner_Break_Points_Return_Total]	int,
	[Winner_Service_Games_Played]		int,
	[Winner_Return_Games_Played]		int,
	[Winner_Return_Points_Total]		int,		
	[Winner_Total_Points_Total]			int,
	[Loser_Aces]						int,
	[Loser_Double_Faults]				int,
	[Loser_First_Serves_In]				int,
	[Loser_First_Serves_Total]			int,	
	[Loser_First_Serve_Points_Total]	int,
	[Loser_Second_Serve_Points_Total]	int,
	[Loser_Break_Points_Saved]			int,
	[Loser_Break_Points_Serve_Total]	int,
	[Loser_Service_Points_Total]		int,
	[Loser_First_Serve_Return_Total]	int,
	[Loser_Second_Serve_Return_Total]	int,
	[Loser_Break_Points_Converted]		int,	
	[Loser_Break_Points_Return_Total]	int,
	[Loser_Service_Games_Played]		int,
	[Loser_Return_Games_Played]			int,
	[Loser_Return_Points_Total]			int,	
	[Loser_Total_Points_Total]			int

)


INSERT INTO factMatchStats
SELECT TourneyOrder, MatchID, MatchTime, MatchDuration, WinnerAces, Winner_Double_Faults, Winner_First_Serves_In, Winner_First_Serves_Total, Winner_First_Serve_Points_Total,
	Winner_Second_Serve_Points_Total, Winner_Break_Points_Saved, Winner_Break_Points_Serve_Total, Winner_Service_Points_Total, Winner_First_Serve_Return_Total, Winner_Second_Serve_Return_Total,
	Winner_Break_Points_Converted, Winner_Break_Points_Return_Total, Winner_Service_Games_Played, Winner_Return_Games_Played, Winner_Return_Points_Total, Winner_Total_Points_Total, Loser_Aces,
	Loser_Double_Faults, Loser_First_Serves_In, Loser_First_Serves_Total, Loser_First_Serve_Points_Total, Loser_Second_Serve_Points_Total, Loser_Break_Points_Saved, Loser_Break_Points_Serve_Total,
	Loser_Service_Points_Total, Loser_First_Serve_Return_Total, Loser_Second_Serve_Return_Total, Loser_Break_Points_Converted, Loser_Break_Points_Return_Total, Loser_Service_Games_Played,
	Loser_Return_Games_Played, Loser_Return_Points_Total, Loser_Total_Points_Total	
FROM  MatchStats

PRINT 'Finished Creating Fact Tables'
PRINT 'DONE'






------------------------------------------------------------------------------------
----	Create Dimension Tables
------------------------------------------------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dimTourneyYear]') AND TYPE IN (N'U'))
DROP TABLE dimTourneyYear
GO


CREATE TABLE dimTourneyYear(
	YearID int IDENTITY(1,1),
		CONSTRAINT PK_dimTourneyYear_YearID PRIMARY KEY CLUSTERED (YearID),
	TournamentYear varchar(15)
)


INSERT INTO dimTourneyYear
SELECT DISTINCT TourneyYear
FROM factTournaments
GO

--SELECT DISTINCT TourneyYear
--FROM factTournaments

-------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dimTourneySurface]') AND TYPE IN (N'U'))
DROP TABLE dimTourneySurface
GO



CREATE TABLE dimTourneySurface(
	SurfaceID int IDENTITY(1,1),
		CONSTRAINT PK_dimTourneySurface_SurfaceID PRIMARY KEY CLUSTERED (SurfaceID),
	Surface varchar(50)
)

INSERT INTO dimTourneySurface
SELECT DISTINCT TourneySurface
FROM factTournaments
GO

-------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dimFlagCode]') AND TYPE IN (N'U'))
DROP TABLE dimFlagCode
GO


CREATE TABLE dimFlagCode(
	FlagCodeID nvarchar(100),
		CONSTRAINT PK_dimFlagCode_FlagCodeID PRIMARY KEY CLUSTERED (FlagCodeID),
	FlagCodeDescription nvarchar(100)

)

INSERT INTO dimFlagCode
SELECT DISTINCT FlagCode,
		FlagCodeDescription =
				CASE 
	--				YOUR CODE GOES HERE
					WHEN FlagCode = 'ISR' THEN 'Israel'
					WHEN FlagCode = 'BOL' THEN 'Bolivia'
					WHEN FlagCode = 'CHN' THEN 'China'
					WHEN FlagCode = 'SUI' THEN 'Switzerland'
					WHEN FlagCode = 'ZIM' THEN 'Zimbabwe'
					WHEN FlagCode = 'NGR' THEN 'Nigeria'
					WHEN FlagCode = 'COL' THEN 'Colombia'
					WHEN FlagCode = 'MDA' THEN 'Moldova'
					WHEN FlagCode = 'JPN' THEN 'Japan'
					WHEN FlagCode = 'CRC' THEN 'Costa Rica'
					WHEN FlagCode = 'MON' THEN 'Monaco'
					WHEN FlagCode = 'NZL' THEN 'New Zealand'
					WHEN FlagCode = 'UZB' THEN 'Uzbekistan'
					WHEN FlagCode = 'ARG' THEN 'Argentina'
					WHEN FlagCode = 'USA' THEN 'United States of America'
					WHEN FlagCode = 'BAR' THEN 'Barbados'
					WHEN FlagCode = 'AUS' THEN 'Australia'
					WHEN FlagCode = 'MEX' THEN 'Mexico'
					WHEN FlagCode = 'CHI' THEN 'Chile'
					WHEN FlagCode = 'VEN' THEN 'Venezuela'
					WHEN FlagCode = 'LAT' THEN 'Latvia'
					WHEN FlagCode = 'HKG' THEN 'Hong Kong'
					WHEN FlagCode = 'SVK' THEN 'Slovakia'
					WHEN FlagCode = 'KAZ' THEN 'Kazakhstan'
					WHEN FlagCode = 'CZE' THEN 'Czech Republic'
					WHEN FlagCode = 'ARM' THEN 'Armenia'
					WHEN FlagCode = 'ITA' THEN 'Italy'
					WHEN FlagCode = 'KOR' THEN 'South Korea'
					WHEN FlagCode = 'RSA' THEN 'South Africa'
					WHEN FlagCode = 'TUR' THEN 'Turkey'
					WHEN FlagCode = 'CAN' THEN 'Canada'
					WHEN FlagCode = 'SLO' THEN 'Slovenia'
					WHEN FlagCode = 'GRE' THEN 'Greece'
					WHEN FlagCode = 'ESA' THEN 'El Salvador'
					WHEN FlagCode = 'IRL' THEN 'Ireland'
					WHEN FlagCode = 'POL' THEN 'Poland'
					WHEN FlagCode = 'AUT' THEN 'Austria'
					WHEN FlagCode = 'BEL' THEN 'Belgium'
					WHEN FlagCode = 'BRA' THEN 'Brazil'
					WHEN FlagCode = 'URU' THEN 'Uruguay'
					WHEN FlagCode = 'TPE' THEN 'Taiwan'
					WHEN FlagCode = 'FIN' THEN 'Finland'
					WHEN FlagCode = 'GEO' THEN 'Georgia'
					WHEN FlagCode = 'MAR' THEN 'Morocco'
					WHEN FlagCode = 'LTU' THEN 'Lithuania'
					WHEN FlagCode = 'PAR' THEN 'Paraguay'
					WHEN FlagCode = 'EGY' THEN 'Egypt'
					WHEN FlagCode = 'PAK' THEN 'Pakistan'
					WHEN FlagCode = 'CIV' THEN 'Côte d''Ivoire'
					WHEN FlagCode = 'BER' THEN 'Bermuda'
					WHEN FlagCode = 'BUL' THEN 'Bulgaria'
					WHEN FlagCode = 'NED' THEN 'Netherlands'
					WHEN FlagCode = 'RUS' THEN 'Russia'
					WHEN FlagCode = 'TOG' THEN 'Togo'
					WHEN FlagCode = 'ROU' THEN 'Romania'
					WHEN FlagCode = 'THA' THEN 'Thailand'
					WHEN FlagCode = 'LUX' THEN 'Luxembourg'
					WHEN FlagCode = 'CRO' THEN 'Croatia'
					WHEN FlagCode = 'SRB' THEN 'Serbia'
					WHEN FlagCode = 'TUN' THEN 'Tunisia'
					WHEN FlagCode = 'DEN' THEN 'Denmark'
					WHEN FlagCode = 'SWE' THEN 'Sweden'
					WHEN FlagCode = 'BLR' THEN 'Belarus'
					WHEN FlagCode = 'EST' THEN 'Estonia'
					WHEN FlagCode = 'FRA' THEN 'France'
					WHEN FlagCode = 'GUA' THEN 'Guatemala'
					WHEN FlagCode = 'DOM' THEN 'Dominican Republic'
					WHEN FlagCode = 'SIN' THEN 'Singapore'
					WHEN FlagCode = 'BAH' THEN 'Bahamas'
					WHEN FlagCode = 'IND' THEN 'India'
					WHEN FlagCode = 'ESP' THEN 'Spain'
					WHEN FlagCode = 'GBR' THEN 'United Kingdom'
					WHEN FlagCode = 'CYP' THEN 'Cyprus'
					WHEN FlagCode = 'ECU' THEN 'Ecuador'
					WHEN FlagCode = 'POR' THEN 'Portugal'
					WHEN FlagCode = 'PER' THEN 'Peru'
					WHEN FlagCode = 'HUN' THEN 'Hungary'
					WHEN FlagCode = 'BIH' THEN 'Bosnia-Herzegovina'
					WHEN FlagCode = 'GER' THEN 'Germany'
					WHEN FlagCode = 'UKR' THEN 'Ukraine'
					WHEN FlagCode = 'PHI' THEN 'Philippines'
					WHEN FlagCode = 'NOR' THEN 'Norway'
					WHEN FlagCode = 'INA' THEN 'Indonesia'
				END
FROM factPlayer


-------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dimHandedness]') AND TYPE IN (N'U'))
DROP TABLE dimHandedness
GO


CREATE TABLE dimHandedness(
	HandID int IDENTITY(1,1),
	--May have to get rd of CityID in PK
		CONSTRAINT PK_dimHandedness_HandID PRIMARY KEY CLUSTERED (HandID),
	Hand varchar(100)

)

INSERT INTO dimHandedness
SELECT DISTINCT Handedness
FROM factPlayer
GO



-------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dimBackhand]') AND TYPE IN (N'U'))
DROP TABLE dimBackhand
GO


CREATE TABLE dimBackhand(
	BackhandID int IDENTITY(1,1),
		CONSTRAINT PK_dimHandedness_BackhandID PRIMARY KEY CLUSTERED (BackhandID),
	Backhand varchar(100)

)

INSERT INTO dimBackhand
SELECT DISTINCT Backhand
FROM factPlayer
GO



-------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dimBirthMonth]') AND TYPE IN (N'U'))
DROP TABLE dimBirthMonth
GO



CREATE TABLE dimBirthMonth(
	BirthMonthID int,
		CONSTRAINT PK_dimBirthMonth_BirthMonthID PRIMARY KEY CLUSTERED (BirthMonthID),
	MonthDescription nvarchar(100)

)

INSERT INTO dimBirthMonth
SELECT DISTINCT BirthMonth,
		MonthDescription =
				CASE 
	--				YOUR CODE GOES HERE
					WHEN BirthMonth = 1 THEN 'January'
					WHEN BirthMonth = 2 THEN 'February'
					WHEN BirthMonth = 3 THEN 'March'
					WHEN BirthMonth = 4 THEN 'April'
					WHEN BirthMonth = 5 THEN 'May'
					WHEN BirthMonth = 6 THEN 'June'
					WHEN BirthMonth = 7 THEN 'July'
					WHEN BirthMonth = 8 THEN 'August'
					WHEN BirthMonth = 9 THEN 'September'
					WHEN BirthMonth = 10 THEN 'October'
					WHEN BirthMonth = 11 THEN 'November'
					WHEN BirthMonth = 12 THEN 'December'
				END
FROM factPlayer
WHERE BirthMonth IS NOT NULL


-------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dimSinglesDraw]') AND TYPE IN (N'U'))
DROP TABLE dimSinglesDraw
GO



CREATE TABLE dimSinglesDraw(
	SinglesDrawID int IDENTITY(1,1),
		CONSTRAINT PK_dimSinglesDraw_SinglesDrawID PRIMARY KEY CLUSTERED (SinglesDrawID),
	DrawType int
)

INSERT INTO dimSinglesDraw
SELECT DISTINCT Tourney_Singles_Draw
FROM factTournaments
GO


-------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dimMoveDirection]') AND TYPE IN (N'U'))
DROP TABLE dimMoveDirection
GO

CREATE TABLE dimMoveDirection(
	DirectionID int IDENTITY(1,1),
		CONSTRAINT PK_dimMoveDirection_DirectionID PRIMARY KEY CLUSTERED (DirectionID),
	Moved nvarchar(100)
)

INSERT INTO dimMoveDirection
SELECT DISTINCT MoveDirection
FROM factRankings
GO


-------------------------------------------


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dimRoundName]') AND TYPE IN (N'U'))
DROP TABLE dimRoundName
GO


CREATE TABLE dimRoundName(
	RoundNameID int IDENTITY(1,1),
		CONSTRAINT PK_dimRoundName_RoundNameID PRIMARY KEY CLUSTERED (RoundNameID),
	RoundName nvarchar(100)
)

INSERT INTO dimRoundName
SELECT DISTINCT Tourney_Round_Name
FROM factMatches
GO



-------------------------------------------

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dimRoundOrder]') AND TYPE IN (N'U'))
DROP TABLE dimRoundOrder
GO

CREATE TABLE dimRoundOrder(
	RoundOrderID int IDENTITY(1,1),
		CONSTRAINT PK_dimRoundOrder_RoundOrderID PRIMARY KEY CLUSTERED (RoundOrderID),
	RoundOrder int
)

INSERT INTO dimRoundOrder
SELECT DISTINCT RoundOrder
FROM factMatches
GO




IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[dimHeightInches]') AND TYPE IN (N'U'))
DROP TABLE dimHeightInches
GO

CREATE TABLE dimHeightInches(
	HeightInchesID int IDENTITY(1,1),
		CONSTRAINT PK_dimHeightInches_HeightInchesID PRIMARY KEY CLUSTERED (HeightInchesID),
	Height int
)

INSERT INTO dimHeightInches
SELECT DISTINCT Height_Inches
FROM factPlayer
ORDER BY Height_Inches DESC
GO



--Filter the data to find the players who have won and their respective statistics

SELECT F.WinnerPlayerID, COUNT(F.MatchID) AS [# of Matches Played], SUM(F.Winner_Sets_Won) AS [Winner Sets Won], SUM(F.Winner_Games_Won) AS [# of Games Won], SUM(M.WinnerAces) AS [ACES],SUM(M.Winner_First_Serves_In) AS [# Of First Serves In],
	(SELECT P.LastName
	FROM factPlayer P
	WHERE (F.WinnerPlayerID = P.PlayerID)) AS [LastName],
	(SELECT P.FirstName
	FROM factPlayer P
	WHERE (F.WinnerPlayerID = P.PlayerID)) AS [FirstName],
	(SELECT P.TurnedPro
	FROM factPlayer P
	WHERE (F.WinnerPlayerID = P.PlayerID)) AS [Turned Pro],
	(SELECT P.Height_Inches
	FROM factPlayer P
	WHERE (F.WinnerPlayerID = P.PlayerID)) AS [Height In Inches], 
	(SELECT P.BirthYear
	FROM factPlayer P
	WHERE (F.WinnerPlayerID = P.PlayerID)) AS [BirthYear], 
	(SELECT P.BirthMonth
	FROM factPlayer P
	WHERE (F.WinnerPlayerID = P.PlayerID)) AS [BirthMonth],
	(SELECT P.FlagCode
	FROM factPlayer P
	WHERE (F.WinnerPlayerID = P.PlayerID)) AS [Country]
FROM factMatches F INNER JOIN factMatchStats M ON M.MatchID = F.MatchID
GROUP BY WinnerPlayerID
ORDER BY [# of Matches Played] DESC
