# Stored Procedures : compiled format hence faster
# Views

create database if not exists student;
use student;

create table if not exists student_info(
id int not null,
student_code varchar(20),
firstname varchar(25),
lastname varchar(25),
subjects varchar(20),
marks int,
primary key(id)
);
desc student_info;

insert into student.student_info values(1, "101", "Krish", "Naik", "data science", 91);
insert into student.student_info values(2, "102", "Sunny", "Savita", "machine learning", 70);
insert into student.student_info values(3, "103", "John", "Dalton", "physics", 92);
insert into student.student_info values(4, "104", "Mary", "Cooper", "chemistry", 71);
insert into student.student_info values(5, "105", "Virat", "Kohli", "cricket", 92);
insert into student.student_info values(6, "106", "Sheldon", "Cooper", "physics", 91);
insert into student.student_info values(7, "107", "John", "Doe", "history", 56);
insert into student.student_info values(8, "108", "Ariv", "Ladel", "civics", 42);
insert into student.student_info values(9, "109", "Apple", "Maps", "geography", 52);
insert into student.student_info values(10, "110", "Google", "Maps", "geography", 73)


# Creating Stored Procedures without wizard >>
# 1. Change the delimiter to something other than ';'
delimiter //
# 2. Define the Stored Procedure
create procedure if not exists sp_display_names()
begin
    select id, firstname, lastname from student_info order by lastname;
end; // # end the block with the delimiter
# 3. Restore the delimiter back to default ';'
delimiter ;
# Call the Stored Procedure
call sp_display_names();

delimiter //
create procedure if not exists sp_display_names_id(_id int)
begin
    select id, firstname, lastname from student_info where id = _id order by lastname;
end; // 
delimiter ;
call sp_display_names_id(3);

delimiter //
create procedure sp_get_subjects_for_id(in _id int, out _subjects varchar(20))
begin
    select subjects into _subjects from student_info where id = _id;
end; //
delimiter ;

call sp_get_subjects_for_id(1, @ret_sub);
select @ret_sub;
select * from student_info where subjects = @ret_sub;

# Index : Makes queries faster
create index idx_firstname on student_info(firstname);
select * from student_info where firstname = "Krish";
alter table student_info drop index idx_firstname;

# Functions
delimiter //
create function fn_get_result(marks int, threshold int)
returns varchar(8)
DETERMINISTIC
begin
    declare result varchar(8);
    if marks >= threshold then set result = "pass";
    else set result = "fail";
    end if;
    return result;
end; //
delimiter ;

select id, fn_get_result(marks, 90) from student_info;


/* TODO : 
    # Triggers
    # CTE Windows Functions
*/



