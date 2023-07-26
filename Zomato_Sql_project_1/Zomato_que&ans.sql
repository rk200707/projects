-- 1. What is the total amount each customer spent on Zomato?

select sales.userid, sum(product.price) as 'Total amount'
from sales
inner join product
on sales.product_id = product.product_id
group by sales.userid
order by sales.userid asc ;

-- 2. How many days has each customer visited zomato?

select userid, count(distinct created_date) as 'Days_Visited' 
from sales
group by userid;

-- 3. what was the first product purchased by each customer?

select * 
from (select *, rank() over(partition by userid order by created_date) rnk 
from sales) a where rnk = 1;

/* 4. what is the most purchased item on the menu 
and how many times was it purchased by all customers? */

select userid, count(product_id) cnt
from sales where product_id = 
(select product_id 
from sales
group by product_id
order by count(product_id) desc
limit 1)
group by userid
order by userid;

-- 5. which item was the most popular for each customer?

select userid, product_id from
(select userid, product_id, count(product_id), 
rank() over(partition by userid order by count(product_id) desc) popular_product
from sales
group by userid, product_id)
a where popular_product = 1;

-- 6. what item was purchased first by the customer after they became a member?

select userid, product_id from 
(select a.userid, a.created_date, a.product_id, b.gold_signup_date,
rank() over(partition by userid order by created_date) as rnk 
from sales as a
inner join goldusers_signup as b
on a.userid = b.userid
where gold_signup_date <= created_date
order by userid, product_id)
a where rnk = 1;

-- 7. which item was purchased just before the customer become a member?

select * from 
(select a.userid, a.created_date, a.product_id, b.gold_signup_date,
rank() over(partition by userid order by created_date desc) as rnk
from sales as a
inner join goldusers_signup as b
on a.userid = b.userid
where gold_signup_date >= created_date
order by userid, product_id)
a where rnk = 1;

-- 8. what is the total orders and amount spent for each member before they became a member?

select c.userid, count(c.product_id) as total_orders, sum(d.price) as amount_spent from
(select a.userid, a.created_date, a.product_id, b.gold_signup_date 
from sales as a
inner join goldusers_signup as b
on a.userid = b.userid
where a.created_date <= b.gold_signup_date ) as c
inner join product as d
on c.product_id = d.product_id
group by c.userid
order by c.userid;

/* 9. If value of 2 zomato points = 5rs and 
each product has different purchasing points for eg for p1 5rs = 1 zomato point, 
for p2 10rs=5 zomato point and for p3 5rs = 1 zomato point 
calculate points collected by each cutomer and for which product most points have been given till now*/

select c.userid, sum(c.zomato_points) as total_money_earned 
from (select a.userid,
	Case
		when b.product_id = 1 then (2.5*(price/5))
        when b.product_id = 2 then (2.5*(price/2))
        when b.product_id = 3 then (2.5*(price/5))
	END as zomato_points
from sales as a
inner join product as b
on a.product_id = b.product_id) as c
group by c.userid
order by c.userid;

select e.* from
(select d.*, rank() over(order by d.total_points desc) rnk from
(select c.product_id, sum(c.zomato_points) as total_points
from (select a.userid,a.product_id,
	Case
		when b.product_id = 1 then (price/5)
        when b.product_id = 2 then (price/2)
        when b.product_id = 3 then (price/5)
	END as zomato_points
from sales as a
inner join product as b
on a.product_id = b.product_id) as c
group by c.product_id
order by c.product_id) as d) as e
where rnk = 1 ;

/*10. In the first one year after a customer joins the gold program (including their join date) irrespective
of what the customer has purchased they earn '5' zomato points for every 10 rs spent who earned more 1 or 3 
and what was their points earning in their first year? */

select e.userid, e.created_date, e.gold_signup_date, (e.price/2) as zomato_points from
(select c.*, d.gold_signup_date from
(select a.*, b.price
from sales as a inner join product as b on a.product_id=b.product_id) as c
inner join goldusers_signup as d
on c.userid = d.userid
and c.created_date > d.gold_signup_date
and c.created_date <= date_add(d.gold_signup_date, Interval 1 year ))as e
order by e.userid;

-- 11. rank all the transaction of the customers

select *, rank() over(partition by userid order by created_date) rnk from sales;

/* 12. rank all the transactions for each member wherever they are a zomato gold member 
for every non gold member transaction mark as na */

select c.*, 
	case 
		when gold_signup_date is null
		then 'na'
		else rank() over(partition by userid order by created_date desc)
	end as rnk
from (select a.userid, a.created_date, a.product_id, b.gold_signup_date
from sales as a left join goldusers_signup as b on a.userid = b.userid
and a.created_date >= b.gold_signup_date) as c;