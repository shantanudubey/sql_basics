# Joins
create DATABASE if not exists emp_order;
use emp_order;

CREATE TABLE customers (
   id INT NOT NULL,
   name VARCHAR (20) NOT NULL,
   age INT NOT NULL,
   city CHAR (25),
   salary DECIMAL (18, 2),       
   PRIMARY KEY (id)
);
desc customers;

INSERT INTO customers (id,name,age,city,salary) VALUES
(1, 'Ramesh', 32, 'Ahmedabad', 26000.00 ),
(2, 'Suresh', 35, 'Gandhinagar', 32000.00 ),
(3, 'Mohan', 27, 'Pune', 21000.00 ),
(4, 'Sohan', 29, 'Mumbai', 26000.00 ),
(5, 'Rohan', 30, 'Kolkata', 27000.00 ),
(6, 'Gopal', 42, 'Mumbai', 52000.00 ),
(7, 'Kartik', 36, 'Bengaluru', 42000.00 );
select * from customers;

CREATE TABLE orders (
   id int NOT NULL,
   date VARCHAR (20) NOT NULL,
   customer_id INT NOT NULL,
   amount DECIMAL (18, 2)
);

INSERT INTO orders (id, date, customer_id, amount) VALUES 
(101, '2023-01-01 00:00:00', 3, 1700.00),
(102, '2023-09-21 00:00:00', 3, 1000.00),
(103, '2023-10-24 00:00:00', 4, 600.00),
(104, '2023-11-01 00:00:00', 2, 2300.00);
select * from orders;

CREATE TABLE employee (
   id INT NOT NULL,
   name VARCHAR (30) NOT NULL,
   sales DECIMAL (20),
   PRIMARY KEY(id)
);

INSERT INTO EMPLOYEE VALUES 
(101, 'Amit', 4500),
(102, 'Ankit', 5200),
(103, 'Raghu', 9200),
(104, 'Joe', 2800);
select * from employee;

# Inner Join : or EquiJoin, the default join to get the common elements from tables
select customers.id as "customer-id", customers.name as "customer-name", orders.amount, orders.date as "order-date", orders.id as "order-id", employee.name as "agent"
from customers INNER JOIN orders
ON customers.id = orders.customer_id
INNER JOIN employee
ON  orders.id = employee.id;

# Outer Join : 
select customers.id as "customer-id", customers.name as "customer-name", orders.amount, orders.date as "order-date", orders.id as "order-id", employee.name as "agent"
from customers LEFT OUTER JOIN orders
ON customers.id = orders.customer_id
LEFT OUTER JOIN employee
ON  orders.id = employee.id;

select customers.id as "customer-id", customers.name as "customer-name", orders.amount, orders.date as "order-date", orders.id as "order-id", employee.name as "agent"
from customers RIGHT OUTER JOIN orders
ON customers.id = orders.customer_id
RIGHT OUTER JOIN employee
ON  orders.id = employee.id;

# Full Join : implemented as a Union of Left and Right Joins
select customers.id as "customer-id", customers.name as "customer-name", orders.amount, orders.date as "order-date", orders.id as "order-id", employee.name as "agent"
from customers LEFT OUTER JOIN orders
ON customers.id = orders.customer_id
LEFT OUTER JOIN employee
ON  orders.id = employee.id
UNION
select customers.id as "customer-id", customers.name as "customer-name", orders.amount, orders.date as "order-date", orders.id as "order-id", employee.name as "agent"
from customers RIGHT OUTER JOIN orders
ON customers.id = orders.customer_id
RIGHT OUTER JOIN employee
ON  orders.id = employee.id;


# Cross Join : Cartesian Product >> the first table is crossed with the second table and permutations returned in t he result
select customers.id, customers.name, orders.amount, employee.name as "agent" from customers
CROSS JOIN orders
CROSS JOIN employee;


# Self Join : 
select a.id, a.name, a.salary from customers a, customers b
where a.salary < b.salary
ORDER BY a.salary DESC;


# Cleanup
drop table if exists customers;
drop table if exists employee;
drop table if exists orders;
drop database if exists emp_order;
