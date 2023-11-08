select t1.campaign_id       as id, 
            t1.campaign_name as name
from public.facebook_campaign  t1
;


select *
from public.facebook_campaign  t1
;


select t1.campaign_id       as id, 
            t1.campaign_name as name
from public.facebook_campaign  t1
where  t1.campaign_name = 'Brand'
             and t1.campaign_name ='Electronics'
;


select 
					spend , 
					reach , 
					clicks , 
					clicks * 1.1 as upped_clicks,
					spend + reach as fild1,
					spend/reach    as fild2
from public.facebook_ads_basic_daily fabd 
where (spend > 50000 and clicks > 500) 
			or  clicks >= 3000
order by spend	desc ,  clicks 
limit 20
;
