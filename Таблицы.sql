use LibraryDB;

create table Books(
	Id int IDENTITY(1,1) primary key,
	Title nvarchar(255) not null,
	Author nvarchar(255) not null,
	Description nvarchar(max),
	PYear int not null,
	Status nvarchar(12) not null,
	Image varbinary(max)
);

drop table Books;

create table ConnectionBF(
	BId int not null,
	FId int not null,
	Foreign Key (BId) references Books(Id) on delete cascade,
	Foreign Key (FId) references Files(Id) on delete cascade
);

drop table ConnectionBF;

create table Files(
	Id int IDENTITY(1,1) primary key,
	FName nvarchar(255),
	BFile varbinary(max) not null
);

drop table Files;

create table Issue(
	Id int identity(1,1) primary key,
	BookId int not null,
	IssueDate date not null,
	ReaderCard int not null,
	Foreign Key (BookId) References Books(Id) on Delete cascade
);

drop table Issue;

create table Reader(
	Card int identity(11111, 1) primary key,
	FullName nvarchar(255) not null,
	Username nvarchar(255) not null
	
);

drop table Reader;


create table Users(
	Id int identity(1,1) primary key,
	Flag nvarchar(2) not null,
	Username nvarchar(255) not null,
	UPassword nvarchar(255) not null,
	CardId int
);

create nonclustered index IndxForUsers on Users(Id)
drop index IndxForUsers on Users.Id

drop table Users;

select * from Users
select * from Reader
select * from Files;
select * from Books;
select * from ConnectionBF
select * from  Issue;

