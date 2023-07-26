drop table if exists goldusers_signup;
CREATE TABLE goldusers_signup(userid integer,gold_signup_date date); 

INSERT INTO goldusers_signup(userid,gold_signup_date) 
 VALUES (1,STR_TO_DATE('09-22-2017','%m-%d-%Y')),
(3,STR_TO_DATE('04-21-2017','%m-%d-%Y'));

drop table if exists users;
CREATE TABLE users(userid integer,signup_date date); 

INSERT INTO users(userid,signup_date) 
 VALUES (1,STR_TO_DATE('09-02-2014','%m-%d-%Y')),
(2,STR_TO_DATE('01-15-2015','%m-%d-%Y')),
(3,STR_TO_DATE('04-11-2014','%m-%d-%Y'));

drop table if exists sales;
CREATE TABLE sales(userid integer,created_date date,product_id integer); 

INSERT INTO sales(userid,created_date,product_id) 
 VALUES (1,STR_TO_DATE('04-19-2017','%m-%d-%Y'),2),
(3,STR_TO_DATE('12-18-2019','%m-%d-%Y'),1),
(2,STR_TO_DATE('07-20-2020','%m-%d-%Y'),3),
(1,STR_TO_DATE('10-23-2019','%m-%d-%Y'),2),
(1,STR_TO_DATE('03-19-2018','%m-%d-%Y'),3),
(3,STR_TO_DATE('12-20-2016','%m-%d-%Y'),2),
(1,STR_TO_DATE('11-09-2016','%m-%d-%Y'),1),
(1,STR_TO_DATE('05-20-2016','%m-%d-%Y'),3),
(2,STR_TO_DATE('09-24-2017','%m-%d-%Y'),1),
(1,STR_TO_DATE('03-11-2017','%m-%d-%Y'),2),
(1,STR_TO_DATE('03-11-2016','%m-%d-%Y'),1),
(3,STR_TO_DATE('11-10-2016','%m-%d-%Y'),1),
(3,STR_TO_DATE('12-07-2017','%m-%d-%Y'),2),
(3,STR_TO_DATE('12-15-2016','%m-%d-%Y'),2),
(2,STR_TO_DATE('11-08-2017','%m-%d-%Y'),2),
(2,STR_TO_DATE('09-10-2018','%m-%d-%Y'),3);


drop table if exists product;
CREATE TABLE product(product_id integer,product_name text,price integer); 

INSERT INTO product(product_id,product_name,price) 
 VALUES
(1,'p1',980),
(2,'p2',870),
(3,'p3',330);


select * from sales;
select * from product;
select * from goldusers_signup;
select * from users;
