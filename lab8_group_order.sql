-- LAB 8: Implement Grouping and Ordering (GROUP BY, HAVING, ORDER BY)
-- Tested on MySQL / MariaDB

DROP DATABASE IF EXISTS lab8;
CREATE DATABASE lab8;
USE lab8;

CREATE TABLE employees (
  emp_id INT PRIMARY KEY,
  name   VARCHAR(30),
  dept   VARCHAR(20),
  city   VARCHAR(20),
  salary INT
);

-- Changed sample values
INSERT INTO employees VALUES
 (101,'Mohith','IT','Bangalore',62000),
 (102,'Virat Kohli','IT','Mysore',58000),
 (103,'Samay Raina','HR','Bangalore',47000),
 (104,'Cristiano Ronaldo','Finance','Delhi',76000),
 (105,'Thor','IT','Bangalore',67000),
 (106,'Arjun','HR','Delhi',49000),
 (107,'Rohan','Finance','Bangalore',73000);
SELECT * FROM employees;

-- GROUP BY - count and average salary per department
SELECT dept, COUNT(*) AS total_emp, AVG(salary) AS avg_salary
FROM employees
GROUP BY dept;

-- GROUP BY with SUM, MIN and MAX
SELECT dept, SUM(salary) AS total_salary,
       MIN(salary) AS lowest, MAX(salary) AS highest
FROM employees
GROUP BY dept;

-- GROUP BY on multiple columns
SELECT dept, city, COUNT(*) AS total_emp
FROM employees
GROUP BY dept, city;

-- HAVING - keep only groups with average salary above 55000
SELECT dept, AVG(salary) AS avg_salary
FROM employees
GROUP BY dept
HAVING AVG(salary) > 55000;

-- WHERE + GROUP BY + HAVING together
SELECT dept, COUNT(*) AS total_emp
FROM employees
WHERE city = 'Bangalore'
GROUP BY dept
HAVING COUNT(*) >= 2;

-- ORDER BY ascending
SELECT name, dept, salary
FROM employees
ORDER BY salary;

-- ORDER BY descending
SELECT name, dept, salary
FROM employees
ORDER BY salary DESC;

-- ORDER BY multiple columns
SELECT name, dept, salary
FROM employees
ORDER BY dept ASC, salary DESC;

-- GROUP BY + HAVING + ORDER BY combined
SELECT dept, COUNT(*) AS total_emp, SUM(salary) AS total_salary
FROM employees
GROUP BY dept
HAVING SUM(salary) > 100000
ORDER BY total_salary DESC;
