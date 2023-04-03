
create table Borrowers (
    mem_ID CHAR(20) primary key,
    firstname varchar(20) not null,
    lastname varchar(20),
    mem_type varchar(10),
    address varchar(30) default('Not Available'),
    start_date date not null,
    expiry_date date not null,
    fine decimal(4,2)
);

create table Book_Transactions (
    trans_num char(20) primary key not null,
    mem_ID char(20),
    book_ID int,
    issue_date date not null,
    return_date date not NULL,
    foreign key(mem_ID) references borrowers(mem_ID)
);

create table Books (
    Book_ID int primary key,
    Title varchar(40) not null,
    Author varchar(40) not null,
    Genre varchar(20),
    Price decimal(4,2),
    Availability varchar(10)
);

alter table book_transactions
add foreign key(book_id)
references books(book_id)


create table Publisher (
    pub_id char(20) primary key,
    pub_yr int,
    book_id int,
    pub_name varchar(30),
    address varchar(50),
    foreign key(book_id) references books(book_id)
);

create table membership (
    mem_type varchar(10) primary key,
    mem_type_des varchar(100)
)

alter table borrowers
add foreign key(mem_type)
references membership(mem_type)

alter table books
add foreign key(availability)
references membership(mem_type)




