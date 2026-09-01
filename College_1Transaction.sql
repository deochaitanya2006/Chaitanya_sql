
CREATE DATABASE college_1;

USE college_1;

CREATE TABLE student (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50),
    branch VARCHAR(20),
    cgpa DECIMAL(3,2)
);

INSERT INTO student VALUES
(101, 'Chaitanya', 'ECE', 9.70),
(102, 'Varun', 'ECE', 8.50),
(103, 'Samira', 'ECE', 8.90),
(104, 'Bhargavi', 'ECE', 9.20);

SELECT * FROM student;
START TRANSACTION;

UPDATE student
SET cgpa = 8.50
WHERE roll_no = 101;

SELECT cgpa
FROM student
WHERE roll_no = 101;

ROLLBACK;

SELECT cgpa
FROM student
WHERE roll_no = 101;

SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

SELECT @@transaction_isolation;