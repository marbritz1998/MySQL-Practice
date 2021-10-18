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


