# see all databases
show databases;

# DDL
CREATE DATABASE if not exists testdb;
use testdb;

# CREATE DATABASE if not exists self_test_db;
# show databases like "%test%";

show tables like "%emp%";

# DDL
create table if not exists employee(
emp_id int,
fname varchar(50),
lname varchar(50), 
dob date,
hire_date date,
role varchar(30),
# if we use float instead of decimal then 9999999 is stored as 10000000
salary DECIMAL(15,2)
);
desc employee;
RENAME TABLE employee TO employees;
desc employees;
RENAME TABLE employees TO employee;
desc employee;


# DML 
insert into employee values(1, "Prog", "Rammer", "1990-01-01", "2022-01-01", "programmer", 66000);
insert into employee values(2, "Data", "Analyst", "1995-01-01", "2022-01-01", "data analyst", 46000);
insert into employee values(3, "Data", "Scientist", "1989-01-01", "2022-01-01", "data scientist", 88000);
insert into employee values(4, "Data", "Engineer", "1995-01-01", "2022-01-01", "data engineer", 48000);
insert into employee values(5, "Employee", "Name", "1995-01-01", "2022-01-01", "dummy", 22222);
insert into employee values(6, "John", "Doe", "1970-01-01", "2023-01-01", "admin", 9999999);

# DQL
select * from employee;
select fname, lname from employee;
select * from employee where salary > 32000;
# Get last name in ascending order
select * from employee order by lname asc;

# Flag to enable modifications based on non-pkey fields
set sql_safe_updates = 0;
# DML 
update employee set salary = 99999 where employee.emp_id = 1;
delete from employee where role = "dummy";
# DDL
alter table employee add dept varchar(20);
# DML
update employee set dept = "production";
# DQL
select * from employee;


# Other operations >>

# Shallow cloning : only structure
CREATE TABLE s_employees LIKE employee;
desc s_employees;

# Deep Cloning : structure and data
CREATE TABLE d_employees LIKE employee;
INSERT INTO d_employees SELECT * FROM employee;
select * from d_employees;

drop table s_employees;
set sql_safe_updates = 0;
delete from d_employees where fname = "Data";
select * from d_employees;
delete from d_employees;
select * from d_employees;
drop table d_employees;


# Views : 
# Provide a configurable window entry to a large table. So any operations on the records will happen on the source table.
CREATE VIEW emp_view as SELECT emp_id, fname, lname from employee;
select * from emp_view;

# Updates impact the source table
update emp_view set lname = "xxxxx";
select * from emp_view;
select * from employee;

# Deleting records from a view also deletes it from the source table
delete from emp_view where emp_id = 1;
select * from emp_view;
select * from employee;
# Dropping a View doesn't affect the source table as its just the window is closed.
drop view emp_view;
select * from employee order by emp_id;


/* DDL : deleting the created schema as it has been altered(added dept)
	and subsequent runs will generate column mis-match errors in the initial insert-into statements */
drop table if exists employee;
drop database if exists testdb;