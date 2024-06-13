create or replace procedure insert_actor(
	full_name varchar
)
language plpgsql	
as $$
declare
	fname varchar;
	lname varchar;
begin
	-- split the fullname into first & last name
	select 
		split_part(full_name,' ', 1),
		split_part(full_name,' ', 2)
	into fname,
	     lname;
	
	-- insert first & last name into the actor table
	insert into actor(first_name, last_name)
	values(fname, lname);
end;
$$;

call insert_actor('Andrew Tate');

create or replace procedure delete_actor(a_id int)
language plpgsql
as $$
begin
	delete from actor where actor_id = a_id;
end;
$$;

create or replace procedure update_actor(a_id int, full_name varchar)
language plpgsql
as $$
declare
	fname varchar;
	lname varchar;
begin
	select
		split_part(full_name, ' ', 1),
		split_part(full_name, ' ', 2)
	into 
		fname,
		lname;

	update actor 
	set first_name = fname, last_name = lname 
	where actor_id = a_id;

	commit;

end;
$$;

call update_actor(201, 'Andrew Tata');

select * from actor where first_name = 'Andrew';



