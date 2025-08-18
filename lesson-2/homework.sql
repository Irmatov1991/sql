create table employees (employee_id int, name varchar (50), salary decimal (10,2))
insert into employees (employee_id, name, salary) values
(1, 'Sher', 5500.00),
(2, 'Mir', 7800.00),
(3, 'Bek', 8000.00),
(4, 'Aki', 9500.00)

update employees
set salary = 7000.00
where employee_id = 1

delete from employees
where employee_id = 2

truncate table employees

drop table employees

alter table employees
alter column name varchar(100) 

alter table employees
add Departament varchar(50)

alter table employees 
alter column salary Float

create table Department (departmentid int Primary Key, Departmentname varchar (100))

delete from employees

truncate table employees

INSERT INTO Department (departmentid, Departmentname)
SELECT 6, 'HR'
UNION ALL
SELECT 7, 'Finance'
UNION ALL
SELECT 8, 'Marketing'
UNION ALL
SELECT 9, 'Management'
UNION ALL
SELECT 10, 'IT'

alter table employees
add department varchar (50)

update employees
set department = 'management'
Where salary = 5000

alter table employees
drop column Department

EXEC sp_rename 'Employees', 'StaffMembers'

drop table Department

select * from Department



select * from employees


create table Products (Productid int primary Key, Product_name varchar(50), category varchar(50), price decimal(10,2))
alter table Products
ADD CONSTRAINT chk_price check (price > 0)

alter table products
add StockQuantity int default (50)
	

EXEC sp_rename 'Products.Category', 'categoryname' 


INSERT INTO Products (ProductID, Product_Name, categoryname, Price, StockQuantity)
VALUES 
(1, 'Laptop', 'Electronics', 1200.00, 30),
(2, 'Smartphone', 'Electronics', 800.00, 50),
(3, 'Desk Chair', 'Furniture', 150.00, 40),
(4, 'Coffee Machine', 'Appliances', 200.00, 25),
(5, 'Backpack', 'Accessories', 60.00, 70)

select * 
into products_backup
from Products

EXEC sp_rename 'products', 'inventory'

alter table inventory
drop constraint chk_price


alter table inventory
alter column price float

alter table inventory
add productcode int identity (1000,5)

select * from inventory

drop table Products
