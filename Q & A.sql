-- 1.total trips

select count(distinct tripid) from trip_details_data;

select tripid, count(tripid) from trip_details_data
group by tripid
having count(tripid) > 1;




-- 2.total drivers

select * from trip_data;
select count(distinct driverid) from trip_data;



-- 3.total earnings

select * from trip_data;
select sum(fare) from trip_data;



-- 4.total Completed trips

select * from trip_details_data;
select sum(end_ride) from trip_details_data;




-- 5.total searches

select * from trip_details_data;
select sum(searches) from trip_details_data;



select sum(searches),sum(searches_got_estimate),sum(searches_for_quotes),sum(searches_got_quotes),
sum(customer_not_cancelled),sum(driver_not_cancelled),sum(otp_entered),sum(end_ride)
from trips_details;

-- 6.total searches which got estimate

select * from trip_details_data;
select sum(searches_got_estimate) from trip_details_data;


-- 7.total searches for quotes

select * from trip_details_data;
select sum(searches_for_quotes) from trip_details_data;


-- 8.total searches which got quotes

select * from trip_details_data;
select sum(searches_got_quotes) from trip_details_data;




-- 9.total driver cancelled

select * from trip_details_data;
select count(*) from trip_details_data;
select sum(driver_not_cancelled) from trip_details_data;
select count(*) - sum(driver_not_cancelled) from trip_details_data;


-- 10.total otp entered

select * from trip_details_data;
select sum(otp_entered) from trip_details_data;




-- 11.total end ride

select * from trip_details_data;
select sum(end_ride) from trip_details_data;






-- 12.average distance per trip

select * from trip_data;
select avg(distance) from trip_data;



-- 13.average fare per trip

select * from trip_data;
select avg(fare) from trip_data;
select sum(fare)/count(tripid) from trip_data;
select sum(fare)/count(*) from trip_data;



-- 14.distance travelled

select * from trip_data;
select sum(distance) from trip_data;




-- 15.which is the most used payment method 

select * from trip_data;

select a.method from payment as a join
(select faremethod, count(distinct tripid) from trip_data
group by faremethod
order by count(distinct tripid) desc limit 1) as b 
on a.id = b.faremethod;



-- 16.the highest payment was made through which instrument

select a.method from payment as a inner join
(select * from trip_data
order by fare desc
limit 1) as b 
on a.id = b.faremethod;



-- 17.which two locations had the most trips


SELECT loc_to, COUNT(distinct tripid) 
FROM trip_data
GROUP BY loc_to
ORDER BY count(distinct tripid) DESC
LIMIT 2;


-- 18.top 5 earning drivers

select * from trip_data;

select * from 
(select *,dense_rank() over(order by fare desc) rnk
from
(select driverid, sum(fare) fare from trip_data
group by driverid)b)c
where rnk<6
;



-- 19.which duration had more trips

select * from trip_data;

select * from
(select *, rank() over(order by cnt desc) rnk from
(select duration, count(distinct tripid) cnt from trip_data
group by duration)b)c
where rnk=1;


-- 20.which driver, customer pair had more orders

select * from trip_data;

select * from
(select *, rank() over(order by cnt desc) rnk from
(select driverid, custid, count(distinct tripid) cnt from trip_data
group by driverid,custid)c)d
where rnk=1;


-- 21. search to estimate rate

select * from trip_details_data;

select sum(searches_got_estimate)*100/sum(searches) from trip_details_data;


-- 22. estimate to search for quote rates

select sum(searches_for_quotes)*100/sum(searches) from trip_details_data;


-- 23. quote acceptance rate

select sum(searches_got_quotes)*100/sum(searches) from trip_details_data;





-- 24. which area got highest trips in which duration

select * from 
(select *, rank() over(partition by duration order by cnt desc) rnk from
(select duration, loc_from, count(distinct tripid) cnt from trip_data
group by duration, loc_from)a)b
where rnk=1;



-- 25. which area got the highest fares, cancellations

select * from trip_data;
select * from trip_details_data;

select * from 
(select *,rank() over(order by fare desc) rnk from
(select loc_from, sum(fare) fare from trip_data
group by loc_from)a)b
where rnk=1;

select * from
(select *, rank() over(order by can desc) rnk from
(select loc_from, count(*) - sum(driver_not_cancelled) can
from trip_details_data
group by loc_from)a)b
where rnk=1;



-- 26. which duration got the highest trips and fares

select * from
(select *, rank() over(order by fare desc) rnk from
(select duration, count(distinct tripid) fare from trip_data
group by duration)a)b
where rnk=1;

