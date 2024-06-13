drop table users;
drop table department;

-- CREATE SEQUENCE users_id_my_seq;

-- ALTER SEQUENCE users_id_my_seq RESTART WITH 1;


create table if not exists users(
	id INTEGER PRIMARY KEY DEFAULT nextval('users_id_my_seq'),
	name varchar(255),
	salary numeric(10,2) check (salary > 0),
	language varchar(255)
);


-- CREATE OR REPLACE FUNCTION reuse_deleted_id()
-- RETURNS TRIGGER AS $$
-- BEGIN
--     -- Check if there are any gaps (deleted rows) in the id sequence
--     IF NOT EXISTS (SELECT 1 FROM users WHERE id = NEW.id) THEN
--         -- Reuse the smallest available id
--         UPDATE users SET id = NEW.id WHERE id = (
--             SELECT id FROM users WHERE id > NEW.id ORDER BY id LIMIT 1
--         );
--         RETURN NULL; -- Skip the insert operation
--     END IF;
--     RETURN NEW; -- Continue with the insert operation
-- END;
-- $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION ensure_id_sequence()
RETURNS TRIGGER AS $$
BEGIN
    -- If the NEW.id value is NULL or not provided, set it to the next value of the sequence
    IF NEW.id IS NULL THEN
        NEW.id := nextval('users_id_my_seq');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER before_insert_trigger
BEFORE INSERT ON users
FOR EACH ROW
EXECUTE FUNCTION ensure_id_sequence();

create table if not exists department(
	id serial PRIMARY KEY,
	department_name varchar(255),
	location varchar(255)
);

insert into department(department_name, location) 
values 
('Python Framework', 'London'),
('Android Dev', 'France'),
('IOS Dev', 'China');

insert into users (name, salary, language, department_id) 
	values 
	('Aakash', 85000, 'Python', 1),
	('Bhavesh', 81000, 'Javascript', 2),
	('John', 20000, 'Java', 2),
    ('Emily', 18000, 'C++', 1);

select * from users;

-- altering structure of users table adding foreign key of department

ALTER TABLE users
ADD COLUMN department_id INT;

-- alter table users 
-- add constraint fk_department
-- foreign key (department_id) references department(id)
-- on delete cascade
-- on update cascade;

-- new constraint for nice rules of deleting and updating data

ALTER TABLE users
add constraint fk_department
foreign key (department_id) references department(id)
on delete set null on update cascade;

-- SELECT constraint_name
-- FROM information_schema.table_constraints
-- WHERE table_name = 'users' AND constraint_type = 'PRIMARY KEY';

-- ALTER TABLE users DROP CONSTRAINT users_pkey;

-- ALTER TABLE users
-- ADD CONSTRAINT users_pkey PRIMARY KEY (id) DEFAULT nextval('users_id_my_seq');



insert into users(name, salary, language, department_id) 
	values
	('James', 52000, 'Swift', 4),
	('Jessie', 35000, 'Kotlin', 3);




