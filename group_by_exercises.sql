-- Create a new file named group_by_exercises.sql
USE employees;
-- In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.
SELECT DISTINCT(title) FROM titles;
-- 7 distinct titles

-- Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
SELECT last_name
FROM employees
WHERE last_name LIKE 'e%e'
GROUP BY last_name;


-- Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
SELECT first_name,last_name
FROM employees
GROUP BY first_name, last_name
HAVING last_name LIKE 'e%e';

-- Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
SELECT last_name
FROM employees
GROUP BY last_name
HAVING last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';
-- Chleq, Lindqvist, Qiwen

-- Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
SELECT last_name, COUNT(last_name)
FROM employees
GROUP BY last_name
HAVING last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';

-- Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
SELECT first_name, COUNT(gender='M') as M, COUNT(gender='F') as F
FROM employees
WHERE first_name IN ('Irena','Vidya','Maya')
GROUP BY first_name;

-- Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?
SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1), SUBSTR(last_name, 1,4),'_',SUBSTR(birth_date, 6, 2),SUBSTR(birth_date, 3, 2))) as username, COUNT(*) as count_user
FROM employees
GROUP BY username
HAVING count_user > 1;
-- There are 13,251 duplicate usernames

-- Bonus: More practice with aggregate functions:

-- Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.
SELECT emp_no, AVG(salary)
FROM salaries
GROUP BY emp_no;

-- Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.
SELECT dept_no, COUNT(emp_no)
FROM dept_emp
GROUP BY dept_no;


-- Determine how many different salaries each employee has had. This includes both historic and current.
SELECT emp_no, COUNT(salary) as different_salaries
FROM salaries
GROUP BY emp_no;

-- Find the maximum salary for each employee.
SELECT emp_no, MAX(salary) as max_salaries
FROM salaries
GROUP BY emp_no;

-- Find the minimum salary for each employee.
SELECT emp_no, MIN(salary) as min_salaries
FROM salaries
GROUP BY emp_no;


-- Find the standard deviation of salaries for each employee.
SELECT emp_no, STD(salary) as std_salaries
FROM salaries
GROUP BY emp_no;

-- Now find the max salary for each employee where that max salary is greater than $150,000.
SELECT emp_no, MAX(salary) as max_salaries
FROM salaries
GROUP BY emp_no
HAVING max_salaries>150000;


-- Find the average salary for each employee where that average salary is between $80k and $90k.
SELECT emp_no, AVG(salary) as avg_salaries
FROM salaries
GROUP BY emp_no
HAVING avg_salaries BETWEEN 80000 AND 90000;

