-- CREATE TYPE FilmStats AS (
--   min_length int,
--   max_length int,
--   avg_length numeric
-- );

-- CREATE OR REPLACE FUNCTION get_film_stats(
--   OUT min_len int,
--   OUT max_len int,
--   OUT avg_len numeric
-- )
-- LANGUAGE plpgsql AS $$
-- BEGIN
--   DECLARE
--     rec FilmStats;
--   BEGIN
--     SELECT min(length), max(length), avg(length)::numeric
--     INTO rec.min_length, rec.max_length, rec.avg_length
--     FROM film;
--   EXCEPTION WHEN OTHERS THEN
--     rec.min_length := NULL;  -- Handle potential errors (optional)
--     rec.max_length := NULL;
--     rec.avg_length := NULL;
--   END;
  
--   min_len := rec.min_length;
--   max_len := rec.max_length;
--   avg_len := rec.avg_length;
--   RETURN;
-- END;
-- $$;

-- -- Calling the function and accessing returned values
-- DO $$
-- DECLARE
--   film_min_len int;
--   film_max_len int;
--   film_avg_len numeric;
-- BEGIN
--   select * from get_film_stats();
--   RAISE NOTICE 'Minimum length: %', film_min_len;
--   RAISE NOTICE 'Maximum length: %', film_max_len;
--   RAISE NOTICE 'Average length: %', film_avg_len;
-- END;
-- $$


create or replace function swap(
	inout x int,
	inout y int
) 
language plpgsql	
as $$
begin
   select x,y into y,x;
end; $$;

select * from swap(10,20);