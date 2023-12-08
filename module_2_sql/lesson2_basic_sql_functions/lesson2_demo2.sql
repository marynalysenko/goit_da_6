select      5/2       as col1, 
		    5.0/2.0   as col2, 
		    5::numeric / 2::numeric                  as col3, 
		    cast(5 as numeric) / cast(2 as numeric)  as col4, 
		    (5*1.0)/2                                as col5,
		    5.0/2                                    as col6,
		    cast(5/2 as numeric)                     as col7, 
		    round(2.45784435674356,     2)           as col8
;			
		    
select 123, cast(123 as varchar)		    
;
		    
select now(), 
            cast(now() as date) 
;			
            
 select
	spend / clicks  as cpc_int,
	round(spend::numeric / clicks ::numeric , 1) as cpc_num
from facebook_ads_basic_daily fabd 
 where clicks >0
 limit 100
 ;
 
 select 
		 count(*) as row_count,
		 count(campaign_id) as campaign_id_cnt, -- null 
		 count(distinct campaign_id) as uniq_camp,
		 sum(spend) as amt_all,
		 avg(spend) as avg_spend,
		 min(spend) as min_spend,
		 max(spend) as max_spend
from facebook_ads_basic_daily
; 

select * from facebook_ads_basic_daily
;

select campaign_id,
			ad_date,
			count(*)   as ad_total,
			sum(spend) as amt_all,
			avg(spend) as avg_spend,
			min(spend) as min_spend,
			max(spend) as max_spend,
			sum(spend) / avg(spend) 
from facebook_ads_basic_daily
group by campaign_id, ad_date
having campaign_id is not null 
and sum(spend)>50000
; 


select      campaign_id,
			ad_date,
			sum(spend) as amt_all
from facebook_ads_basic_daily
group by campaign_id, ad_date
having campaign_id is not null 
order by amt_all desc 
limit 5
;


    

select cast(true as varchar), 
            now(), 
            cast(now() as date)
            
select ad_date, 
            spend, 
            clicks, 
            spend/clicks as cpc_int,
            spend::numeric/clicks::numeric as cpc_numeric,
            cast(spend as numeric)/cast(clicks as numeric) as cpc_numeric2,
            (spend*1.0)/clicks as cpc_numeric3
 from    facebook_ads_basic_daily fabd 
where clicks > 5
order by cpc_numeric asc;


            
----------------------------
-- аліас це псевдонім до змінних до полів до таблиць, якщо помічали то автоматично додає 
-- as - для читабельності
----------------------------

select * 
from facebook_ads_basic_daily;

select count(*),
		    count(distinct ad_date )
from facebook_ads_basic_daily;

select count(*),
 		    count(distinct campaign_id),
 		    sum(1.0) / sum(3) 
from facebook_ads_basic_daily fabd;

select  campaign_id,
			count(*),
			sum(spend)
from facebook_ads_basic_daily fabd
group by campaign_id;
--------------------------------------------------------
select
    campaign_id,
	sum(spend/100) as total_spend,
	sum (value/100) as total_income,
	round (sum (value):: numeric/sum(spend), 2) as roas 
from facebook_ads_basic_daily fabd 
group by campaign_id
having campaign_id is not null
order by roas asc
limit 5;
