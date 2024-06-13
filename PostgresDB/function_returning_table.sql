create or replace function get_actor_rows(start int, "end" int)
returns setof actor
as
$$
begin
	return query select * from actor where actor_id between start and "end";
end;
$$
language plpgsql;


do
$$
declare
	row RECORD;
begin
	for row in	select * from get_actor_rows(1, 25) order by first_name limit 10
	loop
		raise notice 'Actor : %', UPPER(row.first_name || ' ' || row.last_name);
	end loop;
end;
$$