-- 1. Declare Cursor
-- 2. Open Cursor
-- 3. Fetch
-- 4. Close Cursor

create or replace function get_film_title_and_release(OUT f_title varchar, OUT f_release int)
returns setof RECORD as
$$
declare
	film_cursor CURSOR FOR select title,release_year from film;
	film_record RECORD;
begin
	open film_cursor;
	loop
		fetch film_cursor into film_record;
		exit when not found;	
		f_title = film_record.title;
		f_release = film_record.release_year;
		return next;
	end loop;
	close film_cursor;
end;
$$
language plpgsql;

select * from get_film_title_and_release() where f_title ilike 'Gr%' limit 20;
