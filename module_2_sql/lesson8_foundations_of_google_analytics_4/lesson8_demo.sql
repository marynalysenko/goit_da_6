-- LESSON 8: GOOGLE ANALYTICS 4 BIGQUERY DEMO
-- документація: https://support.google.com/analytics/answer/7029846?sjid=277899357526244524-EU

-- Експортує раз в день з певною затримкою (але не пініше 48 годин)
-- Кожна таблиця = відповідна дата
-- Отже у нас дані за 3 місяці

SELECT distinct event_date
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_20210131` 
;
-- застосування маски вводу щоб отримати дані з усих таблиць
SELECT distinct event_date
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` 
;
-- але так робити не рекомендую коли готуєте дані (зірочку на всих не використовувати, а відтестувати на 1-2 таблиці а потім вкінці запустити на всіх)

-- застосування суфіксів як фільтра таблиць
--Є спосіб кверіти лише частину таблиць (технічна складова, це не оператор і не частина таблиці 
-- це біг квері дає спосіб як використовувати те що винесено за зірочку, він стрінг рядок і його можна легко порівнювати)

SELECT distinct event_date
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
where _table_suffix = '20210101'
;

SELECT distinct event_date
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
where _table_suffix >= '20210101'
;

SELECT distinct event_date
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` 
where _table_suffix in  ('20201201', '20201230')
;
-- застосування суфіксів як фільтра таблиць з between
SELECT distinct event_date
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` 
where _table_suffix between  '20201201' and '20201230'
;
-- фільтрація за датою з таймстемпа
select distinct date(timestamp_micros(event_timestamp)) as report_date
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` 
where EXTRACT(YEAR FROM date(timestamp_micros(event_timestamp))) = 2021
order by 1
;
-- дістаємо параметри та затосовуємо регулярні вирази
select  
        (select value.int_value from e.event_params where key = 'ga_session_id')    as session_id, -- він не є унікальним
        user_pseudo_id,

        (select value.string_value from e.event_params where key = 'page_location') as page_location, 
        regexp_extract((select value.string_value from e.event_params where key = 'page_location'), r'https?://[^/]+(/[^?#]*)?' ) as path

from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` as e
where _table_suffix in  ('20201201', '20201230')
;
-- винесення параметрів в cte
with event_param as (
select  
        (select value.int_value from e.event_params where key = 'ga_session_id')    as session_id, -- він не є унікальним
        user_pseudo_id,
        (select value.string_value from e.event_params where key = 'page_location') as page_location
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` as e
where _table_suffix in  ('20201201', '20201230')
limit 1000
)
select 
        regexp_extract(page_location, r'https?://[^/]+(/[^?#]*)?' ) as path
from   event_param      
;


-- дивимось на кількість подій в сесії
with event_param as (
select  
        (select value.int_value from e.event_params where key = 'ga_session_id')    as session_id, -- він не є унікальним
        user_pseudo_id,
        event_name,
        (select value.string_value from e.event_params where key = 'page_location') as page_location
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` as e
--where _table_suffix in  ('20201201', '20201230')
--limit 1000
)
select 
        user_pseudo_id,
        session_id,
        count(*) as session_event_count
from   event_param   
where event_name = 'session_start'
group by 1,2
order by  3 desc
;

-- подивимось на топ-часті події
select event_name, count(*) as t
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` as e
group by 1
order by 2 desc 
;

-- визначити кількість сесій в яких була купівля товару
with event_param as (
select  
        (select value.int_value from e.event_params where key = 'ga_session_id')    as session_id, -- він не є унікальним
        user_pseudo_id,
        event_name,
        event_timestamp
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` as e
where _table_suffix between '20201201' and '20201230'
limit 1000
)
select 
        user_pseudo_id,
        session_id,
        count(*) as session_event_count ,

        count( distinct case when event_name = 'page_view' then   event_timestamp end)   as page_views_cnt,
        count( distinct case when event_name = 'purchase' then   event_timestamp end)    as purchase_cnt,
        count( distinct case when event_name = 'purchase' then   event_timestamp end)>=1 as has_purchased

from   event_param   
group by 1,2
order by  3 desc
;



-- дістанемо дані по девайсам (алалогічно діставати гео дані)
with event_param as (
select  
        (select value.int_value from e.event_params where key = 'ga_session_id')    as session_id, -- він не є унікальним
        user_pseudo_id,
        event_name,
        event_timestamp,
        device.category,
        device.operating_system,
        device.operating_system_version	
from `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` as e
where _table_suffix between '20201201' and '20201205'
limit 100
)
select 
        user_pseudo_id,
        session_id,

        category,
        operating_system,
        operating_system_version,	

        count(*) as session_event_count
from   event_param   
group by 1,2,3,4,5
order by  3 desc
;


-- метрики залученності: session_engaged
-- (сессії в яких користувач був залучений)
with event_params as (
    SELECT 
       user_pseudo_id,
      (select value.int_value from e.event_params where key = 'ga_session_id')    as session_id, 
      
      ( select coalesce(value.string_value, cast(value.int_value  as string ), cast(value.float_value  as string ) ) 
        FROM e.event_params 
        where key = 'session_engaged'

      ) = '1' as  session_engaged
    FROM 
      `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` e
    LIMIT 100
)
select  user_pseudo_id, 
        session_id,  
        session_engaged,
        count(*) as event_count
from event_params
group by 1,2,3 
order by 4
;


-- наступна метрика залученності engagement_time_msec
with event_params as (
    SELECT 
       user_pseudo_id,
       event_name,
       event_timestamp,
      (select value.int_value from e.event_params where key = 'ga_session_id')        as session_id, 
      (SELECT value.int_value FROM e.event_params WHERE key = 'engagement_time_msec') as engagement_time_msec

    FROM 
      `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*` e
    LIMIT 100
)
select  user_pseudo_id, 
        session_id,  
        sum(engagement_time_msec) as total_time_on_site
from event_params
group by 1,2
order by 3 desc
;

--  кейс з Q&A
SELECT
  event_date,
  event_name,
  COUNT(*) AS event_count
FROM
  `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE
  event_name IN ( 'add_to_cart', 'purchase')
  AND _TABLE_SUFFIX BETWEEN '20201201' AND '20201202'
GROUP BY 1, 2;