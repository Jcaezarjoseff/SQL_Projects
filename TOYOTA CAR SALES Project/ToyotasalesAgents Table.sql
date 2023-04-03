CREATE TABLE  ToyotaSalesAgents
   (	
    Agent_ID int,
    Name varchar(20) not null,
    Gender varchar(1),
    Work_branch varchar(20) not null,
    Commission decimal(4,4) not null,          
    Phone_num int,
    primary key(Agent_ID)
    );


 Create Table ToyotaClients (
    Client_ID int not null,
    Name varchar(20),
    Client_Location varchar(20),
    Agent_ID int,
    primary key(Client_ID),
    foreign key(agent_ID) references toyotasalesagents(Agent_ID)
 );

create table Purchases (
    Purchase_num int,
    Type_Purchase varchar(15),
    Purchase_date date,
    Purchase_info decimal(4,1),
    Client_ID int,
    primary key(Purchase_num),
    foreign key(client_ID) references toyotaclients(CLient_ID)
    );

    alter table purchases
    add foreign key(purchase_info)
    references toyotavariants(code);

    select * from purchases;
    select * from toyotaclients;


Create Table ToyotaCarModels(
    Car_ID int primary key,
    Car_name varchar(50)
)

Create Table ToyotaVariants (
    Code decimal(4,1) primary key,
    Variant varchar(50),
    Price int,
    Car_ID int,
    foreign key(Car_ID) references toyotacarmodels(Car_ID)
)


alter table toyotavariants
add foreign key(Car_id)
references toyotacarmodels(Car_ID)
on delete set null;

    /*SALES AGENTS DATA*/

insert into toyotasalesagents values(101,'Apple','F','TYT_Plaridel',0.05,2237482);
insert into toyotasalesagents values(102,'Jerry','M','TYT_Clark',0.05,2237543);
insert into toyotasalesagents values(103,'Mabelle','F','TYT_Commonwealth',0.05,2234545);
insert into toyotasalesagents values(104,'Ben','M','TYT_Sucat',0.05,2236561);
insert into toyotasalesagents values(105,'Denise','F','TYT_Sucat',0.05,2236561);
insert into toyotasalesagents values(106,'Flora','F','TYT_Bicutan',0.05,2236671);
insert into toyotasalesagents values(107,'Benji','M','TYT_BGC',0.05,2238994);
insert into toyotasalesagents values(108,'Cassy','F','TYT_Pasay',0.05,2234562);
insert into toyotasalesagents values(109,'Gilber','M','TYT_Commonwealth',0.05,2234545);
insert into toyotasalesagents values(110,'Shiela','F','TYT_Pampanga',0.05,2237544);

    /*CLIENTS DATA */

insert into toyotaclients values(10001,'Bert','Muntinlupa',106);
insert into toyotaclients values(10002,'Fidel','Pasay',108);
insert into toyotaclients values(10003,'Nica','Taguig main',107); 
insert into toyotaclients values(10004,'Vincent','Mabalacat',110); 
insert into toyotaclients values(10005,'Luis','Muntinlupa',104);  
insert into toyotaclients values(10006,'Jason','Moonwalk 3',106); 
insert into toyotaclients values(10007,'Claire','Quezon',109); 
insert into toyotaclients values(10008,'Denis','Samar',108); 
insert into toyotaclients values(10009,'Jayson','Clark',102); 
insert into toyotaclients values(10010,'Allan','Pasay',108); 
insert into toyotaclients values(10011,'Beatriz','Pasay',107); 
insert into toyotaclients values(10012,'Bogart','Kalayaan village',109); 
insert into toyotaclients values(10013,'Danah','BGC',107); 
insert into toyotaclients values(10014,'Zamora','Taguig sector3',107); 
insert into toyotaclients values(10015,'Castro','Baclaran',108); 
insert into toyotaclients values(10016,'Mike','Laguna',104); 
insert into toyotaclients values(10017,'Nigel','Lower Bicutan',106); 
insert into toyotaclients values(10018,'Cassy','Quezon',109); 
insert into toyotaclients values(10019,'Bea','Calbayog Metro',108); 
insert into toyotaclients values(10020,'Marie','Cavite',106); 
insert into toyotaclients values(10021,'Joshua','New Clark CIty',102); 
insert into toyotaclients values(10022,'Arturo','Bulacan',101); 
insert into toyotaclients values(10023,'Ynah','Moonwalk 2',106); 
insert into toyotaclients values(10024,'Vargas','Valley 1',104); 
insert into toyotaclients values(10025,'Leni','4th State',104); 
insert into toyotaclients values(10026,'Marcos','Quezon',109); 
insert into toyotaclients values(10027,'Natalie','Portside',107); 
insert into toyotaclients values(10028,'Marie','Plaridel',101); 
insert into toyotaclients values(10029,'Danah','Upper Bicutan',106);
insert into toyotaclients values(10030,'Kent','Pasay',108);

/*Purchases DATA */

insert into Purchases values(0001,'installment','2023-05-09',3.3,10001);
insert into Purchases values(0002,'installment','2023-05-01',1.1,10008);
insert into Purchases values(0003,'installment','2023-05-09',3.1,10030);
insert into Purchases values(0004,'installment','2023-05-07',2.3,10004);
insert into Purchases values(0005,'installment','2023-05-22',1.2,10020);
insert into Purchases values(0006,'installment','2023-05-21',5.3,10029);
insert into Purchases values(0007,'installment','2023-05-09',6.1,10009);
insert into Purchases values(0008,'installment','2023-05-01',6.1,10011);
insert into Purchases values(0009,'cash','2023-05-03',3.1,10002);
insert into Purchases values(0010,'installment','2023-05-02',4.1,10007);
insert into Purchases values(0011,'installment','2023-05-11',5.2,10010);
insert into Purchases values(0012,'installment','2023-05-30',5.1,10003);
insert into Purchases values(0013,'installment','2023-05-05',1.1,10016);
insert into Purchases values(0014,'installment','2023-05-11',3.3,10018);
insert into Purchases values(0015,'cash','2023-05-18',3.2,10006);
insert into Purchases values(0016,'cash','2023-05-19',3.3,10019);
insert into Purchases values(0017,'installment','2023-05-26',6.4,10017);
insert into Purchases values(0018,'installment','2023-05-03',3.1,10005);
insert into Purchases values(0019,'installment','2023-05-29',6.2,10024);
insert into Purchases values(0020,'installment','2023-05-13',5.1,10021);
insert into Purchases values(0021,'installment','2023-05-17',6.2,10027);
insert into Purchases values(0022,'cash','2023-05-14',3.3,10013);
insert into Purchases values(0023,'installment','2023-05-02',5.1,10015);
insert into Purchases values(0024,'installment','2023-05-24',3.3,10025);
insert into Purchases values(0025,'installment','2023-05-22',5.3,10012);
insert into Purchases values(0026,'installment','2023-05-11',1.3,10028);
insert into Purchases values(0027,'installment','2023-05-27',3.1,10023);
insert into Purchases values(0028,'installment','2023-05-02',3.2,10026);
insert into Purchases values(0029,'cash','2023-05-19',4.1,10022);
insert into Purchases values(0030,'installment','2023-05-21',4.1,10014);

/*Car Models DATA */


insert into Toyotacarmodels values(1,'Toyota Camry');
insert into Toyotacarmodels values(2,'Toyota Corolla Altis');
insert into Toyotacarmodels values(3,'Toyota Vios');
insert into Toyotacarmodels values(4,'Toyota Wigo');
insert into Toyotacarmodels values(5,'Toyota Fortuner');
insert into Toyotacarmodels values(6,'Toyota Avanza');

/*Car Models DATA */

insert into Toyotavariants values(1.1,'Toyota Camry 2.5 S AT',2012441,1);
insert into Toyotavariants values(1.2,'Toyota Camry 2.5 V AT',1566341,1);
insert into Toyotavariants values(2.1,'Toyota Corolla Altis 2.0 V AT',1987660,2);
insert into Toyotavariants values(2.2,'Toyota Corolla Altis 1.6 V AT',1788641,2);
insert into Toyotavariants values(2.3,'Toyota Corolla Altis 1.6 G AT',1450001,2);
insert into Toyotavariants values(3.1,'Toyota Vios 1.5 TRD AT',1599442,3);
insert into Toyotavariants values(3.3,'Toyota Vios 1.5 G AT',998789,3);
insert into Toyotavariants values(4.1,'Toyota Wigo 1.0 G AT',789776,4);
insert into Toyotavariants values(5.1,'Toyota Fortuner 2.8 V Diesel 4×4 AT (White Pearl)',2376123,5);
insert into Toyotavariants values(5.2,'Toyota Fortuner 2.4 V Diesel 4×2 AT',1678776,5);
insert into Toyotavariants values(5.3,'Toyota Fortuner 2.4 V Diesel 4×2 AT',1455899,5);
insert into Toyotavariants values(6.1,'Toyota Avanza 1.5 G AT',1566890,6);
insert into Toyotavariants values(6.2,'Toyota Avanza 1.3 J MT',1287000,6);
insert into Toyotavariants values(6.3,'Toyota Avanza 1.3 E MT',1150100,6);
insert into Toyotavariants values(6.4,'Toyota Avanza 1.3 E AT',1256092,6);





