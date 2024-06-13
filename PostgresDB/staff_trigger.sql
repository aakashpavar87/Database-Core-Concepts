create or replace function check_staff()
returns trigger
as
$$
begin
	if length(NEW.username) < 8 OR NEW.username IS null then
		raise Exception 'Provided username length is % User Name Can not be lesser than 8 characters',length(NEW.username);
	end if;
	return NEW;
end;
$$
language plpgsql;

create or replace trigger staff_validator
before insert or update
on staff
for each row
execute procedure check_staff();

insert into staff(first_name, last_name, address_id, email, store_id, active, username, password, last_update)
values ('Aakash', 'Pavar', 5, 'aakash@g.com', 1, true, 'aakashpavar', 'Aakash', now());

update staff set username = 'Millyefg' where staff_id = 1;

