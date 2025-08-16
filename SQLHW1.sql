
use found_class5
go
drop table homework
go
--1️⃣ DQL – Data Query Language (Язык запроса данных)
create table homework_students (id int, name_Students varchar(50), age varchar (20),class_number varchar(80))

select * from homework_students
--DML – Data Manipulation Language (Манипуляция данными)
insert into homework_students (id,name_Students,age,class_number) values 
(1, 'Ali','21','B1'), 
(2, 'Mir','22','B2'),
(3, 'Sher','20','B3'),
(4, 'Bek','23','B4')

update homework_students	
set age = 19
where id = 3
-- DDL – Data Definition Language (Определение структуры)

alter table homework_students
add gender varchar(20)

update homework_students
set gender = M
insert into homework_students (id,name_Students,age,class_number,gender) values 
(1, 'Ali','21','B1','M'), 
(2, 'Mir','22','B2','M'),
(3, 'Sher','20','B3','M'),
(4, 'Bek','23','B4','M')

truncate table homework_students

--DCL – Data Control Language (Управление доступом)

--Дать пользователю право на чтение таблицы
grant select on homework_students to user_1
--отозвать право
remove select on homework_students to user_1

--TCL – Transaction Control Language (Управление транзакциями)
begin transaction

update homework_students	
set age = 20
where id = 1

rollback

commit


C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\
