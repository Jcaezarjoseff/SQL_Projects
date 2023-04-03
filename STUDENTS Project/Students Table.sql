create table Students (
	stud_id	char(20) primary key not null,
    fname	varchar(30) not null,
    lname	varchar(30) not null,
    gender 	varchar(1) default('undecided'),
    age		int,
    contact	int
);

create table Enrollments (
	En_ID			char(20) primary key,
    Acad_Yr			year,
    Term 			char(20),
    date_enrolled	date,
    stud_id 		char(20),
    sec_id			char(20),
    final_grade		int,
    foreign key(stud_id) references students(stud_id) on delete set null
);

create table Sections (
	Sec_ID			char(20) primary key not null,
    SName 			varchar(20),
    Course_ID		char(20),
    schedule_ID		char(20),
    instructor_ID	char(20),
    Room 			int
);

alter table enrollments
add foreign key(sec_id)
references sections(sec_id) 
on delete set null

create table Schedules (
	Sched_ID	char(20) primary key,
    day_name	varchar(10),
    start_time	time,
    end_time	time
);

alter table sections
add foreign key(schedule_id)
references schedules(sched_id)

create table courses (
	course_id			char(20) primary key,
    Course_name			varchar(20),
    course_description	varchar(50)
);

alter table sections
add foreign key(course_id)
references courses(course_id)

create table professors (
	prof_id	char(20) primary key,
    fname	varchar(20),
    lname	varchar(20),
    Pos		varchar(20),
    dept_ID	char(20)
);

alter table sections
add foreign key(instructor_id)
references professors(prof_id)

create table Departments (
	dept_id		char(20) primary key,
    dept_name	varchar(20),
    Head_ID		char(20),
    contacts	int,
	foreign key(head_id) references professors(prof_id)
);

alter table professors
add foreign key(dept_ID)
references departments(dept_id)
	





