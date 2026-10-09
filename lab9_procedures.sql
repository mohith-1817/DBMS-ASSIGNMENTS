-- LAB 9: Implement Procedures (basic, Insert, Update, Delete)
-- Tested on MySQL / MariaDB

DROP DATABASE IF EXISTS lab9;
CREATE DATABASE lab9;
USE lab9;

CREATE TABLE students (
  roll_no INT PRIMARY KEY,
  name    VARCHAR(30),
  course  VARCHAR(20),
  marks   INT
);

-- Changed sample values
INSERT INTO students VALUES
 (11,'Mohith','BCom',84),
 (12,'Virat Kohli','BCom',76),
 (13,'Samay Raina','BCom',92);
SELECT * FROM students;

-- Basic procedure (no parameters) - display all students
DELIMITER //
CREATE PROCEDURE sp_show_students()
BEGIN
  SELECT * FROM students;
END //
DELIMITER ;
CALL sp_show_students();

-- Procedure with IN and OUT parameters - get marks of a student
DELIMITER //
CREATE PROCEDURE sp_get_marks(IN p_roll INT, OUT p_marks INT)
BEGIN
  SELECT marks INTO p_marks FROM students WHERE roll_no = p_roll;
END //
DELIMITER ;
CALL sp_get_marks(13, @m);
SELECT @m AS marks_of_roll_13;

-- Procedure for INSERT
DELIMITER //
CREATE PROCEDURE sp_insert_student(
  IN p_roll INT, IN p_name VARCHAR(30), IN p_course VARCHAR(20), IN p_marks INT)
BEGIN
  INSERT INTO students VALUES (p_roll, p_name, p_course, p_marks);
END //
DELIMITER ;
CALL sp_insert_student(14, 'Cristiano Ronaldo', 'BCom', 69);
CALL sp_insert_student(15, 'Thor', 'BCom', 78);
SELECT * FROM students;

-- Procedure for UPDATE
DELIMITER //
CREATE PROCEDURE sp_update_marks(IN p_roll INT, IN p_marks INT)
BEGIN
  UPDATE students SET marks = p_marks WHERE roll_no = p_roll;
END //
DELIMITER ;
CALL sp_update_marks(12, 81);
SELECT * FROM students;

-- Procedure for DELETE
DELIMITER //
CREATE PROCEDURE sp_delete_student(IN p_roll INT)
BEGIN
  DELETE FROM students WHERE roll_no = p_roll;
END //
DELIMITER ;
CALL sp_delete_student(15);
SELECT * FROM students;

-- Procedure with IF/ELSE - grade of a student
DELIMITER //
CREATE PROCEDURE sp_grade(IN p_roll INT)
BEGIN
  DECLARE m INT;
  SELECT marks INTO m FROM students WHERE roll_no = p_roll;
  IF m >= 90 THEN SELECT p_roll AS roll_no, m AS marks, 'A+' AS grade;
  ELSEIF m >= 75 THEN SELECT p_roll AS roll_no, m AS marks, 'A' AS grade;
  ELSEIF m >= 60 THEN SELECT p_roll AS roll_no, m AS marks, 'B' AS grade;
  ELSE SELECT p_roll AS roll_no, m AS marks, 'C' AS grade;
  END IF;
END //
DELIMITER ;
CALL sp_grade(13);
CALL sp_grade(12);

-- List the stored procedures created
SELECT routine_name, routine_type
FROM information_schema.routines
WHERE routine_schema = 'lab9'
ORDER BY routine_name;
