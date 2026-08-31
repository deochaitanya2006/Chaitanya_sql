CREATE DATABASE school_db;

USE school_db;

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    age INT,
    class INT,
    section CHAR(1),
    city VARCHAR(50),
    marks INT
);

INSERT INTO students VALUES
(101, 'Aarav', 14, 9, 'A', 'Nagpur', 85),
(102, 'Ananya', 15, 10, 'B', 'Pune', 92),
(103, 'Rahul', 14, 9, 'A', 'Nagpur', 78),
(104, 'Priya', 15, 10, 'A', 'Mumbai', 88),
(105, 'Rohan', 13, 8, 'B', 'Nagpur', 74),
(106, 'Sneha', 14, 9, 'B', 'Pune', 95),
(107, 'Aditya', 15, 10, 'A', 'Nagpur', 81),
(108, 'Isha', 13, 8, 'A', 'Mumbai', 89),
(109, 'Karan', 14, 9, 'B', 'Nagpur', 76),
(110, 'Neha', 15, 10, 'B', 'Pune', 94);

SELECT * FROM students;

EXPLAIN SELECT * FROM students
WHERE city = 'Nagpur';

CREATE INDEX idx_student_city
ON students(city);

SHOW INDEX FROM students;

EXPLAIN SELECT * FROM students
WHERE city = 'Nagpur';

SELECT * FROM students
WHERE city = 'Nagpur';