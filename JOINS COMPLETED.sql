USE db;
-- Problems can be found at https://www.w3resource.com/mysql-exercises/join-exercises/

-- Problem 1.) Write a query to find the addresses (location_id, street_address, city, state_province, country_name) of all the departments.
-- from locations: need  country_id,   join on location_id
-- from departments: need location_id
SELECT l.location_id, street_address, postal_code, city, state_province, country_id
FROM locations l
INNER JOIN departments d
ON l.location_id = d.location_id
ORDER BY l.location_id;

-- different syntax
SELECT l.location_id, street_address, postal_code, city, state_province, country_id
FROM locations l
INNER JOIN departments d USING (location_id)
ORDER BY location_id;

-- something seems off from the sample, for example, theirs has location+id 1000, and mine does not, will look at sample solution, it is because, 
-- the 2 tables they are joining are locations and countries!

SELECT location_id, street_address, postal_code, city, state_province, country_id
FROM locations
INNER JOIN countries USING (country_id)
ORDER BY location_id;

-- something is still off, I do not have location_id 3200, yet the sample does...
SELECT *
FROM locations
WHERE location_id = 3200;

-- so there does NOT exist a country_id for location_id 3200, which is why it is not showing up in the inner join, it states to use a NATURAL join, will
-- use this and see what happens
SELECT location_id, street_address, postal_code, city, state_province, country_id
FROM locations
NATURAL JOIN countries
ORDER BY location_id;

-- okay, so this still resulted in the same thing, looks like NATURAL JOINS join on columns names with same data types, seems like I should avoid 
-- NATURAL JOINS as the join conditions are not explicit alter

-- sample solution 1.)
SELECT location_id, street_address, city, state_province, country_name
FROM locations
NATURAL JOIN countries;

-- okay so sample solution is the same thing I have, the thing I saw was the info for locations table

-- Problem 2.) Write a query to find the name (first_name, last name), department ID and department_name of all the employees
SELECT first_name, last_name, e.department_id, department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
ORDER BY last_name;

-- different syntax
SELECT first_name, last_name, department_id, department_name
FROM employees
INNER JOIN departments USING (department_id)
ORDER BY last_name;

-- so interestingly, If a join meets the conditions of USING(), then I do not have to use aliases on common column names.


-- Problem 3.) Write a query to find the name (first_name, last_name), job, department ID and department_name of the employees who works in London

-- so locations has 'location_id' and can set city = london and departments has 'location_id'
SELECT first_name, last_name, job_id, e.department_id, department_name
FROM employees e
INNER JOIN departments d ON d.department_id = e.department_ID
INNER JOIN locations l ON l.location_id = d.location_id
WHERE city = 'London';

-- so the second inner join is joining the result of the first inner join on locations with the ON clause

-- Sample Solution 3.) 
SELECT e.first_name, e.last_name, e.job_id, e.department_id, d.department_name 
FROM employees e 
JOIN departments d 
ON (e.department_id = d.department_id) 
JOIN locations l ON 
(d.location_id = l.location_id) 
WHERE LOWER(l.city) = 'London';

-- is a little bit more complicated than my scripts, for example, used the LOWER() function


-- Problem 4.) Write a query to find the employee id, name (last_name) along with their manager_id and name (last_name)
-- looks like I will have to use a self join, there are 2 managers, tyring to figure out what to join on AKA how to tell which employees the managers manage
-- this info is not clear to me, so i will look at the sample solution

-- sample solution 4.)
SELECT e.employee_id 'Emp_Id', e.last_name 'Employee', 
m.employee_id 'Mgr_Id', m.last_name 'Manager' 
FROM employees e 
join employees m 
ON (e.manager_id = m.employee_id);

-- so it was a self join, the manager_id, refered to the employee_id of an the employee who was the manager over the other employee. except for King, who 
-- is the president, so the manager_id under his name is 0

-- Problem 5.) Write a query to find the name (first_name, last_name) and hire date of the employees who was hired after 'Jones'
SELECT CONCAT(first_name, ' ', last_name) 'Full Name', hire_date FROM employees
WHERE employee_id > 195;  -- Jones employee_id is 195, so anyone hired after 'Jone' will have employee_id greater than his

-- didn't have to use a join, so will be interesting to see what the sample solution does

-- sample solution 5.)
SELECT e.first_name, e.last_name, e.hire_date 
FROM employees e 
JOIN employees davies 
ON (davies.last_name = 'Jones') 
WHERE davies.hire_date < e.hire_date;

-- Probelm 6.) Write a query to get the department name and number of employees in the department.
SELECT d.department_name, COUNT(employee_id) 'number of employees'
FROM employees e
INNER JOIN departments d ON d.department_id = e.department_id
GROUP BY d.department_name;

-- sample solution 6.) 
SELECT department_name AS 'Department Name', 
COUNT(*) AS 'No of Employees' 
FROM departments 
INNER JOIN employees 
ON employees.department_id = departments.department_id 
GROUP BY departments.department_id, department_name 
ORDER BY department_name;

-- Problem 7.) Write a query to find the employee ID, job title, number of days between ending date and starting date for all jobs in department 90
SELECT e.employee_id , ABS(DATEDIFF(start_date, end_date)) 'Days Employeed'
FROM employees e
INNER JOIN job_history jh ON jh.department_id = e.department_id
WHERE e.department_id = 90
ORDER BY employee_id;

-- Sample Solution 7.) 
SELECT employee_id, job_title, end_date-start_date Days , department_id
FROM job_history 
NATURAL JOIN jobs 
WHERE department_id=90;

-- hmm, am going to investigate why the outputs are different, also the sample solution makes no sense, it has over 59,000 days between end date and start date
-- which is over 163 years. clearly the sample solution is wrong
SELECT *
FROM employees e
INNER JOIN job_history jh on jh.department_id = e.department_id
WHERE jh.department_id = 90
ORDER BY e.employee_id;

SELECT *
FROM employees e
INNER JOIN job_history jh 
WHERE jh.department_id = 90
ORDER BY e.employee_id;

-- the first thing to note, is that I did not use the correct tables, I used employees and job history, the sample solution used job_history and jobs
SELECT * FROM jobs;
SELECT * FROM job_history;

-- this is the correct solution
SELECT employee_id, ABS(DATEDIFF(start_date, end_date)) 'Days Employeed'
FROM jobs j
INNER JOIN job_history jh ON jh.job_id = j.job_id
WHERE department_id = 90;


-- Problem 8.) Write a query to display the department ID and department name and first name of manager
SELECT e.department_id, department_name, m.first_name 'Manager First Name'
FROM employees e
INNER JOIN departments d ON d.department_id = e.department_id
INNER JOIN employees m ON m.employee_id = e.manager_id
ORDER BY e.department_id;

-- So 1 department can have multiple managers, for example, department 60 has Lex, and Alexander as managers. this seems right

-- Sample Solution 8.)
SELECT d.department_id, d.department_name, d.manager_id, e.first_name 
FROM departments d 
INNER JOIN employees e 
ON (d.manager_id = e.employee_id);

-- I really butchered this question


-- Problem 9.) Write a query to display the department name, manager name, and city
 -- get department name from TABLE departments
 -- get manager name from doing join on departments.manager_id = employees.employee_id
 -- get city from join TABLE locations.country_id on departments.country_id
 SELECT d.department_name, CONCAT(e.first_name, " ", e.last_name) 'Manager', l.city
 FROM departments d
 INNER JOIN employees e ON e.employee_id = d.manager_id
 INNER JOIN locations l ON l.location_id = d.location_id;

-- Hermann Baer has a ZIP code as the city, something wrong there


-- sample solution 9.) 
SELECT d.department_name, e.first_name, l.city 
FROM departments d 
JOIN employees e 
ON (d.manager_id = e.employee_id) 
JOIN locations l USING (location_id);

-- good, my result and the sample solution's result are the same thing


-- Problem 10.) Write a query to display the job title and average salary of employees.
SELECT job_title, AVG(salary)
FROM employees e
INNER JOIN jobs j ON e.job_id = j.job_id
GROUP BY job_title;

-- Sample solution 10.)
SELECT job_title, AVG(salary) 
FROM employees 
NATURAL JOIN jobs 
GROUP BY job_title;

-- same results, though sample solution uses NATURAL JOIN and I have already stated reasons for why I would not want to use NATURAL JOIN

-- Problem 11.) Write a query to display job title, employee name, and the difference between salary of the employee and minimum salary for the job
SELECT * FROM jobs;
SELECT job_title, CONCAT(e.first_name, ' ', e.last_name) 'Employee Name', salary - min_salary 'Salary - Min Salary'
FROM employees e
INNER JOIN jobs j ON e.job_id = j.job_id;

-- sample solution 11.) 
SELECT job_title, first_name, salary-min_salary 'Salary - Min_Salary' 
FROM employees 
NATURAL JOIN jobs;

-- same as sample solution

-- Problem 12.) Write a query to display the job history that were done by any employee who is currently drawing more than 10000 of salary
SELECT jh.*
FROM job_history jh
INNER JOIN employees e ON jh.job_id = e.job_id
WHERE salary > 10000;

-- Sample solution 12.)
SELECT jh.* FROM job_history jh 
JOIN employees e 
ON (jh.employee_id = e.employee_id) 
WHERE salary > 10000;

-- I butchered this question, I should have joined on employee id, and I did job_id. Not entirely sure why it didn't work

-- Problem 13.) Write a query to display department name, name (first_name, last_name), hire date, salary of the manager for 
-- all managers whose experience is more than 15 years.

-- so using TABLES: departments, employees, 
SELECT e.employee_id, department_name, CONCAT(e.first_name," ",e.last_name) 'Manager', hire_date, salary
FROM employees e
INNER JOIN departments d ON e.employee_id = d.manager_id
ORDER BY e.employee_id;

SELECT e.employee_id, department_name, CONCAT(e.first_name," ",e.last_name) 'Manager', hire_date, salary, start_date, end_date
FROM employees e
INNER JOIN departments d ON e.employee_id = d.manager_id
LEFT JOIN job_history jh ON e.employee_id = jh.employee_id
ORDER BY e.employee_id;


-- so employee_id 200 has multiple records, one before she was a manager, and one after she was a manager, I am not sure how to remedy this issue
-- another issue is I do not know how to find the experience, is it end_date - hire_date? seems logical, but over half of the entries for managers
-- do not have an end date, so should I assume that they are still with this company today?

SELECT e.employee_id, department_name, CONCAT(e.first_name," ",e.last_name) 'Manager', hire_date, salary, start_date, IFNULL(end_date, CURDATE()) 'end_date/current_date'
FROM employees e
INNER JOIN departments d ON e.employee_id = d.manager_id
LEFT JOIN job_history jh ON e.employee_id = jh.employee_id
ORDER BY e.employee_id;

-- so that takes care of the date issue
-- so I want to keep Jennifer Whalen where the job_id = AC_ACCOUNT
SELECT e.employee_id, department_name, CONCAT(e.first_name," ",e.last_name) 'Manager', hire_date, salary, start_date, IFNULL(end_date, CURDATE()) 'end_date/current_date'
FROM employees e
INNER JOIN departments d ON e.employee_id = d.manager_id
LEFT JOIN job_history jh ON e.employee_id = jh.employee_id
WHERE 'end_date/current_date' NOT IN('1993-06-17')
ORDER BY e.employee_id;


-- Sample Solution 13.) 
SELECT first_name, last_name, hire_date, salary, 
(DATEDIFF(now(), hire_date))/365 Experience 
FROM departments d 
JOIN employees e ON (d.manager_id = e.employee_id) 
WHERE (DATEDIFF(now(), hire_date))/365>15;

-- okay, so the sample solution just used hire_date, but as I noted earlier, Jennifer Whalen didn't start as a manager, so if you are wanting
-- years experience as a MANAGER, than this is certainly wrong for her!