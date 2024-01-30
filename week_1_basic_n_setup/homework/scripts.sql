-- Homework, questions 3-6
-- 3 Count records
select count("index")
from green_taxi_trips gtd
where date(lpep_pickup_datetime) = to_date('2019-09-18', 'YYYY-MM-DD')
    and date(lpep_dropoff_datetime) = to_date('2019-09-18', 'YYYY-MM-DD')

-- 4 Largest trip for each day
select lpep_pickup_datetime
from green_taxi_trips gtd
where trip_distance = (select max(trip_distance) from green_taxi_trips gtd2)

-- 5 Three biggest pickups
select zpu."Borough", sum("total_amount") as sm
from green_taxi_trips gtd
join zones zpu on gtd."PULocationID" = zpu."LocationID"
where date(gtd.lpep_pickup_datetime) = to_date('2019-09-18', 'YYYY-MM-DD') and zpu."Borough" != 'Unknown'
group by zpu."Borough"
order by sum("total_amount") desc
limit 3

-- 6 Largest tip
with tmp as (
select max(t1."tip_amount"), t1."DOLocationID"
from green_taxi_trips t1
join zones zpu on t1."PULocationID" = zpu."LocationID"
where zpu."Zone" = 'Astoria'
group by t1."DOLocationID"
order by max(t1."tip_amount") desc
limit 1
)
select zdo."Zone"
from tmp t1
JOIN zones zdo ON t1."DOLocationID"=zdo."LocationID"