-- приклад  використання функцій
CREATE OR REPLACE FUNCTION pg_temp.decode_url_part(p varchar) RETURNS varchar AS $$
SELECT convert_from(CAST(E'\\x' || string_agg(CASE WHEN length(r.m[1]) = 1 THEN encode(convert_to(r.m[1], 'SQL_ASCII'), 'hex') ELSE substring(r.m[1] from 2 for 2) END, '') AS bytea), 'UTF8')
FROM regexp_matches($1, '%[0-9a-f][0-9a-f]|.', 'gi') AS r(m);
$$ LANGUAGE SQL IMMUTABLE STRICT;

select 
	ad_date,
	url_parameters,
	substring(url_parameters, 'utm_campaign=([^\&]+)'),
	lower(substring(url_parameters, 'utm_campaign=([^\&]+)')),
	decode_url_part(lower(substring(url_parameters, 'utm_campaign=([^\&]+)'))),
	case
		when lower(substring(url_parameters, 'utm_campaign=([^\&]+)')) != 'nan' 
					then decode_url_part(lower(substring(url_parameters, 'utm_campaign=([^\&]+)')))
	end as utm_campaign, 
	coalesce(spend, 0) as spend
from 	facebook_ads_basic_daily fabd;