use class15

--1--
CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (id, name, salary) VALUES
(1, 'Alice', 50000),
(2, 'Bob', 60000),
(3, 'Charlie', 50000)

select id,name,SALARY from employees
where SALARY = (select min(salary) from Employees)

--2--


CREATE TABLE products (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2)
);

INSERT INTO products (id, product_name, price) VALUES
(1, 'Laptop', 1200),
(2, 'Tablet', 400),
(3, 'Smartphone', 800),
(4, 'Monitor', 300);

select id,product_name from products
where price > (select AVG(price) from products)


--3--



CREATE TABLE departments (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments (id, department_name) VALUES
(1, 'Sales'),
(2, 'HR');

INSERT INTO employees (id, name, department_id) VALUES
(1, 'David', 1),
(2, 'Eve', 2),
(3, 'Frank', 1);

select e1.id, e1.name, d1.department_name from Employees as e1
join departments as d1
on e1.DEPARTMENT_ID = d1.id
where d1.department_name = 'sales'

--4--

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_id, name) VALUES
(1, 'Grace'),
(2, 'Heidi'),
(3, 'Ivan');

INSERT INTO orders (order_id, customer_id) VALUES
(1, 1),
(2, 1);

select c1.name, o1.customer_id, o1.order_id from customers as c1
left join orders as o1
on c1.customer_id = o1.customer_id
where o1.customer_id is null

--5--
CREATE TABLE products1 (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products1 (id, product_name, price, category_id) VALUES
(1, 'Tablet', 400, 1),
(2, 'Laptop', 1500, 1),
(3, 'Headphones', 200, 2),
(4, 'Speakers', 300, 2);



select p.id,p.price,p.product_name, p.category_id from products1 as p
where p.price = (select SUM(p2.price) from products1 as p2
where p2.category_id = p.category_id)

--6--


CREATE TABLE departments1 (
    id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

CREATE TABLE employees1 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

INSERT INTO departments1(id, department_name) VALUES
(1, 'IT'),
(2, 'Sales');

INSERT INTO employees1 (id, name, salary, department_id) VALUES
(1, 'Jack', 80000, 1),
(2, 'Karen', 70000, 1),
(3, 'Leo', 60000, 2);

select e1.id,e1.name, d1.department_name from employees1 as e1
join departments1 as d1
on e1.department_id = d1.id
where e1.department_id = 
(select top 1 department_id 
from employees1
group by department_id
order by AVG(salary) desc)


--7--

CREATE TABLE employees3 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees3 (id, name, salary, department_id) VALUES
(1, 'Mike', 50000, 1),
(2, 'Nina', 75000, 1),
(3, 'Olivia', 40000, 2),
(4, 'Paul', 55000, 2);

SELECT e.id, e.name, e.salary, e.department_id
FROM employees3 as e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees3
    WHERE department_id = e.department_id
);

--8--


CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE grades (
    student_id INT,
    course_id INT,
    grade DECIMAL(4, 2),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO students (student_id, name) VALUES
(1, 'Sarah'),
(2, 'Tom'),
(3, 'Uma');

INSERT INTO grades (student_id, course_id, grade) VALUES
(1, 101, 95),
(2, 101, 85),
(3, 102, 90),
(1, 102, 80);

SELECT s.student_id, 
       s.name, 
       g.course_id, 
       g.grade
FROM grades g
JOIN students s 
  ON g.student_id = s.student_id
WHERE g.grade = (
    SELECT MAX(g2.grade)
    FROM grades g2
    WHERE g2.course_id = g.course_id
);

--9--

CREATE TABLE products2 (
    id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT
);

INSERT INTO products2 (id, product_name, price, category_id) VALUES
(1, 'Phone', 800, 1),
(2, 'Laptop', 1500, 1),
(3, 'Tablet', 600, 1),
(4, 'Smartwatch', 300, 1),
(5, 'Headphones', 200, 2),
(6, 'Speakers', 300, 2),
(7, 'Earbuds', 100, 2);


SELECT category_id, 
       product_name, 
       price
FROM (
    SELECT 
        category_id,
        product_name,
        price,
        DENSE_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS rnk
    FROM products2
) ranked_products
WHERE rnk = 3;


--10--
CREATE TABLE employees5 (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
    department_id INT
);

INSERT INTO employees5 (id, name, salary, department_id) VALUES
(1, 'Alex', 70000, 1),
(2, 'Blake', 90000, 1),
(3, 'Casey', 50000, 2),
(4, 'Dana', 60000, 2),
(5, 'Evan', 75000, 1);

SELECT 
    e.id,
    e.name,
    e.salary,
    e.department_id
FROM employees5 e
WHERE e.salary > (SELECT AVG(salary) FROM employees)
  AND e.salary < (
      SELECT MAX(salary)
      FROM employees5 e2
      WHERE e2.department_id = e.department_id
  );




