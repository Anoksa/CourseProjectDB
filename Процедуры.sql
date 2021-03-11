use LibraryDB;


create proc BookSummary as
Select Id, Title, Author, Description, PYear, Status, Image
From Books;

drop proc BookSummary;

exec BookSummary;


create proc AddBook
	@title nvarchar(255),
	@author nvarchar(255),
	@description nvarchar(max),
	@pYear int,
	@status nvarchar(11),
	@image varbinary(max)
	as insert into Books(Title, Author, Description, PYear, Status, Image)
	Values (@title, @author, @description, @pYear, @status, @image)


drop proc AddBook;

create proc AddFile
	@fName nvarchar(255),
	@bFile varbinary(max)
as insert into Files(FName, BFile)
values (@fName, @bFile);

drop proc AddFile;

exec AddBook 'Колобок' , 'Народ','Народная сказка', 1990, null

create proc DeleteBook
	@title nvarchar(255),
	@id int
	as delete from Books where Title=@title and Id=@id

drop proc DeleteBook;
6 8 11
exec DeleteBook 'Книга 4', 11;



create proc Connection
	@BId int,
	@FId int
as insert into ConnectionBF(BId, FId)
values(@BId, @FId);

exec Connection 11, 5


create proc AddUser
	@flag nvarchar(2),
	@username nvarchar(255),
	@uPassword nvarchar(255),
	@cardId int
as insert into Users(Flag, Username, UPassword, CardId)
values (@flag, @username, @uPassword, @cardId)

drop proc AddUser;

exec AddUser 'ad', 'admin', 'admin', null

declare @number int
set @number =1;

while @number <100000
	begin 
		exec AddUser 'ad', 'test', 'admin', null
		Set @number = @number +1
		end;

create proc ShowUsers
	as select * from Users

exec ShowUsers;

drop proc ShowUsers;

create proc AddReader
	@fullName nvarchar(255),
	@username nvarchar(255)
as insert into Reader(FullName, Username)
values (@fullName, @username)

drop proc AddReader;

create proc DeleteUser
	@Username nvarchar(255)
as delete from Users where Username=@Username;

exec DeleteUser 'mark';

delete from Reader  where Username='mark';

drop proc DeleteUser;




create proc FindUser
	@username nvarchar(255),
	@uPassword nvarchar(255)
as select * from Users where Username=@username and UPassword=@uPassword;

exec FindUser 'admin', 'admin'

create proc UserType
	@username nvarchar(255)
as select Flag from Users where Username=@username;

exec Usertype 'admin'

create proc ChangeCard
	@cardId int,
	@username nvarchar(255)
as update Users
	Set CardId = @cardId
	where Username = @username
	
drop proc ChangeCard;

exec ChangeCard 11111, koks

create proc FindCard
	@Username nvarchar(255)
as select Card from Reader where Username = @Username

exec FindCard 'koks'

create proc FindBId
	@title nvarchar(255)
as select Id from Books where Title=@title;

create proc FindFId
	@name nvarchar(255)
as select Id from Files where Fname = @name;

create proc FindBFile
	@id int
as select BFile from Files where Id=@id;

create proc FindByID
	@id int
as select FId from ConnectionBF where BId =@id;

exec FindByID 3

create proc FindNameBy
	@fId int
as select FName from Files where ID=@fId;

exec FindNameBy 1

create proc AddIssue
	@bookId int,
	@issueDate date,
	@readerCard int
as insert into Issue(BookId, IssueDate, ReaderCard)
values (@bookId, @issueDate, @readerCard);


create proc FindUserCard
	@userName varchar(255)
as select CardID FROM Users where Username = @userName

drop proc FindUserCard

exec FindUserCard 'koks'



create proc DCount
	@bookId int
as select COUNT(Id) from Issue where BookId=@bookId

exec DCount 11



create proc DeleteF
	@id int
as delete from Files where Id=@id;

exec DeleteF 6000

create proc FindBook
	@word nvarchar(255)
as select * from Books where Author = @word or Title=@word

drop proc FindBook




