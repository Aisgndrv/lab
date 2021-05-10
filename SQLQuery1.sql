CREATE DATABASE BLOG
USE BLOG

CREATE TABLE Category
(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(50)
)

CREATE TABLE Tags
(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(50)
)

CREATE TABLE Blog
(
Id INT PRIMARY KEY IDENTITY,
Title NVARCHAR(200),
Text NVARCHAR(2500),
CategoryId INT CONSTRAINT FK_Ctgry FOREIGN KEY (CategoryId) REFERENCES Category(Id),
BlogPhoto NVARCHAR(400),
AddedDate DATETIME2,
IsPopular BIT

)

CREATE TABLE [User]
(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(30),
Surname NVARCHAR(30),
Email Nvarchar(20)
)

CREATE TABLE BlogReviews
(
Id INT PRIMARY KEY IDENTITY,
Review NVARCHAR(100),
UserId INT CONSTRAINT FK_User FOREIGN KEY (UserId) REFERENCES [User](Id),
BlogId INT CONSTRAINT FK_Blogs FOREIGN KEY (UserId) REFERENCES Blog(Id)
)

CREATE TABLE TagsBlogs
(
Id  INT PRIMARY KEY IDENTITY,
TagId INT CONSTRAINT FK_tags FOREIGN KEY (TagId) REFERENCES Tags(Id),
BlogId INT CONSTRAINT FK_blogg FOREIGN KEY (BlogId) REFERENCES Blog(Id)
)

--blog title ve addeddate cixaran view
CREATE VIEW vw_titleAndDate
AS
SELECT Blog.Title AS 'BlogTitle',Blog.AddedDate AS 'Date' FROM Blog

SELECT*FROM vw_titleAndDate
--blog title addeddate ve categoryname va tagname cixaran view
SELECT Blog.Title AS 'BlogTitle',Blog.AddedDate AS 'Date',Category.Name AS 'CategoryName',Tags.Name AS 'TagName' FROM Blog
INNER JOIN Category ON Category.Id=Blog.CategoryId
INNER JOIN TagsBlogs ON Blog.Id=TagsBlogs.BlogId
INNER JOIN Tags ON Tags.Id=TagsBlogs.TagId
--titlein uzunlugu 10-dan boyuk olan blog-lar view
CREATE VIEW vw_Lens
AS
SELECT*FROM Blog WHERE LEN(Blog.Title)>3

SELECT *FROM vw_Lens
--parametrler verilir ona gore title-i hemin parametrden b
CREATE PROCEDURE usp_TwoValue
@Min INT ,
@Max INT
AS
SELECT *FROM Blog WHERE LEN(Blog.Title) BETWEEN @Min AND @Max

EXEC usp_TwoValue 2,10
--title-e aaidolan search gonderen procedure
CREATE PROCEDURE usp_Search
@Search NVARCHAR(50)
AS
SELECT *FROM Blog WHERE Blog.Title LIKE '%'+@Search+'%'

EXEC usp_Search 'ti'