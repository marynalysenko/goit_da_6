
create table _users_mlysenko (
	user_id int ,
	user_name varchar,
	email varchar
);

select * from _users_mlysenko;

insert into _users_mlysenko( user_id,user_name, email )
values ( 1, 'Max', 'supermax@gmail.com')
;

insert into _users_mlysenko( user_id,user_name, email )
values ( 2, 'Anna', 'ann95@gmail.com')
;

insert into _users_mlysenko( user_id,user_name, email )
values ( 3, 'Viktor', 'vik123@gmail.com')
;

insert into _users_mlysenko( user_id,user_name, email )
values ( 4, 'Nick', 'nick123@gmail.com'),  ( 5, 'Marie', 'mar@gmail.com')
;
--
--delete from _users_mlysenko
--where user_id = 4 or user_id = 5
; 
--
select * from _users_mlysenko;
--
alter table _users_mlysenko add primary key (user_id);


update _users_mlysenko 
set user_name = 'Maryana',
       email = 'supermar123@gmail.com'
where user_id = 5
;
---
alter table _users_mlysenko add primary key (user_id);

select * 
from pg_tables 
where tableowner = 'da_one_sigma'
limit 100

select * 
into _user_mmause
from _user2;

select *
from _user_mmause;


