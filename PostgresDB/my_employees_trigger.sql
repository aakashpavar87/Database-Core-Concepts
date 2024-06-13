DROP TABLE IF EXISTS my_employees;

CREATE TABLE my_employees(
   employee_id INT GENERATED ALWAYS AS IDENTITY,
   first_name VARCHAR(50) NOT NULL,
   last_name VARCHAR(50) NOT NULL,
   salary decimal(11,2) NOT NULL DEFAULT 0,
   PRIMARY KEY(employee_id)
);

create or replace function increment_checker()
returns trigger
as
$$
begin
if (NEW.salary - OLD.salary) / OLD.salary >= 1 then
	raise Exception 'Salary increment can not that much high.';
end if;
	NEW.first_name = upper(NEW.first_name);
	NEW.last_name = upper(NEW.last_name);
return NEW;
end;
$$
language plpgsql;

create or replace trigger salary_increment_trigger
before update
on my_employees
for each row
execute procedure increment_checker();

INSERT INTO my_employees(first_name, last_name, salary)
VALUES('Aakash','Pavar',100000);

update my_employees set salary = 150000 where first_name = 'Aakash';

select * from my_employees;




