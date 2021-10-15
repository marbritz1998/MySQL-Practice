SHOW DATABASES;
USE db;

-- Practicing Exercises for Restricting and Sorting Data
-- Problems can be found here: https://www.w3resource.com/mysql-exercises/restricting-and-sorting-data-exercises/

-- Problem 1.) Write a query to display the name (first_name, last_name) and salary for all employees whose salary is not in the range $10,000 through $15,000.
SELECT first_name, last_name, salary FROM employees WHERE salary NOT BETWEEN 10000 AND 15000;

-- Problem 2.) Write a query to display the name (first_name, last_name) and department ID of all employees in departments 30 or 100 in ascending order.
SELECT first_name, last_name, department_id FROM employees WHERE (department_id = 30 OR department_id = 100) ORDER BY department_id;

-- sample solution way
SELECT first_name, last_name, department_id FROM employees WHERE department_id IN (30,100) ORDER BY department_id;

-- Problem 3.) Write a query to display the name (first_name, last_name) and salary for all employees whose salary is not in the range $10,000 through $15,000 and are in department 30 or 100
SELECT first_name, last_name, salary FROM employees WHERE salary NOT BETWEEN 10000 AND 15000 AND department_id IN (30,100);

-- for readability
SELECT first_name, last_name, salary FROM employees
WHERE salary NOT BETWEEN 10000 AND 15000
AND department_id IN (30,100);

-- Problem 4.) Write a query to display the name (first_name, last_name) and hire date for all employees who were hired in 1987.
SELECT first_name, last_name, hire_date FROM employees 
WHERE hire_date BETWEEN '1987-01-01' AND '1987-12-31';

-- There has to be a better way, will look at sample solution
SELECT first_name, last_name, hire_date
FROM employees
WHERE YEAR(hire_date) LIKE '1987%';