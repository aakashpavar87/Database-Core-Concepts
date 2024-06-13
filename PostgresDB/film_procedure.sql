create or replace procedure count_film(
    inout total_film int default 0
) 
as 
$$
begin
    select count(*) from film
    into total_film;
end;
$$
language plpgsql;

call count_film();

do
$$
declare
   total_film int = 0;
begin
   call count_film(total_film);
   raise notice 'Total film: %', total_film;
end;
$$;

create or replace procedure film_stat(
   inout total_film int default 0,
   inout total_length int default 0,
   inout avg_rental_rate numeric(4,2) default 0
)
as
$$
begin
  select count(*) into total_film
  from film;
  
  select sum(length) into total_length
  from film;
  
  select round(avg(rental_rate),2) into avg_rental_rate
  from film;  
end;
$$
language plpgsql;

call film_stat();

