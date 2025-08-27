create table inputB (col1 varchar (30), col2 varchar (30))
go
insert into inputB (col1, col2) values
('a', 'b'),
('a', 'b'),
('b', 'a'),
('c', 'd'),
('c', 'd'),
('m', 'n'),
('n', 'm')

select * from inputB

select distinct col1,
col2
	from inputB

select col1, col2 from inputB
	group by col1, col2

SELECT DISTINCT 
       CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
       CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM inputB



CREATE TABLE TestMultipleZero (
    A INT NULL,
    B INT NULL,
    C INT NULL,
    D INT NULL
);

INSERT INTO TestMultipleZero(A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0)


select * from TestMultipleZero
	where (A + B + C + D) <> 0

select * from TestMultipleZero
	where not (A=0 and B=0 and C=0 and D=0)


create table section1(id int, name varchar(20))
insert into section1 values (1, 'Been'),
       (2, 'Roma'),
       (3, 'Steven'),
       (4, 'Paulo'),
       (5, 'Genryh'),
       (6, 'Bruno'),
       (7, 'Fred'),
       (8, 'Andro')


select id, name
	from section1
	where id % 2 = 1
	
SELECT id, name
	FROM section1
	WHERE id = (SELECT MIN(id) FROM section1)

select top 1 id,name
	from section1
	order by id asc


select MIN(id) as min_id
	from section1
	


select MAX(id) as max_id
	from section1 

select top 1 id,name
	from section1
	order by id desc

SELECT id, name
	FROM section1
	WHERE id = (SELECT Max(id) FROM section1)

select id, name
	from section1
	where name like 'B%'

	CREATE TABLE ProductCodes (
    Code VARCHAR(20)
);

INSERT INTO ProductCodes (Code) VALUES
('X-123'),
('X_456'),
('X#789'),
('X-001'),
('X%202'),
('X_ABC'),
('X#DEF'),
('X-999');
	

select Code
from ProductCodes 
where Code like '%\_%' escape '\'

