----- Homework 6 Q&A -----
/*
алгоритм розрахунку:
1. обєднуєте дані гугла і фейсбука як раніше (не забуваємо про coalesce)
2. в наступній cte будуєте статистику з date_trunc помісячно
3. в настіпній cte до попередньої застосовуєте ще lag щоб отримати значення за попередній місяць (previous_month_cpm і тд)
4. в основній частині попередньо зробивши перевірку на не рівність знаменника нулю розраховуємо
на прикладі цієї метрики cpm::numeric / previous_month_cpm - 1 (на скільки % змінилось значення відносно попереднього місяця)
*/

with all_ads_data as (

	select ad_date, url_parameters, 
	coalesce(spend, 0) as spend,  
	coalesce(clicks, 0) as clicks

	from facebook_ads_basic_daily fabd
	
	union all
	select ad_date, 
	url_parameters, 
	coalesce(spend, 0), 
	coalesce(clicks, 0)
	from google_ads_basic_daily gabd
),

monthly_stats as (
	select 
		date_trunc('month', ad_date) as ad_month, 
		case
			when lower(substring(url_parameters, 'utm_campaign=([^\&]+)')) != 'nan' then (lower(substring(url_parameters, 'utm_campaign=([^\&]+)')))
		end as utm_campaign,
		sum(spend) as total_spend, 
		sum(clicks) as total_clicks,
		case 
			when sum(clicks) > 0 then sum(spend)/sum(clicks)
		end as cpc 
	from all_ads_data aad 
	group by 1,2
),
monthly_stats_with_changes as (
	select 
		*,
		lag(cpc) over(partition by utm_campaign order by ad_month desc) as previous_month_cpc
  	from monthly_stats ms
)
select 
	*,
	case 
		when previous_month_cpc > 0 then cpc::numeric / previous_month_cpc - 1
		when previous_month_cpc = 0 and cpc > 0 then 1 -- за замовчуванням
	end as cpc_change
from monthly_stats_with_changes mswc;
