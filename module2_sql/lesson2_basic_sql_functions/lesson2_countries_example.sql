drop table if exists __countries_mlysenko;

-- Show the countries that are big by area (more than 3 million) or big by population (more than 250 million) but not both 
create table __countries_mlysenko (
    country_id serial primary key,
    country_name varchar(30) ,
    area numeric,
    population numeric 
);

insert into __countries_mlysenko (country_name, area, population) 
values
    ('Country A', 4000000, 220000000),
    ('Country B', 2800000, 270000000),
    ('Country C', 3500000, 290000000),
    ('Country D', 2500000, 260000000),
    ('Country E', 4500000, 300000000);
 
 
select *
from __countries_mlysenko
where (area > 3000000 or population > 250000000) and not (area > 3000000 and population > 250000000);