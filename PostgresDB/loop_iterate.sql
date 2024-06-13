do $$
<<loopgetter>>
declare
	myrec record;
begin
	for myrec in select name, language from users
	loop
		raise notice 'Name : % | Language : %',myrec.name, myrec.language;
	end loop;
end loopgetter;
$$

-- do $$ 
-- declare
--    vat constant numeric = 0.1;
--    net_price    numeric = 20.5;
-- begin
--    raise notice 'The selling price is %', net_price * ( 1 + vat );
-- end $$;

do $$ 
declare
   started_at constant time := clock_timestamp();
begin
   -- pause 3s
   perform pg_sleep(3);
   
   -- show the current time
   raise notice '3s later';
   raise notice 'Current time: %', clock_timestamp();
   
   -- pause 3s
   perform pg_sleep(3);
   -- show the value of the started_at
   -- later than the one above
   raise notice 'Started at: %', started_at; 
end $$;

do $$
declare
  user_name users.name%type;
  user_id users.id%type;
begin  
  user_id = 15;
  select name from users
  into user_name
  where id =user_id;
  
  if not found then
     raise notice'The user with id % could not be found', 
	    user_id;
  else
	raise notice 'User found with id % is %',user_id,user_name;
  end if;
end $$;




