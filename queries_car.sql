
CREATE DATABASE if not exists vehicles;
USE vehicles;

create table if not exists manufacturer(
id INT not null,
name varchar(30),
country varchar(30),
status int DEFAULT 0,
PRIMARY KEY(id)
);

insert into manufacturer(id, name, country, status) values 
(1, "Maruti Suzuki", "India", 1),
(2, "Tata Motors", "India", 1),
(3, "Mahindra and Mahindra", "India", 1),
(4, "Hyundai Motors", "South Korea", 1),
(5, "Honda Cars", "Japan", 1),
(6, "Toyota Motors", "Japan", 1),
(7, "Skoda-VW", "Germany", 1),
(8, "MG Motors", "China", 1),
(9, "BYD", "China", 1),
(10, "Kia Motors", "South Korea", 1),
(11, "Force Motors", "India", 1),
(12, "Nissan", "Japan", 1),
(13, "Renault", "France", 1),
(14, "BMW", "Germany", 1),
(15, "Mercedes Benz", "Germany", 1),
(16, "Audi", "Germany", 1),
(17, "Citroen", "France", 1),
(18, "Jeep", "USA", 1),
(19, "Maserati", "Italy", 1),
(20, "Lamborghini", "Italy", 1);
select * from manufacturer order by id;


create table if not exists car_segment(
id int not null,
name VARCHAR(20),
category VARCHAR(25),
PRIMARY KEY(id)
);
INSERT INTO car_segment(id, name, category) values 
(1, "AHB", "small hatchback"),
(2, "BHB", "medium hatchback"),
(3, "CHB", "large hatchback"),
(4, "DHB", "premium hatchback"),

(5, "BSD", "small sedan"),
(6, "CSD", "large sedan"),
(7, "DSD", "premium sedan"),
(8, "ESD", "luxury sedan"),

(9, "ASV", "micro suv"),
(10, "BSV", "compact suv"),
(11, "CSV", "medium suv"),
(12, "DSV", "large SUV"),
(13, "ESV", "premium suv"),
(14, "FSV", "luxury suv"),

(15, "OFR", "off-roader"),
(16, "SCR", "sports car"),
(17, "HSC", "hyper sports car");
select * from car_segment;

create table if not exists fuel_type(
id int not null,
name VARCHAR(25),
PRIMARY KEY(id)
);
insert into fuel_type(id, name) values
(1, "petrol"),
(2, "diesel"),
(3, "cng"),
(4, "mhev"),
(5, "hev"),
(6, "phev"),
(7, "bev");
select * from fuel_type;


CREATE TABLE car(
id int not null,
manufacturer_id INT not null,
name VARCHAR(35),
model VARCHAR(20),
segment_id int not null,
fuel_id int not null,
PRIMARY KEY(id),
FOREIGN KEY(manufacturer_id) REFERENCES manufacturer(id),
FOREIGN KEY(segment_id) REFERENCES car_segment(id),
FOREIGN KEY(fuel_id) REFERENCES fuel_type(id)
);

insert into car(id, manufacturer_id, name, model, segment_id, fuel_id) values
(1, 1, "Alto", "Vxi", 1, 1),
(2, 1, "S-Presso", "VXi", 1, 1),
(3, 13, "Kwid", "Climber", 1, 1),
(4, 1, "Celerio", "ZXi", 2, 1),
(5, 4, "i10 Nios", "Asta", 2, 1),
(6, 1, "Swift", "ZXi", 2, 1),
(7, 2, "Tiago", "XZ", 2, 1),
(8, 1, "WagonR", "ZXi", 2, 1),
(9, 4, "Exter", "SX", 9, 1),
(10, 2, "Punch", "Accomplished MT", 9, 1),
(11, 12, "Magnite", "XV Turbo", 10, 1),
(12, 13, "Kiger", "RXZ Turbo", 10, 1),
(13, 17, "C3", "Shine Turbo", 9, 1),
(14, 2, "Altroz", "XZ iTurbo", 3, 1),
(15, 1, "Baleno", "Alpha", 3, 1),
(16, 4, "i20", "Asta", 3, 1),
(17, 1, "Fronx", "Alpha", 10, 1),
(18, 2, "Nexon", "XZ", 10, 1),
(19, 4, "Venue", "SX", 10, 1),
(20, 10, "Sonet", "GTX Plus", 10, 1),
(21, 1, "Brezza", "ZXi", 10, 1),
(22, 3, "XUV300", "W8", 10, 1),
(23, 1, "DZire", "ZXi", 5, 1),
(24, 2, "Tigor", "XZ", 5, 1),
(25, 4, "Aura", "SX", 5, 1),
(26, 5, "Amaze", "VX", 5, 1),
(27, 5, "City", "ZX", 6, 1),
(28, 7, "Virtus", "GT 1.5", 6, 1),
(29, 7, "Slavia", "Style 1.5", 6, 1),
(30, 1, "Ciaz", "Alpha", 6, 1),
(31, 4, "Verna", "SX 1.5 Turbo", 6, 1),
(32, 4, "Creta", "SX 1.5", 11, 1),
(33, 10, "Seltos", "HTX Plus", 11, 1),
(34, 7, "Kushaq", "Style 1.5", 11, 1),
(35, 7, "Taigun", "Topline 1.0", 11, 1),
(36, 8, "Astor", "Sharp 1.3  Turbo", 11, 1),
(37, 1, "Grand Vitara", "Alpha Plus Allgrip", 11, 4),
(38, 6, "HYRyder", "G Hybrid", 11, 5),
(39, 2, "Harrier", "XZ Plus", 11, 2),
(40, 8, "Hector", "Sharp Pro", 11, 2),
(41, 18, "Compass", "Limited", 11, 2),
(42,8 , "Hector Plus", "Sharp Pro", 12, 2),
(43, 2, "Safari", "XZ Plus Adventure", 12, 2),
(44, 18, "Meridian", "Limited Plus 4x4", 12, 2),
(45, 4, "Alcazar", "Signature", 12, 2),
(46, 3, "Scorpio N", "Z8L 4x4", 12, 2),
(47, 3, "Scorpio Classic", "S11", 11, 2),
(49, 11, "Gurkha", "4x4", 15, 2),
(50, 3, "Thar", "LX Hard Top 4x4", 15, 1),
(51, 1, "Jimny", "Alpha  MT",15, 1),
(52, 6, "Fortuner", "4x4 AT", 12, 2);
select * from car;




# Cleanup
drop table if exists car;
drop table if exists manufacturer;
drop table if exists fuel_type;
drop table if exists car_segment;
drop DATABASE if exists vehicles;


