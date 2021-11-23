USE stackhowto;


-- 1. Get all employees.
SELECT * FROM employee;

-- 2. Display the first name and last name of all employees.
SELECT CONCAT(first_name,' ',last_name) as Name FROM employee;

-- or
SELECT first_name, last_name FROM employee;

-- 3. Display all the values of the “First_Name” column using the alias “Employee Name”

SELECT first_name 'Employee Name' FROM employee;

-- 4. Get all “Last_Name” in lowercase.
SELECT LOWER(last_name) FROM employee;

-- 5. Get all “Last_Name” in uppercase.
SELECT UPPER(last_name) FROM employee;

-- 6. Get unique “DEPARTMENT”.
-- the table has department spelled as departement, going to correct this
ALTER TABLE employee RENAME COLUMN Departement TO Department;
SELECT DISTINCT(department) FROM employee;


-- 7. Get the first 4 characters of “FIRST_NAME” column.
-- solution
SELECT SUBSTRING(first_name, 1,4) FROM employee;

-- 8. Get the position of the letter ‘h’ in ‘John’.
SELECT POSITION('h' IN 'John');

-- or
SELECT POSITION('h' IN first_name) FROM employee WHERE first_name = 'John';

-- or 
SELECT LOCATE('h', first_name) FROM employee WHERE first_name = 'John';

-- 9. Get all values from the “FIRST_NAME” column after removing white space on the right.
SELECT RTRIM(first_name) FROM employee;

-- 10. Get all values from the “FIRST_NAME” column after removing white space on the left.
SELECT LTRIM(first_name) FROM employee;

-- 11. Write the syntax to create the “employee” table.

-- will show sample solution as I do not know this

-- CREATE TABLE Employee(
--  	employee_id int NOT NULL,
--  	First_name varchar(50) NULL,
 -- 	Last_name varchar(50) NULL,
 -- 	salary decimal(18, 0) NULL,
 -- 	joining_date datetime2(7) default getdate(),
 -- 	departement varchar(50) NULL
-- 		);