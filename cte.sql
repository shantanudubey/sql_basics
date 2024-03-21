create database if not exists cte_test;
use cte_test;

/*
    CTE : Common Table Expression is a named temporary result set that exists solely within the execution scope of a single SQL statement,
    such as SELECT, INSERT, UPDATE, or DELETE.
        - similar in concept to a derived table but offers better readability and performance, can be self referenced(recursive-CTE)
        - can have multiple CTEs in a query separated by commas
*/
with cte_records as (select id, student_code, firstname, lastname, subjects, marks from added_student_info) select * from cte_records order by marks DESC;



/* TODO : 
    # CTE Windows Functions
*/

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

/* CTE Window functions :
        - Enable us to perform the aggregate on the partition.
            Here total_sales will contain the total sales for each fiscal_year and
            we can see see the sales by each employee in relation to total sales for that FY.
        - executed  after all JOIN, WHERE, GROUP BY, and HAVING clauses and before the ORDER BY, LIMIT and SELECT DISTINCT
        PS : fiscal year(US) is the same as financial year(UK)
*/
# SUM() is the window function here
# window function is performed within partitions and re-initialized when crossing the partition boundary.
# ORDER BY clause specifies how the rows are ordered within a partition
select fiscal_year, sales_employee, sale, SUM(sale)
over (PARTITION BY fiscal_year ORDER BY sale) total_sales
from sales;

# A frame is a subset of the current partition













