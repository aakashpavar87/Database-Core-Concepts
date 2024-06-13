CREATE OR REPLACE FUNCTION get_film_details(f_id INT, OUT film_name film.title%type, OUT film_release film.release_year%type)
RETURNS RECORD AS $$
BEGIN
    SELECT title, release_year
    INTO film_name, film_release
    FROM film
    WHERE film_id = f_id;
END;
$$ LANGUAGE plpgsql;

select * from get_film_details(76);

-- create or replace function get_film (p_pattern varchar) 
-- returns table (
-- 	film_title varchar,
-- 	film_release_year int
-- ) 
-- language plpgsql
-- as $$
-- begin
-- 	return query 
-- 		select
-- 			title,
-- 			release_year::integer
-- 		from
-- 			film
-- 		where
-- 			title ilike p_pattern;
-- end;
-- $$;

create or replace function get_film (
	p_pattern varchar,
	p_year int
) 
returns table (
	film_title varchar,
	film_release_year int
) 
language plpgsql
as $$
declare 
    var_r record;
begin
	for var_r in(
            select title, release_year 
            from film 
	     where title ilike p_pattern and 
		    release_year = p_year
        ) loop  film_title := upper(var_r.title) ; 
		film_release_year := var_r.release_year;
           return next;
	end loop;
end; $$ 

select * from get_film('ca%', 2006);

