CREATE TABLE employees(
   id INT GENERATED ALWAYS AS IDENTITY,
   first_name VARCHAR(40) NOT NULL,
   last_name VARCHAR(40) NOT NULL,
   PRIMARY KEY(id)
);

CREATE TABLE employee_audits (
   id INT GENERATED ALWAYS AS IDENTITY,
   employee_id INT NOT NULL,
   last_name VARCHAR(40) NOT NULL,
   changed_on TIMESTAMP NOT NULL
);


create or replace function log_employee_changes()
returns trigger
as
$$
begin
	if OLD.last_name <> NEW.last_name then
		insert into employee_audits(employee_id, last_name, changed_on) values (OLD.id, OLD.last_name, now());
	end if;
	return NEW;
end;
$$
language plpgsql;

create or replace trigger last_name_change_detector
before update 
on employees
for each row
execute procedure log_employee_changes();

update employees set last_name = 'Bruno' where id = 2;

select * from employee_audits;





