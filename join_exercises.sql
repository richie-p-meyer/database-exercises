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

SELECT departments.dept_name Department_Name, CONCAT(employees.first_name, ' ', employees.last_name) 'Name'
FROM dept_manager
JOIN employees ON employees.emp_no = dept_manager.emp_no
JOIN departments ON departments.dept_no = dept_manager.dept_no
WHERE to_date = '9999-01-01'
ORDER BY Department_Name;