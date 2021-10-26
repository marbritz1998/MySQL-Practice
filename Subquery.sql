USE db;
-- currently on problem 11

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

-- Problem 4.) Write a query to find the name (first_name, last_name) of the employees who are managers
SELECT first_name, last_name
FROM employees
WHERE employee_id IN (SELECT manager_id FROM employees);

-- testing to see if it worked
SELECT COUNT(first_name)
FROM employees
WHERE employee_id IN (SELECT manager_id FROM employees);
-- this gives 18

SELECT COUNT(first_name)
FROM employees
WHERE employee_id;
-- this gives 107 ,  so it looks like the scripts did indeed work

-- Sample Solution 4.) 
SELECT first_name, last_name 
FROM employees 
WHERE (employee_id IN (SELECT manager_id FROM employees));

SELECT COUNT(first_name)
FROM employees 
WHERE (employee_id IN (SELECT manager_id FROM employees));
-- okay, the sample solution is the same thing and gives the same result count!

-- Problem 5.) Write a query to find the name (first_name, last_name), and salary of the employees whose salary is greater than the average salary
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Sample Solution 5.) 
SELECT first_name, last_name, salary FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Problem 6.) Write a query to find the name (first_name, last_name), and salary of the employees whose salary is equal to the minimum salary for their job grade
-- this is using a join
SELECT first_name, last_name, salary
FROM employees 
INNER JOIN jobs  USING(job_id)
WHERE salary = min_salary;

-- using subquery, not sure how to go about making a subquery for this

-- Sample Solution 6.) 
SELECT first_name, last_name, salary 
FROM employees 
WHERE employees.salary = (SELECT min_salary
FROM jobs
WHERE employees.job_id = jobs.job_id);

-- so this gives the same result as my join 

-- Problem 7.) Write a query to find the name (first_name, last_name), and salary of the employees who earns more than the average salary 
-- and works in any of the IT departments
SELECT first_name, last_name, salary
FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees) 
	AND	job_id LIKE '%IT%';
    
-- Sample Solution 7.) 
SELECT first_name, last_name, salary 
FROM employees 
WHERE department_id IN 
(SELECT department_id FROM departments WHERE department_name LIKE 'IT%') 
AND salary > (SELECT avg(salary) FROM employees);
-- I can see why a subquery would be used for comparing the average, but doing a subquery for the department seems to overcomplicate things as you can
-- get the same info by just looking over job_id and using LIKE

-- Problem 8.) Write a query to find the name (first_name, last_name), and salary of the employees who earns more than the earning of Mr. Bell
SELECT first_name, last_name, salary
FROM employees
WHERE salary < (SELECT salary FROM employees WHERE last_name = 'Bell');

SELECT COUNT(first_name)
FROM employees
WHERE salary < (SELECT salary FROM employees WHERE last_name = 'Bell'); -- there is 42 entries

-- sample solution 8.)
SELECT first_name, last_name, salary 
FROM employees 
WHERE salary > 
(SELECT salary FROM employees WHERE last_name = 'Bell') ORDER BY first_name;
-- okay, my solution is the same as the sample solution

-- Problem 9.) Write a query to find the name (first_name, last_name), and salary of the employees who earn the same salary 
-- as the minimum salary for all departments
-- this is my answer
SELECT first_name,last_name, salary
FROM employees
WHERE salary IN (SELECT MIN(salary) FROM employees GROUP BY department_id);

SELECT COUNT(first_name)
FROM employees
WHERE salary IN (SELECT MIN(salary) "employee min salary" FROM employees GROUP BY department_id); -- so there are 26 entries

SELECT *
FROM employees
INNER JOIN jobs USING(job_id)
WHERE first_name = 'Lex';
-- so for Lex, his salary is 17000, where as his min_salary is 15000, he has department_id = 90

SELECT department_id, MIN(salary) "employee min salary"
FROM employees
GROUP BY department_id; -- and this shows that the minimum salary in the department_id = 90 is 17000, which is what Lex's salary is.
-- so, Lex's salary is the minimum salary that an employee has in his department id, though it is NOT the minimum salary set up by the department id

-- if I want that I would use:
SELECT first_name, last_name, salary
FROM employees e
INNER JOIN jobs j ON (j.job_id = e.job_id)
WHERE salary = min_salary;    -- and this is a query that I did in an earlier example

-- Sample Solution 9.)
SELECT * FROM employees 
WHERE salary = (SELECT MIN(salary) FROM employees);

-- ahh okay, miss-interpreted the question. I thought by "all department" they meant to take the minimum salary for each department, where as
-- they were looking for the minimum salary across the departments

-- Problem 10.) Write a query to find the name (first_name, last_name), and salary of the employees whose salary
-- is greater than the average salary of all departments
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Sample Solution 10.) 
SELECT * FROM employees 
WHERE salary > 
ALL(SELECT avg(salary)FROM employees GROUP BY department_id);

-- so the sample solution found the average salary for each department and then wanting to choose the employees that had a higher salary than the list of those





