# Stored Procedures : compiled format hence faster
# Views

create database student;
use student;

create table if not exists student_info(
id int,
student_code varchar(20),
firstname varchar(25),
lastname varchar(25),
subjects varchar(20),
marks int);

insert into student.student_info values(1, "101", "Krish", "Naik", "data science", 91);
insert into student.student_info values(2, "102", "Sunny", "Savita", "machine learning", 70);
insert into student.student_info values(3, "103", "John", "Dalton", "physics", 92);
insert into student.student_info values(4, "104", "Mary", "Cooper", "chemistry", 71);
insert into student.student_info values(5, "105", "Virat", "Kohli", "cricket", 92);
insert into student.student_info values(6, "106", "Sheldon", "Cooper", "physics", 91);
insert into student.student_info values(7, "107", "John", "Doe", "history", 56);
insert into student.student_info values(8, "108", "Ariv", "Ladel", "civics", 42);
insert into student.student_info values(9, "109", "Apple", "Maps", "geography", 52);
insert into student.student_info values(10, "110", "Google", "Maps", "geography", 73);
select * from student_info;

# Calling Stored Procedures
call ranked_students(90);
call top_marks(@output);
select @output;

# Index : Makes queries faster
create index idx_firstname on student_info(firstname);
select * from student_info where firstname = "Krish";
alter table student_info drop index idx_firstname;

# Views
create view stud_basic_info as
select student_code, firstname from student_info;
select * from stud_basic_info;


/* TODO : 
    # Functions
    # Triggers
    # Joins
    # CTE Windows Functions
*/