
# Stored Procedures : compiled format hence faster
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



# Triggers
create table if not exists deleted_student_info(
id int not null,
student_code varchar(20),
firstname varchar(25),
lastname varchar(25),
subjects varchar(20),
marks int,
deleted_time TIMESTAMP
);
desc deleted_student_info;

create table if not exists added_student_info(
id int not null,
student_code varchar(20),
firstname varchar(25),
lastname varchar(25),
subjects varchar(20),
marks int,
deleted_time TIMESTAMP
);
desc added_student_info;

# Triggers : works BEFORE or AFTER any INSERT/UPDATE/DELETE operations on a table
delimiter //
create TRIGGER trg_ad_student_info
after delete 
on student_info
for each row
begin
    # add the records to be deleted to deleted_student_info along with the timestamp
    insert into deleted_student_info(id, student_code, firstname, lastname, subjects, marks, deleted_time)
    values
    (old.id, old.student_code, old.firstname, old.lastname, old.subjects, old.marks, NOW());    
end;//
delimiter ;

delimiter //
create TRIGGER trg_ai_student_info
after insert 
on student_info
for each row
begin
    # add the records to be added to added_student_info along with the timestamp
    insert into added_student_info(id, student_code, firstname, lastname, subjects, marks, deleted_time)
    values
    (new.id, new.student_code, new.firstname, new.lastname, new.subjects, new.marks, NOW());
end;//
delimiter ;

delimiter //
create TRIGGER trg_ai_student_info_chk_deleted
after insert 
on student_info
for each row
FOLLOWS trg_ai_student_info
begin
    # delete records from deleted table if they have been inserted again
    delete from deleted_student_info where new.id = id;    
end;//
delimiter ;

# only shows the triggers registered
show TRIGGERS from student;
# Also check the action order
select trigger_name, action_order 
from information_schema.triggers 
where trigger_schema = 'student'
order by event_object_table, action_timing, event_manipulation;

select * from student_info;
delete from student_info where (id <= 3 and id > 0);
select * from student_info;
select * from deleted_student_info;

# Restoring >>
# Inserting records back to the main table from deleted table and trg_ai_student_info_chk_deleted will take care of claening up re-insertions 
create TEMPORARY table temp_records
select id, student_code, firstname, lastname, subjects, marks from deleted_student_info;
select * from temp_records;

SET SQL_SAFE_UPDATES = 0;
insert into student_info(id, student_code, firstname, lastname, subjects, marks)
select id, student_code, firstname, lastname, subjects, marks from temp_records where id = temp_records.id;
SET SQL_SAFE_UPDATES = 1;

# Verify the table states
select * from student_info;
select * from deleted_student_info;
select * from added_student_info;

# CTE Test >> More in the dedicated sql file
with cte_records as (select id, student_code, firstname, lastname, subjects, marks from added_student_info) select * from cte_records order by marks DESC;

