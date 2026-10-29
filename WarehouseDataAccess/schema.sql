USE [master]
GO
/****** Object:  Database [WarehouseDB]    Script Date: 10/29/2026 06:42:54 م ******/
CREATE DATABASE [WarehouseDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WarehouseDB', FILENAME = N'/var/opt/mssql/data/WarehouseDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'WarehouseDB_log', FILENAME = N'/var/opt/mssql/data/WarehouseDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [WarehouseDB] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WarehouseDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WarehouseDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WarehouseDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WarehouseDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WarehouseDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WarehouseDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [WarehouseDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WarehouseDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WarehouseDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WarehouseDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WarehouseDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WarehouseDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WarehouseDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WarehouseDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WarehouseDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WarehouseDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WarehouseDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WarehouseDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WarehouseDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WarehouseDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WarehouseDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WarehouseDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WarehouseDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WarehouseDB] SET RECOVERY FULL 
GO
ALTER DATABASE [WarehouseDB] SET  MULTI_USER 
GO
ALTER DATABASE [WarehouseDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WarehouseDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WarehouseDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WarehouseDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [WarehouseDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [WarehouseDB] SET OPTIMIZED_LOCKING = OFF 
GO
ALTER DATABASE [WarehouseDB] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'WarehouseDB', N'ON'
GO
ALTER DATABASE [WarehouseDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [WarehouseDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [WarehouseDB]
GO
/****** Object:  UserDefinedTableType [dbo].[InvoiceItemType]    Script Date: 10/29/2026 06:42:54 م ******/
CREATE TYPE [dbo].[InvoiceItemType] AS TABLE(
	[ProductID] [int] NULL,
	[Quantity] [decimal](18, 3) NULL,
	[UnitPrice] [decimal](18, 2) NULL,
	[DiscountAmount] [decimal](18, 2) NULL,
	[TaxAmount] [decimal](18, 2) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[TransferItemType]    Script Date: 10/29/2026 06:42:54 م ******/
CREATE TYPE [dbo].[TransferItemType] AS TABLE(
	[ProductID] [int] NULL,
	[Quantity] [decimal](18, 3) NULL
)
GO
/****** Object:  Table [dbo].[Products]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Sku] [varchar](100) NOT NULL,
	[Barcode] [varchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[PurchasePrice] [decimal](18, 2) NOT NULL,
	[SalePrice] [decimal](18, 2) NOT NULL,
	[MinStock] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[UpdatedAt] [datetime] NULL,
	[CategoryID] [int] NULL,
	[UnitID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Warehouses]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Warehouses](
	[WarehouseID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Code] [varchar](100) NOT NULL,
	[Location] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[WarehouseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StockBalances]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockBalances](
	[StockBalanceID] [int] IDENTITY(1,1) NOT NULL,
	[Quantity] [decimal](18, 3) NOT NULL,
	[ProductID] [int] NOT NULL,
	[WarehouseID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StockBalanceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_CurrentStock]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_CurrentStock] AS
SELECT 
    p.ProductID, 
    p.Name AS ProductName, 
    w.Name AS WarehouseName, 
    sb.Quantity, 
    p.PurchasePrice AS UnitCost, 
    (sb.Quantity * p.PurchasePrice) AS TotalValue 
FROM StockBalances sb
INNER JOIN Products p ON sb.ProductID = p.ProductID
INNER JOIN Warehouses w ON sb.WarehouseID = w.WarehouseID;
GO
/****** Object:  Table [dbo].[InvoiceStatuses]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceStatuses](
	[StatusID] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Invoices]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoices](
	[InvoiceID] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceNumber] [varchar](100) NOT NULL,
	[InvoiceDate] [datetime] NOT NULL,
	[StatusID] [tinyint] NOT NULL,
	[Subtotal] [decimal](18, 2) NOT NULL,
	[DiscountAmount] [decimal](18, 2) NOT NULL,
	[TaxAmount] [decimal](18, 2) NOT NULL,
	[TotalAmount]  AS (([Subtotal]+[TaxAmount])-[DiscountAmount]),
	[Note] [nvarchar](500) NULL,
	[WarehouseID] [int] NOT NULL,
	[CreatedByID] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InvoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SalesInvoices]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesInvoices](
	[SalesInvoiceID] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SalesInvoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseInvoices]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseInvoices](
	[PurchaseInvoiceID] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceID] [int] NOT NULL,
	[SupplierID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PurchaseInvoiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[SupplierID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Phone] [varchar](100) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Address] [nvarchar](500) NOT NULL,
	[TaxNumber] [varchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Phone] [varchar](100) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Address] [nvarchar](500) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_InvoicesSummary]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_InvoicesSummary] AS
SELECT 
    i.InvoiceID, 
    i.InvoiceNumber, 
    i.CreatedAt, 
    InvoiceType = CASE    
        WHEN pi.InvoiceID IS NOT NULL THEN 'Purchase Invoice'
        WHEN si.InvoiceID IS NOT NULL THEN 'Sale Invoice'
        ELSE 'Unknown'
    END, 
    PartyName = ISNULL(s.Name, c.Name),
    w.Name AS WarehouseName, 
    (i.Subtotal + i.TaxAmount - i.DiscountAmount) AS NetTotal,
    ins.Name AS StatusName
FROM Invoices i 
LEFT JOIN PurchaseInvoices pi ON i.InvoiceID = pi.InvoiceID
LEFT JOIN SalesInvoices si ON i.InvoiceID = si.InvoiceID
LEFT JOIN Suppliers s ON pi.SupplierID = s.SupplierID
LEFT JOIN Customers c ON si.CustomerID = c.CustomerID
INNER JOIN Warehouses w ON i.WarehouseID = w.WarehouseID
INNER JOIN InvoiceStatuses ins ON i.StatusID = ins.StatusID;
GO
/****** Object:  Table [dbo].[Users]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Username] [varchar](100) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[PasswordHash] [nvarchar](100) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[RoleID] [int] NOT NULL,
	[RefreshToken] [nvarchar](max) NULL,
	[RefreshTokenExpiryTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ReferenceTypes]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReferenceTypes](
	[ReferenceTypeID] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ReferenceTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InventoryTransactions]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryTransactions](
	[InventoryTransactionID] [int] IDENTITY(1,1) NOT NULL,
	[IsInward] [bit] NOT NULL,
	[Quantity] [decimal](18, 3) NOT NULL,
	[UnitCost] [decimal](18, 2) NOT NULL,
	[ReferenceID] [int] NOT NULL,
	[ReferenceTypeID] [tinyint] NOT NULL,
	[Note] [nvarchar](500) NULL,
	[ProductID] [int] NOT NULL,
	[WarehouseID] [int] NOT NULL,
	[CreatedByID] [int] NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InventoryTransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_ItemLedger]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_ItemLedger] AS
SELECT 
    it.InventoryTransactionID, 
    it.CreatedAt AS TransactionDate,
    p.Name AS ProductName, 
    w.Name AS WarehouseName,   
    rt.Name AS TransactionType,
    MovementType = CASE 
        WHEN it.IsInward = 1 THEN 'Inward'
        WHEN it.IsInward = 0 THEN 'Outward'
        ELSE 'Unknown'
    END, 
    it.Quantity, 
    it.Note AS ReferenceDocument,
    u.Name AS CreatedByName
FROM InventoryTransactions it
INNER JOIN Products p ON it.ProductID = p.ProductID 
INNER JOIN Warehouses w ON it.WarehouseID = w.WarehouseID
INNER JOIN ReferenceTypes rt ON it.ReferenceTypeID = rt.ReferenceTypeID
INNER JOIN Users u ON it.CreatedByID = u.UserID;
GO
/****** Object:  Table [dbo].[Categories]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[CreatedAt] [datetime] NOT NULL,
	[ParentID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InvoiceItems]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceItems](
	[InvoiceItemID] [int] IDENTITY(1,1) NOT NULL,
	[InvoiceID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [decimal](18, 3) NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[DiscountAmount] [decimal](18, 2) NOT NULL,
	[TaxAmount] [decimal](18, 2) NOT NULL,
	[TotalAmount]  AS (([Quantity]*[UnitPrice]+[TaxAmount])-[DiscountAmount]),
PRIMARY KEY CLUSTERED 
(
	[InvoiceItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StockTransferItems]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockTransferItems](
	[StockTransferItemID] [int] IDENTITY(1,1) NOT NULL,
	[StockTransferID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [decimal](18, 3) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StockTransferItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StockTransfers]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StockTransfers](
	[StockTransferID] [int] IDENTITY(1,1) NOT NULL,
	[TransferNumber] [varchar](100) NOT NULL,
	[TransferDate] [datetime] NOT NULL,
	[StatusID] [tinyint] NOT NULL,
	[Note] [nvarchar](500) NULL,
	[FromWarehouseID] [int] NOT NULL,
	[ToWarehouseID] [int] NOT NULL,
	[CreatedByID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StockTransferID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransferStatuses]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransferStatuses](
	[StatusID] [tinyint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Units]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Units](
	[UnitID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UnitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[InvoiceStatuses] ON 

INSERT [dbo].[InvoiceStatuses] ([StatusID], [Name]) VALUES (5, N'Cancelled')
INSERT [dbo].[InvoiceStatuses] ([StatusID], [Name]) VALUES (1, N'Draft')
INSERT [dbo].[InvoiceStatuses] ([StatusID], [Name]) VALUES (4, N'Paid')
INSERT [dbo].[InvoiceStatuses] ([StatusID], [Name]) VALUES (3, N'PartiallyPaid')
INSERT [dbo].[InvoiceStatuses] ([StatusID], [Name]) VALUES (6, N'Refunded')
INSERT [dbo].[InvoiceStatuses] ([StatusID], [Name]) VALUES (2, N'Unpaid')
SET IDENTITY_INSERT [dbo].[InvoiceStatuses] OFF
GO
SET IDENTITY_INSERT [dbo].[ReferenceTypes] ON 

INSERT [dbo].[ReferenceTypes] ([ReferenceTypeID], [Name]) VALUES (6, N'InventoryAdjustment')
INSERT [dbo].[ReferenceTypes] ([ReferenceTypeID], [Name]) VALUES (1, N'PurchaseInvoice')
INSERT [dbo].[ReferenceTypes] ([ReferenceTypeID], [Name]) VALUES (4, N'PurchaseReturn')
INSERT [dbo].[ReferenceTypes] ([ReferenceTypeID], [Name]) VALUES (2, N'SalesInvoice')
INSERT [dbo].[ReferenceTypes] ([ReferenceTypeID], [Name]) VALUES (5, N'SalesReturn')
INSERT [dbo].[ReferenceTypes] ([ReferenceTypeID], [Name]) VALUES (3, N'StockTransfer')
SET IDENTITY_INSERT [dbo].[ReferenceTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleID], [Name]) VALUES (1, N'System Administrator')
INSERT [dbo].[Roles] ([RoleID], [Name]) VALUES (2, N'Warehouse Manager')
INSERT [dbo].[Roles] ([RoleID], [Name]) VALUES (3, N'Sales Representative')
INSERT [dbo].[Roles] ([RoleID], [Name]) VALUES (4, N'Purchasing Officer')
INSERT [dbo].[Roles] ([RoleID], [Name]) VALUES (5, N'Accountant')
SET IDENTITY_INSERT [dbo].[Roles] OFF
GO
SET IDENTITY_INSERT [dbo].[TransferStatuses] ON 

INSERT [dbo].[TransferStatuses] ([StatusID], [Name]) VALUES (4, N'Cancelled')
INSERT [dbo].[TransferStatuses] ([StatusID], [Name]) VALUES (3, N'Completed')
INSERT [dbo].[TransferStatuses] ([StatusID], [Name]) VALUES (2, N'InTransit')
INSERT [dbo].[TransferStatuses] ([StatusID], [Name]) VALUES (1, N'Pending')
SET IDENTITY_INSERT [dbo].[TransferStatuses] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserID], [Name], [Username], [Email], [PasswordHash], [IsActive], [CreatedAt], [RoleID], [RefreshToken], [RefreshTokenExpiryTime]) VALUES (1, N'Nizar Omar', N'Admin', N'nizar78787@icloud.com', N'8D969EEF6ECAD3C29A3A629280E686CF0C3F5D5A86AFF3CA12020C923ADC6C92', 1, CAST(N'2026-05-05T20:25:22.783' AS DateTime), 1, N'EBxk60Rd76s6MKVrsbrKNpNTvbQLDtyR2AKN81Vxjek=', CAST(N'2026-05-17T19:06:54.000' AS DateTime))
INSERT [dbo].[Users] ([UserID], [Name], [Username], [Email], [PasswordHash], [IsActive], [CreatedAt], [RoleID], [RefreshToken], [RefreshTokenExpiryTime]) VALUES (1001, N'Khalid Ahmed', N'Manager1', N'khalid642@gmail.com', N'8D969EEF6ECAD3C29A3A629280E686CF0C3F5D5A86AFF3CA12020C923ADC6C92', 1, CAST(N'2026-05-06T12:52:06.850' AS DateTime), 2, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Name], [Username], [Email], [PasswordHash], [IsActive], [CreatedAt], [RoleID], [RefreshToken], [RefreshTokenExpiryTime]) VALUES (2001, N'Sara', N'accountent1', N'sara324@gmail.com', N'8D969EEF6ECAD3C29A3A629280E686CF0C3F5D5A86AFF3CA12020C923ADC6C92', 1, CAST(N'2026-05-09T21:56:09.337' AS DateTime), 5, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Name], [Username], [Email], [PasswordHash], [IsActive], [CreatedAt], [RoleID], [RefreshToken], [RefreshTokenExpiryTime]) VALUES (2002, N'Qassem', N'accountent2', N'qassem3874@icloud.com', N'8D969EEF6ECAD3C29A3A629280E686CF0C3F5D5A86AFF3CA12020C923ADC6C92', 0, CAST(N'2026-05-09T21:58:06.770' AS DateTime), 5, NULL, NULL)
INSERT [dbo].[Users] ([UserID], [Name], [Username], [Email], [PasswordHash], [IsActive], [CreatedAt], [RoleID], [RefreshToken], [RefreshTokenExpiryTime]) VALUES (3001, N'Zakaria', N'zak574', N'zakr764@gmail.com', N'8D969EEF6ECAD3C29A3A629280E686CF0C3F5D5A86AFF3CA12020C923ADC6C92', 1, CAST(N'2026-05-10T18:14:37.237' AS DateTime), 3, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Customers_Email_Active]    Script Date: 10/29/2026 06:42:54 م ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Customers_Email_Active] ON [dbo].[Customers]
(
	[Email] ASC
)
WHERE ([IsActive]=(1))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Customers_Phone_Active]    Script Date: 10/29/2026 06:42:54 م ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Customers_Phone_Active] ON [dbo].[Customers]
(
	[Phone] ASC
)
WHERE ([IsActive]=(1))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_InventoryTransactions_ProductID]    Script Date: 10/29/2026 06:42:54 م ******/
CREATE NONCLUSTERED INDEX [IX_InventoryTransactions_ProductID] ON [dbo].[InventoryTransactions]
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_InventoryTransactions_WarehouseID]    Script Date: 10/29/2026 06:42:54 م ******/
CREATE NONCLUSTERED INDEX [IX_InventoryTransactions_WarehouseID] ON [dbo].[InventoryTransactions]
(
	[WarehouseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Invoices__D776E981C77CED73]    Script Date: 10/29/2026 06:42:54 م ******/
ALTER TABLE [dbo].[Invoices] ADD UNIQUE NONCLUSTERED 
(
	[InvoiceNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_Invoices_CreatedAt]    Script Date: 10/29/2026 06:42:54 م ******/
CREATE NONCLUSTERED INDEX [IX_Invoices_CreatedAt] ON [dbo].[Invoices]
(
	[CreatedAt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Invoices_InvoiceNumber]    Script Date: 10/29/2026 06:42:54 م ******/
CREATE NONCLUSTERED INDEX [IX_Invoices_InvoiceNumber] ON [dbo].[Invoices]
(
	[InvoiceNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__InvoiceS__737584F6DBAB6102]    Script Date: 10/29/2026 06:42:54 م ******/
ALTER TABLE [dbo].[InvoiceStatuses] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Products_Barcode_Active]    Script Date: 10/29/2026 06:42:54 م ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Products_Barcode_Active] ON [dbo].[Products]
(
	[Barcode] ASC
)
WHERE ([IsActive]=(1))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Products_Sku_Active]    Script Date: 10/29/2026 06:42:54 م ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Products_Sku_Active] ON [dbo].[Products]
(
	[Sku] ASC
)
WHERE ([IsActive]=(1))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Referenc__737584F6E30793BD]    Script Date: 10/29/2026 06:42:54 م ******/
ALTER TABLE [dbo].[ReferenceTypes] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__StockBal__366C4C11E1F65B99]    Script Date: 10/29/2026 06:42:54 م ******/
ALTER TABLE [dbo].[StockBalances] ADD UNIQUE NONCLUSTERED 
(
	[ProductID] ASC,
	[WarehouseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_StockBalances_Warehouse_Product]    Script Date: 10/29/2026 06:42:54 م ******/
CREATE NONCLUSTERED INDEX [IX_StockBalances_Warehouse_Product] ON [dbo].[StockBalances]
(
	[WarehouseID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_StockTransfers_TransferNumber]    Script Date: 10/29/2026 06:42:54 م ******/
ALTER TABLE [dbo].[StockTransfers] ADD  CONSTRAINT [UQ_StockTransfers_TransferNumber] UNIQUE NONCLUSTERED 
(
	[TransferNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Suppliers_Email_Active]    Script Date: 10/29/2026 06:42:54 م ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Suppliers_Email_Active] ON [dbo].[Suppliers]
(
	[Email] ASC
)
WHERE ([IsActive]=(1))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Suppliers_Phone_Active]    Script Date: 10/29/2026 06:42:54 م ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Suppliers_Phone_Active] ON [dbo].[Suppliers]
(
	[Phone] ASC
)
WHERE ([IsActive]=(1))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Suppliers_TaxNumber_Active]    Script Date: 10/29/2026 06:42:54 م ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Suppliers_TaxNumber_Active] ON [dbo].[Suppliers]
(
	[TaxNumber] ASC
)
WHERE ([IsActive]=(1))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Transfer__737584F6FD182337]    Script Date: 10/29/2026 06:42:54 م ******/
ALTER TABLE [dbo].[TransferStatuses] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Units__737584F6D605882B]    Script Date: 10/29/2026 06:42:54 م ******/
ALTER TABLE [dbo].[Units] ADD UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Users_Email_Active]    Script Date: 10/29/2026 06:42:54 م ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Users_Email_Active] ON [dbo].[Users]
(
	[Email] ASC
)
WHERE ([IsActive]=(1))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Users_Username_Active]    Script Date: 10/29/2026 06:42:54 م ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Users_Username_Active] ON [dbo].[Users]
(
	[Username] ASC
)
WHERE ([IsActive]=(1))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Warehouses_Code_Active]    Script Date: 10/29/2026 06:42:54 م ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Warehouses_Code_Active] ON [dbo].[Warehouses]
(
	[Code] ASC
)
WHERE ([IsActive]=(1))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Warehouses_Name_Active]    Script Date: 10/29/2026 06:42:54 م ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_Warehouses_Name_Active] ON [dbo].[Warehouses]
(
	[Name] ASC
)
WHERE ([IsActive]=(1))
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Categories] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Customers] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Customers] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[InventoryTransactions] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT (getdate()) FOR [InvoiceDate]
GO
ALTER TABLE [dbo].[Invoices] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Products] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[StockTransfers] ADD  DEFAULT (getdate()) FOR [TransferDate]
GO
ALTER TABLE [dbo].[Suppliers] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Suppliers] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Warehouses] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Warehouses] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Categories]  WITH CHECK ADD FOREIGN KEY([ParentID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[InventoryTransactions]  WITH CHECK ADD FOREIGN KEY([CreatedByID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[InventoryTransactions]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[InventoryTransactions]  WITH CHECK ADD FOREIGN KEY([ReferenceTypeID])
REFERENCES [dbo].[ReferenceTypes] ([ReferenceTypeID])
GO
ALTER TABLE [dbo].[InventoryTransactions]  WITH CHECK ADD FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[Warehouses] ([WarehouseID])
GO
ALTER TABLE [dbo].[InvoiceItems]  WITH CHECK ADD FOREIGN KEY([InvoiceID])
REFERENCES [dbo].[Invoices] ([InvoiceID])
GO
ALTER TABLE [dbo].[InvoiceItems]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[Invoices]  WITH CHECK ADD FOREIGN KEY([CreatedByID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Invoices]  WITH CHECK ADD FOREIGN KEY([StatusID])
REFERENCES [dbo].[InvoiceStatuses] ([StatusID])
GO
ALTER TABLE [dbo].[Invoices]  WITH CHECK ADD FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[Warehouses] ([WarehouseID])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD FOREIGN KEY([UnitID])
REFERENCES [dbo].[Units] ([UnitID])
GO
ALTER TABLE [dbo].[PurchaseInvoices]  WITH CHECK ADD FOREIGN KEY([InvoiceID])
REFERENCES [dbo].[Invoices] ([InvoiceID])
GO
ALTER TABLE [dbo].[PurchaseInvoices]  WITH CHECK ADD FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([SupplierID])
GO
ALTER TABLE [dbo].[SalesInvoices]  WITH CHECK ADD FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[SalesInvoices]  WITH CHECK ADD FOREIGN KEY([InvoiceID])
REFERENCES [dbo].[Invoices] ([InvoiceID])
GO
ALTER TABLE [dbo].[StockBalances]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[StockBalances]  WITH CHECK ADD FOREIGN KEY([WarehouseID])
REFERENCES [dbo].[Warehouses] ([WarehouseID])
GO
ALTER TABLE [dbo].[StockTransferItems]  WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[StockTransferItems]  WITH CHECK ADD FOREIGN KEY([StockTransferID])
REFERENCES [dbo].[StockTransfers] ([StockTransferID])
GO
ALTER TABLE [dbo].[StockTransfers]  WITH CHECK ADD FOREIGN KEY([CreatedByID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[StockTransfers]  WITH CHECK ADD FOREIGN KEY([FromWarehouseID])
REFERENCES [dbo].[Warehouses] ([WarehouseID])
GO
ALTER TABLE [dbo].[StockTransfers]  WITH CHECK ADD FOREIGN KEY([StatusID])
REFERENCES [dbo].[TransferStatuses] ([StatusID])
GO
ALTER TABLE [dbo].[StockTransfers]  WITH CHECK ADD FOREIGN KEY([ToWarehouseID])
REFERENCES [dbo].[Warehouses] ([WarehouseID])
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[InventoryTransactions]  WITH CHECK ADD CHECK  (([Quantity]>=(0)))
GO
ALTER TABLE [dbo].[InventoryTransactions]  WITH CHECK ADD CHECK  (([UnitCost]>=(0)))
GO
ALTER TABLE [dbo].[InvoiceItems]  WITH CHECK ADD CHECK  (([DiscountAmount]>=(0)))
GO
ALTER TABLE [dbo].[InvoiceItems]  WITH CHECK ADD CHECK  (([Quantity]>(0)))
GO
ALTER TABLE [dbo].[InvoiceItems]  WITH CHECK ADD CHECK  (([TaxAmount]>=(0)))
GO
ALTER TABLE [dbo].[InvoiceItems]  WITH CHECK ADD CHECK  (([UnitPrice]>=(0)))
GO
ALTER TABLE [dbo].[Invoices]  WITH CHECK ADD CHECK  (([DiscountAmount]>=(0)))
GO
ALTER TABLE [dbo].[Invoices]  WITH CHECK ADD CHECK  (([Subtotal]>=(0)))
GO
ALTER TABLE [dbo].[Invoices]  WITH CHECK ADD CHECK  (([TaxAmount]>=(0)))
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [CHK_Product_Dates] CHECK  (([UpdatedAt]>=[CreatedAt]))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [CHK_Product_Dates]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD CHECK  (([MinStock]>=(0)))
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD CHECK  (([PurchasePrice]>=(0)))
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD CHECK  (([SalePrice]>=(0)))
GO
ALTER TABLE [dbo].[StockBalances]  WITH CHECK ADD CHECK  (([Quantity]>=(0)))
GO
ALTER TABLE [dbo].[StockTransferItems]  WITH CHECK ADD CHECK  (([Quantity]>=(0)))
GO
ALTER TABLE [dbo].[StockTransfers]  WITH CHECK ADD  CONSTRAINT [CHK_Transfer_Warehouses] CHECK  (([ToWarehouseID]<>[FromWarehouseID]))
GO
ALTER TABLE [dbo].[StockTransfers] CHECK CONSTRAINT [CHK_Transfer_Warehouses]
GO
/****** Object:  StoredProcedure [dbo].[sp_ApprovePurchaseInvoice]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ApprovePurchaseInvoice]
    @InvoiceNumber VARCHAR(100),
    @SupplierID INT,
    @WarehouseID INT,
    @CreatedByID INT,
    @Subtotal DECIMAL(18,2),
    @DiscountAmount DECIMAL(18,2),
    @TaxAmount DECIMAL(18,2),
    @Note NVARCHAR(500),
    @Items dbo.InvoiceItemType READONLY
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CalcSubtotal DECIMAL(18,2) = ISNULL((SELECT SUM(Quantity * UnitPrice)
    FROM @Items), 0);
    DECLARE @CalcDiscount DECIMAL(18,2) = ISNULL((SELECT SUM(DiscountAmount)
    FROM @Items), 0);
    DECLARE @CalcTax DECIMAL(18,2) = ISNULL((SELECT SUM(TaxAmount)
    FROM @Items), 0);

    IF (@CalcSubtotal <> @Subtotal OR @CalcDiscount <> @DiscountAmount OR @CalcTax <> @TaxAmount)
    BEGIN
        ;THROW 50001, 'Security Error: Invoice totals do not match the sum of items.', 1;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Invoices
        (InvoiceNumber, StatusID, Subtotal, DiscountAmount, TaxAmount, Note, WarehouseID, CreatedByID)
    VALUES
        (@InvoiceNumber, 2, @Subtotal, @DiscountAmount, @TaxAmount, @Note, @WarehouseID, @CreatedByID);

        DECLARE @NewInvoiceID INT = SCOPE_IDENTITY();

        INSERT INTO PurchaseInvoices
        (InvoiceID, SupplierID)
    VALUES
        (@NewInvoiceID, @SupplierID);

        INSERT INTO InvoiceItems
        (InvoiceID, ProductID, Quantity, UnitPrice, DiscountAmount, TaxAmount)
    SELECT @NewInvoiceID, ProductID, Quantity, UnitPrice, DiscountAmount, TaxAmount
    FROM @Items;

        UPDATE sb 
        SET sb.Quantity = sb.Quantity + i.TotalQuantity
        FROM StockBalances sb
        INNER JOIN (SELECT ProductID, SUM(Quantity) AS TotalQuantity
        FROM @Items
        GROUP BY ProductID) i
        ON sb.ProductID = i.ProductID
        WHERE sb.WarehouseID = @WarehouseID;

        INSERT INTO StockBalances
        (Quantity, ProductID, WarehouseID)
    SELECT i.TotalQuantity, i.ProductID, @WarehouseID
    FROM (SELECT ProductID, SUM(Quantity) AS TotalQuantity
        FROM @Items
        GROUP BY ProductID) i
        LEFT JOIN StockBalances sb
        ON i.ProductID = sb.ProductID AND sb.WarehouseID = @WarehouseID
    WHERE sb.ProductID IS NULL;

        INSERT INTO InventoryTransactions
        (IsInward, Quantity, UnitCost, ReferenceID, ReferenceTypeID, ProductID, WarehouseID, CreatedByID, Note)
    SELECT 1, i.Quantity, i.UnitPrice, @NewInvoiceID, 1, i.ProductID, @WarehouseID, @CreatedByID, 'Purchases Invoice No. ' + @InvoiceNumber
    FROM @Items i;

        UPDATE p 
        SET p.PurchasePrice = i.NewPurchasePrice 
        FROM Products p
        INNER JOIN (SELECT ProductID, MAX(UnitPrice) AS NewPurchasePrice
        FROM @Items
        GROUP BY ProductID) i
        ON p.ProductID = i.ProductID;
        
        COMMIT TRANSACTION;
    END TRY 
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        ;THROW;
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ApproveSalesInvoice]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ApproveSalesInvoice]
    @InvoiceNumber VARCHAR(100),
    @CustomerID INT,
    @WarehouseID INT,
    @CreatedByID INT,
    @Subtotal DECIMAL(18,2),
    @DiscountAmount DECIMAL(18,2),
    @TaxAmount DECIMAL(18,2),
    @Note NVARCHAR(500),
    @Items dbo.InvoiceItemType READONLY
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CalcSubtotal DECIMAL(18,2) = ISNULL((SELECT SUM(Quantity * UnitPrice)
    FROM @Items), 0);
    DECLARE @CalcDiscount DECIMAL(18,2) = ISNULL((SELECT SUM(DiscountAmount)
    FROM @Items), 0);
    DECLARE @CalcTax DECIMAL(18,2) = ISNULL((SELECT SUM(TaxAmount)
    FROM @Items), 0);

    IF (@CalcSubtotal <> @Subtotal OR @CalcDiscount <> @DiscountAmount OR @CalcTax <> @TaxAmount)
    BEGIN
        ;THROW 50001, 'Security Error: Invoice totals do not match the sum of items.', 1;
    END

    IF EXISTS (
        SELECT 1
    FROM (SELECT ProductID, SUM(Quantity) AS TotalQty
        FROM @Items
        GROUP BY ProductID) i
        LEFT JOIN StockBalances sb ON i.ProductID = sb.ProductID AND sb.WarehouseID = @WarehouseID
    WHERE i.TotalQty > ISNULL(sb.Quantity, 0)
    )
    BEGIN
        ;THROW 50002, 'Insufficient stock in the warehouse for one or more requested items.', 1;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Invoices
        (InvoiceNumber, StatusID, Subtotal, DiscountAmount, TaxAmount, Note, WarehouseID, CreatedByID)
    VALUES
        (@InvoiceNumber, 2, @Subtotal, @DiscountAmount, @TaxAmount, @Note, @WarehouseID, @CreatedByID);

        DECLARE @NewInvoiceID INT = SCOPE_IDENTITY();

        INSERT INTO SalesInvoices
        (InvoiceID, CustomerID)
    VALUES
        (@NewInvoiceID, @CustomerID);

        INSERT INTO InvoiceItems
        (InvoiceID, ProductID, Quantity, UnitPrice, DiscountAmount, TaxAmount)
    SELECT @NewInvoiceID, ProductID, Quantity, UnitPrice, DiscountAmount, TaxAmount
    FROM @Items;

        UPDATE sb
        SET sb.Quantity = sb.Quantity - i.TotalQuantity
        FROM StockBalances sb
        INNER JOIN (SELECT ProductID, SUM(Quantity) AS TotalQuantity
        FROM @Items
        GROUP BY ProductID) i
        ON sb.ProductID = i.ProductID
        WHERE sb.WarehouseID = @WarehouseID;

        INSERT INTO InventoryTransactions
        (IsInward, Quantity, UnitCost, ReferenceID, ReferenceTypeID, ProductID, WarehouseID, CreatedByID, Note)
    SELECT 0, i.Quantity, p.PurchasePrice, @NewInvoiceID, 2, i.ProductID, @WarehouseID, @CreatedByID, 'Sales Invoice No. ' + @InvoiceNumber
    FROM @Items i
        INNER JOIN Products p ON i.ProductID = p.ProductID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        ;THROW;
    END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ExecuteStockTransfer]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ExecuteStockTransfer]
    @TransferNumber VARCHAR(100),
    @SourceWarehouseID INT,
    @DestinationWarehouseID INT,
    @CreatedByID INT,
    @Note NVARCHAR(500),
    @Items dbo.TransferItemType READONLY
AS
BEGIN

    IF (@SourceWarehouseID = @DestinationWarehouseID)
    BEGIN
        ;THROW 50003, 'Cannot transfer between the same warehouse.', 1;
    END

    IF EXISTS (SELECT 1
    FROM (SELECT ProductID, SUM(Quantity) AS TotalQty
        FROM @Items
        GROUP BY ProductID) i LEFT JOIN StockBalances sb
        ON i.ProductID = sb.ProductID AND sb.WarehouseID = @SourceWarehouseID
    WHERE i.TotalQty > ISNULL(sb.Quantity, 0))
    BEGIN
        ;THROW 50002, 'Insufficient stock in the warehouse for one or more requested items.', 1;
    END

    BEGIN TRY
        BEGIN TRANSACTION

            INSERT INTO StockTransfers
        (TransferNumber, StatusID, Note, FromWarehouseID, ToWarehouseID, CreatedByID)
    VALUES
        (@TransferNumber, 3, @Note, @SourceWarehouseID, @DestinationWarehouseID, @CreatedByID)
            
            DECLARE @NewStockTransferID INT = SCOPE_IDENTITY();

            INSERT INTO StockTransferItems
        (StockTransferID, ProductID, Quantity)
    SELECT @NewStockTransferID, i.ProductID, i.Quantity
    FROM @Items i

            UPDATE sb 
            SET sb.Quantity = sb.Quantity - i.TotalQty
            FROM StockBalances sb INNER JOIN (SELECT ProductID, SUM(Quantity) AS TotalQty
        FROM @Items
        GROUP BY ProductID) i ON sb.ProductID = i.ProductID AND sb.WarehouseID = @SourceWarehouseID

            UPDATE sb 
        SET sb.Quantity = sb.Quantity + i.TotalQuantity
        FROM StockBalances sb
        INNER JOIN (SELECT ProductID, SUM(Quantity) AS TotalQuantity
        FROM @Items
        GROUP BY ProductID) i
        ON sb.ProductID = i.ProductID
        WHERE sb.WarehouseID = @DestinationWarehouseID;

        INSERT INTO StockBalances
        (Quantity, ProductID, WarehouseID)
    SELECT i.TotalQuantity, i.ProductID, @DestinationWarehouseID
    FROM (SELECT ProductID, SUM(Quantity) AS TotalQuantity
        FROM @Items
        GROUP BY ProductID) i
        LEFT JOIN StockBalances sb
        ON i.ProductID = sb.ProductID AND sb.WarehouseID = @DestinationWarehouseID
    WHERE sb.ProductID IS NULL;

         INSERT INTO InventoryTransactions
        (IsInward, Quantity, UnitCost, ReferenceID, ReferenceTypeID, ProductID, WarehouseID, CreatedByID, Note)
    SELECT 0, i.Quantity, p.PurchasePrice, @NewStockTransferID, 3, i.ProductID, @SourceWarehouseID, @CreatedByID, 'Transfer No. ' + @TransferNumber
    FROM @Items i
        INNER JOIN Products p ON i.ProductID = p.ProductID;

        INSERT INTO InventoryTransactions
        (IsInward, Quantity, UnitCost, ReferenceID, ReferenceTypeID, ProductID, WarehouseID, CreatedByID, Note)
    SELECT 1, i.Quantity, p.PurchasePrice, @NewStockTransferID, 3, i.ProductID, @DestinationWarehouseID, @CreatedByID, 'Transfer No. ' + @TransferNumber
    FROM @Items i
        INNER JOIN Products p ON i.ProductID = p.ProductID;

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        ;THROW;
    END CATCH
END
GO
/****** Object:  Trigger [dbo].[trg_InsteadOfDeleteCustomer]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[trg_InsteadOfDeleteCustomer] ON [dbo].[Customers]
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE C
    SET C.IsActive = 0
    FROM Customers C
    INNER JOIN deleted D ON C.CustomerID = D.CustomerID
    WHERE C.IsActive = 1;
END;
GO
ALTER TABLE [dbo].[Customers] ENABLE TRIGGER [trg_InsteadOfDeleteCustomer]
GO
/****** Object:  Trigger [dbo].[trg_ProtectInventoryTransactions]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[trg_ProtectInventoryTransactions]
ON [dbo].[InventoryTransactions]
INSTEAD OF UPDATE, DELETE
AS
BEGIN
    ;THROW 50004, 'Security Alert: Cannot update or delete inventory transactions. Please use adjustment or return processes.', 1;
END
GO
ALTER TABLE [dbo].[InventoryTransactions] ENABLE TRIGGER [trg_ProtectInventoryTransactions]
GO
/****** Object:  Trigger [dbo].[trg_ProtectInvoices]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[trg_ProtectInvoices]
ON [dbo].[Invoices]
INSTEAD OF DELETE
AS
BEGIN
    ;THROW 50005, 'Security Alert: Cannot delete invoices permanently. Please cancel them or create a return invoice instead.', 1;
END
GO
ALTER TABLE [dbo].[Invoices] ENABLE TRIGGER [trg_ProtectInvoices]
GO
/****** Object:  Trigger [dbo].[trg_InsteadOfDeleteProduct]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[trg_InsteadOfDeleteProduct] ON [dbo].[Products]
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE P
    SET P.IsActive = 0
    FROM Products P
    INNER JOIN deleted D ON P.ProductID = D.ProductID
    WHERE P.IsActive = 1;
END;
GO
ALTER TABLE [dbo].[Products] ENABLE TRIGGER [trg_InsteadOfDeleteProduct]
GO
/****** Object:  Trigger [dbo].[trg_InsteadOfDeleteSupplier]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[trg_InsteadOfDeleteSupplier] ON [dbo].[Suppliers]
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE S
    SET S.IsActive = 0
    FROM Suppliers S
    INNER JOIN deleted D ON S.SupplierID = D.SupplierID
    WHERE S.IsActive = 1;
END;
GO
ALTER TABLE [dbo].[Suppliers] ENABLE TRIGGER [trg_InsteadOfDeleteSupplier]
GO
/****** Object:  Trigger [dbo].[trg_InsteadOfDeleteUser]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[trg_InsteadOfDeleteUser] ON [dbo].[Users]
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE U
    SET U.IsActive = 0
    FROM Users U
    INNER JOIN deleted D ON U.UserID = D.UserID
    WHERE U.IsActive = 1;
END;
GO
ALTER TABLE [dbo].[Users] ENABLE TRIGGER [trg_InsteadOfDeleteUser]
GO
/****** Object:  Trigger [dbo].[trg_InsteadOfDeleteWarehouse]    Script Date: 10/29/2026 06:42:54 م ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[trg_InsteadOfDeleteWarehouse] ON [dbo].[Warehouses]
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE W
    SET W.IsActive = 0
    FROM Warehouses W
    INNER JOIN deleted D ON W.WarehouseID = D.WarehouseID
    WHERE W.IsActive = 1;
END;
GO
ALTER TABLE [dbo].[Warehouses] ENABLE TRIGGER [trg_InsteadOfDeleteWarehouse]
GO
USE [master]
GO
ALTER DATABASE [WarehouseDB] SET  READ_WRITE 
GO
