create database found_class5 

use found_class5--men bu qatorni eslab qolish uchun 

--DQL DATA Query language(Select)

--Select, from, where, group by, having, order by
--bilish uchun ishlatish

select 1 as number
select 12 as twelve

select(13*6)-9 multiplied

select 'Alisher'

select 'o''lmas olloberganov' as [artist name]
---7,-4,-23,89,67,5,0
create table students(id int,name varchar (30))

select name, id from students

--select IIF ('a'a', 'ular teng', 'ular teng emas')







--1) DB name readbooksdb
--table name books
--colums
--bookid int
-- name varchar(30)
--author varchar (30)
 -- genre varchar(20)
 --status varchar(30)

 create database reedbooks

 use reedbooks

 create table books (bookid int, name varchar (30), author_name varchar (30),genre varchar(20), status varchar(30))

 select name, bookid from books  