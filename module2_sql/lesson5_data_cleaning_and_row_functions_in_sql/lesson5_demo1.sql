select
	url_parameters,
	substring(url_parameters, 'utm_campaign=([^\&]+)')
from facebook_ads_basic_daily

select
	url_parameters,
	 lower(substring(url_parameters, 'utm_campaign=([^\&]+)'))
from facebook_ads_basic_daily

----- Homework 2 -----
select 
	ad_date, 
	campaign_id, 
	sum(spend) as total_spend, 
	sum(impressions) as total_impressions,
	sum(clicks) as total_clicks,
	sum(value) as total_value,
	sum(spend)/sum(clicks) as cpc,
	1000*sum(spend)/sum(impressions) as cpm,
	sum(clicks)::numeric/sum(impressions) as ctr,
	sum(value)::numeric/sum(spend) as romi
from facebook_ads_basic_daily fabd 
where clicks > 0 and impressions > 0 and spend > 0
group by ad_date, campaign_id
order by ad_date desc;


select * from facebook_ads_basic_daily limit 100

-------------------------------












-- more for coalese 
drop table if exists sales_mlysenko;

CREATE TABLE sales_mlysenko (
    order_date DATE,
    ship_date DATE,
    delivery_date DATE,
    return_date DATE
);

INSERT INTO sales_mlysenko (order_date, ship_date, delivery_date, return_date)
VALUES
    ('2023-01-01', '2023-01-05', '2023-01-10', NULL),
    ('2023-01-02', '2023-01-06', NULL, '2023-01-15'),
    ('2023-01-03', NULL, '2023-01-11', '2023-01-20'),
    ('2023-01-04', '2023-01-08', NULL, NULL);
   
   
 SELECT 
    order_date,
    COALESCE(ship_date, delivery_date, return_date, now()::date) AS actual_date_coalesce
FROM sales_mlysenko;  
   
SELECT 
    order_date,
    COALESCE(ship_date, delivery_date, return_date) AS actual_date_coalesce,
    ISNULL(ship_date::date, now()::date) AS ship_date_isnull,
    ISNULL(delivery_date::date, now()::date) AS delivery_date_isnull,
    ISNULL(return_date::date, now()::date) AS return_date_isnull
FROM sales_mlysenko;

-----

