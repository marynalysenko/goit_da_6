 with fb as (
		select fabd.ad_date, 
					fc.campaign_name, 
					fa.adset_name,
					fabd.spend, 
					fabd.impressions,
					fabd.reach, 
					fabd.clicks, 
					fabd.leads, 
					fabd.value,
					'facebook' as add_source
		from facebook_ads_basic_daily fabd 
		left join facebook_campaign fc on fc.campaign_id  = fabd.campaign_id 
		left join facebook_adset fa  on fa.adset_id = fabd.adset_id 
		where reach > impressions 
	),
google as (
		select fabd.ad_date, 
					fabd.campaign_name, 
					fabd.adset_name,
					fabd.spend, 
					fabd.impressions,
					fabd.reach, 
					fabd.clicks, 
					fabd.leads, 
					fabd.value,
					'google' as add_source
		from google_ads_basic_daily   fabd  
		where reach > impressions 
		) , 
	res as (select * from 
				(select * from fb
				union all
				select * from google
				) as t1 
		order by ad_date		
		)
	select count(*) from 	res
	;
	

