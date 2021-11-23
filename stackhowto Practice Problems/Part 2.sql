USE stackhowto;

-- 1. Get the length of the text in the “First_name” column.
SELECT char_length(first_name) FROM employee;

-- or

SELECT LENGTH(first_name) FROM employee;

-- 2. Get the employee’s first name after replacing ‘o’ with ‘#’.
SELECT REPLACE(first_name, 'o', '#') FROM employee;

-- 3. Get the employee’s last name and first name in a single column separated by a ‘_’.
SELECT CONCAT(first_name, '_', last_name) FROM employee;

-- 4. Get the year, month, and day from the “Joining_date” column.
SELECT YEAR(Joining_date), MONTH(joining_date), DAY(joining_date) FROM employee;

-- 5. Get all employees in ascending order by first name.
SELECT first_name FROM employee ORDER BY first_name;

-- 6. Get all employees in descending order by first name.
SELECT first_name FROM employee ORDER BY first_name DESC;

-- 7. Get all employees in ascending order by first name and descending order by salary.
SELECT first_name, salary FROM employee ORDER BY first_name, salary DESC;

-- 8. Get employees whose first name is “Bob”.
SELECT first_name FROM employee WHERE first_name = 'Bob';

-- 9. Get employees whose first name is “Bob” or “Alex”.
SELECT first_name FROM employee WHERE first_name = 'Bob' OR first_name = 'Alex';

-- or
SELECT first_name FROM employee WHERE first_name IN ('Bob','Alex');

-- 10. Get employees whose first name is neither “Bob” nor “Alex”
SELECT first_name FROM employee WHERE first_name != 'Bob' AND first_name != 'Alex';

-- or

SELECt first_name FROM employee WHERE first_name NOT IN ('Bob','Alex');

-- 11. What is SQL injection?
-- SQL injection is one of the techniques used by hackers to hack a website by injecting SQL commands into data fields.