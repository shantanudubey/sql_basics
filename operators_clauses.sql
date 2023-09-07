

CREATE DATABASE IF NOT EXISTS bikes;
use bikes;

create table if not exists bike_info(
id int AUTO_INCREMENT,
name VARCHAR(30),
manufacturer VARCHAR(25),
cubic_capacity int,
price int,
PRIMARY KEY(id)
);
desc bike_info;

INSERT INTO bike_info(manufacturer, name, cubic_capacity, price) values 
("Hero", "Xtreme 160 R 4V", 160, 130000),
("TVS", "Apache RTR 160 4V", 160, 125000),
("Bajaj", "Pulsar N160", 160, 123000),
("Hero", "Karizma XMR", 210, 173000),
("TVS", "Apache RTR 200 4V", 200, 143000),
("Bajaj", "Pulsar F250", 250, 144000),
("Suzuki", "Gixxer SF250", 250, 194000),
("TVS", "Ronin", 220, 150000),
("RE", "Hunter 350", 350, 150000),
("Hero", "Karizma XMR", 210, 173000);
select * from bike_info;


# IN : match from a list of options
SELECT * from bike_info where manufacturer in ("TVS", "Bajaj") ORDER BY price;

/*
LIKE : pattern matching with wild card : 
    %   : match 0,1 or more characters
    _   : match a single character   
*/
SELECT * from bike_info where name like "%16%";
# Finding Apache : _p%, ap%, ___che%
SELECT * from bike_info where name like "_p%";
# Finding TVS : ___, t__, _v_
SELECT * from bike_info where manufacturer like "___";

# DISTINCT : skip duplicates
select DISTINCT * from bike_info;

# ORDER BY : ASC/DESC for each column
select * from bike_info ORDER BY cubic_capacity ASC, name DESC;

# GROUP BY : groups rows that have the same values into summary rows, like "find the number of customers in each country"
# get the count and average price of motorcycles by cubic_capacity
select cubic_capacity, count(id), avg(price) from bike_info GROUP BY cubic_capacity ORDER BY cubic_capacity;
# get the max price of motorcycles by cubic_capacity
select cubic_capacity, max(price) from bike_info GROUP BY cubic_capacity ORDER BY max(price) DESC;

# HAVING : similar to where clause but must be followed by a group-by clause and can be used with aggregate functions unlike where
SELECT count(id),cubic_capacity,max(price) from bike_info GROUP BY cubic_capacity HAVING avg(price) > 100000 ORDER BY cubic_capacity ASC;


# BIT : works like boolean, accepted values are NULL,0,1.
alter table bike_info add COLUMN is_available BIT;
desc bike_info;

# adding a new column : disable SAFE_UPDATES to update or delete data
SET SQL_SAFE_UPDATES = 0;
update bike_info set is_available = 1;
select * from bike_info;
# Re-enable it after 
SET SQL_SAFE_UPDATES = 1;

INSERT INTO bike_info(manufacturer, name, cubic_capacity, price, is_available) values 
("Yamaha", "RX 100", 100, 56000, 0),
("Yamaha", "RX 135", 135, 60000, 0),
("Yamaha", "RXZ", 135, 68000, 0),
("Yamaha", "RD 350", 350, 80000, 0);
select * from bike_info;

# ANY : The ANY and ALL operators must be preceded by a standard comparison operator i.e. >, >=, <, <=, =, <>, != and followed by a subquery.
select * from bike_info where price > ANY (select avg(price) from bike_info where cubic_capacity >= 200);
# ALL : column_name operator ALL (subquery)
select distinct name,price from bike_info where price != ALL (select price from bike_info where price > 100000);
select distinct name,price from bike_info HAVING price < ALL (select price from bike_info where price > 100000);

# EXISTS : WHERE EXISTS (subquery)
select DISTINCT name from bike_info WHERE manufacturer = "Yamaha" and exists (select * from bike_info where price < 100000 and manufacturer = "Yamaha");

# CASE >> 
SELECT manufacturer,name, cubic_capacity,price,
CASE
WHEN cubic_capacity > 90 and cubic_capacity <= 125 THEN "Economy"
WHEN cubic_capacity > 140 and cubic_capacity <= 160 THEN "Executive"
WHEN cubic_capacity > 160 and cubic_capacity <= 200 THEN "Sports"
WHEN cubic_capacity > 200 and cubic_capacity <= 500 THEN "Premium"
ELSE "NA"
END AS eng_classification
FROM bike_info ORDER BY name;

SELECT * from bike_info 
ORDER BY
(CASE 
    WHEN is_available = 1 THEN price
    else name
END);


# UNION and INTERSECTION >>
create table riders(
id int AUTO_INCREMENT,
name VARCHAR(30),
company varchar(25),
age int not null,
weight int not null,
PRIMARY KEY(id)
);

insert into riders(name, age, weight, company) VALUES
("Santosh",32,65,"TVS"),
("Vijay",25,62,"Hero"),
("Kartik",36,68,"Royal Enfield"),
("Vikram",42,71,"Bajaj"),
("Zubin",48,73,"Independent");
select * from riders;

# UNION : combines rows based from two tables based on the same type of data, number of columns and order of columns
select name from riders
UNION
select name from bike_info;

select name, company, age, "rider-age" AS type
from riders
UNION
select name, manufacturer, cubic_capacity, "engine-capacity" AS type
from bike_info;

create table if not exists bike_160(
id int AUTO_INCREMENT,
name VARCHAR(30),
manufacturer VARCHAR(25),
cubic_capacity int,
price int,
PRIMARY KEY(id)
);
desc bike_info;

INSERT INTO bike_160(manufacturer, name, cubic_capacity, price) values 
("Hero", "Xtreme 160 R 4V", 160, 130000),
("TVS", "Apache RTR 160 4V", 160, 125000),
("Bajaj", "Pulsar NS160", 160, 134000),
("Bajaj", "Pulsar N160", 160, 123000);
select * from bike_160;

alter table bike_160 add COLUMN is_available BIT default 1;
desc bike_160;

# INTERSECT : returns the rows that are common to both tables
select name from bike_info
INTERSECT
select name from bike_160;

# EXCEPT : returns the rows that are not common to both tables
select name as "Motorcycle", manufacturer as "Company" from bike_info
EXCEPT
select name, manufacturer from bike_160;


# Sub-Queries : 
select * from bike_info where price < (select avg(price) from bike_info where cubic_capacity >= 200) and is_available = 1;























