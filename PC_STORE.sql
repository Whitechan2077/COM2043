CREATE DATABASE PC_Store
USE PC_Store;
GO
CREATE TABLE Account(
	UserID int IDENTITY(1,1) PRIMARY KEY,
	username varChar(14) NOT NULL,
	password varchar(14) NOT NULL,
	role tinyint NOT NULL,
	fullName nvarchar(255) NOT NULL,
	phoneNum varchar(10) NOT NULL,
	ad nvarchar(255) NOT NULL,
	userPoint int 
);
GO
CREATE TABLE Product(
	ID int IDENTITY(1,1) PRIMARY KEY,
	ProductName nvarchar(69) NOT NULL,
	Price int NOT NULL,
	CreateDate date NOT NULL,
	Status tinyint NOT NULL
);
GO
CREATE TABLE Ranking(
	
);
CREATE TABLE Cart(
	UserID int CONSTRAINT FK_UserID FOREIGN KEY (UserID) REFERENCES Account(UserID),
	Status tinyint,
	PRIMARY KEY(UserID)
);
GO
CREATE TABLE CartDetail(
	UserID int CONSTRAINT FK_Cart_UserID FOREIGN KEY (UserID) REFERENCES Cart(UserID),
	SellID int NOT NULL,
	BillID int NOT NULL,
	Amout int NOT NULL,
	Status tinyint NOT NULL,
);
CREATE TABLE SetUp(
	SetUpID int PRIMARY KEY,
);