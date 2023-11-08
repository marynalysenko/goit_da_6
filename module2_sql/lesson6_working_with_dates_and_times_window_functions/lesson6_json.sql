 select *
 from public.orders o

 
 select *
 from "HR".orders o 
 
  
 select id, 
 			info,
 			json_object_keys(info) 
 from "HR".orders e 

   
 select id, 
 			info,
 			json_object_keys(info)  as json_key
 from "HR".orders e 
 
select id, 
 			info,
 			info -> 'items'  as json_values,
 			json_object_keys(info -> 'items')  as json_key2,
 			(info ->> 'items')  as json_values,
 			info -> 'items' ->> 'product'
 from "HR".orders e 
 
 
  select id, 
 			info,
 			json_object_keys(info)  as json_key,
 			json_object_keys(info -> 'items')  as json_key2,
 			info ->> 'items'  as json_values
 from "HR".orders e 
 
 
  
  select id, 
 			info, 
 			info -> 'items' -> 'qty' as json_values
 from "HR".orders e 