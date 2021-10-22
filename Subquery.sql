USE db;
-- currently on problem 4.)

-- Problems here found at https://www.w3resource.com/mysql-exercises/subquery-exercises/

-- Problem 1.) Write a query to find the name (first_name, last_name) and the salary of the employees who have a higher salary than the employee
--  whose last_name='Bull'.
SELECT * FROM employees;

SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT salary FROM employees WHERE last_name = 'Bull');

-- lets see if doing a join gives the same thing
SELECT COUNT(DISTINCT(em.salary))
FROM employees em
JOIN employees e
WHERE em.salary > (e.salary = 'Bull');
-- this query gives 57

SELECT COUNT(DISTINCT(salary))
FROM employees
WHERE salary > (SELECT salary FROM employees WHERE last_name = 'Bull');
-- this query gives 38

SELECT COUNT(DISTINCT(salary))
FROM employees;
-- this gives 57, so it looks like my join didn't do anything to the dataset

-- Sample solution 1.) 
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM employees 
WHERE SALARY > 
(SELECT salary FROM employees WHERE last_name = 'Bull');

-- same as my solution, has 38 distinct records

-- Problem 2.) Write a query to find the name (first_name, last_name) of all employees who works in the IT department 
SELECT first_name, last_name
FROM employees
WHERE job_id LIKE '%IT%';

-- well be interesting to see how a subquery would do this, this seems much simpler and faster

-- sample solution 2.) 
SELECT first_name, last_name 
FROM employees 
WHERE department_id 
IN (SELECT department_id FROM departments WHERE department_name='IT');

-- okay, both give the same result just using WHERE and LIKE is much more simple than doing a subquery for this

-- Problem 3.) Write a query to find the name (first_name, last_name) of the employees who have a manager and worked in a USA based department
SELECT first_name, last_name
FROM employees e
INNER JOIN departments d USING(department_id)
INNER JOIN locations l USING(location_id)
WHERE department_id IN (SELECT department_id FROM departments WHERE manager_id != 0);  -- this gives the department_id's that have managers 

-- so this query has 60 records. this seems correct. didn't use a subquery though
SELECT first_name, last_name
FROM employees e
INNER JOIN departments d USING(department_id)
INNER JOIN locations l USING(location_id)
WHERE d.manager_id != 0 AND e.manager_id != 0 AND l.country_id = 'US';

SELECT COUNT(DISTINCT(first_name))
FROM employees e
INNER JOIN departments d USING(department_id)
INNER JOIN locations l USING(location_id)
WHERE d.manager_id != 0 AND l.country_id = 'US' AND e.manager_id != 0;


-- sample solution 3.) 
SELECT first_name, last_name FROM employees 
WHERE manager_id in 
(select employee_id 
FROM employees WHERE department_id IN 
(SELECT department_id FROM departments WHERE location_id IN 
(select location_id from locations where country_id='US')));

SELECT COUNT(DISTINCT(first_name)) FROM employees 
WHERE manager_id in (select employee_id 
FROM employees WHERE department_id 
IN (SELECT department_id FROM departments WHERE location_id 
IN (select location_id from locations where country_id='US')));

-- the sample solution has 65 records... so my solution is WRONG, so why did my join not work?