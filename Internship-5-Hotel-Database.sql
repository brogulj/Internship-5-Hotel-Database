create table Hotels(
Id int identity(1,1) primary key,
HotelName nvarChar(50) not null,
HotelLocation nvarChar(50) not null,
HotelStars int check (HotelStars between 1 and 5) not null
)

create table Workers(
Id int identity(1,1) primary key,
FirstName nvarchar(30) not null,
LastName nvarchar(30) not null,
Pay int not null,
WorkerRole nvarchar(30) not null,
HotelsId int foreign key references Hotels(Id) not null
)


create table Rooms(
Id int identity(1,1) primary key,
RoomNumber int not null,
Capacity int not null,
HotelsId int foreign key references Hotels(Id) not null
)

create table Stays(
Id int identity(1,1) primary key,
TimeOfArrival datetime2 not null,
TimeOfDeparture datetime2 not null,
TransactionTime datetime2 not null,
Price int check(Price > 0) not null,
RoomsId int foreign key references Rooms(Id),
Category nvarchar(15) check(Category = 'Regular' or Category = 'Half-pansion' or Category = 'Pansion')
)

create table Guests(
Id int identity(1,1) primary key,
FirstName nvarchar(30) not null,
LastName nvarchar(30) not null,
OIB nvarchar(12)not null
)

create table GuestsStays(
GuestsId int foreign key references Guests(Id) not null,
StaysId int foreign key references Stays(Id) not null,
constraint GuestsStaysPrimaryKey primary key (GuestsId,StaysId)
)

insert into Hotels (HotelName,HotelLocation,HotelStars) values
('Briig','Split',4),
('Park','Split',5),
('Atrium','Split',5),
('Radisson','Split',4),
('Esplanada','Zagreb',5)

insert into Rooms(RoomNumber,Capacity,HotelsId) values 
(11,4,1),
(12,3,1),
(34,2,2),
(53,3,3),
(41,4,2)

insert into Stays(TimeOfArrival,TimeOfDeparture,Category,TransactionTime,Price,RoomsId) values 
(getdate(),'2020-12-31','Pansion',getdate(),1000,1),
(getdate(),'2020-12-31','Half-pansion',getdate(),500,2),
(getdate(),'2020-12-31','Regular',getdate(),900,3),
(getdate(),'2020-12-31','Pansion',getdate(),1500,4),
(getdate(),'2020-12-31','regular',getdate(),2000,5)

Insert into Guests(FirstName,LastName,OIB) values
('Ivan','Ivanović','012345678900'),
('Marko','Markić','098765432100'),
('Filip','Filipinski','102938475600'),
('Martin','Martinović','918273645000'),
('Karlo','Karlović','987651234000')

insert into GuestsStays(GuestsId,StaysId) values 
(1,3),
(2,3),
(3,1),
(4,1),
(5,2)

insert into Workers(FirstName,LastName,WorkerRole,Pay,HotelsId) values
('Ante','Antić','Cleaner',3500,1),
('Ivo','Ivić','Electrician',4500,1),
('Milorad','Miloradić','Barman',5500,4),
('Ana','Anić','Receptionist',6500,3),
('Mila','Milić','Cook',4500,2)

select * from Rooms Where HotelsId = (select Id from Hotels where HotelName='Briig') order by RoomNumber

select * from Rooms where RoomNumber like('1%')

select FirstName,LastName from Workers where HotelsId = (select Id from Hotels where HotelName = 'Briig') and WorkerRole = 'Cleaner'

select * from Stays where Price>=1000 and TimeOfArrival>='2020-12-1'

select * from Stays where TimeOfDeparture>=GetDate()

delete from Stays where TimeOfArrival<='2020-1-1'

update Rooms set Capacity = 4 where(HotelsId = 2 and Capacity =3)

select * from Stays where RoomsId=1 order by(TimeOfArrival)

select * from Stays where (Category = 'Pansion' or Category = 'Half-pansion') and RoomsId in (select Id from Rooms where HotelsId =1)

update Workers set WorkerRole='Receptionist' where Id = 1 or Id =2
