create database uber;
select * from ncr;
use uber;
-- (1) Ride Booking Performance optimization 

-- Completed vs Cancelled vs Incomplete Bookings

SELECT `Booking Status`, COUNT(*) AS total_booking
FROM ncr
GROUP BY `Booking Status`;

-- Booking Performance By Vehicle Type
SELECT `vehicle type`, COUNT(*) AS total_booking
FROM ncr
GROUP BY `vehicle type`;

-- Booking TrendsBy Months And TIME

SELECT MONTH(STR_TO_DATE(Date, '%d-%m-%Y')) AS month,
    COUNT(*) AS total_booking FROM ncr
GROUP BY MONTH(STR_TO_DATE(Date, '%d-%m-%Y'))
ORDER BY month;

SELECT HOUR(STR_TO_DATE(Time, '%H:%i:%s')) AS booking_hour,
COUNT(*) AS total_booking FROM ncr
GROUP BY HOUR(STR_TO_DATE(Time, '%H:%i:%s'))
ORDER BY COUNT(*) DESC LIMIT 5;
--------------------------------------------------------------------------------------------------------------------------
-- (2) Revenue and Vehicle Profitability 
-- Revenue By Vehicle type 
select `vehicle type`, sum(`booking value`) as 'total_amount'
from ncr
group by  `vehicle type`;

-- Average Booking Value By Vehicle Type
select `vehicle type`, round(avg(`booking value`),2) as 'average_amount'
from ncr
group by  `vehicle type`;

-------------------------------------------------------------------------------------------------------------------------------
-- (3) Ride Cancellation Reduction 
-- Customer vs Driver Cancellation Rate
select sum(`Cancelled Rides by Customer`) as 'Cancelled Rides by Customer',
sum(`Cancelled Rides by Driver`) as 'Cancelled Rides by Driver' 
from ncr;

-- Top  Cancellation Reason By customer

select `Reason for cancelling by Customer`,count(*) as ' total_ride'
from ncr
group by `Reason for cancelling by Customer`
having `Reason for cancelling by Customer` <> 'null'
order by count(*) desc;

-- Top  Cancellation Reason By Driver
select `Driver Cancellation Reason`,count(*) as ' total_ride'
from ncr
group by `Driver Cancellation Reason`
having `Driver Cancellation Reason` <> 'null'
order by count(*) desc;

-- Cancellation Rate by Vehicle Type 
SELECT `Vehicle Type`, COUNT(*) AS total_rides,
SUM(`Cancelled Rides by Customer`) AS customer_cancellations,
SUM(`Cancelled Rides by Driver`) AS driver_cancellations,
ROUND((SUM(`Cancelled Rides by Customer`) + SUM(`Cancelled Rides by Driver`)) / COUNT(*) * 100, 2) AS cancellation_rate
FROM ncr
GROUP BY `Vehicle Type`
ORDER BY cancellation_rate DESC;
-------------------------------------------------------------------------------------------------------------------------------------
-- (4) Location And Route Optimization
-- Top Pickup and Drop Location  By Booking
 select `Pickup Location` , count(*) 
 from ncr 
 group by `Pickup Location`
 order by count(*)desc
 limit 3; -- for Pickup Location --

 select `Drop Location` , count(*) 
 from ncr 
 group by `Drop Location`
 order by count(*)desc
 limit 3; -- for Drop Location --

-- Most Popular Pickup And Drop Routes
SELECT `Pickup Location` , `Drop Location`, COUNT(*) AS 'TOTAL_BOOKING'
FROM NCR 
WHERE `Booking Status` = 'COMPLETED'
group by `Pickup Location`,`Drop Location`
order by COUNT(*)DESC
LIMIT 3;

-- Cancellation Rate By Pickup location 
SELECT`Pickup Location`,COUNT(*) AS total_rides,
SUM(`Booking Status` IN ('Cancelled by Customer', 'Cancelled by Driver')) AS cancelled_rides,
    ROUND(SUM(`Booking Status` IN ('Cancelled by Customer', 'Cancelled by Driver'))/ COUNT(*) * 100,2) AS cancellation_rate
FROM ncr
GROUP BY `Pickup Location`
ORDER BY cancellation_rate DESC;
-----------------------------------------------------------------------------------------------------------------------------------
-- Customer Experirnce Improvement
-- Average VTAT And CTAT By Vehicle Type
select `Vehicle Type`, round(avg(`Avg VTAT`),2) , round(avg(`Avg CTAT`),2)
from ncr 
group by `Vehicle Type`;

-- Customer Rating By Vehicle Type 
select `Vehicle Type`, round(avg(`Customer Rating`),2) 
from ncr 
group by `Vehicle Type`;


























