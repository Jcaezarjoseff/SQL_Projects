/*show all students details*/
select * 
from students
/*displays all datas of students including those with null/no datas, this helps us
track that student and fill there blank values on the records*/

/*select everything from students except contacts*/
select stud_id, fname, lname, gender, age
from students
/*selecting specific datas only helps us breakdown information only need*/

/*select only stud_id, fname and lname*/
select stud_id, fname, lname
from students
/*selecting specific datas only helps us breakdown information only need*/

/*how students are male and female*/
/*using group by*/
select gender, count(gender) as GENDERCOUNT
from students
group by gender
/*helps us identify gender counts easiy on a simple command*/

/*students grouped by age*/
select age, count(age) as AgeCount
from students
group by age
/*helps us identify age counts easiy on a simple command*/

/*students grouped by age and gender*/
select age, gender, count(age) as AgeCount
from students
group by age, gender
/*helps us identify age counts easiy on a simple command*/

/*sum of enrollees in 2022-2023 acad yr*/
select count(en_id) as totalenrollees
from enrollments

/*show all students enrolled in acad yr 2022-2023*/
/*displays studID, fname, lname*/
/*using nested queries*/
select stud_id, fname, lname
from students
where stud_id in (
	select stud_id
	from enrollments
	where acad_yr = '2022-2023' 
)/*considering excluding null values*/
/*these helps us track students whose acad_yr is 2022-2023 and nothing else*/

/*show all students who enrolled late considering the 
deadline is 2022-08-15 display one id,fname,lname*/
/*nested queries*/
select stud_id, fname, lname
from students
where stud_id in (
	select stud_id
	from enrollments
	where date_enrolled > '2022-08-15'
)/*helps us breakdown students who enrolled late, these data helps
us analyze how often these happens, we can avoid these next time with 
tighter restrictions on late enrollees especially when its rate is rising*/

/*show all students who enrolled in time or prior to the 
deadline display fname,lname only*/
select fname,lname
from students
where stud_id in (
	select stud_id
	from enrollments
	where date_enrolled <= '2022-08-15'
)/*simply helps us identify who enrolled early, more datas in the future will
tell us the rate of students who enroll early vs late and get some actions to it*/

/*find the students who enrolled in 2022-07-29 - 2022-08-10 display stud_id,fname, lname*/
select stud_id, fname, lname
from students
where stud_id in(
	select stud_id
	from enrollments
	where date_enrolled >= '2022-07-29' and date_enrolled <= '2022-08-10'
)/*using or operator*/
/*or*/
select stud_id, fname, lname
from students
where stud_id in(
	select stud_id
	from enrollments
	where date_enrolled 
	between '2022-07-29' and '2022-08-10'
)/*using between operator*/
/*helps us breakdown data that is only looked for*/

/*match only stud_id, fname, lname ,en_id and sec_id*/
/*using joins*/
select st.stud_id, st.fname, st.lname, en.date_enrolled, en.en_ID, en.sec_ID
from students as st
	join enrollments as en
    on st.stud_id = en.stud_id
/*join matches 2 tables with a common data but does not show those without matching datas*/
select st.stud_id, st.fname, st.lname, en.date_enrolled, en.en_ID, en.sec_ID
from students as st
	left join enrollments as en
    on st.stud_id = en.stud_id
/*left join matches 2 tables but also shows left table data even if it does not match the 2nd table*/
select st.stud_id, st.fname, st.lname, en.date_enrolled, en.en_ID, en.sec_ID
from students as st
	right join enrollments as en
    on st.stud_id = en.stud_id
/*right join matches 2 tables but also shows right table data even if it does not match the 1st table*/
/*helps us compare 2 tables and analyze specific datas to be used*/

/*show final grades for all the students displaying
stud_id, fname, lname, finalgrade*/
select st.stud_id, st.fname, st.lname, en.final_grade
from students as st
	join enrollments as en
    on st.stud_id = en.stud_id

/*create a case statement saying a grade >3.5 is excellent
>3.0 fair else poor show there id , and name and grade */
select st.stud_id, st.fname, st.lname, en.final_grade,
case
	when en.final_grade >= 3.5 then 'excellent'
    when en.final_grade >= 3 then 'fair'
    else 'poor/fail'
end as Remarks
from students as st
	join enrollments as en
    on st.stud_id = en.stud_id
/*helps us easily identify the list of outstanding and failure students*/

/*show sections*/
select *
from sections

/*students who is assigned in each sections*/
/*display stud_id, fname, lname, section, sectioname*/
select st.stud_id, st.fname, st.lname, en.sec_id, se.sname
from students as st
	join enrollments as en
    on st.stud_id = en.stud_id
    join sections as se
    on en.sec_id = se.sec_id
/*despite multiple tables, join statement helps us combined tables ang get specific matching datas specifically*/

/*how many students each sections*/
select en.sec_id, se.sname, count(en.sec_id) as SectionsHeadCount
from students as st
	join enrollments as en
    on st.stud_id = en.stud_id
    join sections as se
    on en.sec_id = se.sec_id
    group by en.sec_id 
    order by en.sec_id
/*helps us determin the number of students participating in each sections*/

/*how many male and female in each sections*/
/*displays sec_id, secname, gender, gendercount*/
select en.sec_id, se.sname, gender, count(st.gender) as GenderCountSections
from students as st
	join enrollments as en
    on st.stud_id = en.stud_id
    join sections as se
    on en.sec_id = se.sec_id
	where gender is not null		/*null values are excluded*/
    group by en.sec_id, st.gender
/*helps us breakdown the number of people according to gender in each sections*/

/*create a case statement where if sections students is < 9 = dissolved else continue classes*/
select en.sec_id, se.sname, count(st.stud_id) as StudentCountPerSec,
case
	when count(st.stud_id) < 9 then 'ClassDissolved'
    else 'Class Continues'
end as SectionsStatus
from students as st
	join enrollments as en
    on st.stud_id = en.stud_id
    join sections as se
    on en.sec_id = se.sec_id
    group by en.sec_id, se.sname
/*no CLass is dissolved since statement is less than 9 is dissolved*/
/*helps us identify if classes is dissolved or not could be more helpful if there will more sections in the future*/
    
/*create a case statement where if sections students is <= 9 = dissolved else continue classes*/
select en.sec_id, se.sname, count(st.stud_id) as StudentCountPerSec,
case
	when count(st.stud_id) <= 9 then 'ClassDissolved'
    else 'Class Continues'
end as SectionsStatus
from students as st
	join enrollments as en
    on st.stud_id = en.stud_id
    join sections as se
    on en.sec_id = se.sec_id
    group by en.sec_id, se.sname
/*S03 class is dissolved since it has only 9 students and the condition to meet is <= 9 class is dissolved*/

/*show sections and their start/end time of sched display student_id, fname, lname, section, day_name, time, 
and group by student id*/
select st.stud_id, st.fname, st.lname, se.sec_id, se.sname, sc.day_name, sc.start_time, sc.end_time
from students as st
	join enrollments as en
    on st.stud_id = en.stud_id
    join sections as se
    on en.sec_id = se.sec_id
    join schedules as sc
    on se.schedule_id = sc.sched_id
    order by st.stud_ID
/*helps us display specific schedule of each students */

/*show sections and their start/end time of sched display student_id, fname, lname, section, day_name, time, 
but this time only show students with monday schedule*/
select st.stud_id, st.fname, st.lname, se.sec_id, se.sname, sc.day_name, sc.start_time, sc.end_time
from students as st
	join enrollments as en
    on st.stud_id = en.stud_id
    join sections as se
    on en.sec_id = se.sec_id
    join schedules as sc
    on se.schedule_id = sc.sched_id
    where day_name like '%monday%'
    order by st.stud_ID
    /*helps us find the students who have monday as one of his clas schedule*/
    
/*show sections and their start/end time of sched display time, 
but this time group them according to there start_time*/
select sc.start_time, count(sc.start_time) as numb_of_stud_According_toTIME
from students as st
	join enrollments as en
    on st.stud_id = en.stud_id
    join sections as se
    on en.sec_id = se.sec_id
    join schedules as sc
    on se.schedule_id = sc.sched_id
    group by sc.start_time
    
/*show sections and there start/end time of sched
display student_id, fname, lname, section, day_name, course and prof*/
select st.stud_id, st.fname, st.lname, se.sec_id, se.sname, sc.day_name, sc.start_time, sc.end_time, co.course_id, co.course_name, prof.prof_id, prof.fname, prof.lname
from students as st
	join enrollments as en
    on st.stud_id = en.stud_id
		join sections as se
		on en.sec_id = se.sec_id
			join schedules as sc
			on se.schedule_id = sc.sched_id
				join courses as co
				on se.course_id = co.course_id
					join professors as prof
                    on se.instructor_id = prof.prof_id
    order by st.stud_ID
    
/* determine professors with 10 or more students, show profID, name*/
select prof.prof_id, prof.fname, prof.lname, count(prof.prof_id) as StudentsHandledPerProf
from students as st
	join enrollments as en
    on st.stud_id = en.stud_id
		join sections as se
		on en.sec_id = se.sec_id
			join schedules as sc
			on se.schedule_id = sc.sched_id
				join courses as co
				on se.course_id = co.course_id
					join professors as prof
                    on se.instructor_id = prof.prof_id
    group by prof.prof_id
    having count(prof.prof_id) >= 10
    order by prof.prof_id
    
/* determine professors with less than 10 students, show profID, name, dept*/
select prof.prof_id, prof.fname, prof.lname, dep.dept_id, dep.dept_name, count(prof.prof_id) as StudentsHandledPerProf
from students as st
	join enrollments as en
    on st.stud_id = en.stud_id
		join sections as se
		on en.sec_id = se.sec_id
			join schedules as sc
			on se.schedule_id = sc.sched_id
				join courses as co
				on se.course_id = co.course_id
					join professors as prof
                    on se.instructor_id = prof.prof_id
						join departments as dep
                        on dep.dept_id = prof.dept_id
    group by prof.prof_id
    having count(prof.prof_id) >= 10
    order by prof.prof_id
/*multiple joins helps you combine all tables to make relational datas breakdown into smaller datas*/

/*show departments*/
select * 
from departments
    
/*show supervisors or head of each professors*/
select pro.prof_id, pro.fname, pro.lname, dep.dept_name, dep.head_id
from professors pro
	join departments dep
    on pro.dept_id = dep.dept_id
    order by pro.prof_id
    
/*Now Using Stored Procedures*/
select *
from students as st
	join enrollments as en
    on st.stud_id = en.stud_id
		join sections as se
		on en.sec_id = se.sec_id
/*this statement is often used, and tiring if we always retype it
whenever we need it again so lets store it in stored procedure*/
delimiter $$
create procedure get_stud_en_sec()
begin
select *
from students as st
	join enrollments as en
    on st.stud_id = en.stud_id
		join sections as se
		on en.sec_id = se.sec_id
        order by st.stud_id;
end $$
delimiter ;

call get_stud_en_sec()

/*lets make our stored proc send data within the parenthesis
using stud_id*/
drop procedure get_stud_en_sec

delimiter $$
create procedure get_stud_en_sec(in id char(20))
begin
select *
from students as st
	join enrollments as en
    on st.stud_id = en.stud_id
		join sections as se
		on en.sec_id = se.sec_id
        where id = st.stud_id
        order by st.stud_id;
end $$
delimiter ;

call get_stud_en_sec(1003);
/*it calls specific data from procedure depending on what you input inside the parenthesis
as long as it belongs to the stored proc*/

/*lets make our stored proc send data within the parenthesis
using fname and lastname*/
delimiter $$
create procedure get_stud_en_sec(in firstname varchar(30), in lastname varchar(30))
begin
select *
from students as st
	join enrollments as en
    on st.stud_id = en.stud_id
		join sections as se
		on en.sec_id = se.sec_id
        where firstname = st.fname and lastname = st.lname
        order by st.stud_id;
end $$
delimiter ;

call get_stud_en_sec('arra','panganiban');
/*stored procedures benefits: reduces network traffic, increases performance, secure*/










  

    
    






    
 









    




































