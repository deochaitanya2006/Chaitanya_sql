DROP DATABASE IF EXISTS college_demo3;

CREATE DATABASE college_demo3;

USE college_demo3;

CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL UNIQUE
);
CREATE TABLE student (
    roll_no INT PRIMARY KEY,
    student_id INT UNIQUE,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    aadhar_no VARCHAR(20) UNIQUE,
    dept_id INT,
    cgpa DECIMAL(3,1),

    FOREIGN KEY (dept_id)
        REFERENCES department(dept_id)
);

CREATE TABLE course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    dept_id INT,

    FOREIGN KEY (dept_id)
        REFERENCES department(dept_id)
);

CREATE TABLE enrollment (
    roll_no INT,
    course_id INT,
    semester INT,
    grade CHAR(1),

    PRIMARY KEY (roll_no, course_id, semester),

    FOREIGN KEY (roll_no)
        REFERENCES student(roll_no),

    FOREIGN KEY (course_id)
        REFERENCES course(course_id)
);

INSERT INTO department
VALUES
(1, 'Computer Science'),
(2, 'Electronics');


INSERT INTO student
(roll_no, student_id, name, email, aadhar_no, dept_id, cgpa)
VALUES
(101, 1001, 'Chaitanya', 'chaitanya@gmail.com', '111111111111', 1, 9.0),
(102, 1002, 'Varun', 'varun@gmail.com', '222222222222', 2, 8.5),
(103, 1003, 'Siddhi', 'siddhi@gmail.com', '333333333333', 1, 9.2),
(104, 1004, 'Parth', 'parth@gmail.com', '444444444444', 2, 8.0),
(105, 1005, 'Samira', 'samira@gmail.com', '555555555555', 1, 8.8),
(106, 1006, 'Bhargavi', 'bhargavi@gmail.com', '666666666666', 1, 9.0),
(107, 1007, 'Arya', 'arya@gmail.com', '777777777777', 2, 8.7),
(108, 1008, 'Pranay', 'pranay@gmail.com', '888888888888', 2, 7.8),
(109, 1009, 'Hardik', 'hardik@gmail.com', '999999999999', 1, 8.3),
(110, 1010, 'Rohit', 'rohit@gmail.com', '123456789012', 2, 7.5),
(111, 1011, 'Deep', 'deep@gmail.com', '234567890123', 1, 8.6);

INSERT INTO course
VALUES
(501, 'DBMS', 1),
(502, 'Circuits', 2);

INSERT INTO enrollment
VALUES
(101, 501, 3, 'A'),
(101, 502, 3, 'B');

SELECT * FROM department;

SELECT * FROM student;

SELECT * FROM course;

SELECT * FROM enrollment;


SELECT
    s.name,
    s.cgpa,
    d.dept_name
FROM student s
INNER JOIN department d
ON s.dept_id = d.dept_id;

SELECT
    s.name,
    e.course_id,
    e.grade
FROM student s
INNER JOIN enrollment e
ON s.roll_no = e.roll_no;

SELECT
    s.name,
    c.course_name,
    e.semester,
    e.grade
FROM student s
INNER JOIN enrollment e
ON s.roll_no = e.roll_no
INNER JOIN course c
ON e.course_id = c.course_id;

SELECT
    s.roll_no,
    s.student_id,
    s.name,
    d.dept_name,
    c.course_name,
    e.semester,
    e.grade
FROM student s
INNER JOIN department d
ON s.dept_id = d.dept_id
INNER JOIN enrollment e
ON s.roll_no = e.roll_no
INNER JOIN course c
ON e.course_id = c.course_id;

SELECT
    s.name,
    s.cgpa,
    d.dept_name
FROM student s
INNER JOIN department d
ON s.dept_id = d.dept_id
WHERE s.cgpa > 8;

SELECT
    d.dept_name,
    COUNT(*) AS student_count
FROM student s
INNER JOIN department d
ON s.dept_id = d.dept_id
GROUP BY d.dept_name;

SELECT
    d.dept_name,
    AVG(s.cgpa) AS avg_cgpa
FROM student s
INNER JOIN department d
ON s.dept_id = d.dept_id
GROUP BY d.dept_name;

SELECT
    s.name,
    d.dept_name
FROM student s
JOIN department d
USING (dept_id);

SELECT
    s.name,
    e.course_id,
    e.grade
FROM student s
LEFT JOIN enrollment e
ON s.roll_no = e.roll_no;

SELECT
    s.name
FROM student s
LEFT JOIN enrollment e
ON s.roll_no = e.roll_no
WHERE e.roll_no IS NULL;

SELECT
    s.name,
    e.course_id,
    e.grade
FROM enrollment e
RIGHT JOIN student s
ON e.roll_no = s.roll_no;


SELECT
    s.name,
    e.course_id,
    e.grade
FROM student s
LEFT JOIN enrollment e
ON s.roll_no = e.roll_no

UNION

SELECT
    s.name,
    e.course_id,
    e.grade
FROM student s
RIGHT JOIN enrollment e
ON s.roll_no = e.roll_no;

ALTER TABLE student
ADD mentor_roll_no INT NULL;

SELECT
    s.name AS student_name,
    m.name AS mentor_name
FROM student s
JOIN student m
ON s.mentor_roll_no = m.roll_no;


SELECT
    s.name,
    c.course_name
FROM student s
CROSS JOIN course c;

SELECT
    c.course_name,
    d.dept_name
FROM course c
INNER JOIN department d
ON c.dept_id = d.dept_id;


SELECT
    s.name,
    s.cgpa,
    d.dept_name
FROM student s
INNER JOIN department d
ON s.dept_id = d.dept_id
WHERE d.dept_id = 2
AND s.cgpa < 7.5;

SELECT
    s.student_id,
    s.roll_no AS enrollment_no,
    s.name AS student_name,
    d.dept_name AS department,
    c.course_id,
    c.course_name,
    e.semester,
    e.grade
FROM student s
LEFT JOIN department d
ON s.dept_id = d.dept_id
LEFT JOIN enrollment e
ON s.roll_no = e.roll_no
LEFT JOIN course c
ON e.course_id = c.course_id;


