USE [master]
GO
/****** Object:  Database [OT_Assessment_DB]    Script Date: 07-10-2024 10:42:24 AM ******/
CREATE DATABASE [OT_Assessment_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OT_Assessment_DB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\OT_Assessment_DB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'OT_Assessment_DB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\OT_Assessment_DB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [OT_Assessment_DB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OT_Assessment_DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [OT_Assessment_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OT_Assessment_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OT_Assessment_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OT_Assessment_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OT_Assessment_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [OT_Assessment_DB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [OT_Assessment_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OT_Assessment_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OT_Assessment_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OT_Assessment_DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [OT_Assessment_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OT_Assessment_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OT_Assessment_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OT_Assessment_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OT_Assessment_DB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [OT_Assessment_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OT_Assessment_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OT_Assessment_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OT_Assessment_DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [OT_Assessment_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OT_Assessment_DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [OT_Assessment_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [OT_Assessment_DB] SET RECOVERY FULL 
GO
ALTER DATABASE [OT_Assessment_DB] SET  MULTI_USER 
GO
ALTER DATABASE [OT_Assessment_DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [OT_Assessment_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [OT_Assessment_DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [OT_Assessment_DB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [OT_Assessment_DB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [OT_Assessment_DB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'OT_Assessment_DB', N'ON'
GO
ALTER DATABASE [OT_Assessment_DB] SET QUERY_STORE = OFF
GO
USE [OT_Assessment_DB]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 07-10-2024 10:42:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[AccountID] [uniqueidentifier] NOT NULL,
	[AccountNumber] [varchar](50) NULL,
	[FirstName] [varchar](100) NULL,
	[Surname] [varchar](100) NULL,
	[Email] [varchar](150) NULL,
	[Username] [varchar](50) NULL,
	[DateCreated] [datetime] NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Brands]    Script Date: 07-10-2024 10:42:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brands](
	[BrandId] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NULL,
	[DateCreated] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[BrandId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Countries]    Script Date: 07-10-2024 10:42:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Countries](
	[CountryID] [uniqueidentifier] NOT NULL,
	[CountryCode] [varchar](10) NULL,
	[CountryName] [varchar](50) NULL,
	[DateCreated] [datetime] NULL,
 CONSTRAINT [PK_Countries] PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Games]    Script Date: 07-10-2024 10:42:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Games](
	[GameId] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NULL,
	[Description] [varchar](255) NULL,
	[Theme] [varchar](100) NULL,
	[DateCreated] [datetime] NULL,
	[Active] [bit] NULL,
	[ProviderID] [uniqueidentifier] NULL,
	[BrandId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Games] PRIMARY KEY CLUSTERED 
(
	[GameId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Providers]    Script Date: 07-10-2024 10:42:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Providers](
	[ProviderID] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NULL,
	[DateCreated] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProviderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transactions]    Script Date: 07-10-2024 10:42:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transactions](
	[TransactionId] [uniqueidentifier] NOT NULL,
	[TransactionTypeId] [uniqueidentifier] NULL,
	[Date] [datetime] NULL,
	[Amount] [decimal](10, 2) NULL,
	[AccountId] [uniqueidentifier] NULL,
	[Unit] [int] NULL,
	[ExternalReferenceId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Transactions] PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionsType]    Script Date: 07-10-2024 10:42:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionsType](
	[TransactionTypeId] [uniqueidentifier] NOT NULL,
	[TransactionTypeCode] [varchar](10) NULL,
	[TransactionTypeDescription] [varchar](255) NULL,
	[DateCreated] [datetime] NULL,
 CONSTRAINT [PK_TransactionsType] PRIMARY KEY CLUSTERED 
(
	[TransactionTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Wagers]    Script Date: 07-10-2024 10:42:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wagers](
	[WagerId] [uniqueidentifier] NOT NULL,
	[GameId] [uniqueidentifier] NOT NULL,
	[TransactionId] [uniqueidentifier] NULL,
	[AccountId] [uniqueidentifier] NULL,
	[CountryID] [uniqueidentifier] NULL,
	[Amount] [decimal](10, 2) NULL,
	[NumberOfBets] [int] NULL,
	[Duration] [bigint] NULL,
	[SessionData] [varchar](max) NULL,
	[DateCreated] [datetime] NULL,
 CONSTRAINT [PK_Wagers] PRIMARY KEY CLUSTERED 
(
	[WagerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Accounts] ADD  CONSTRAINT [DF_Accounts_AccountID]  DEFAULT (newid()) FOR [AccountID]
GO
ALTER TABLE [dbo].[Accounts] ADD  CONSTRAINT [DF_Accounts_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Brands] ADD  DEFAULT (newid()) FOR [BrandId]
GO
ALTER TABLE [dbo].[Brands] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Countries] ADD  CONSTRAINT [DF_Countries_CountryID]  DEFAULT (newid()) FOR [CountryID]
GO
ALTER TABLE [dbo].[Countries] ADD  CONSTRAINT [DF_Countries_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Games] ADD  CONSTRAINT [DF_Games_GameId]  DEFAULT (newid()) FOR [GameId]
GO
ALTER TABLE [dbo].[Games] ADD  CONSTRAINT [DF_Games_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Providers] ADD  DEFAULT (newid()) FOR [ProviderID]
GO
ALTER TABLE [dbo].[Providers] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Transactions] ADD  CONSTRAINT [DF_Transactions_TransactionId]  DEFAULT (newid()) FOR [TransactionId]
GO
ALTER TABLE [dbo].[Transactions] ADD  CONSTRAINT [DF_Transactions_TransactionDate]  DEFAULT (getdate()) FOR [Date]
GO
ALTER TABLE [dbo].[Transactions] ADD  CONSTRAINT [DF_Transactions_ExternalReferenceId]  DEFAULT (newid()) FOR [ExternalReferenceId]
GO
ALTER TABLE [dbo].[TransactionsType] ADD  CONSTRAINT [DF_TransactionsType_TransactionTypeId]  DEFAULT (newid()) FOR [TransactionTypeId]
GO
ALTER TABLE [dbo].[TransactionsType] ADD  CONSTRAINT [DF_TransactionsType_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Wagers] ADD  CONSTRAINT [DF_Wagers_WagerId]  DEFAULT (newid()) FOR [WagerId]
GO
ALTER TABLE [dbo].[Wagers] ADD  CONSTRAINT [DF_Wagers_DateCreated]  DEFAULT (getdate()) FOR [DateCreated]
GO
ALTER TABLE [dbo].[Games]  WITH CHECK ADD  CONSTRAINT [FK_Games_Brand] FOREIGN KEY([BrandId])
REFERENCES [dbo].[Brands] ([BrandId])
GO
ALTER TABLE [dbo].[Games] CHECK CONSTRAINT [FK_Games_Brand]
GO
ALTER TABLE [dbo].[Games]  WITH CHECK ADD  CONSTRAINT [FK_Games_Provider] FOREIGN KEY([ProviderID])
REFERENCES [dbo].[Providers] ([ProviderID])
GO
ALTER TABLE [dbo].[Games] CHECK CONSTRAINT [FK_Games_Provider]
GO
ALTER TABLE [dbo].[Transactions]  WITH CHECK ADD  CONSTRAINT [FK_Transactions_TransactionsType] FOREIGN KEY([TransactionTypeId])
REFERENCES [dbo].[TransactionsType] ([TransactionTypeId])
GO
ALTER TABLE [dbo].[Transactions] CHECK CONSTRAINT [FK_Transactions_TransactionsType]
GO
ALTER TABLE [dbo].[Wagers]  WITH CHECK ADD  CONSTRAINT [FK_Wagers_Accounts] FOREIGN KEY([AccountId])
REFERENCES [dbo].[Accounts] ([AccountID])
GO
ALTER TABLE [dbo].[Wagers] CHECK CONSTRAINT [FK_Wagers_Accounts]
GO
ALTER TABLE [dbo].[Wagers]  WITH CHECK ADD  CONSTRAINT [FK_Wagers_Country] FOREIGN KEY([CountryID])
REFERENCES [dbo].[Countries] ([CountryID])
GO
ALTER TABLE [dbo].[Wagers] CHECK CONSTRAINT [FK_Wagers_Country]
GO
ALTER TABLE [dbo].[Wagers]  WITH CHECK ADD  CONSTRAINT [FK_Wagers_Games] FOREIGN KEY([GameId])
REFERENCES [dbo].[Games] ([GameId])
GO
ALTER TABLE [dbo].[Wagers] CHECK CONSTRAINT [FK_Wagers_Games]
GO
ALTER TABLE [dbo].[Wagers]  WITH CHECK ADD  CONSTRAINT [FK_Wagers_Transactions] FOREIGN KEY([TransactionId])
REFERENCES [dbo].[Transactions] ([TransactionId])
GO
ALTER TABLE [dbo].[Wagers] CHECK CONSTRAINT [FK_Wagers_Transactions]
GO
/****** Object:  StoredProcedure [dbo].[sp_AddWager]    Script Date: 07-10-2024 10:42:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_AddWager]
    @WagerId UNIQUEIDENTIFIER,
    @Theme VARCHAR(100),
    @ProviderName VARCHAR(50),
    @GameName VARCHAR(50),
    @Username VARCHAR(50),
    @TransactionType VARCHAR(10),
    @Amount DECIMAL(10,2),
    @CountryCode VARCHAR(10),
    @NumberOfBets INT,
	@Duration INT,
	@SessionData VARCHAR(max)
AS
BEGIN
    -- Start the transaction
    BEGIN TRANSACTION;

    -- Start the TRY block
    BEGIN TRY
        DECLARE @BrandId UNIQUEIDENTIFIER;
        DECLARE @AccountId UNIQUEIDENTIFIER;
        DECLARE @CountryId UNIQUEIDENTIFIER;
        DECLARE @ExternalReferenceId UNIQUEIDENTIFIER;
        DECLARE @TransactionId UNIQUEIDENTIFIER;
        DECLARE @TransactionTypeId UNIQUEIDENTIFIER;
        DECLARE @GameId UNIQUEIDENTIFIER;
        
        -- Check if the wager already exists
        IF EXISTS (SELECT 1 FROM [dbo].[Wagers] WHERE WagerId = @WagerId)
        BEGIN
            -- If the ID already exists, raise an error
            RAISERROR('A wager with this ID already exists.', 16, 1);
            RETURN;
        END

        -- Validate game name
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Games] WITH (NOLOCK) WHERE [Name] = @GameName)
        BEGIN
            RAISERROR('There is no game with this name that exists.', 16, 1);
            RETURN;
        END

        -- Validate provider name
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Providers] WITH (NOLOCK) WHERE [Name] = @ProviderName)
        BEGIN
            RAISERROR('There is no provider with this name that exists.', 16, 1);
            RETURN;
        END

        -- Validate account username
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Accounts] WITH (NOLOCK) WHERE Username = @Username)
        BEGIN
            RAISERROR('There is no account with this username that exists.', 16, 1);
            RETURN;
        END

        -- Validate transaction type
        IF NOT EXISTS (SELECT 1 FROM [dbo].[TransactionsType] WITH (NOLOCK) WHERE TransactionTypeCode = @TransactionType)
        BEGIN
            RAISERROR('There is no transaction type with this code that exists.', 16, 1);
            RETURN;
        END

        -- Validate country code
        IF NOT EXISTS (SELECT 1 FROM [dbo].[Countries] WITH (NOLOCK) WHERE CountryCode = @CountryCode)
        BEGIN
            RAISERROR('There is no country with this code that exists.', 16, 1);
            RETURN;
        END

        -- Retrieve necessary details
        SELECT TOP 1 @GameId = GameId , @BrandId = BrandId
        FROM [dbo].[Games] g WITH (NOLOCK)
        JOIN [dbo].[Providers] p WITH (NOLOCK) ON g.ProviderID = p.ProviderID  
        WHERE g.[Name] = @GameName AND p.Name = @ProviderName AND g.Theme = @Theme;

        SELECT TOP 1 @TransactionTypeId = TransactionTypeId 
        FROM [dbo].[TransactionsType] WITH (NOLOCK) 
        WHERE TransactionTypeCode = @TransactionType;

        SELECT TOP 1 @AccountId = AccountID
        FROM [dbo].[Accounts] WITH (NOLOCK) 
        WHERE Username = @Username;

		SELECT TOP 1 @CountryId = [CountryID] 
        FROM [dbo].[Countries] WITH (NOLOCK) 
        WHERE CountryCode = @CountryCode;

        -- Insert into Transactions
        INSERT INTO [dbo].[Transactions](TransactionId, AccountId, Amount, Unit, TransactionTypeId)
        VALUES (@TransactionId, @AccountId, @Amount, @NumberOfBets, @TransactionTypeId);

        -- Retrieve External Reference ID
        SELECT TOP 1 @ExternalReferenceId = ExternalReferenceId
        FROM [dbo].[Transactions] WITH (NOLOCK)
        WHERE TransactionId = @TransactionId ORDER BY [Date] DESC;
		       

        -- Insert into Wagers
        INSERT INTO [dbo].[Wagers] 
        (WagerId, GameId, TransactionId, AccountId,[CountryID], Amount, NumberOfBets,[Duration], [SessionData], [DateCreated])
        VALUES 
        (@WagerId, @GameId, @TransactionId, @AccountId,@CountryId, @Amount, @NumberOfBets, @Duration, @SessionData, GETDATE());

        -- Commit the transaction
        COMMIT TRANSACTION;

        -- Return the inserted WagerID and other details
        SELECT 
            @WagerId AS WagerId, @Theme AS Theme, @ProviderName AS Provider, @GameName AS GameName,
            @TransactionId AS TransactionId, @BrandId AS BrandId, @AccountId AS AccountId, @Username AS Username,
            @ExternalReferenceId AS ExternalReferenceId, @TransactionTypeId AS TransactionTypeId, @Amount AS Amount,
            GETDATE() AS CreatedDateTime, @NumberOfBets AS NumberOfBets, @CountryCode AS CountryCode, 
            @Username AS SessionData, 34563 AS Duration;
    END TRY

    -- Begin the CATCH block
    BEGIN CATCH
        -- Rollback the transaction if an error occurs
        IF XACT_STATE() <> 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        -- Retrieve the error details
        SELECT ERROR_MESSAGE();

    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllWages]    Script Date: 07-10-2024 10:42:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[sp_GetAllWages]
    AS
BEGIN
    BEGIN TRY
        SELECT 
            WagerId, 
			g.theme,
			p.[Name] as [provider],
			g.[Name] as [gameName],           
			a.[Username],
            t.ExternalReferenceId, 
            t.Amount, 			
            w.DateCreated,
            w.NumberOfBets, 
            c.CountryCode, 
			w.SessionData,
            w.Duration
        FROM [dbo].[Wagers] w WITH (NOLOCK)
		inner join [dbo].[Accounts] a on a.[AccountID] = w.[AccountId]
		inner join [dbo].[Transactions] t on t.[TransactionId] = w.[TransactionId]
		Inner Join [dbo].[Countries] c on c.[CountryID] = w.[CountryID]
		inner join [dbo].[Games] g on g.[GameId] = w.[GameId]
		inner join [dbo].[Providers] p on p.[ProviderID] = g.[ProviderID]

    END TRY
    BEGIN CATCH
        SELECT ERROR_MESSAGE();
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPlayerWagersWithPagination]    Script Date: 07-10-2024 10:42:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetPlayerWagersWithPagination]
    @PlayerId UNIQUEIDENTIFIER,
    @Page INT,
    @PageSize INT
AS
BEGIN
    SET NOCOUNT ON;
	    -- Start the TRY block
    BEGIN TRY
    -- Calculate the starting row
    DECLARE @StartRow INT = (@Page - 1) * @PageSize + 1;

    -- Get the total number of rows for the player
    DECLARE @TotalRows INT;
    SELECT @TotalRows = COUNT(*)
    FROM Wagers
    WHERE accountId = @PlayerId;

    -- Fetch paginated data for the player
    SELECT 
        w.wagerId as WagerId,
        g.Name AS Game,
        p.Name as  Name,
        w.amount as Amount,
        w.DateCreated AS CreatedDate
    FROM Wagers w
    INNER JOIN Games g ON w.gameId = g.gameId
	inner join Providers p on g.ProviderID  = p.ProviderID
    WHERE w.accountId = @PlayerId
    ORDER BY w.DateCreated DESC
    OFFSET @StartRow - 1 ROWS
    FETCH NEXT @PageSize ROWS ONLY;

    -- Return pagination metadata
    SELECT 
        @Page AS Page,
        @PageSize AS PageSize,
        @TotalRows AS Total,
        CEILING((@TotalRows + 0.0) / @PageSize) AS TotalPages;

	END TRY

    BEGIN CATCH
        SELECT ERROR_MESSAGE();
    END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTopSpenders]    Script Date: 07-10-2024 10:42:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetTopSpenders]
    @Count INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
    -- Retrieve the top spenders based on total amount spent
		SELECT TOP (@Count) 
		    a.accountId as AccountId,
		    a.username as Username,
		    SUM(w.amount) AS TotalAmountSpent
		FROM Wagers w
		INNER JOIN Accounts a ON w.accountId = a.accountId
		GROUP BY a.accountId, a.username
		ORDER BY totalAmountSpent DESC;
	 END TRY
    -- Begin the CATCH block
     BEGIN CATCH
         SELECT ERROR_MESSAGE();
     END CATCH
END;
GO
USE [master]
GO
ALTER DATABASE [OT_Assessment_DB] SET  READ_WRITE 
GO
