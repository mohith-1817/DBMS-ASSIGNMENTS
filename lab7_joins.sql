-- LAB 7: Implement different types of Joins
-- Tested on MySQL / MariaDB

-- 1. Create database and tables
DROP DATABASE IF EXISTS lab7;
CREATE DATABASE lab7;
USE lab7;

CREATE TABLE departments (
  dept_id   INT PRIMARY KEY,
  dept_name VARCHAR(30)
);

CREATE TABLE employees (
  emp_id   INT PRIMARY KEY,
  emp_name VARCHAR(30),
  dept_id  INT,
  salary   INT
);

SHOW TABLES;

-- 2. Insert changed sample data (Thor has no department; Support has no employees)
INSERT INTO departments VALUES
 (1,'Development'),(2,'Marketing'),(3,'Accounts'),(4,'Support');

INSERT INTO employees VALUES
 (201,'Mohith',1,62000),
 (202,'Virat Kohli',1,58000),
 (203,'Samay Raina',2,47000),
 (204,'Cristiano Ronaldo',3,75000),
 (205,'Thor',NULL,42000);

SELECT * FROM departments;
SELECT * FROM employees;

-- 3. INNER JOIN - only rows that match in both tables
SELECT e.emp_id, e.emp_name, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;

-- 4. LEFT OUTER JOIN - all employees, even without a department
SELECT e.emp_id, e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

-- 5. RIGHT OUTER JOIN - all departments, even without employees
SELECT e.emp_name, d.dept_id, d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;

-- 6. FULL OUTER JOIN - emulated using UNION (MySQL has no FULL JOIN keyword)
SELECT e.emp_name, d.dept_name
FROM employees e LEFT JOIN departments d ON e.dept_id = d.dept_id
UNION
SELECT e.emp_name, d.dept_name
FROM employees e RIGHT JOIN departments d ON e.dept_id = d.dept_id;

-- 7. NATURAL JOIN - joins automatically on the common column (dept_id)
SELECT emp_id, emp_name, dept_name
FROM employees
NATURAL JOIN departments;

-- 8. CROSS JOIN - every employee paired with every department (first 6 rows)
SELECT e.emp_name, d.dept_name
FROM employees e
CROSS JOIN departments d
ORDER BY e.emp_id, d.dept_id
LIMIT 6;

-- 9. SELF JOIN - employees who earn more than Virat Kohli
SELECT a.emp_name AS employee, b.emp_name AS compared_with, a.salary
FROM employees a
JOIN employees b ON a.salary > b.salary AND b.emp_name = 'Virat Kohli';
