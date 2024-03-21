
/*
    CTE : Common Table Expression is a named temporary result set that exists solely within the execution scope of a single SQL statement,
    such as SELECT, INSERT, UPDATE, or DELETE.
        - similar in concept to a derived table but offers better readability and performance, can be self referenced(recursive-CTE)
        - can have multiple CTEs in a query separated by commas
*/
# using sample data imported from https://www.mysqltutorial.org/getting-started-with-mysql/mysql-sample-database/
use classicmodels;

with customers_in_usa as
(
    select customerName, state
    from customers
    where country = "USA"
)
select customerName 
from customers_in_usa
where state = "CA"
order by customerName;

select * from customers;
select * from employees;
select * from orders;
select * from orderdetails;
select * from payments;
select * from productlines;
select * from products;
select * from offices;

with topsales2003 as (
select salesRepEmployeeNumber, employeeNumber, SUM(quantityOrdered * priceEach) sales
from orders
inner join orderdetails using (orderNumber)
inner join customers using (customerNumber)
where year(shippedDate) = 2003 and status = 'Shipped'
GROUP BY salesRepEmployeeNumber
ORDER BY sales DESC
LIMIT 5)
select employeeNumber, firstName, lastName, sales
from employees
join topsales2003 using (employeeNumber);





/* CTE Window functions : window means a partition
        - Enable us to perform an operation/function over a partition.
            Here total_sales will contain the total sales for each fiscal_year and
            we can see see the sales by each employee in relation to total sales for that FY.
        - executed  after all JOIN, WHERE, GROUP BY, and HAVING clauses and before the ORDER BY, LIMIT and SELECT DISTINCT
        PS : fiscal year(US) is the same as financial year(UK)
        
        Ref : https://www.mysqltutorial.org/mysql-window-functions/        
*/
create database if not exists cte_test;
use cte_test;

CREATE TABLE sales(
    sales_employee VARCHAR(50) NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(sales_employee,fiscal_year)
);

INSERT INTO sales(sales_employee,fiscal_year,sale)
VALUES('Bob',2016,100),
      ('Bob',2017,150),
      ('Bob',2018,200),
      ('Alice',2016,150),
      ('Alice',2017,100),
      ('Alice',2018,200),
       ('John',2016,200),
      ('John',2017,150),
      ('John',2018,250);
SELECT * FROM sales;

# aggregate
select fiscal_year, sales_employee, sale, sum(sale) from sales group by fiscal_year, sales_employee order by fiscal_year;

# SUM() is used as a window function here
# window function is performed within partitions and re-initialized when crossing the partition boundary.
# ORDER BY clause specifies how the rows are ordered within a partition
select fiscal_year, sales_employee, sale, SUM(sale)
over (PARTITION BY fiscal_year ORDER BY sale) total_sales
from sales;


# CUM_DIST function >> finds the cumulative distribution
CREATE TABLE scores (
    name VARCHAR(20) PRIMARY KEY,
    score INT NOT NULL
);

INSERT INTO
	scores(name, score)
VALUES
	('Smith',81),
	('Jones',55),
	('Williams',55),
	('Taylor',62),
	('Brown',62),
	('Davies',84),
	('Evans',87),
	('Wilson',72),
	('Thomas',72);

SELECT name, score, ROW_NUMBER()
OVER (ORDER BY score) row_num,
CUME_DIST() OVER (ORDER BY score) cume_dist_val
FROM scores;


/*
    TODO : More window functions
*/














