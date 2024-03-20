# Exercises

create DATABASE ats;
use ats;

create table techmap(
applicant_id int not NULL,
tech varchar(25) not null
);
desc techmap;

insert into techmap values
(1, "ds"), 
(1, "py"),
(1, "sql"),
(2, "sql"),
(2, "py"),
(2, "ds"),
(2, "tableau"),
(3, "tableau"),
(3, "sql"),
(1, "tableau"),
(1, "c"),
(1, "c++"),
(3, "as3"),
(3, "java"),
(2, "php"),
(2, "java");

select applicant_id, tech from techmap ORDER BY applicant_id;

SELECT applicant_id from techmap where tech in ("ds", "sql", "py");

# Using Nested Queries to get the applicants who know ds, sql and py
select applicant_id from techmap where tech = "ds" and applicant_id in (
select applicant_id from techmap where tech = "sql" and applicant_id in (
select applicant_id from techmap where tech = "java"
));


# Cleanup
drop table if exists techmap;
drop database if exists ats;