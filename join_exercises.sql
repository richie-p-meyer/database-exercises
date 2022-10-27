-- Create a file named join_exercises.sql to do your work in.

-- Join Example Database
-- Use the join_example_db. Select all the records from both the users and roles tables.
USE join_example_db;

SELECT *
FROM users as u
JOIN roles as r ON r.id = u.role_id;

-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
SELECT *
FROM users as u
JOIN roles as r ON r.id = u.role_id;
-- 6 people in users, 2 with null values in role_id, expect 4 results
SELECT *
FROM users as u
LEFT JOIN roles as r ON r.id = u.role_id;
-- 6 people in users, expect 6 results
SELECT *
FROM users as u
RIGHT JOIN roles as r ON r.id = u.role_id;
-- 4 roles, expect 4 results, got 5 results NULL was associated with a role


-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
SELECT r.name, COUNT(*)
FROM roles as r
JOIN users as u ON u.role_id = r.id
GROUP BY r.name;

USE employees;
SELECT *
FROM departments;

-- Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
SELECT departments.dept_name Department_Name, CONCAT(employees.first_name, ' ', employees.last_name) 'Name'
FROM dept_manager
JOIN employees ON employees.emp_no = dept_manager.emp_no
JOIN departments ON departments.dept_no = dept_manager.dept_no
WHERE to_date = '9999-01-01'
ORDER BY Department_Name;

-- Find the name of all departments currently managed by women.
SELECT departments.dept_name Department_Name, CONCAT(employees.first_name, ' ', employees.last_name) 'Name'
FROM dept_manager
JOIN employees ON employees.emp_no = dept_manager.emp_no
JOIN departments ON departments.dept_no = dept_manager.dept_no
WHERE to_date = '9999-01-01' AND gender ='F'
ORDER BY Department_Name;

-- Find the current titles of employees currently working in the Customer Service department.
SELECT title, COUNT(dept_name)
FROM employees
JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
JOIN titles ON titles.emp_no = employees.emp_no
WHERE departments.dept_name LIKE 'Customer Service' AND dept_emp.to_date = '9999-01-01' AND titles.to_date = '9999-01-01'
GROUP BY title
ORDER BY title;


-- 5 Find the current salary of all current managers.
SELECT CONCAT(employees.first_name, ' ', employees.last_name) 'Name',salaries.salary
FROM dept_manager
JOIN employees USING (emp_no)
JOIN salaries USING (emp_no)
WHERE dept_manager.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01';


-- 6 Find the number of current employees in each department.
SELECT dept_emp.dept_no, departments.dept_name, COUNT(dept_name)
FROM employees
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no)
WHERE dept_emp.to_date = '9999-01-01'
GROUP BY dept_name
ORDER BY dept_no;


-- 7 Which department has the highest average salary? Hint: Use current not historic information.
SELECT departments.dept_name, AVG(salary) avg_salary
FROM employees
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no)
JOIN salaries USING (emp_no)
WHERE dept_emp.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01'
GROUP BY dept_name
ORDER BY avg_salary DESC
LIMIT 1;


-- 8 Who is the highest paid employee in the Marketing department?
SELECT CONCAT(first_name, ' ', last_name) 'name', salary
FROM employees
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no)
JOIN salaries USING (emp_no)
WHERE dept_emp.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01' AND dept_name = "Marketing"
ORDER BY salary DESC
LIMIT 1;


-- 9 I Which current department manager has the highest salary?
SELECT first_name,last_name,salary, dept_name
FROM dept_manager
JOIN dept_emp USING (emp_no)
JOIN departments ON dept_emp.dept_no = departments.dept_no
JOIN salaries USING (emp_no)
JOIN employees USING (emp_no)
WHERE dept_manager.to_date = '9999-01-01' AND salaries.to_date = '9999-01-01' 
ORDER BY salary DESC
LIMIT 1;



-- 10 Determine the average salary for each department. Use all salary information and round your results.

SELECT dept_name, AVG(salary) avg_salary
FROM employees
JOIN dept_emp USING (emp_no)
JOIN departments ON dept_emp.dept_no = departments.dept_no
JOIN salaries USING (emp_no)
GROUP BY dept_name 
ORDER BY avg_salary DESC;

-- 11 Bonus Find the names of all current employees, their department name, and their current manager's name.
SELECT CONCAT(employees.first_name,' ', employees.last_name) AS employee, dept_name, CONCAT(e.first_name, ' ',e.last_name) AS manager
FROM employees
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no)
JOIN dept_manager USING (dept_no)
JOIN employees e ON dept_manager.emp_no = e.emp_no
WHERE dept_emp.to_date = '9999-01-01' AND dept_manager.to_date ='9999-01-01';


-- 12 Bonus Who is the highest paid employee within each department.