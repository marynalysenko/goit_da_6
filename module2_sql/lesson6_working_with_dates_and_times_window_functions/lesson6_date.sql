select   date('2023-11-02')

select   date('2023-06-11 12:00:00.000'::timestamp)

select date('2023-11-02'), 
			date_trunc( 'week',    date('2023-11-02')),
			date_trunc( 'year',    date('2023-11-02')),
			date_trunc( 'month',    date('2023-11-02'))
			
		
select  age('2023-03-03'::DATE , '2023-01-01'::DATE); --2 mons 2 days

select '2023-03-03'::DATE  -  '2023-01-01'::DATE --61 

select '2023-01-01'::DATE  + interval '61 day'

select age('2020-10-01'::date)



select 
	date_trunc('day','2023-11-25'::date) ,
	date_trunc('day','2023-11-5'::date),
	date_trunc('day','2023-11-25'::date) - date_trunc('day','2023-11-5'::date)

	
SELECT 
	DATE_PART ('year',  '2025-03-03'::date),
	DATE_PART ('month',  '2025-10-03'::date),
	DATE_PART ('day',  '2025-10-03'::date)

	
SELECT extract (month from '2025-03-03'::date)
	


-- одне і теж 
SELECT extract (year from '2025-03-03'::date),
               DATE_PART ('year',  '2025-03-03'::date)


-- корисно для когортного аналізу
select date_trunc('week', current_date)
select date_trunc('month', current_date)
select date_trunc('year', current_date)


select  age('2025-03-03'::DATE , '2023-06-30'::DATE); --1 year 8 mons 3 days


SELECT 
		DATE_PART('month',    age('2025-03-03'::DATE , '2023-06-30'::DATE)) + DATE_PART('year',    age('2025-03-03'::DATE , '2023-06-30'::DATE))*12;


SELECT DATE_PART('day', age('2023-03-03'::DATE , '2023-01-01'::DATE));
SELECT DATE_PART('month', age('2023-03-03'::DATE , '2023-01-01'::DATE));
SELECT DATE_PART('year', age('2023-03-03'::DATE , '2023-01-01'::DATE));

-- у звичному виді
SELECT DATE_PART('month', age('2023-03-03'::DATE , '2023-01-01'::DATE))+ DATE_PART('year', age('2023-03-03'::DATE , '2023-01-01'::DATE))*12


-- є можливість отримати різницю дат в днях
SELECT ('2023-03-03'::DATE - '2023-01-01'::DATE) AS days_difference;

-- але навпаки тільки інтервал
select date('2023-10-01') + interval '1 day'