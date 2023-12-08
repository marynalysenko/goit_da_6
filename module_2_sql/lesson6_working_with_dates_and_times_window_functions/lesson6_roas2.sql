-- приклад ROAS 

select 
		date(date_trunc('month' , ad_date)) as ad_month,
        case 
				when sum(spend) != 0 then sum(value)::numeric / sum(spend)
        end as roas, 
        lag(case 
				when sum(spend) != 0 then sum(value)::numeric / sum(spend)
        end) over( order by date(date_trunc('month' , ad_date))) as roas_prev
from facebook_ads_basic_daily fabd 
group by 1
order by 1 desc



select roas.ad_month, 
                        roas.roas,
                        lag(roas) over (order by ad_month asc)  as roas_1m_ago
from ad_roas as roas 

-------------------------------------------------

select ad_date, 
			campaign_id, 
            date(date_trunc('month', ad_date)) as ym, 
			sum(spend) as total_spend,
			lag(sum(spend)) over(  order by ad_date   ) as total_spend_prev, 
			avg(sum(spend) )    over ( partition by date(date_trunc('month', ad_date)), campaign_id ) as monthly_avg_spend
from facebook_ads_basic_daily fabd 
group by 1,2,3
order by 1,2,3








select     ad_date,
				sum(spend) as total_spend,
				lag( sum(spend) ) over (order by ad_date desc)  as spending_1d_ago -- попередній рядок
from facebook_ads_basic_daily fabd 
group by 1 
order by 1 desc 

-----------------
-- порівняти з середнім спендом за всіма
select     ad_date,
				campaign_id, 
				sum(spend) as total_spend,
				avg( sum(spend) ) over (partition by ad_date)  as spending_1d_ago
from facebook_ads_basic_daily fabd 
group by 1,2 
order by 1 desc ,2 desc 
-----------------


 
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


