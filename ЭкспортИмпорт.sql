use LibraryDB;

exec master.dbo.sp_configure 'show advanced options', 1;
RECONFIGURE;

exec master.dbo.sp_configure 'xp_cmdshell', 1;
RECONFIGURE;

create function ExportToXMlTable (@path nvarchar(500), @tableName nvarchar(100))
returns int as 
	begin
	declare @fullTableName nvarchar(100) = 'LibraryDB.dbo.' + @tableName;
	declare @sql nvarchar(500) = 'BCP "SELECT * FROM  '+@fullTableName+' FOR XML PATH(''Tag''), ROOT(''Root'')" QUERYOUT '+@path+' -r -t -T -w -S .\SQLEXPRESS';	
		EXEC xp_cmdshell @sql;
	return 1;
end;

drop function ExportToXML


create procedure ExportToXML
	@path nvarchar(500)
as
begin
  declare @books int
  declare @connectionBF int
  declare @files int
  declare @issue int
  declare @reader int
  declare @users int

  set @books = dbo.ExportToXMLTable(@path + 'Books.xml', 'Books');
  set @connectionBF = dbo.ExportToXMLTable(@path + 'ConnectionBF.xml', 'ConnectionBF');
  set @files = dbo.ExportToXMLTable(@path + 'Files.xml', 'Files');
  set @issue = dbo.ExportToXMLTable(@path + 'Issue.xml', 'Issue');
  set @reader = dbo.ExportToXMLTable(@path + 'Reader.xml', 'Reader');
  set @users = dbo.ExportToXMLTable(@path + 'Users.xml', 'Users');
end;


Exec dbo.ExportToXML 'C:\XML\';


create procedure ImportFromXmlBooks
@path nvarchar(500) as
begin
	SET XACT_ABORT ON  
	BEGIN TRAN
	declare @results table (x xml)			
	declare @sql nvarchar(300)='SELECT CAST(x AS XML) FROM OPENROWSET(BULK '''+@path+''', SINGLE_BLOB) AS T(x)'; 
 
	INSERT INTO @results EXEC (@sql) 

	declare @xml XML = (SELECT  TOP 1 x from  @results);
	insert into Books(Title, Author, Description, PYear, Status, Image)
		SELECT 
		P.value('Title[1]', 'nvarchar(255)') AS Title,
		P.value('Author[1]', 'nvarchar(255)') AS Author,
		P.value('Description[1]', 'nvarchar(max)') AS Description,
		P.value('PYear[1]', 'int') AS PYear,
		P.value('Status[1]', 'nvarchar(12)') AS Status,
		P.value('Image[1]', 'varbinary(max)') AS Image
		FROM @xml.nodes('Root/Tag') AS T3(P) 
	COMMIT;
end;
go



create procedure ImportFromXmlConnectionBF
@path nvarchar(500) as
begin
	SET XACT_ABORT ON  
	BEGIN TRAN
	declare @results table (x xml)			
	declare @sql nvarchar(300)='SELECT CAST(x AS XML) FROM OPENROWSET(BULK '''+@path+''', SINGLE_BLOB) AS T(x)'; 
	
	INSERT INTO @results EXEC (@sql) 

	declare @xml XML = (SELECT  TOP 1 x from  @results);
	insert into ConnectionBF(BId, FId)
		SELECT 
		P.value('BId[1]', 'int') AS BId,
		P.value('FId[1]', 'int') AS FId
		FROM @xml.nodes('Root/Tag') AS T3(P) 
	COMMIT;
end;
go



create procedure ImportFromXmlFiles
@path nvarchar(500) as
begin
	SET XACT_ABORT ON  
	BEGIN TRAN
	declare @results table (x xml)			
	declare @sql nvarchar(300)='SELECT CAST(x AS XML) FROM OPENROWSET(BULK '''+@path+''', SINGLE_BLOB) AS T(x)'; 
 
	INSERT INTO @results EXEC (@sql) 

	declare @xml XML = (SELECT  TOP 1 x from  @results);
	insert into Files(FName, BFile)
		SELECT 
		P.value('FName[1]', 'nvarchar(255)') AS FName,
		P.value('BFile[1]', 'varbinary(max)') AS BFile	
		FROM @xml.nodes('Root/Tag') AS T3(P) 
	COMMIT;
end;
go



create procedure ImportFromXmlIssue
@path nvarchar(500) as
begin
	SET XACT_ABORT ON  
	BEGIN TRAN
	declare @results table (x xml)			
	declare @sql nvarchar(300)='SELECT CAST(x AS XML) FROM OPENROWSET(BULK '''+@path+''', SINGLE_BLOB) AS T(x)'; 
 
	INSERT INTO @results EXEC (@sql) 

	declare @xml XML = (SELECT  TOP 1 x from  @results);
	insert into Issue(BookId, IssueDate, ReaderCard)
		SELECT 
		P.value('BookId[1]', 'int') AS BookId,
		P.value('IssueDate[1]', 'date') AS IssueDate,
		P.value('ReaderCard[1]', 'int') AS ReaderCard
		FROM @xml.nodes('Root/Tag') AS T3(P) 
	COMMIT;
end;
go





create procedure ImportFromXmlReader
@path nvarchar(500) as
begin
	SET XACT_ABORT ON  
	BEGIN TRAN
	declare @results table (x xml)			
	declare @sql nvarchar(300)='SELECT CAST(x AS XML) FROM OPENROWSET(BULK '''+@path+''', SINGLE_BLOB) AS T(x)'; 
 
	INSERT INTO @results EXEC (@sql) 

	declare @xml XML = (SELECT  TOP 1 x from  @results);
	insert into Reader(Card, FullName)
		SELECT 
		P.value('Card[1]', 'int') AS Card,
		P.value('FullName[1]', 'varchar(255)') AS FullName		
		FROM @xml.nodes('Root/Tag') AS T3(P) 
	COMMIT;
end;
go

create procedure ImportFromXmlUsers
@path nvarchar(500) as
begin
	SET XACT_ABORT ON  
	BEGIN TRAN
	declare @results table (x xml)			
	declare @sql nvarchar(300)='SELECT CAST(x AS XML) FROM OPENROWSET(BULK '''+@path+''', SINGLE_BLOB) AS T(x)'; 
 
	INSERT INTO @results EXEC (@sql) 

	declare @xml XML = (SELECT  TOP 1 x from  @results);
	insert into Users(Flag, Username, UPassword, CardId)
		SELECT 
		P.value('Flag[1]', 'nvarchar(2)') AS Flag,
		P.value('Username[1]', 'varchar(255)') AS Username,
		P.value('UPassword[1]', 'varchar(255)') AS UPassword,
		P.value('CardId[1]', 'int') AS CardId	
		FROM @xml.nodes('Root/Tag') AS T3(P) 
	COMMIT;
end;
go


----выполняем импорт во все импортируемые таблицы
create procedure ImportFromXML
as
begin
  exec dbo.ImportFromXmlReader 'C:\XML\Reader.xml'
  exec dbo.ImportFromXmlUsers 'C:\XML\Users.xml'
end;

drop proc ImportFromXML

exec dbo.ImportFromXML;

exec dbo.ImportFromXmlBooks 'C:\XML\Books.xml'
  exec dbo.ImportFromXmlConnectionBF 'C:\XML\ConnectionBF.xml'
  exec dbo.ImportFromXmlFiles'C:\XML\Files.xml'
  exec dbo.ImportFromXmlIssue'C:\XML\Issue.xml'