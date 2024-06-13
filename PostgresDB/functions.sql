create or replace function greet_user(u_id int)
returns varchar(255)
language plpgsql
as
$$
declare
	user_name users.name%type;
begin
	select name into user_name from users where id = u_id;
	if not found then
		raise notice 'Sorry but user not found with this id %',u_id;
	end if;
	raise notice 'Hello brother %',user_name;
	return user_name;
end;
$$;


do $$
declare
name_of_user users.name%type;
begin
	select greet_user(u_id=> 14) into name_of_user;     
end $$;




