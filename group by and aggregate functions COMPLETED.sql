-- problems can be found here: https://www.w3resource.com/mysql-exercises/aggregate-function-exercises/

USE db;

-- Problem 1.) Write a query to list the number of jobs available in the employees table.
SELECT job_id FROM employees
GROUP BY job_id;

-- or
SELECT DISTINCT job_id
FROM employees;

-- or
SELECT DISTINCT(COUNT(job_id)) 'Number of Jobs' FROM employees;

-- sample solution 1.) 
SELECT COUNT(DISTINCT job_id) 'Number of Jobs'
FROM employees;

-- so I needed to first select the distinct job_id's then count them to get the number of different jobs, difference in interpretation of the question

-- Problem 2.) Write a query to get the total salaries payable to employees
-- so I am going to interpret this on different levels

-- first, the sum of the salaries of all employees
SELECT SUM(salary) 'Total Salaries Payable Just Salary' FROM employees;

-- second, the sum of the salaries, including the commission percentage on the salary
SELECT SUM(salary + (salary * commission_pct)) 'Total Salaries including commission' FROM employees;

-- third, the total salary payable to each individual employee 
SELECT CONCAT(first_name, " ", last_name) 'Employee Name', (salary + (salary * commission_pct)) 'Full Salary' FROM employees;

-- Sample Solution 2.) 
SELECT SUM(salary) 
FROM employees;

-- they chose to only do the salary sum

-- Problem 3.) Write a query to get the minimum salary from employees table
SELECT MIN(salary) FROM employees;

-- sample solution 3.) 
SELECT MIN(salary) 
FROM employees;


-- Problem 4.) Write a query to get the maximum salary of an employee working as a Programmer
SELECT MAX(salary) FROM employees
WHERE job_id LIKE '%prog%';

-- Sample solution 4.) 
SELECT MAX(salary) 
FROM employees 
WHERE job_id = 'IT_PROG';

-- Problem 5.) Write a query to get the average salary and number of employees working the department 90
SELECT AVG(salary) 'Average Salary', COUNT(*) 'Number of Employees'
FROM employees
WHERE department_id = 90;

-- sample solution 5.) 
SELECT AVG(salary),count(*) 
FROM employees 
WHERE department_id = 90;

-- Problem 6.) Write a query to get the highest, lowest, sum, and average salary of all employees
SELECT MAX(salary), MIN(salary), SUM(salary), AVG(salary) FROM employees;

-- sample solution 6.) 
SELECT ROUND(MAX(salary),0) 'Maximum',
ROUND(MIN(salary),0) 'Minimum',
ROUND(SUM(salary),0) 'Sum',
ROUND(AVG(salary),0) 'Average'
FROM employees;

-- Problem 7.) Write a query to get the number of employees with the same job
SELECT job_id, COUNT(*) 'Number of employees'
FROM employees
GROUP BY job_id
ORDER BY COUNT(*) DESC;

-- Sample solution 7.) 
SELECT job_id, COUNT(*)
FROM employees
GROUP BY job_id;

-- Problem 8.) Write a query to get the difference between the highest and lowest salaries
SELECT (MAX(salary) - MIN(salary)) 'diff bet high and low salary' FROM employees;

-- sample solution 8.) 
SELECT MAX(salary) - MIN(salary) DIFFERENCE
FROM employees;

-- Problem 9.) Write a query to find the manager ID and the salary of the lowest-paid employee for that manager
SELECT manager_id, MIN(salary) 'lowest salary'
FROM employees
GROUP BY manager_id
ORDER BY MIN(salary) DESC;

-- sample solution 9.) 
SELECT manager_id, MIN(salary)
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
ORDER BY MIN(salary) DESC;

-- Problem 10.) Write a query to get the department ID and the total salary payable in each department
SELECT IF(GROUPING(department_id), 'ALL Departments', department_id) department_id, SUM(salary)'total salary'
FROM employees
GROUP BY department_id
WITH ROLLUP;

-- Sample solution 10.) 
SELECT department_id, SUM(salary)
FROM employees 
GROUP BY department_id;

-- Problem 11.) Write a query to get the average salary for each job ID excluding programmer.
SELECT job_id, AVG(salary)
FROM employees
GROUP BY job_id
HAVING job_id NOT LIKE '%prog%';

-- lets use rollup on this one to
SELECT IF(GROUPING(job_id), 'ALL jobs except programmer', job_id) job_id, AVG(salary)
FROM employees
WHERE job_id NOT LIKE '%prog%'
GROUP BY job_id
WITH ROLLUP;

-- so interestly enough, I couldn't use HAVING on this, I had to make it a WHERE statement

-- sample solution 11.) 
SELECT job_id, AVG(salary) 
FROM employees 
WHERE job_id <> 'IT_PROG' 
GROUP BY job_id;

-- Problem 12.) Write a query to get the total salary, maximum, minimum, average salary of employees (job ID wise), for department ID 90 only.
SELECT job_id, SUM(salary), MAX(salary), MIN(salary), AVG(salary) 
FROM employees
WHERE department_id = 90
GROUP BY job_id;

-- sample solution 12.) 
SELECT job_id, SUM(salary), AVG(salary), MAX(salary), MIN(salary)
FROM employees 
WHERE department_id = '90' 
GROUP BY job_id;

-- Problem 13) Write a query to get the job ID and maximum salary of the employees where maximum salary is greater than or equal to $4000
SELECT job_id, MAX(salary)
FROM employees
GROUP BY job_id
HAVING MAX(salary) >= 4000;

-- sample solution 13.)
SELECT job_id, MAX(salary) 
FROM employees 
GROUP BY job_id 
HAVING MAX(salary) >=4000;

-- Problem 14.) Write a query to get the average salary for all departments employing more than 10 employees
SELECT department_id, ROUND(AVG(salary), 0) 'average salary'
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 10;

-- lets put rollup on

SELECT IF(GROUPING(department_id), 'ALL RELEVANT department', department_id) department_id, ROUND(AVG(salary), 0) 'average salary'
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 10
WITH ROLLUP;

-- doesn't work... must have something to do when rollup and having are initiated, HAVING is initiated between the GROUP BY and SELECT, but I do not
-- know when ROLLUP is initiated

-- sample solution 14.) 
SELECT department_id, AVG(salary), COUNT(*) 
FROM employees 
GROUP BY department_id
HAVING COUNT(*) > 10;