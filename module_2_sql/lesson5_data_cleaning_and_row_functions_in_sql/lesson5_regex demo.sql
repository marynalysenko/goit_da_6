-- where email ~ '[a-zA-Z0-9_.+-]+@[a-zA-Z0-9_.+-]+\.[a-zA-Z0-9_.+-]';

select 
	url_parameters,
	regexp_replace(url_parameters, 'utm_medium=(cpc)', 'utm_medium=ppc')
from facebook_ads_basic_daily fabd;



select url_parameters
from facebook_ads_basic_daily fabd
where url_parameters like '%utm_medium=cpc%';


select 
		url_parameters, 
		lower(substring(url_parameters, 'utm_medium=([^&#$]+)')),
		lower(substring(url_parameters, 'utm_campaign=([^&#$]+)'))
from facebook_ads_basic_daily fabd;


with cte as (
	select  
		lower('TEDDY') as a
	union 
	select 
	 	lower('TEDDY3')  as a
	 union 
	select 
	 	lower('CAT1') as a
)
select *
from cte
where a like 'cat_'

select 
		url_parameters, 
		case when lower(substring(url_parameters, 'utm_medium=([^&#$]+)')) like 'cpc' then 'error' else 'ok' end as check_res,
		lower(substring(url_parameters, 'utm_campaign=([^&#$]+)'))
from facebook_ads_basic_daily fabd;