do $$
<<adder>>
declare
	record users%rowtype;
	department department%rowtype;
begin
	department.department_name = 'Web Developement';
	department.location = 'France';
	
	record.name = 'Aakash';
	record.salary = 25000;
	record.language = 'PHP';
	record.department_id = 1;

	insert into department(department_name, location) values (department.department_name,department.location);
	insert into users(name, salary, language, department_id) values (record.name ,record.salary ,record.language, record.department_id);  

	raise notice 'Data successfully inserted in DB';
end adder;
$$