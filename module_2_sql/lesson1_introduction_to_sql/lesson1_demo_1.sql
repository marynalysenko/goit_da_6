select ad_date, campaign_id, adset_id, spend, impressions, reach, clicks, leads, value, url_parameters, total
from public.facebook_ads_basic_daily
where spend > 100000
order by leads desc, clicks
limit 10;


-- example 2
drop table if exists __users;

create table __users (
	user_id       int,
	user_name varchar,
	email          varchar
);

insert into __users (user_id, user_name, email)
values (1, 'John', 'john@example.com');

insert into __users (user_id, user_name, email)
values
   (2, 'Jane', 'jane@example.com'),
   (3, 'Alice', 'alice@example.com');

select * from __users;

update __users
set user_name = 'Marie'
where user_id = 2;

delete from __users
where user_id = 2;
