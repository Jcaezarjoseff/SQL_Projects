
create table employees
(Emp_ID int primary key,
firstname varchar(30),
lastname varchar(30),
birthdate date,
sex varchar(10),
salary int,
superID int,
branchID int
);



create table branch (
    branchID int primary key,
    branch_name varchar (30),
    mgr_ID int,
    mgr_start_date date,
    foreign key(mgr_id) references employees(emp_id) on delete set null
);


alter table employees
add foreign key(branchid)
references branch(branchid)
on delete set null;

alter table employees
add foreign key(superID)
references employees(emp_ID)
on delete set null;


create table client (
    clientID int primary key,
    client_name varchar(30),
    branchID int,
    foreign key(branchID) references branch(branchID) on delete set null
);



create table works_with(
    emp_id int,
    clientID int,
    total_sales int,
    primary key(emp_ID, clientID),
    foreign key (emp_id) references employees(emp_id) on delete cascade,
    foreign key (clientID) references client(clientID) on delete cascade
);


create table branch_supplier (
    branchID int,
    supplier_name varchar(50),
    supply_type varchar(50),
    primary key(branchID, supplier_name),
    foreign key (branchID) references branch(branchID) on delete cascade
);



