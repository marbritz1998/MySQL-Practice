-- problems found on https://www.w3resource.com/mysql-exercises/basic-simple-exercises/

use db;
SHOW DATABASES;

-- Problem 1.) Write a query to display the names (first_name, last_name) using alias name “First Name", "Last Name"
SELECT first_name 'FIRST NAME', last_name 'LAST NAME' FROM employees;

-- Problem 2.) Write a query to get unique department ID from employee table
SELECT DISTINCT department_id FROM employees;

-- Problem 3.) Write a query to get all employee details from the employee table order by first name, descending

SELECT * FROM employees ORDER BY first_name DESC;

-- Problem 4.) Write a query to get the names (first_name, last_name), salary, PF of all the employees (PF is calculated as 15% of salary
SELECT CONCAT(first_name, ' ', last_name) AS 'Full Name', salary, salary * 0.15 AS 'PF' FROM employees;

-- Problem 5.) Write a query to get the employee ID, names (first_name, last_name), salary in ascending order of salary
SELECT employee_id, first_name, last_name, salary FROM employees ORDER BY salary;

-- Problem 6.) Write a query to get the total salaries payable to employees
-- guessing that total salaries payable to employees is salary + (salary * commission_pct)
SELECT employee_id, first_name, last_name, salary, (salary * commission_pct) + salary as 'total salary' FROM employees;
SELECT SUM(salary) as 'payable salary' FROM employees;

-- Problem 7.) Write a query to get the maximum and minimum salary from employees table
-- mimimum
SELECT * FROM employees ORDER BY salary LIMIT 1;
-- maximum
SELECT * FROM employees ORDER BY salary DESC LIMIT 1;

-- or can use functions
SELECT MAX(salary), MIN(salary) FROM employees;

-- Problem 8.) Write a query to get the average salary and number of employees in the employees table
SELECT COUNT(employee_id) 'Number of Employees', AVG(salary) 'Average Salary' FROM employees;

-- Problem 9.) Write a query to get the number of employees working with the company
SELECT COUNT(employee_id) as 'number of employees' FROM employees;
-- or 
SELECT COUNT(*) as 'number of employees' FROM employees;

-- Problem 10.) Write a query to get the number of jobs available in the employees table.
SELECT COUNT(DISTINCT job_id) FROM employees;

-- Problem 11.) Write a query get all first name from employees table in upper case
SELECT UPPER(first_name) FROM employees;

-- WRONG! Problem 12.) Write a query to get the first 3 characters of first name from employees table

-- sample solution 11.)
SELECT SUBSTRING(first_name, 1,3) '1st 3 letters of first name' FROM employees;

-- Problem 13.) Write a query to calculate 171*214+625
SELECT 171*214+625;

-- Problem 14.) Write a query to get the names (for example Ellen Abel, Sundar Ande etc.) of all the employees from employees table
SELECT CONCAT(first_name, ' ', last_name) FROM employees;

-- Problem 15.) Write a query to get first name from employees table after removing white spaces from both side
SELECT TRIM(first_name) 'firstname' FROM employees;

-- Problem 16.) Write a query to get the length of the employee names (first_name, last_name) from employees table
SELECT CHAR_LENGTH(CONCAT(first_name,last_name)) 'character length of full name' FROM employees;
-- or
SELECT first_name,last_name, LENGTH(first_name)+LENGTH(last_name)  'Length of  Names'  FROM employees;

-- WRONG! Problem 17.) Write a query to check if the first_name fields of the employees table contains numbers.
SELECT * FROM employees WHERE first_name REGEXP '[0-9]';

-- Problem 18.) Write a query to select first 10 records from a table.
SELECT * FROM employees LIMIT 10;

-- Problem 19.) Write a query to get monthly salary (round 2 decimal places) of each and every employee. Note : Assume the salary field provides the 'annual salary' information.
SELECT *, ROUND(salary/12, 2) 'monthly salary' FROM employees;