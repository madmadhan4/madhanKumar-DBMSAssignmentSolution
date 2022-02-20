create schema travelonthego;
use travelonthego;
drop table if exists PRICE;
drop table if exists PASSENGER;

-- Create PASSENGER Table
create table if not exists PASSENGER( Passenger_name varchar(20),
									  Category varchar(10),
                                      Gender char,
                                      Boarding_City varchar(20),
                                      Destination_City varchar(20),
                                      Distance int,
                                      Bus_Type varchar(10) );
									
-- create PRICE Table
create table if not exists PRICE( Bus_Type varchar(10),
								  Distance int,
								  Price int );
                                  
-- Insert Data into PASSENGER Table
insert into PASSENGER values("Sejal", "AC", "F", "Bengaluru", "Chennai", 350, "Sleeper" );
insert into PASSENGER values("Anmol", "Non-AC", "M", "Mumbai", "Hyderabad", 700, "Sitting" );
insert into PASSENGER values("Pallavi", "AC", "F", "Panaji", "Bengaluru", 600, "Sleeper" );
insert into PASSENGER values("Khusboo", "AC", "F", "Chennai", "Mumbai", 1500, "Sleeper" );
insert into PASSENGER values("Udit", "Non-AC", "M", "Trivandrum", "Panaji", 1000, "Sleeper" );
insert into PASSENGER values("Ankur", "AC", "M", "Nagpur", "Hyderabad", 500, "Sitting" );
insert into PASSENGER values("Hemant", "Non-AC", "M", "Panaji", "Mumbai", 700, "Sleeper" );
insert into PASSENGER values("Manish", "Non-AC", "M", "Hyderabad", "Bengaluru", 500, "Sitting" );
insert into PASSENGER values("Piyush", "AC", "M", "Pune", "Nagpur", 700, "Sitting" );

-- Insert Data into PRICE Table
insert into PRICE values( "Sleeper", 350, 770 );
insert into PRICE values( "Sleeper", 500, 1100 );
insert into PRICE values( "Sleeper", 600, 1320 );
insert into PRICE values( "Sleeper", 700, 1540 );
insert into PRICE values( "Sleeper", 1000, 2200 );
insert into PRICE values( "Sleeper", 1200, 2640 );
insert into PRICE values( "Sleeper", 1500, 2700 );
insert into PRICE values( "Sitting", 500, 620 );
insert into PRICE values( "Sitting", 600, 744 );
insert into PRICE values( "Sitting", 700, 868 );
insert into PRICE values( "Sitting", 1000, 1240 );
insert into PRICE values( "Sitting", 1200, 1488 );
insert into PRICE values( "Sitting", 1500, 1860 );
                                  
-- Write queries for the following:
-- 3) How many females and how many male passengers travelled for a minimum distance of 600 KM s?
select Gender, count(Gender) as Gender_Count from PASSENGER where Distance > 600 group by Gender;

-- 4) Find the minimum ticket price for Sleeper Bus. 
select min(Price) as Minimum_Ticket from PRICE where Bus_Type = 'Sleeper';

-- 5) Select passenger names whose names start with character 'S'
select Passenger_name from PASSENGER where Passenger_Name like 'S%';

-- 6) Calculate price charged for each passenger displaying Passenger name, Boarding City,
--    Destination City, Bus_Type, Price in the output
select distinct(pa.Passenger_name), pa.Boarding_City, pa.Destination_City, pa.Bus_Type, pr.Price from PASSENGER pa 
inner join PRICE pr on pa.Bus_Type = pr.Bus_Type and pa.Distance = pr.Distance;

-- 7) What are the passenger name/s and his/her ticket price who travelled in the Sitting bus for a distance of 1000 KM s
select distinct(pa.Passenger_name), pr.Price from PASSENGER pa inner join PRICE pr 
on pa.Bus_Type = pr.Bus_Type and pa.Distance = pr.Distance where pr.Distance = 1000 and pr.Bus_Type = 'Sitting';

-- 8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
-- Distance from Bengaluru to Panaji is 600, so we are using the column Distance to query rather than using 
-- Boarding and Destination City
select pr.Bus_Type, pr.Price from PRICE pr inner join PASSENGER pa 
on pr.Bus_Type = pa.Bus_Type where pr.Distance = 600 group by pr.Bus_Type;

-- 9) List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.
select distinct(Distance) from PASSENGER group by Distance having count(Distance) = 1 order by Distance desc;

-- 10) Display the passenger name and percentage of distance travelled by that passenger
--     from the total distance travelled by all passengers without using user variables 
select Passenger_name, Distance * 100 / (select sum(Distance) from PASSENGER) as Percentage_Distance from PASSENGER;
-- Alternate Approach With the help of OVER() clause --
select Passenger_name, Distance * 100 / sum(Distance) OVER() as Percentage_Distance from PASSENGER;

-- 11)  Display the distance, price in three categories in table Price 
-- a) Expensive if the cost is more than 1000
-- b) Average Cost if the cost is less than 1000 and greater than 500
-- c) Cheap otherwise
select Distance, Price,
CASE
    WHEN Price >1000 THEN 'Expensive'
    WHEN Price <1000 AND Price >500 THEN 'Average Cost'
    ELSE 'Cheap'
END AS Category from PRICE;