/*Sample QUERIES */

select *
from borrowers;
select*
from book_transactions;
select *
from books;
select * 
from publisher;
select *
from membership

/*find all borrowers whose membership is still active up to this date which is 2023-04-01*/
/*display only name and mem type*/
select firstname, lastname
from borrowers
where expiry_date > '2023-04-01'
/*it is useful in managing a library to electronically identify whose membership is still
valid */

/*group borrowers according to their membership type*/
select mem_type, count(mem_type) as mem_type_count
from borrowers
group by mem_type
/*can easily identify the comparison of number of members according to mem type*/

/*group borrowers by their addresses */ 
select address, count(address)
from borrowers
group by address
/*data shows that more borrowers are coming from port moresby*/

/*group borrowers by their addresses and mem type*/
select address, mem_type, count(address)
from borrowers
group by address, mem_type
/*data shows more platinum users in 4th state city and more gold users
in port moresby*/

/*identify thos borrowers with existing fines then order by fines*/
select * 
from borrowers
where fine > 0
order by fine
/*data shows the borrowers with fine, and observed that Mr. ervin has the highest
fine while drey has the lowest*/

/*identify who has the highest fine without accesing looking at the table */
select mem_type, firstname, lastname
from borrowers
where fine = (
	select max(fine)
	from borrowers
)/*more complicated script but this scenario is without looking at the exting table
because datas in table changes over time in real world*/

/*select distinct name*/
select distinct firstname, lastname
from borrowers

/*what books can Gold users acces*/
select * from books
where availability = 'gold'
/*displays only books that can be accesed by gold member*/

/*what books can platinum users acces*/
select *
from books
where availability = 'platinum'

/*what book bannie radcliff borrowed*/
select *
from books
where book_id = (
    select book_id
    from book_transactions 
    where mem_id = (
        select mem_ID 
        from borrowers
        where firstname = 'Bannie' and lastname = 'Radcliff'
));/*data shows that bannie borrower jk rowlings harry potter and
chamber of secret book*/

/*what book did ace magallanes borrowerd*/
select*
from books
where book_id = (
	select book_id
	from book_transactions 
	where mem_id = (
		select mem_id
		from borrowers 
		where firstname = 'ace' and lastname ='magallanes'
))/*data shows that Mr. ace borrowed a book sister by stan and jan berenstain*/

/*this time find out who borrowed the book a midsummer nights dream*/
/*display only mem_ID, firstname and lastname*/
select mem_id, firstname, lastname
from borrowers
where mem_id = (
	select mem_id
	from book_transactions
	where book_id = (
		select book_id
		from books
		where title = 'A Midsummer Nights Dream'
))/*data shows the book was borrowed by mr. clark robins*/

/*whose books has a return date until 2023-04-05*/
select firstname, Lastname
from borrowers
where mem_id in (
    select mem_id
    from book_transactions
    where return_date <= '2023-04-05'
)/*data shows that these people have there books returned until 2023-04-5*/

/*determine those people who havnt returned their books yet despite the deadline */
select * 
from borrowers
where mem_id in (
	select mem_id
	from book_transactions
	where status = 'delayed'
)/*data shows people who havnt returned books yet the consequences should be fines*/

/*people who returned their books without delays or on time*/
select * 
from borrowers
where mem_id in (
	select mem_id
	from book_transactions
	where status = 'returned'
)/*data shows people who have returned their books on or before the deadlin*/

/*combining table books and book transactions based in mem_ID*/
select *
from borrowers as bo
    join book_transactions as bt
    on bo.mem_ID = bt.mem_id
    
/*people with returned status, this time display all info*/
select *
from borrowers as bo
    join book_transactions as bt
    on bo.mem_ID = bt.mem_id
	where status = 'returned'
/*this time people returned books has displayed their other details including their
transactions*/

/*display all info of the borrower who borrowed the book the prize by irving wallace*/
select *
from borrowers as bo
	join book_transactions as bt
    on bo.mem_id = bt.mem_id
		join books as b
        on bt.book_id = b.book_id 
where title = 'the prize'
/*data shows all info of the borrower including transactions and book details*/

/*determine the name of borrower , books borrowed and publisher of books available*/
/*order them by author*/
select bo.firstname, bo.lastname, b.title, b.author, p.pub_name
from borrowers as bo
	join book_transactions as bt
    on bo.mem_id = bt.mem_id
		join books as b
        on bt.book_id = b.book_id
			join publisher as p
            on b.book_id = p.book_id
order by author
/*joined 3 tables and data was specified accordingly*/

/*display counts of each publishers available in library*/
select p.pub_name, count(p.pub_name) as PublisherCount
from borrowers as bo
	join book_transactions as bt
    on bo.mem_id = bt.mem_id
		join books as b
        on bt.book_id = b.book_id
			join publisher as p
            on b.book_id = p.book_id
group by p.pub_name
/*data shows count of books with their publisher grouped by publisher*/

/*this time we must retain other infos such as names titles and author while we count
number of each publisher present in the library*/
select bo.firstname, bo.lastname, b.title, b.author, p.pub_name,
count(p.pub_name) over (partition by p.pub_name) as CountPublisher
from borrowers as bo
	join book_transactions as bt
    on bo.mem_id = bt.mem_id
		join books as b
        on bt.book_id = b.book_id
			join publisher as p
            on b.book_id = p.book_id
/*partition by was used in order to retain variaty of informations while
publisher count still displays */

/*determining the date difference from this 2023-04-01 date from return date as time elapsed in number of days*/
select b.mem_ID, bt.book_id, bt.trans_num, datediff('2023-04-01', return_date) as date_difference_days
from Book_transactions as bt
    join borrowers as b
    on bt.mem_ID = b.mem_ID
/*all positive integer or the output must indicate that it has been days books should be returned*/
/*negative numbers means the return date has not yet come*/

/*determining fines*/
select bo.mem_ID, bo.firstname, bo.lastname, bt.trans_num , bt.return_date, datediff('2023-03-29', bt.return_date) as date_diff_days, b.price, bt.status,
case
    when status = 'delayed' then datediff('23-03-29', return_date) * (b.price * 0.05)
	when status = 'active' or status = 'returned' then 'NoFines'
    else null
end as Total_fines
from borrowers as bo
    join book_transactions as bt
    on bo.mem_ID = bt.mem_ID
    join books as b
    on bt.book_id = b.book_id
    /*data show on total_fines that a status displayed in delayed obviously gets a fine 
    based on the given formula, otherwise it shoud be still active or already returned*/

/*Lets say A finance is monitoring a specific table that includes datas such as 
borrowers name number of elapse days past from return date , status and fines*/
/*this data should be accessed frequently by the IT guy thats why we will make a stored procedure for this*/
/*finance is responsible to head up the borrower of its status and existing fines*/
delimiter $$
create procedure Borrower_fines()
begin
select bo.mem_ID, bo.firstname, bo.lastname, bt.trans_num , bt.return_date, datediff('2023-04-01', bt.return_date) as date_diff_days, b.price, bt.status,
case
    when status = 'delayed' then datediff('23-04-01', return_date) * (b.price * 0.05)
    when status = 'active' or status = 'returned' then 'NoFines'
    else null
end as Total_fines
from borrowers as bo
    join book_transactions as bt
    on bo.mem_ID = bt.mem_ID
    join books as b
    on bt.book_id = b.book_id;
end $$
delimiter ;

call borrower_fines()
/*this script simply calls output of the above script*/




