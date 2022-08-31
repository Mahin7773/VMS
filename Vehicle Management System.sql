set pagesize 1000;
set linesize 5000;
set tab off;
set lines 256;
set trimout on;

--drop command

Drop TABLE Purchasement;
Drop TABLE Customer;
Drop TABLE Extras;
Drop TABLE BasicInfo;
Drop TABLE Body;
Drop TABLE Engine;

----------table cration-----------

create TABLE Engine(
    EngineID VARCHAR2(10) NOT NULL,
    EngineType VARCHAR2(10),
    EngineSize VARCHAR2(10),
    FuelSystem VARCHAR2(10),
    HP NUMBER(5),
    PRIMARY KEY (EngineID)
);
create TABLE Body(
    BodyID VARCHAR2(10) NOT NULL,
    Color VARCHAR2(10),
    Seats NUMBER(2),
    WheelSize VARCHAR2(10),
    Height NUMBER(3,1),
    Width NUMBER(3,1),
    Length NUMBER(3,1),
    Primary key (BodyID)
);
Create table BasicInfo(
    CarID VARCHAR2(10) NOT NULL,
    BodyID VARCHAR2(10),
    EngineID VARCHAR2(10),
    Model VARCHAR2(20),
    Manufacturer VARCHAR2(20),
    Price NUMBER(30),
    Condition VARCHAR2(10),
    LaunchDate DATE,
    Mileage NUMBER(10),
    primary key (CarID),
    foreign KEY (EngineID) REFERENCES Engine(EngineID),
    foreign KEY (BodyID) REFERENCES Body(BodyID)
);
create table Extras(
    CarID VARCHAR2(10) NOT NULL,
    AutoPilot VARCHAR2(10),
    SmartAssistant VARCHAR2(15),
    GPS VARCHAR2(5),
    Radio VARCHAR2(5),
    Primary key (CarID),
    Foreign key (CarID) references BasicInfo(CarID) 
);
Create TABLE Customer(
    CustID VARCHAR2(10) NOT NULL,
    CustName varchar2(20),
    Address varchar2(40),
    Email varchar(30),
    Phone number(15),
    PRIMARY KEY (CustID)
);
Create TABLE Purchasement(
    CustID VARCHAR2(10) NOT NULL,
    CarID VARCHAR2(10) NOT NULL,
    NoOfCars number(5),
    PDate DATE, 
    PRIMARY KEY (CustID,CarID),
    Foreign KEY (CustID) REFERENCES Customer(CustID),
    Foreign KEY (CarID) REFERENCES BasicInfo(CarID)
);

----------Data insertion----------

--customer
Insert into Customer values('CT1807','Christopher Nolan','222B Baker Street London','nolan123@gmail.com',831671261);
Insert into Customer values('CT1808','Curtis Mayfield','378 Eagle Lane Minnesota','cmf399@gmail.com',795289377);
Insert into Customer values('CT1803','Robert Pattinson','2129 Wilson Street California','pattinson56@yahoo.com',603802256);
Insert into Customer values('CT1801','Sadie Sink','1546 Pleasant Hill Road California','sadsink@gmail.com',595219298);
Insert into Customer values('CT1806','Maxine Mayfield','2098 Juniper Drive Michigan','maxx44@yahoo.com',962343534);
Insert into Customer values('CT1804','Miachael Morbius','2753 Armory Road North Carolina','morbin@marvel.com',831642069);

--engine
Insert into engine VALUES('EG041','Combustion','Medium','Diesel',1000);
Insert into engine VALUES('EG042','Electric','Medium','',900);
Insert into engine VALUES('EG044','Combustion','Large','Gasoline',1200);
Insert into engine VALUES('EG045','Combustion','Large','Octane',1400);
Insert into engine VALUES('EG046','Hybrid','Large','Octane',1000);
Insert into engine VALUES('EG047','Electric','Large','',1300);


--body
insert INTO body VALUES('BD001','white',4,'Medium',14.5,9.5,22.5);
insert INTO body VALUES('BD002','red',2,'small',12.5,7.5,18.5);
insert INTO body VALUES('BD003','purple',10,'large',16.5,12.5,25.5);
insert INTO body VALUES('BD004','white',4,'Medium',14.5,9.5,22.5);
insert INTO body VALUES('BD005','black',4,'Medium',14.5,9.5,22.5);

--basicinfo
insert INTO basicinfo VALUES('CR001','BD001','EG041','LaFerrari','Ferrari',5000000,'New',TO_DATE('24-May-2005'),40);
insert INTO basicinfo VALUES('CR003','BD005','EG042','Model S','Tesla',95000,'New',TO_DATE('22-Jun-2012'),400);
insert INTO basicinfo VALUES('CR005','BD002','EG041','4c Spider','Alfa Romeo',68500,'New',TO_DATE('20-Jan-2020'),50);
insert INTO basicinfo VALUES('CR002','BD005','EG041','Shelby GT500','Ford',50000,'Used',TO_DATE('24-May-2006'),70);
insert INTO basicinfo VALUES('CR009','BD005','EG044','Noah 2014','Toyota',8500,'Used',TO_DATE('24-May-2014'),50);

--extras
Insert INTO extras VALUES('CR001','No','Yes','Yes','Yes');
Insert INTO extras VALUES('CR003','Yes','Yes','Yes','Yes');
Insert INTO extras VALUES('CR005','No','Yes','Yes','Yes');
Insert INTO extras VALUES('CR009','No','No','Yes','Yes');
Insert INTO extras VALUES('CR002','No','Yes','Yes','Yes');

--purchasement
insert INTO purchasement VALUES('CT1804','CR001',5000,TO_DATE('22-JAN-2022'));
insert INTO purchasement VALUES('CT1804','CR003',23000,TO_DATE('22-JAN-2022'));
insert INTO purchasement VALUES('CT1804','CR005',4400,TO_DATE('22-JAN-2022'));
insert INTO purchasement VALUES('CT1804','CR009',52300,TO_DATE('22-JAN-2022'));
insert INTO purchasement VALUES('CT1804','CR002',50330,TO_DATE('22-JAN-2022'));

----------Queries----------

select * from tab;

--descriptions
desc basicinfo;
desc engine;
desc body;
desc extras;
desc customer;
desc purchasement;

--show data
select * from basicinfo;
select * from engine;
select * from body;
select * from extras;
select * from customer;
select * from purchasement;


--alter command

alter TABLE customer ADD tempColumn1 INTEGER;
alter TABLE customer ADD tempColumn2 VARCHAR(10);
desc customer;

alter TABLE customer MODIFY tempColumn1 VARCHAR(10);
desc customer;

alter TABLE customer drop COLUMN tempColumn2;
desc customer;

alter TABLE customer RENAME COLUMN tempColumn1 to TC1;
desc customer;

alter TABLE customer drop COLUMN TC1;



--update command

SELECT * FROM customer;
update customer SET CustName='Crhistopher Columbus' where CustID='CT1807';
SELECT * FROM customer;


--delete command

insert into customer VALUES('temp1','temporary customer','temporary address','temporary email',123456789);
SELECT * from customer;
delete FROM customer where CustID='temp1';
SELECT * from customer;


--applying conditions

select CustName, Address, Email from customer where CustID='CT1807';
SELECT Color, Seats, Height from body where BodyID='BD001';



--range search

select CustID, CarID, PDate from purchasement where NoOfCars between 20000 AND 60000;
select CustID, CarID, PDate from purchasement where NoOfCars>=4000 AND NoOfCars<=25000;



--set membership

select CustID, CarID, PDate from purchasement where NoOfCars IN(4400,23000);



--pattern matching

select CustID,CustName from customer
where address like '%California%';



--order by

select * from customer order by CustID;



--aggregate functions
select MAX(NoOfCars),MIN(NoOfCars) from purchasement;
select COUNT(*),SUM(Price),AVG(Price) from basicinfo;



--group by clause
select CustID,COUNT(CarID),SUM(NoOfCars) from purchasement
group by CustID;



--having clause
select CustID,COUNT(CarID) from purchasement
group by CustID
having COUNT(CarID)>2;



--nested query
select CarID from extras where AutoPilot in(
    select AutoPilot from extras
    where AutoPilot='Yes' AND SmartAssistant='Yes');


------------------------------------------------------------------------
----set operations----

--union all operation
select CustName from customer
where address like '%California%'
union all       --union of customers living in california and customers who made a purchase
select c.CustName from customer c
where c.CustName IN(
    select cc.CustName from customer cc, purchasement p
    where p.CustID=cc.CustID
);

--union operaton
select CustName from customer
union      --union of all customers and customers who made a purchase, no duplicate
select c.CustName from customer c
where c.CustName IN(
    select cc.CustName from customer cc, purchasement p
    where p.CustID=cc.CustID
);

--intersection operation
select CustName from customer
intersect      --intersection of all customers and customers who made a purchase
select c.CustName from customer c
where c.CustName IN(
    select cc.CustName from customer cc, purchasement p
    where p.CustID=cc.CustID
);

--minus operation
select CustName from customer
minus      --all customers minus the customers who made a purchase
select c.CustName from customer c
where c.CustName IN(
    select cc.CustName from customer cc, purchasement p
    where p.CustID=cc.CustID
);



----------------------------------------------------------------------------------
------join operations------
select CustName, Address, Email, CarID from customer join purchasement
using(CustID) where NoOfCars>50000;

--natural join
select CustName, Phone, CarID from customer natural join purchasement
where NoOfCars>50000;

--cross join
select CustName from customer cross join purchasement;

--Outer join
select Model from basicinfo outer join extras 
on SmartAssistant='Yes';




---------------------------------------------------------------------------------
--PL/SQL
--applying 10% discount on a purcahse of 500 cars and more
SET SERVEROUTPUT ON
DECLARE
    total_price basicinfo.Price%type;
    car_price basicinfo.Price%type;
    num purchasement.NoOfCars%type;
    car basicinfo.CarID%type :='CR001';
BEGIN
    select price into car_price from basicinfo,purchasement
    where basicinfo.CarID=car and purchasement.CarID=car;
    select NoOfCars into num from basicinfo,purchasement
    where basicinfo.CarID=car and purchasement.CarID=car;

    total_price := car_price*num;

    IF num>=500 THEN
        total_price:=total_price-(total_price*0.1);
    ELSE
        total_price:=total_price;
    END IF;

    dbms_output.put_line('Total bill for ordering '||num||' '||car||' is: '||total_price);

END;
/


--PL/SQL normal loop example

SET SERVEROUTPUT ON
DECLARE
    counter NUMBER(2):=0;
BEGIN
    LOOP
        counter:=counter+1;
        DBMS_OUTPUT.PUT_LINE('counter is now '||counter);
        EXIT when counter=5;
    END LOOP;
END;
/



--PL/SQL for loop and cursor
--printing car name and their extra features
SET SERVEROUTPUT ON
DECLARE
    CURSOR car IS SELECT Model, AutoPilot, SmartAssistant, GPS, Radio from basicinfo,extras
    where basicinfo.CarID=extras.CarID;
    car_extras car%ROWTYPE;
    counter number(2);

BEGIN
    OPEN car;
    for counter in 1..5
    LOOP
        FETCH car into car_extras;
        DBMS_OUTPUT.PUT_LINE('Car:'||car_extras.Model||' GPS:'||car_extras.GPS||' RADIO:'||car_extras.Radio||' SA:'||car_extras.SmartAssistant||' AP:'||car_extras.AutoPilot);
    END LOOP;
    CLOSE car;
END;
/



--PL/SQL procedures
--printing body features
SET SERVEROUTPUT ON
CREATE or REPLACE PROCEDURE GetBodyInfo IS 
    color body.Color%type;
    seats body.Seats%type;
    height body.Height%type;
BEGIN
    SELECT Color into color from body
    where BodyID='BD001';
    SELECT Seats into seats from body
    where BodyID='BD001';
    SELECT Height into height from body
    where BodyID='BD001';
    DBMS_OUTPUT.PUT_LINE('For BodyID BD001 color is '||color||',no. of seats is '||seats||',height is '||height);
END;
/

BEGIN
    GetBodyInfo;
END;
/



--PL/SQL functions
--calculation of bill for a purchasement
SET SERVEROUTPUT ON
CREATE OR REPLACE FUNCTION calculate(price in basicinfo.Price%type, num in purchasement.NoOfCars%type)
    RETURN NUMBER IS
BEGIN
    RETURN(price*num);
END calculate;
/
SET SERVEROUTPUT ON
DECLARE
    CURSOR cur IS SELECT Model, Price, NoOfCars, CustName from basicinfo,purchasement,customer
    where basicinfo.CarID=purchasement.CarID AND purchasement.CustID=customer.CustID;
    cur_out cur%ROWTYPE;
    counter2 number(2);
BEGIN
    OPEN cur;
    for counter2 in 1..5
    LOOP
        FETCH cur into cur_out;
        DBMS_OUTPUT.PUT_LINE('Customer:'||cur_out.CustName||' Model:'||cur_out.Model||' Price:'||cur_out.Price||' Num.:'||cur_out.NoOfCars||' Total:'||calculate(cur_out.Price,cur_out.NoOfCars));
    END LOOP;
    CLOSE cur;
END;
/




--PL/SQL Trigger
CREATE OR REPLACE TRIGGER trig BEFORE INSERT OR UPDATE ON purchasement
FOR EACH ROW
DECLARE
    c_min constant number(5):=1;
BEGIN
    IF :new.NoOfCars<c_min THEN
    RAISE_APPLICATION_ERROR(-20000,'Minimum Number of Purchasement must be at least 1');
    END IF;
END;
/
--activates trigger
insert INTO purchasement VALUES('CT1801','CR002',0,TO_DATE('21-JAN-1988'));
--does not acitvate trigger
insert INTO purchasement VALUES('CT1801','CR002',1,TO_DATE('22-JAN-1988'));





--Transaction Management
savepoint trn_1;
insert INTO purchasement VALUES('CT1801','CR003',100,TO_DATE('22-JAN-2022'));
select * from purchasement;
rollback to trn_1;
select * from purchasement;
insert INTO purchasement VALUES('CT1801','CR005',50,TO_DATE('22-JAN-2022'));
savepoint trn_2;
commit;
--cannot rollback after commit
rollback to trn_2;



--date operation
select * from purchasement;
select ADD_MONTHS(PDate,6) from purchasement
where CustID='CT1801';
select CustID,CarID,NoOfCars,EXTRACT(Year FROM PDate) AS PurchaseYear FROM purchasement;

--showing the current date of system from builtin dual table
select sysdate from dual;
select current_date from dual;
--showing the current date and time of the system
select systimestamp from dual;



--outro
set SERVEROUTPUT on;
begin
dbms_output.put_line('--');
dbms_output.put_line('--');
dbms_output.put_line('--');
dbms_output.put_line('--');
dbms_output.put_line('Project Name:');
dbms_output.put_line('Vehicle Management System');
dbms_output.put_line('-------------------------');
dbms_output.put_line('Created by:');
dbms_output.put_line('Md. Mashrur Alam');
dbms_output.put_line('-------------------------');
dbms_output.put_line('Roll:');
dbms_output.put_line('1807001');
dbms_output.put_line('-------------------------');
end;
/