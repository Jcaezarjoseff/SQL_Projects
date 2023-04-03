/*find all employees, clients, branches, works_with, branch salary*/
select * 
from employees
select *
from branches
select *
from clients
select *
from works_with
select *
from branch_suppliers

/*find employees salary inorder by how much they make*/
select emp_ID, firstname, lastname, salary
from employees
order by salary
/*quering data according to your preference is very helpful to avoid waste of time*/

/*find all employees ordered by sex then name*/
select emp_ID, sex, firstname, lastname
from employees
order by sex asc, firstname, lastname
/*quering data according to your preference is very helpful to avoid waste of time*/

/*find the first five employees*/
select *
from employees
where emp_id < 105
/*all info less below id 105 will be listed
/*or*/
select *
from employees
limit 5 offset 3
/*all info starting from 3rd up to 5 counts will be listed */

/*find the first and lastname of all employees*/
select firstname, lastname
from employees
order by firstname, lastname
/*selecting only first and last name in order*/

/*changing the name of columns i.e*/
select firstname as forename, lastname as surname
from employees
order by firstname, lastname
/*changing column names into ur preference would help you navigate data easily in the future*/

/*find out all the different genders*/
select distinct sex
from employees

/*find out all the diff supplier names*/
select distinct supplier_name
from branch_suppliers
/*helpful so you can easily identify what are the supplier names'*/

/*find out the number of human according to sex*/
select sex, count(sex) as gendercount
from employees
group by sex
/*helps you know the population in the business according to gender*/

/*find the number of employees*/
select count(emp_id) as totalemployees
from employees
/*helps you identify the total count of your employees*/

/*find the number of female employees born after 1970*/
select count(emp_id) as femalebornafter1970
from employees
where sex = 'F' and birthdate > '1970-01-01'
/*helps you breakdown data into small data like this */

/*find the ave salary of all employees who are male*/
select avg(salary) as AverageSalary
from employees
where sex = 'M'

/*find the sum of all employees salary*/
select sum(salary) as SalarySum
from employees

/*find the total sales of each salesman*/
select sum(total_sales), emp_id
from works_with
group by emp_id

/*how much money did client spent with the branch*/
select clientID, sum(total_sales)
from works_with
group by clientID

/*or a much complicated one */
select cli.clientID, sum(total_sales)
from clients as cli
    join works_with as wor
    on cli.clientID = wor.clientID
    group by cli.clientID

/*find any clients who are an LLC*/
select *
from Clients
where client_name like '%LLC%'

-/*find branch supplier in label business*/
select *
from branch_suppliers
where supplier_name like '%Label%'

/*find any employee born in october*/
select *
from employees
where birthdate like '____-10-__'

/*getting data in a single column usnig UNION*/
select firstname
from employees
union
select branch_name
from branches
union
select clientID
from clients
/*just a simple query in which you ar going to get all the data without a reference just the data 
neede*/

/*find client and supplier name*/
select client_name, Clientid ,clients.branchID
from clients
union
select supplier_name, supply_type ,branch_suppliers.branchID
from branch_suppliers
/*a union in 2 columns*/

/*find out how many employees are there in each branch*/
select emp.branchID, count(emp.emp_ID) 
from employees as emp
    join branches as bra
    on emp.branchid = bra.branchid
    group by branchID
/*or much simpler*/
select branchID, count(emp_id)
from employees
group by branchID
/*helps you get population of employees on each brances*/

/*find all branches and the names of the managers*/
select bra.branchid, bra.branch_name, bra.mgr_id, emp.firstname, emp.lastname
from employees as emp
    join branches as bra
    on emp.emp_id = bra.mgr_id
/*helps you easily identify the assigned manager on each branch*/ 

/*display all datas on employees table based on emp_id to mgr_id to 2nd table */
select emp.emp_id ,emp.firstname, emp.lastname ,bra.mgr_id, bra.branch_name
from employees as emp 
	left join branches as bra
	on emp.emp_id = bra.mgr_id
/*all datas on the first table will be displayed despite no matching data on 2nd table*/

/*display all datas on employees table based on emp_id to mgr_id to 2nd table */
select emp.emp_id ,emp.firstname, emp.lastname ,bra.mgr_id, bra.branch_name
from employees as emp 
    right join branches as bra
    on emp.emp_id = bra.mgr_id
/*all datas on the 2nd table will be displayed despite no matching data on 1st table*/

/*find names of all employees who have sold over 30000 to a single client*/
/*Using nested Queries*/
select employees.firstname, employees.lastname
from employees
where employees.emp_id IN 
    (select works_with.emp_id
    from works_with
    where total_sales > 30000)

/*find all clients who are handled by the branch that micahel scott manages*/
select cli.clientID, client_name
from clients as cli
where cli. branchID in (
    select employees.branchID
    from employees
    where firstname = 'Fidel' and lastname = 'Scott'
/*simply determines which client is being handled by Fidel Scott*/

/*find out what branch has the least sales*/
/*display branchID and branch name*/
/*using nested query*/
select branch_name
from branches
where branchID = (select branchID
from clients
where clientID = (
	select clientID
	from works_with
	where total_sales = (
		select min(total_sales)
		from works_with
)))
/*using join*/
select br.branchID, br.branch_name 
from branches br
	join clients cli
    on br.branchID = cli.branchID
    join works_with ww
    on cli.clientID = ww.clientID
    where ww.total_sales = 5000
/*identifying who has the least sale will soon help the business analyze what could be the reason
if it depends on the client or the branch that handles*/

/*determine the branch with highest sales*/
select branchID, branch_name
from branches
where branchID = (select branchID
from clients
where clientID = (
	select clientID
	from works_with
	where total_sales = (
		select max(total_sales)
		from works_with
)))

select br.branchID, br.branch_name 
from branches br
	join clients cli
    on br.branchID = cli.branchID
    join works_with ww
    on cli.clientID = ww.clientID
    where ww.total_sales = 267000

/*make a case, where an employeed gets a commission of 0.05 of the sales if he/she gets the quota,
example sales quota should be 30000 per client otherwise he/she gets only 0.02 commission*/

select *
from employees em
	join works_with ww
    on em.emp_id = ww.emp_id
/*since not all got sales. im gonna use left join so all id will be displayed with no sales*/
select em.emp_id, em.firstname, em.lastname, em.salary,ww.clientID, ww.total_sales,
case
	when ww.total_sales < 30000 then ww.total_sales * 0.03
    when ww.total_sales >= 30000 then ww.total_sales * 0.05
    else 'NoSalesNoCommission'
end as commission,
case
	when ww.total_sales is null or ww.total_sales = 0
    then em.salary - (em.salary * 0.01)
    else 'ReferToCommissionTable'
end as SalaryPayCut
from employees em
	left join works_with ww
    on em.emp_id = ww.emp_id
    where em.emp_id <> 100
/*this case statement is a very helpful guide on when and who deserves to have a commision , raise or salary paycut
but we ddnt include salary raise here*/

/*i want the previous query to be accesible anytime, so im gonna put it
in a procedure*/
delimiter $$
create procedure get_commission_cut()
begin
		select em.emp_id, em.firstname, em.lastname, em.salary,ww.clientID, ww.total_sales,
case
	when ww.total_sales < 30000 then ww.total_sales * 0.03
    when ww.total_sales >= 30000 then ww.total_sales * 0.05
    else 'NoSalesNoCommission'
end as commission,
case
	when ww.total_sales is null or ww.total_sales = 0
    then em.salary - (em.salary * 0.01)
    else 'ReferToCommissionTable'
end as SalaryPayCut
from employees em
	left join works_with ww
    on em.emp_id = ww.emp_id
    where em.emp_id <> 100;
end $$
delimiter ;

call get_commission_cut()
/*you can access the output by just running this script and no need for rewriting 
all the code in the previous*/

/*additional Learnings*/
/* ON DELETE */

/*ON DELET SET NULL i.e. "foreign key(mgr_id) references employees(emp_id) on delete set null"
--this means that if an emp id is deleted from employees table, its gonna set null to tables associated with it(branch)

--ON DELETE CASCADE i.e "foreign key(mgr_id) references employees(emp_id) on delete set null"
--this means that if an emp id is deleted from employees table, its gonna delete the entire row of the associated table (branch)*/

 create table branch (
    branchID int primary key,
    branch_name varchar (30),
    mgr_ID int,
    mgr_start_date date,
    foreign key(mgr_id) references employees(emp_id) on delete set null
);

