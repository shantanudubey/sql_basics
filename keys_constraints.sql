# Keys and Constraints : pkey, fkey and other constraints

show databases;
create database sales;
# Enables to use customer_info rather than sales.customer_info
use sales;

create table customer_info(
id int, first_name varchar(25), last_name varchar(25)
);
show tables;

# Inserting some rows
insert into customer_info(id, last_name, first_name) values(2, "John1", "Doe1");
select * from customer_info;
insert into customer_info(id, last_name, first_name) values(3, "Doe2", "John2"), (3, "Doe3", "John3");
select * from customer_info;

# Queries
select * from customer_info where last_name = "Doe" or (last_name = "John1");
select * from customer_info where last_name = "Doe" and first_name = "John";

# Delete table
drop table customer_info;
show tables;

# Create with primary key
create table customer_info(
id int auto_increment,
first_name varchar(25),
last_name varchar(25),
salary int,
primary key(id)
);
describe customer_info;
select * from customer_info;

insert into customer_info(first_name, last_name, salary) values("John", "Doe", 20000);
insert into customer_info(first_name, last_name, salary) values("John1", "Doe1", 20000);

/*	If we insert a record with the id specified and it doesn't exist then it will be inserted.
	But the auto_increment will resume from that value for the next record
*/
insert into customer_info(id, first_name, last_name, salary) values(9, "John9", "Doe9", 99999);
select * from customer_info;

drop table customer_info;

# Create with primary key
create table customer_info(
id int,
first_name varchar(25),
last_name varchar(25),
salary int,
primary key(id)
);
describe customer_info;
insert into customer_info(id, first_name, last_name, salary) values(9, "John9", "Doe9", 99999);
insert into customer_info(id, first_name, last_name, salary) values(9, "John9", "Doe9", 99999);
select * from customer_info;
drop table customer_info;

# DDL : Create a table with primary key auto_increment
create table customer_info(
id int auto_increment,
first_name varchar(25),
last_name varchar(25),
salary int,
primary key(id)
);
describe customer_info;
select * from customer_info;

# DDL : changing a column to float and adding a not null constraint 
alter table customer_info
modify column salary float not null;
# Same as desc
describe customer_info;
select * from customer_info;

# Constraint : unique
create table employee(
id int not null unique auto_increment,
house_no int not null,
pan varchar(10) not null,
first_name varchar(25) not null,
last_name varchar(25) not null,
salary int not null,
primary key(id)
);
DESCRIBE employee;

#use sales;
#drop table employee;
# adding a constraint by combining 2 fields
/*alter table employee
add constraint pk_pan_ln primary key(id, last_name);*/

alter table employee
add constraint uc_employee unique(pan, last_name);
desc employee;

# Check constraints
insert into employee(house_no, pan, first_name, last_name, salary)
 values (1, 1, "John", "Doe", 20000);
insert into employee(house_no, pan, first_name, last_name, salary)
 values (2, 2, "John2", "Doe2", 22000);
 
insert into employee(house_no, pan, first_name, last_name, salary)
 values (2, 3, "John2", "Doe3", 33000);
 
select * from employee limit 0, 100;

alter table employee
drop index uc_employee;

# Drop and Add primary key constraint
desc employee;
alter table employee drop primary key;
desc employee;
ALTER TABLE employee ADD CONSTRAINT pk_id PRIMARY KEY(id);
desc employee;

create table person(
id int not null,
first_name varchar(25),
last_name varchar(25),
age int,
primary key(id)
);
desc person;

insert into person values(1,"John","Doe",32),(2,"John1","Doe1",32);
select * from person;

create table orders(
orderid int not null,
ordernumber int not null,
id int,
primary key(orderid),
foreign key (id) references person(id)
);
desc orders;
insert into orders values(1, 101, 1), (2, 102, 2), (3, 103, 1), (4, 104, 1), (5, 105, 2), (6, 106, 2), (7, 107, 1);
SELECT * from orders, person where person.id = orders.id;







# DDL : Deleting the created schema as this sql creates and alters the tables as a part of the exercise
drop table employee;
drop table customer_info;
drop database sales;