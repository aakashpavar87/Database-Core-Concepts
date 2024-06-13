CREATE TYPE MYRECORD AS (
  title varchar(255),
  release_year int,
  length int
);

create or replace function my_multi_func() 
returns MYRECORD language plpgsql as $$
declare rec MYRECORD;
begin
	select title, release_year, length into rec.title, rec.release_year, rec.length from film where film_id = 1;
	return rec;
end;
$$

select * from my_multi_func();

create type film_record as (
	number_of_movies int,
	max_length int,
	max_length_movies varchar(255)
);

create or replace function get_long_movies(out number_of_movies int, out max_length int, out max_length_movie varchar(255))
returns film_record language plpgsql as $$
declare rec film_record;
begin
	select count(*), max(length) into rec.number_of_movies, rec.max_length from film where length > 90; 
	select title into rec.max_length_movie from film where length = rec.max_length;
	number_of_movies = rec.number_of_movies;
	max_length = rec.max_length;
	max_length_movie = rec.max_length_movie;
	return;
end;
$$

select get_long_movies();