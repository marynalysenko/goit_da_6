with fb_res as (
		select t2.campaign_name , 
					sum(spend) as costs
		from facebook_ads_basic_daily as t1 
		left join facebook_campaign as t2 on t1.campaign_id = t2.campaign_id
		group by t2.campaign_name),
google_res as (
		select campaign_name , 
					sum(spend) as costs
		from google_ads_basic_daily gabd 
		group by campaign_name
)
select 
		t1.campaign_name as fb_campaign_name,
		t1.costs as fb_costs,
		t2.campaign_name as google_campaign_name,
		t2.costs as google_costs
from fb_res as t1 
cross join google_res as t2
 ;
 


with common_tab as (
		select 1 as a 
		union 
		select 2 as a
		), 
common_tab2 as 
(
		select 4 as a 
		union 
		select 5 as a
)
select  * 
from common_tab
cross join common_tab2
;


with tab as (
select 'a' as letter, 
			array[1,2,3]  as arr
union 		
select 'b' as letter ,  
			array[3, 4, 5]  as arr
			)
select t1.* , t2		
from 	tab as t1
cross join unnest(arr) as t2
;