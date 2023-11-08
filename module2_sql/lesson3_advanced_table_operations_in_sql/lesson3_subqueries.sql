select 1;

select true;

select *
from (select 1) t
;

select *
from (select 1) t
where 'a' in (select 'a')
;

select 1 as num, 'a' as letter
;


with ex1 as (
	select 1 as num, 'a' as letter
)
select *
from ex1
where 1 in (select num from ex1)
;

-------------------------------------

select *
from (select 1 as num, 'a' as letter) as t
where 1 in (select num from (select 1 as num, 'a' as letter) as t)
;

-------------------------------------