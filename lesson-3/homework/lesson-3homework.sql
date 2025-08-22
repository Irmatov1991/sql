use found_class5
go

BULK insert employee
from 'D:\files for work\Employee.csv'

with(fieldterminator = ',',
rowterminator = '\n',
firstrow = 2)


create table employee (employeeid int,  Firstname varchar (100), Lastname varchar (100), Salary int)

select * from employee

create table Products (productid int primary key, product_name varchar (50), Price decimal (10,2))

truncate table products

insert into products (productid, product_name, price) values
(1, 'Laptop', 1200.00),
(2, 'Smartphone', 500),
(3, 'Desk Chair', 150.00)

CREATE TABLE Staffperson (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(20) NULL)
-- alter table orqali products ozgartirish kiritilyapti
-- add constraint orqali productsga cheklov qoyildi qaytalanmasligi uchun

alter table products
add constraint product_name unique (Product_name)
-- alter table orqali products ozgartirish kiritilyapti

update products
set categoryid = 0
where categoryid is null

alter table products
add categoryid int

create table category (categoryid int primary key, categoryname varchar(50) unique)

CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY, -- начинается с 1, шаг 1
    OrderDate DATETIME)


alter table category
add productid int

insert into category (categoryid, categoryname) values
(1, 'Laptop'),
(2, 'Smartphone'),
(3, 'Desk Chair')

alter table products
drop column price

alter table products
drop column categoryid

alter table products
add category varchar(50)

alter table products
add price decimal (10,2)

select * from category


select * from products

drop table products

bulk insert products
from 'D:\files for work\products.csv'

with(fieldterminator = ',',
rowterminator = '\n',	
firstrow = 2)

create table products (productid int primary key, productname varchar (50), 
categoryid int foreign key references category(categoryid),
price decimal(10,2)) 


alter table products
add constraint productname unique (Productname)
INSERT INTO Products (ProductID, ProductName, CategoryID, Price, Stock)
VALUES (402, 'Tablet', 1, 500.00, 15)

alter table products
add constraint product_price check (price > 0)
INSERT INTO Products (ProductID, ProductName, CategoryID, Price)
VALUES (202, 'Free Sample', 1, 0)

alter table products
add stock int not null default 0
INSERT INTO Products (ProductID, ProductName, CategoryID, Price,stock)
VALUES (202, 'Free Sample', 1, 50, 0)

select
	productid,
	productname,
	isnull (price,0)
	stock from products

	update products
	set price = ISNULL(price, 0)


	INSERT INTO Products (ProductID, ProductName, CategoryID, Price, Stock)
VALUES (501, 'Gift Item', 1, NULL, 10)

select
	productid,
	productname,
	isnull (price,0) as price
	from products
	--foreign key jadval ortasida Categor va Products aloqa taminlaydi
	-- Table category
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE
);

	-- foreign key jadvaliga Product table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50) UNIQUE,
    CategoryID INT,
    Price DECIMAL(10,2),
    Stock INT NOT NULL DEFAULT 0,
    CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID)
);

create table customers
	(customersid int primary key,
	name varchar(50),
	age int check (age >= 18))
	-- Успешная вставка
INSERT INTO Customers (customersid, Name, Age)
VALUES (1, 'Alice', 25),
	   (2, 'Bob', 26),
	    (3, 'Charlie', 30)
INSERT INTO Customers (customersid, Name, Age)
VALUES (4, 'Harry', 15)		

		select * from customers

create table invoicenumber
	(invoiceid int identity (100,10) primary key,
	invoicedata date not null)

	insert into invoicenumber (invoicedata) values
	('25-01-2025'),
	('26-01-2025'),
	('24-01-2025')

	select * from invoicenumber

create table orderdetails
	(orderid int,
	productid int,
	quantity int,
	constraint pk_orderdetails primary key(orderid,productid))
	
	insert into orderdetails (orderid,productid,quantity) values
	(1,100,5),
	(2,101,5),
	(3,102,4)
	insert into orderdetails (orderid,productid,quantity) values
	(1,100,5)
	 select * from orderdetails

	 
SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price_ISNULL
FROM Products


SELECT ProductID, ProductName, COALESCE(Price, 0) AS Price_COALESCE
FROM Products

	select ISNULL(null, 0) -- 0

	select coalesce(null,null,5,10)

	CREATE TABLE employes (
    empID INT PRIMARY KEY,
    Name VARCHAR(50),
    Email VARCHAR(100) UNIQUE
)
 insert into employes(empID,Name,Email) values
	(1, 'Alice Johnson', 'alice@example.com'),
	(2, 'Bob Smith', 'bob@example.com'),
	(3, 'Charlie Brown', NULL)

	insert into employes(empID,Name,Email) values
	(1, 'Alice Johnson', 'alice@example.com')
	
	select * from employes

-- Table

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50) NOT NULL,
    CategoryID INT,
    Price DECIMAL(10,2),

    CONSTRAINT FK_Products_Categories 
        FOREIGN KEY (CategoryID) 
        REFERENCES Categories(CategoryID)
      ON DELETE CASCADE 
        ON UPDATE CASCADE
) 
	DELETE FROM category WHERE CategoryID = 1
	UPDATE category SET CategoryID = 10 WHERE CategoryID = 2



select * from category