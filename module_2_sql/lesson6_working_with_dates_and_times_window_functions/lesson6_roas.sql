-- приклад ROAS 
with ad_roas as (
		select 
			date(date_trunc('month' , ad_date)) as ad_month,
			case 
				when sum(spend) != 0 then sum(value)::numeric / sum(spend)
			end as roas	
		from facebook_ads_basic_daily fabd 
		group by 1
		order by 1 desc
)
select roas.ad_month, 
			roas.roas,
			roas7d.roas as roas1y
from ad_roas as roas 
left join ad_roas as roas7d on roas.ad_month  =  roas7d.ad_month +  interval '1 year' 


-- приклад ROAS 
with ad_roas as (
		select 
			date(date_trunc('month' , ad_date)) as ad_month,
			case 
				when sum(spend) != 0 then sum(value)::numeric / sum(spend)
			end as roas	
		from facebook_ads_basic_daily fabd 
		group by 1
		order by 1 desc
)
select roas.ad_month, 
			roas.roas,
			lag(roas) over (order by ad_month asc)  as roas_1m_ago
from ad_roas as roas 










-----------------------------------------------------------------------------------

-----------------
with roas_by_date as (
	select ad_date,
		case 
			when sum(spend) != 0 then sum(value)::numeric / sum(spend)
		end as roas	
	from facebook_ads_basic_daily fabd 
	group by 1
	order by 1 desc
)
select rd.ad_date, rd.roas, rd7.roas as roas_7d_ago
from roas_by_date as rd 
left join roas_by_date as rd7 on  rd.ad_date = rd7.ad_date + interval '1 week'
order by rd.ad_date desc


-----------------
with roas_by_date as (
	select date_trunc('month', ad_date)  as ad_month,
		case 
			when sum(spend) != 0 then sum(value)::numeric / sum(spend)
		end as roas	
	from facebook_ads_basic_daily fabd 
	group by 1
	order by 1 desc
)
select rd.ad_month, rd.roas, rd7.roas as roas_1y_ago
from roas_by_date as rd 
left join roas_by_date as rd7 on  rd.ad_month = rd7.ad_month + interval '1 year'
order by rd.ad_month desc


-----------------
with roas_by_date as (
		select
			date_trunc('month', ad_date) as ad_month,
				case 
					when sum(spend) != 0 then sum(value)::numeric / sum(spend)
			end as roas
		from
			facebook_ads_basic_daily fabd
		group by 1
		order by 1 desc
)
select
	rd.ad_month,
	rd.roas,
	rd7.roas as roas_1y_ago
from
	roas_by_date as rd
left join roas_by_date as rd7 
					on rd.ad_month = rd7.ad_month + interval '1 year'
order by
	rd.ad_month desc




-- !!!! трохи быльш надійний селф джойн
-----------------
with roas_by_date as (
	select date_trunc('month', ad_date)  as ad_month,
		case 
			when sum(spend) != 0 then sum(value)::numeric / sum(spend)
		end as roas	
	from facebook_ads_basic_daily fabd 
	group by 1
	order by 1 desc
)
select rd.ad_month, rd.roas, rd7.roas as roas_1m_ago
from roas_by_date as rd 
left join roas_by_date as rd7 on  rd.ad_month = rd7.ad_month + interval '1 month'
order by rd.ad_month desc


select * from facebook_ads_basic_daily fabd 


-----------------
with roas_by_date as (
	select date_trunc('month', ad_date)  as ad_month,
		case 
			when sum(spend) != 0 then sum(value)::numeric / sum(spend)
		end as roas	
	from facebook_ads_basic_daily fabd 
	group by 1
	order by 1 desc
)
select rd.ad_month, 
			rd.roas, 
			lag(rd.roas) over (order by ad_month desc)  as roas_1m_ago
from roas_by_date as rd 
order by rd.ad_month desc
-----------------

select date_trunc('month', ad_date)  as ad_month,
				case 
					when sum(spend) != 0 then sum(value)::numeric / sum(spend)
				end as roas,
				lag(case 
					when sum(spend) != 0 then sum(value)::numeric / sum(spend)
				end) over (order by date_trunc('month', ad_date) desc)  as roas_1m_ago
from facebook_ads_basic_daily fabd 
group by 1 
order by 1 desc
-----------------

 


 