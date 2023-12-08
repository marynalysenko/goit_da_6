-- 
select
	 ad_date, 
	 spend,
	 avg(spend) over (order by ad_date rows between 3 preceding and 0 following)
from (
			select ad_date, 
						sum(spend) as spend 
			from facebook_ads_basic_daily fabd 
			group by 1
) s
order by 1 desc