-------------------------------------------------------------------------------
-- `Book`
-- Przykładowa tabela zawierająca książki kucharskie
-------------------------------------------------------------------------------
CREATE TABLE [dbo].[Books](
	[Id] [int] IDENTITY(1,1) NOT NULL, --Klucz główny tabeli
	[Author] [nvarchar](255) NOT NULL, --Autor książki
	[Isbn] [nvarchar](255) NOT NULL, --Numer ISBN książki
	[Title] [nvarchar](255) NOT NULL, -- Tytuł książki
 CONSTRAINT [PK_Books] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-------------------------------------------------------------------------------
-- `DayName`
-- Tabela zawierająca nazwy dni
-------------------------------------------------------------------------------
CREATE TABLE [dbo].[DayNames](
	[Id] [int] IDENTITY(1,1) NOT NULL, --Klucz główny tabeli
	[DisplayOrder] [int] NOT NULL, --Kolejność wyświetlania
	[Name] [nvarchar](45) NOT NULL, --Nazwa dnia
 CONSTRAINT [PK_DayNames] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-------------------------------------------------------------------------------
-- `Page`
-- Tabela zawierająca dynamiczną zawartość stron
-------------------------------------------------------------------------------
CREATE TABLE [dbo].[Pages](
	[Id] [int] IDENTITY(1,1) NOT NULL, --Klucz główny tabeli
	[Title] [nvarchar](245) NOT NULL, --Tytuł strony
	[Description] [nvarchar](max) NULL, --Zawartość strony
	[Slug] [nvarchar](245) NOT NULL, --Unikalny identyfikator strony tworzony na podstawie tytułu
 CONSTRAINT [PK_Pages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Pages_Slug] ON [dbo].[Pages]
(
	[Slug] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

-------------------------------------------------------------------------------
-- `Recipe`
-- Tabela zawierająca przepisy
-------------------------------------------------------------------------------
CREATE TABLE [dbo].[Recipes](
	[Id] [int] IDENTITY(1,1) NOT NULL, --Klucz główny tabeli
	[Name] [nvarchar](255) NOT NULL, --Nazwa przepisu
	[Ingredients] [nvarchar](max) NOT NULL, --Składniki przepisu
	[Description] [nvarchar](max) NULL, --Opis przepisu
	[Created] [datetime2](7) NOT NULL, --Data dodania
	[Updated] [datetime2](7) NULL, --Data edycji
	[PreparationTime] [int] NOT NULL, --Czas przygotowania w minutach
	[Preparation] [nvarchar](max) NOT NULL, --Sposób przygotowania
	[UserId] [nvarchar](450) NULL, --Klucz obcy tabeli AspNetUser
 CONSTRAINT [PK_Recipes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Recipes]  WITH CHECK ADD  CONSTRAINT [FK_Recipes_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Recipes] CHECK CONSTRAINT [FK_Recipes_AspNetUsers_UserId]
GO

-------------------------------------------------------------------------------
-- `Plan`
-- Tabela zawierająca informacje na temat planów
-------------------------------------------------------------------------------
CREATE TABLE [dbo].[Plans](
	[Id] [int] IDENTITY(1,1) NOT NULL, --Klucz główny tabeli
	[Name] [nvarchar](45) NOT NULL, --Nazwa planu
	[Description] [nvarchar](max) NULL, --Opis planu
	[Created] [datetime2](7) NOT NULL, --Data utworzenia
	[UserId] [nvarchar](450) NULL, --Klucz obcy tabeli AspNetUser
 CONSTRAINT [PK_Plans] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[Plans]  WITH CHECK ADD  CONSTRAINT [FK_Plans_AspNetUsers_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[AspNetUsers] ([Id])
GO
ALTER TABLE [dbo].[Plans] CHECK CONSTRAINT [FK_Plans_AspNetUsers_UserId]
GO

-------------------------------------------------------------------------------
-- `RecipePlan`
-- Tabela zawierająca informacje o połączeniu przepisu oraz planu
-------------------------------------------------------------------------------
CREATE TABLE [dbo].[RecipePlans](
	[Id] [int] IDENTITY(1,1) NOT NULL, --Klucz główny tabeli
	[MealName] [nvarchar](245) NOT NULL, --Nazwa posiłku
	[DisplayOrder] [int] NOT NULL, --Kolejność wyświetlania posiłku w ciągu dnia
	[DayNameId] [int] NOT NULL, --Klucz obcy tabeli dni
	[PlanId] [int] NOT NULL, --Klucz obcy tabeli plany
	[RecipeId] [int] NOT NULL, --Klucz obcy tabeli przepisów
 CONSTRAINT [PK_RecipePlans] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RecipePlans]  WITH CHECK ADD  CONSTRAINT [FK_RecipePlans_DayNames_DayNameId] FOREIGN KEY([DayNameId])
REFERENCES [dbo].[DayNames] ([Id])
GO
ALTER TABLE [dbo].[RecipePlans] CHECK CONSTRAINT [FK_RecipePlans_DayNames_DayNameId]
GO
ALTER TABLE [dbo].[RecipePlans]  WITH CHECK ADD  CONSTRAINT [FK_RecipePlans_Plans_PlanId] FOREIGN KEY([PlanId])
REFERENCES [dbo].[Plans] ([Id])
GO
ALTER TABLE [dbo].[RecipePlans] CHECK CONSTRAINT [FK_RecipePlans_Plans_PlanId]
GO
ALTER TABLE [dbo].[RecipePlans]  WITH CHECK ADD  CONSTRAINT [FK_RecipePlans_Recipes_RecipeId] FOREIGN KEY([RecipeId])
REFERENCES [dbo].[Recipes] ([Id])
GO
ALTER TABLE [dbo].[RecipePlans] CHECK CONSTRAINT [FK_RecipePlans_Recipes_RecipeId]
GO
