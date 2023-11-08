with spend_by_date as (
select     ad_date,
				campaign_id, 
				sum(spend) as total_spend,
				avg( sum(spend) ) over (partition by ad_date)  as daily_avg_for_all
from facebook_ads_basic_daily fabd 
group by 1,2 
union all 
select     ad_date,
				campaign_id, 
				sum(spend) as total_spend,
				avg( sum(spend) ) over (partition by ad_date)  as daily_avg_for_all
from facebook_ads_basic_daily fabd 
group by 1,2 
),
prioritized_spend_by_date as (
	select 
		*,
		row_number() over(  partition by ad_date, campaign_id  order by total_spend) as row_priority
	from spend_by_date
) 
select * from prioritized_spend_by_date
where row_priority = 1