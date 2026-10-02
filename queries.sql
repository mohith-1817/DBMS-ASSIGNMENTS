-- ============ SETUP (include in every run) ============
CREATE TABLE STUDENT (
    Student_ID INT,
    Student_Name VARCHAR(50),
    Class VARCHAR(100),
    Marks INT,
    Fee_Paid DECIMAL(10,2),
    Date_of_Birth DATE,
    Admission_Date DATE
);

INSERT INTO STUDENT
(Student_ID, Student_Name, Class, Marks, Fee_Paid, Date_of_Birth, Admission_Date)
VALUES
(101, 'Mohith', '10A', 85, 50000.00, '2007-06-05', '2023-06-10'),
(102, 'Virat Kohli', '10A', 92, 50000.00, '2008-11-20', '2023-06-12'),
(103, 'Samay Raina', '10B', 76, 45000.00, '2009-02-10', '2023-06-11'),
(104, 'Cristiano Ronaldo', '10B', 88, 48000.00, '2008-08-25', '2023-06-15'),
(105, 'Thor', '10B', 65, 40000.00, '2009-06-05', '2023-06-13');


-- ============ TUTORIAL 4: CONVERSION + DATE FUNCTIONS ============
-- Conversion functions
SELECT CAST('2025' AS UNSIGNED) + 5 AS Cast_Result;

SELECT CONVERT('123', SIGNED) + 7 AS Convert_Result;

SELECT Student_Name, CAST(Fee_Paid AS SIGNED) AS Fee_Integer
FROM STUDENT;

SELECT Student_Name, CAST(Marks AS CHAR) AS Marks_Text
FROM STUDENT;

SELECT STR_TO_DATE('15-08-2024', '%d-%m-%Y') AS Converted_Date;

SELECT Student_Name, DATE_FORMAT(Admission_Date, '%d %b %Y') AS Admission_Formatted
FROM STUDENT;

SELECT Student_Name, FORMAT(Fee_Paid, 2) AS Fee_Formatted
FROM STUDENT;

-- Date functions
SELECT Student_Name,
       YEAR(Date_of_Birth)  AS Birth_Year,
       MONTH(Date_of_Birth) AS Birth_Month,
       DAY(Date_of_Birth)   AS Birth_Day,
       DAYNAME(Date_of_Birth) AS Birth_Weekday
FROM STUDENT;

SELECT Student_Name,
       Admission_Date,
       DATE_ADD(Admission_Date, INTERVAL 1 YEAR)  AS One_Year_Later,
       DATE_SUB(Admission_Date, INTERVAL 15 DAY)  AS Fifteen_Days_Before
FROM STUDENT;

SELECT Student_Name,
       DATEDIFF(CURDATE(), Admission_Date) AS Days_Since_Admission,
       TIMESTAMPDIFF(YEAR, Date_of_Birth, CURDATE()) AS Age
FROM STUDENT;

SELECT CURDATE() AS Today, LAST_DAY('2024-02-10') AS Month_End;


-- ============ TUTORIAL 5: ARITHMETIC, COMPARISON, LOGICAL OPERATORS ============
-- Arithmetic
SELECT 15 + 4 AS Addition, 15 - 4 AS Subtraction, 15 * 4 AS Multiplication,
       15 / 4 AS Division, 15 DIV 4 AS Int_Division, 15 % 4 AS Modulus;

SELECT Student_Name, Marks,
       Marks + 5 AS Marks_Plus_5,
       Marks * 2 AS Marks_Double,
       Fee_Paid / 12 AS Monthly_Fee,
       Marks % 10 AS Marks_Mod_10
FROM STUDENT;

-- Comparison
SELECT Student_Name, Marks FROM STUDENT WHERE Marks > 80;
SELECT Student_Name, Marks FROM STUDENT WHERE Marks < 76;
SELECT Student_Name, Marks FROM STUDENT WHERE Marks >= 88;
SELECT Student_Name, Marks FROM STUDENT WHERE Marks <= 76;
SELECT Student_Name, Class FROM STUDENT WHERE Class = '10A';
SELECT Student_Name, Class FROM STUDENT WHERE Class <> '10A';

SELECT 5 = 5 AS Equal, 5 <> 3 AS Not_Equal, 5 > 8 AS Greater,
       5 <=> 5 AS Null_Safe_1, NULL = NULL AS Null_Eq, NULL <=> NULL AS Null_Safe_2;

-- Logical
SELECT Student_Name, Class, Marks
FROM STUDENT
WHERE Class = '10A' AND Marks > 80;

SELECT Student_Name, Class, Marks
FROM STUDENT
WHERE Class = '10B' OR Marks > 90;

SELECT Student_Name, Marks
FROM STUDENT
WHERE NOT (Marks >= 76);

SELECT Student_Name, Class, Marks
FROM STUDENT
WHERE (Class = '10A') XOR (Marks > 80);


-- ============ TUTORIAL 6: SPECIAL OPERATORS + UNION ============
-- Extra tables for UNION (add these to the setup for this run)
CREATE TABLE Sports_Club (Student_Name VARCHAR(50), Class VARCHAR(100));
CREATE TABLE Music_Club  (Student_Name VARCHAR(50), Class VARCHAR(100));

INSERT INTO Sports_Club VALUES ('Mohith','10A'), ('Cristiano Ronaldo','10B'), ('Thor','10B');
INSERT INTO Music_Club  VALUES ('Virat Kohli','10A'), ('Cristiano Ronaldo','10B'), ('Samay Raina','10B');

-- Special operators
SELECT Student_Name, Marks FROM STUDENT WHERE Marks BETWEEN 70 AND 90;

SELECT Student_Name, Class FROM STUDENT WHERE Class IN ('10A');

SELECT Student_Name, Marks FROM STUDENT WHERE Marks NOT IN (65, 92);

SELECT Student_Name FROM STUDENT WHERE Student_Name LIKE 'M%';

SELECT Student_Name FROM STUDENT WHERE Student_Name LIKE '_a%';

SELECT Student_Name FROM STUDENT WHERE Student_Name LIKE '%a';

SELECT Student_Name, Fee_Paid FROM STUDENT WHERE Fee_Paid IS NOT NULL;

SELECT Student_Name, Marks
FROM STUDENT
WHERE Marks > ALL (SELECT Marks FROM STUDENT WHERE Class = '10B');

SELECT Student_Name, Marks
FROM STUDENT
WHERE Marks > ANY (SELECT Marks FROM STUDENT WHERE Class = '10B');

-- Set operations
SELECT Student_Name, Class FROM Sports_Club
UNION
SELECT Student_Name, Class FROM Music_Club;

SELECT Student_Name, Class FROM Sports_Club
UNION ALL
SELECT Student_Name, Class FROM Music_Club;