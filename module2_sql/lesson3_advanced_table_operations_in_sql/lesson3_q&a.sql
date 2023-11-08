-- кейс з охопленням вище за покази

--  гіпотези 
--  1. перепутали колонки -
--  2. збій в завантаженні в якісь конкретні дати -
--  3. зайві фільтри на частину даних  -
--  4. одна під компейн -
--  5. сервіс щось своє віддає - перечитати доку  - 
--  6. маємо ще дані з гуглом - чи такі ж вони?

select 
	reach,
	impressions ,
	*
from facebook_ads_basic_daily fabd 
where reach < impressions 
;

select 
		count(distinct ad_date) 
from facebook_ads_basic_daily fabd 
where reach >impressions
;
-- 418

select 
		count(distinct ad_date) 
from facebook_ads_basic_daily fabd
;
 -- 547

select 
		count(distinct campaign_id) 
from facebook_ads_basic_daily fabd 
where reach >impressions
;
-- 11

select campaign_id,
			count(distinct reach),
			min(reach),
			max(reach),
			sum(reach)
from facebook_ads_basic_daily fabd 
where reach >impressions
group by campaign_id
;


select campaign_id,
			count(distinct reach),
			min(reach),
			max(reach),
			sum(reach)
from facebook_ads_basic_daily fabd 
where reach >impressions
group by 1
order by 5 desc 			
;

select 
*
from google_ads_basic_daily gabd 
where reach > impressions 
;

/*
маю проблему з
facebook_ads_basic_daily
є 1093 рядки з 2467 де нелогічна умова
reach > impressions
я перевірив такі гіпотези
прошу перевірити ці рядочки
*/

select *
from facebook_ads_basic_daily fabd 
where reach > impressions;

select *
from google_ads_basic_daily gabd   
where reach > impressions;

/*
Питання по минулій темі. 
Я так до кінця і не зрозуміла різницю між GROUP BY та DISTINCT. 
І що значить "використовувати GROUP BY з агрегуючої функцією?
*/

select     campaign_name,
				count(*) 
from google_ads_basic_daily
group by campaign_name
;

select 	campaign_name,
				count(distinct ad_date)
from google_ads_basic_daily gabd 
group by campaign_name
;

select distinct campaign_name
from google_ads_basic_daily
;

-- кейс   Homework 2 з кейс
select 
	ad_date, 
	campaign_id, 
	--sum(spend)/sum(clicks) as cpc1, -- помилка ділення на нуль
	case when sum(clicks)  > 0 then sum(spend)/sum(clicks)   end as cpc2
from facebook_ads_basic_daily fabd 
group by ad_date, campaign_id
order by ad_date;