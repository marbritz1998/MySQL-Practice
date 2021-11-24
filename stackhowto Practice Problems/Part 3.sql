USE stackhowto;

-- 1. Get all the details about employees whose first name begins with ‘B’.
SELECT * FROM employee WHERE first_name LIKE 'B%';

-- 2. Get all the details about employees whose first name contains ‘o’.
SELECT * FROM employee WHERE first_name LIKE '%o%';

-- 3. Get all the details of the employees whose first name ends with ‘n’
SELECT * FROM employee WHERE first_name LIKE '%n';

-- 4. Get all the details about employees whose first name ends with ‘n’ and contains 4 letters.
SELECT * FROM employee WHERE first_name LIKE '___n';

-- or
SELECT * FROM employee WHERE first_name LIKE '%n' AND length(first_name) <= 4;

-- 5. Get all the details about employees whose first name begins with ‘J’ and contains 4 letters.
SELECT * FROM employee WHERE first_name LIKE 'J___';

-- or 
SELECT * FROM employee WHERE first_name LIKE 'J%' AND length(first_name) <=4;

-- 6. Get all the details of employees whose salary is over 3,000,000.
SELECT * FROM employee WHERE salary > 3000000;

-- 7. Get all the details about employees whose salary is less than 3,000,000.
SELECT * FROM employee WHERE salary < 3000000;

-- 8. Get all the details about employees with a salary between 2,000,000 and 5,000,000.
SELECT * FROM employee WHERE salary > 2000000 AND salary < 5000000;

-- or 
SELECT * FROM employee WHERE salary BETWEEN 2000000 AND 5000000;

-- 9. Get all the details about employees whose first name is ‘Bob’ or ‘Alex’
SELECT * FROM employee WHERE first_name = 'Bob' OR first_name = 'Alex';

-- or
SELECT * FROM employee WHERE first_name IN ('Bob','Alex');

-- 10. Get all the details about employees whose joining year is “2019”.
SELECT * FROM employee WHERE YEAR(joining_date) = 2019;

