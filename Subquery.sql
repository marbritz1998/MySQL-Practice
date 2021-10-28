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

-- Problem 11.) Write a query to find the name (first_name, last_name) and salary of the employees who earn a salary that is higher than the salary of all 
-- the Shipping Clerk (JOB_ID = 'SH_CLERK'). Sort the results of the salary of the lowest to highest


-- when it says 'salary higher than all of the shipping clerk' does that mean higher than the max of shipping clerk? higher than the avg of shipping clerk?
-- higher than the sum of shipping clerk? not sure, so will do all three

-- max
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT MAX(salary) FROM employees WHERE job_id = 'SH_CLERK')
ORDER BY salary;

SELECT COUNT(first_name)
FROM employees
WHERE salary > (SELECT MAX(salary) FROM employees WHERE job_id = 'SH_CLERK');  -- has 61 entries

-- avg
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees WHERE job_id = 'SH_CLERK')
ORDER BY salary;

SELECT COUNT(first_name)
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees WHERE job_id = 'SH_CLERK') -- has 73 entries
ORDER BY salary;


-- sum of shipping clerk
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT SUM(salary) FROM employees WHERE job_id = 'SH_CLERK') -- has 0 entries
ORDER BY salary;

-- Sample Solution 11.) 
SELECT first_name,last_name, job_id, salary 
FROM employees 
WHERE salary > 
ALL (SELECT salary FROM employees WHERE job_id = 'SH_CLERK') ORDER BY salary;

-- getting count
SELECT COUNT(first_name) 
FROM employees 
WHERE salary > 
ALL (SELECT salary FROM employees WHERE job_id = 'SH_CLERK') ORDER BY salary; -- has 61 entries

-- they use the ALL() function, but just using MAX() of salary will also work, as the max salary would be in the list

-- Problem 12.) Write a query to find the name (first_name, last_name) of the employees who are not supervisors.
SELECT first_name, last_name
FROM employees 
WHERE employee_id NOT IN (SELECT manager_id FROM employees);

SELECT COUNT(first_name)
FROM employees 
WHERE employee_id NOT IN (SELECT manager_id FROM employees);  -- 89 entries

-- Sample Solution 12.) 
SELECT b.first_name,b.last_name 
FROM employees b 
WHERE NOT EXISTS (SELECT 'X' FROM employees a WHERE a.manager_id = b.employee_id);

SELECT COUNT(first_name) 
FROM employees b 
WHERE NOT EXISTS (SELECT 'X' FROM employees a WHERE a.manager_id = b.employee_id);  -- 89 entries

-- so both my solution and the sample solution give the same result

-- Problem 13.) Write a query to display the employee ID, first name, last name, and department names of all employees

-- so first by using a join
SELECT employee_id, first_name, last_name, department_name
FROM employees 
INNER JOIN departments  USING(department_id);

SELECT COUNT(employee_id)
FROM employees 
INNER JOIN departments  USING(department_id);  -- gives 106 results


-- so using subquery, kind of stuck on this one...

-- Sample Solution 13.)
SELECT employee_id, first_name, last_name, 
(SELECT department_name FROM departments d
 WHERE e.department_id = d.department_id) department 
 FROM employees e ORDER BY department;


SELECT COUNT(first_name), 
(SELECT department_name FROM departments d
 WHERE e.department_id = d.department_id) department 
 FROM employees e ORDER BY department;  -- gives 107 results
 -- this is because the employee Kimberly Grant has a department_id of 0, so I should have done a LEFT JOIN to make sure that all employees are included
 
SELECT COUNT(employee_id)
FROM employees 
LEFT JOIN departments  USING(department_id); -- this works, gives 107 entries

-- Problem 14.) Write a query to display the employee ID, first name, last name, salary of all employees whose salary is above average for their departments
-- using subqeury
SELECT employee_id, first_name, last_name, salary
FROM employees e
WHERE salary > (SELECT AVG(salary) FROM employees GROUP BY department_id); -- so this does not work

SELECT department_id, AVG(salary) FROM employees GROUP BY department_id;


-- try this, this works but it doesn't make sense, as it isn't grouping the employee salaries by department_id then comparing the appropriate average salary
-- in that department, instead it is making a list of the average salaries in each department, then comparing each employee salary to the FULL LIST
-- and if it isn't in the list, then it gets selected for the output, this is not what I want
SELECT employee_id, first_name, last_name, salary
FROM employees e
WHERE salary NOT IN (SELECT AVG(salary) FROM employees GROUP BY department_id);

SELECT COUNT(first_name)
FROM employees e
WHERE salary NOT IN (SELECT AVG(salary) FROM employees GROUP BY department_id); -- gives 93 entries


-- trying something different
SELECT employee_id, first_name, last_name, salary,
(SELECT AVG(salary) FROM employees GROUP BY department_id) avg_department_salary
FROM employees;

SELECT employee_id, first_name, last_name, salary,
(SELECT AVG(salary) FROM employees e_2 WHERE e_2.department_id = e_1.department_id) avg_department_salary
FROM employees e_1
WHERE salary > avg_department_salary; -- so interestingly enough, this will not execute, the avg_department_salary is unknown in the WHERE clause
-- to fix, must use quotations

SELECT employee_id, first_name, last_name, salary, e_1.department_id,
(SELECT AVG(salary) FROM employees e_2 WHERE e_2.department_id = e_1.department_id) 'avg_department_salary'
FROM employees e_1
WHERE salary > 'avg_department_salary'
ORDER BY department_id; 

SELECT first_name, last_name, AVG(salary), department_id
FROM employees
GROUP BY department_id; 
-- so to test if the average was calculated correctly in my subquery scripts, for department_id 20, the average salary = 9500
-- this is the same as I get in my subquery
-- okay, so the subquery is correctly calculating the average salary, what it isn't doing is correctly filtering out the salary of the employees
-- that is less than the avg_department_salary. very strange, as I though this comparison was done rowwise, but since 
-- WHERE salary > 'avg_department_salary' is not doing the trick, this suggests that the comparison is NOT done rowwise


-- so in the WHERE clause, I need to treat the avg_department_salary as a table and call on the column AVG(salary), though if that is the case,
-- then why is the column of the average salary called 'avg_department_salary' in the output? that would seem to contradict my thinking here
-- but will try it anyways
SELECT employee_id, first_name, last_name, salary, e_1.department_id,
(SELECT AVG(salary) FROM employees e_2 WHERE e_2.department_id = e_1.department_id) AS avg_department_salary
FROM employees e_1
WHERE salary > avg_department_salary.AVG(salary)
ORDER BY department_id;
-- okay, so that didn't work, as expected

-- so it looks like the main issue here is the steps of evaluation taken by SQL, it doesn't recognize the alias, because WHERE is evaluated before
-- the select, so in that case, I will trying HAVING to see if it will work
SELECT employee_id, first_name, last_name, salary, e_1.department_id,
(SELECT AVG(salary) FROM employees e_2 WHERE e_2.department_id = e_1.department_id) AS avg_department_salary
FROM employees e_1
HAVING salary > avg_department_salary
ORDER BY department_id;
-- it looks like this worked, fucking sql if wack man, I had to useing HAVING instead of WHERE due to the execution of SQL code, this is why
-- I prefer to use python for more advanced scripts like this. also , because of the order of the code execution, I am not sure how to get 
-- the count though, becuase I can't put it into the SELECT clause as this is executed before the HAVING clause, pretty frustrating.
-- but I do believe I have an answer.

-- Sample solution 14.)

SELECT employee_id, first_name, A.department_id
FROM employees AS A 
WHERE salary > 
(SELECT AVG(salary) FROM employees WHERE department_id = A.department_id)
ORDER BY department_id;

-- so this is the same solution as I have

-- Problem 15.) Write a query to fetch even numbered records from employees table
-- I am not even sure where to begin here, there doesn't seem to be an index 'column'

-- sample solution 15.)
SET @i = 0; 
SELECT i, employee_id 
FROM (SELECT @i := @i + 1 AS i, employee_id FROM employees)
a WHERE MOD(a.i, 2) = 0;

-- this doesn't even run properly on my version of MySQL, what a travesty
-- this is also nasty, because I do not want to alter any of the data in the database, so I can't create a new index as that my have consequences
-- that I can't forsee due to my ignorance of sql

-- Problem 16.) Write a query to find the 5th maximum salary in the employees table
-- this may be cheeky, but if I order the table by salaries, then find the employee_id of the 5th salary, I can make another script to choose
-- that employee_id
SELECT employee_id, salary
FROM employees
ORDER BY salary;  -- 135 is the 5th max salary (though it is tied)

SELECT salary FROM employees WHERE employee_id = 135;


-- Sample Solution 16.)
SELECT DISTINCT salary 
FROM employees e1 
WHERE 5 = (SELECT COUNT(DISTINCT salary) 
FROM employees  e2 
WHERE e2.salary >= e1.salary);

-- Problem 17.) Write a query to find the 4th minimum salary in the employees table
SELECT DISTINCT(salary)
FROM employees e1
WHERE 54 = ( SELECT COUNT(DISTINCT salary) + 1 - 4
FROM employees e2
WHERE e2.salary >= e1.salary);  -- the salary is 2100

-- finding out how far down I have to go to get the 4th min salary
SELECT COUNT(DISTINCT salary) +1 -4 FROM employees; -- this gives 54

-- sample solution 17.) 
SELECT DISTINCT salary 
FROM employees e1 
WHERE 4 = (SELECT COUNT(DISTINCT salary) 
FROM employees  e2 
WHERE e2.salary <= e1.salary); -- this gives 2500
-- man so what I did was not correct, these are some hard problems

