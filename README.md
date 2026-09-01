# Chaitanya_SQL

## SQL Practicals

A collection of MySQL database practicals covering **database design, tables, constraints, relationships, normalization, CRUD operations, indexing, and SQL queries**.

---

## 📚 Contents

| No. | Database | Description |
|---|---|---|
| 1 | `ecommerce_db` | E-commerce platform with customers, products, orders, payments, and reviews |
| 2 | `college_demo` | College management system with departments, students, courses, faculty, and enrollments |
| 3 | `hospital_db` | Hospital management system with patients, doctors, appointments, and admissions |
| 4 | `school_db` | School student database demonstrating SQL indexing |
| 5 | `college` | MySQL transactions, COMMIT, ROLLBACK, isolation levels, and Dirty Read demonstration |

---

# 1. 🛒 ecommerce_db

A relational database modeling a typical online store.

### Tables
- `categories`
- `customers`
- `addresses`
- `suppliers`
- `products`
- `orders`
- `order_items`
- `payments`
- `reviews`

### Highlights
- Primary and foreign keys
- Relational integrity
- `ENUM` and `CHECK` constraints
- Generated `order_items.subtotal` column
- Appropriate `ON DELETE` actions
- Sample data included

### Run
```bash
mysql -u root -p < ecommerce_db.sql
```

---

# 2. 🎓 college_demo

A college management database for departments, students, courses, faculty, employees, and enrollments.

### Tables

| Table | Description |
|---|---|
| `department` | Stores department information |
| `student` | Stores student details |
| `course` | Stores course information |
| `enrollment` | Connects students with courses |
| `faculty` | Stores faculty information |
| `employee` | Stores employee information |

### Highlights
- Composite primary key on `enrollment`
- Foreign keys between related tables
- `CHECK` constraint for semester values
- `UNIQUE` constraints for email, Aadhaar, and phone numbers
- Normalized relational design
- One-to-many and many-to-many relationships

### Run
```bash
mysql -u root -p < college_demo.sql
```

---

# 3. 🏥 hospital_db

A simple MySQL-based **Hospital Database Management System** designed to manage patient, doctor, appointment, and hospital admission information.

## 📌 Overview

This project demonstrates:
- Database and table creation
- Primary keys
- Foreign keys
- One-to-many relationships
- Data insertion
- SQL queries
- ER diagram
- Relational database design

## 🗂️ Tables

| Table | Description |
|---|---|
| `patients` | Stores patient details |
| `doctors` | Stores doctor details and specialization |
| `appointments` | Stores appointments, patients, doctors, status, and consultation fees |
| `admissions` | Stores hospital admissions, diagnosis, discharge dates, and treatment costs |

## 🔗 ER Relationship Summary

```text
PATIENTS (1) ──────── (N) APPOINTMENTS (N) ──────── (1) DOCTORS
    │
    │ 1
    │
    └────────────── (N) ADMISSIONS
```

### Relationships
- One patient can have many appointments.
- One doctor can have many appointments.
- One patient can have many admissions.

## 🔑 Foreign Keys

| Foreign Key | References |
|---|---|
| `appointments.patient_id` | `patients.patient_id` |
| `appointments.doctor_id` | `doctors.doctor_id` |
| `admissions.patient_id` | `patients.patient_id` |

## 📋 Main Attributes

### Patients
| Attribute | Description |
|---|---|
| `patient_id` | Primary Key |
| `patient_name` | Patient name |
| `gender` | Patient gender |
| `age` | Patient age |
| `city` | Patient city |
| `registration_date` | Registration date |

### Doctors
| Attribute | Description |
|---|---|
| `doctor_id` | Primary Key |
| `doctor_name` | Doctor name |
| `specialization` | Medical specialization |
| `department` | Hospital department |

### Appointments
| Attribute | Description |
|---|---|
| `appointment_id` | Primary Key |
| `patient_id` | Foreign Key |
| `doctor_id` | Foreign Key |
| `appointment_date` | Appointment date |
| `status` | Appointment status |
| `consultation_fee` | Consultation fee |

### Admissions
| Attribute | Description |
|---|---|
| `admission_id` | Primary Key |
| `patient_id` | Foreign Key |
| `admission_date` | Admission date |
| `discharge_date` | Discharge date |
| `diagnosis` | Patient diagnosis |
| `treatment_cost` | Treatment cost |

---

# 4. 🏫 school_db — SQL Indexing Practical

A simple school database created to demonstrate **SQL indexing and query optimization**.

## 📌 What is an Index?

An **index** is a database structure that helps MySQL find records faster.

Think of it like the **index of a textbook**. Instead of reading every page to find a topic, you use the index to quickly locate the required page.

```text
WITHOUT INDEX
      ↓
MySQL may scan many/all rows
      ↓
More work for large tables

WITH INDEX
      ↓
MySQL can locate matching rows efficiently
      ↓
Better query performance
```

> **Note:** Indexes are most useful on large tables and columns frequently searched, filtered, joined, or sorted.

## 🗂️ Students Table

| Column | Data Type | Description |
|---|---|---|
| `student_id` | `INT` | Primary key |
| `student_name` | `VARCHAR(50)` | Student name |
| `age` | `INT` | Student age |
| `class` | `INT` | Student class |
| `section` | `CHAR(1)` | Student section |
| `city` | `VARCHAR(50)` | Student city |
| `marks` | `INT` | Student marks |

## 🛠️ Step 1 — Create Database

```sql
CREATE DATABASE school_db;
USE school_db;
```

## 🏗️ Step 2 — Create Students Table

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    age INT,
    class INT,
    section CHAR(1),
    city VARCHAR(50),
    marks INT
);
```

## 📝 Step 3 — Insert Sample Data

```sql
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
```

## 👀 Step 4 — View Student Records

```sql
SELECT * FROM students;
```

# 🔍 Indexing Practical

In this practical, an index is created on the `city` column.

### Why `city`?

Suppose we frequently run:

```sql
SELECT * FROM students
WHERE city = 'Nagpur';
```

An index on `city` can help MySQL find matching records efficiently.

## Step 5 — Check Query Before Indexing

```sql
EXPLAIN SELECT * FROM students
WHERE city = 'Nagpur';
```

`EXPLAIN` shows how MySQL plans to execute the query.

You may see:

```text
type: ALL
```

`ALL` generally indicates a **full table scan**.

## Step 6 — Create the Index

```sql
CREATE INDEX idx_student_city
ON students(city);
```

### Command Explanation

| Part | Meaning |
|---|---|
| `CREATE INDEX` | Creates a database index |
| `idx_student_city` | Name of the index |
| `students` | Table on which the index is created |
| `city` | Column being indexed |

## Step 7 — Verify the Index

```sql
SHOW INDEX FROM students;
```

Look for:

```text
idx_student_city
```

## Step 8 — Check Query After Indexing

```sql
EXPLAIN SELECT * FROM students
WHERE city = 'Nagpur';
```

Depending on the table size and MySQL optimizer, the output may show that the index is being used.

For example:

```text
type: ref
key: idx_student_city
```

> **Important:** Because this example contains only 10 rows, MySQL may still choose a full table scan even after the index is created. This is normal. The performance advantage becomes more noticeable with larger tables.

## Step 9 — Run the Actual Query

```sql
SELECT * FROM students
WHERE city = 'Nagpur';
```

This returns all students whose city is Nagpur.

# 📊 Indexing Practical Summary

| Step | SQL Command | Purpose |
|---|---|---|
| 1 | `EXPLAIN SELECT ...` | Check execution plan before indexing |
| 2 | `CREATE INDEX ...` | Create the index |
| 3 | `SHOW INDEX ...` | Verify the index |
| 4 | `EXPLAIN SELECT ...` | Compare execution plan after indexing |
| 5 | `SELECT ...` | Retrieve matching records |

## 🧠 Simple Comparison

### Without Index

```text
Query
  ↓
Search table
  ↓
Check rows
  ↓
Find matching records
```

### With Index

```text
Query
  ↓
Search index
  ↓
Locate matching records
  ↓
Retrieve rows
```

## 🗑️ Remove the Index

```sql
DROP INDEX idx_student_city
ON students;
```

Verify:

```sql
SHOW INDEX FROM students;
```

---

# 5. 🔄 MySQL Transactions & Transaction Isolation Levels

A MySQL practical demonstrating **SQL Transactions**, `COMMIT`, `ROLLBACK`, Transaction Isolation Levels, and **Dirty Read** using two MySQL sessions.

## 📌 Overview

This practical demonstrates:

- Database and table creation
- Inserting student records
- Starting a transaction
- `COMMIT`
- `ROLLBACK`
- Transaction isolation levels
- `READ UNCOMMITTED`
- Dirty Read demonstration
- ACID properties
- Concurrent transactions using two MySQL sessions

---

## 🗄️ Database

**Database:** `college`

**Table:** `student`

### Table Structure

| Column | Data Type | Constraint | Description |
|---|---|---|---|
| `roll_no` | `INT` | PRIMARY KEY | Student roll number |
| `name` | `VARCHAR(50)` | — | Student name |
| `branch` | `VARCHAR(20)` | — | Student branch |
| `cgpa` | `DECIMAL(3,2)` | — | Student CGPA |

## 🚀 Step 1 — Create Database

```sql
CREATE DATABASE college;
USE college;
```

## 🏗️ Step 2 — Create Student Table

```sql
CREATE TABLE student (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50),
    branch VARCHAR(20),
    cgpa DECIMAL(3,2)
);
```

## 📝 Step 3 — Insert Sample Data

```sql
INSERT INTO student VALUES
(101, 'Chaitanya', 'ECE', 9.70),
(102, 'Rahul', 'ECE', 8.50),
(103, 'Amit', 'CSE', 8.90),
(104, 'Siddhi', 'ECE', 9.20);
```

Display the records:

```sql
SELECT * FROM student;
```

## 🔄 SQL Transactions

A transaction is a sequence of SQL operations treated as one logical unit of work.

The basic transaction flow is:

```text
START TRANSACTION
        ↓
   SQL Operations
        ↓
   ┌────┴────┐
   ↓         ↓
 COMMIT   ROLLBACK
   ↓         ↓
 SAVE       UNDO
```

## ▶️ START TRANSACTION

Starts a new transaction.

```sql
START TRANSACTION;
```

## 💾 COMMIT

`COMMIT` permanently saves the changes made during a transaction.

### Example

```sql
START TRANSACTION;

UPDATE student
SET cgpa = 8.80
WHERE roll_no = 101;

COMMIT;
```

Verify the change:

```sql
SELECT cgpa
FROM student
WHERE roll_no = 101;
```

The value remains `8.80` because the transaction has been committed.

## ↩️ ROLLBACK

`ROLLBACK` cancels changes that have not been committed.

### Example

```sql
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
```

Before rollback:

```text
8.50
```

After rollback:

```text
9.70
```

Therefore:

> `ROLLBACK` → Undo uncommitted changes

## 🔐 Transaction Isolation Levels

Transaction isolation controls how concurrent transactions interact with each other.

MySQL provides four standard isolation levels:

| Isolation Level | Dirty Read | Non-Repeatable Read | Phantom Read |
|---|---|---|---|
| `READ UNCOMMITTED` | ✅ | ✅ | ✅ |
| `READ COMMITTED` | ❌ | ✅ | ✅ |
| `REPEATABLE READ` | ❌ | ❌ | ✅ |
| `SERIALIZABLE` | ❌ | ❌ | ❌ |

## 🟡 READ UNCOMMITTED

`READ UNCOMMITTED` is the lowest isolation level.

It allows a transaction to read changes made by another transaction before those changes are committed.

This can result in a Dirty Read.

Set the isolation level:

```sql
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
```

Check the current isolation level:

```sql
SELECT @@transaction_isolation;
```

Expected output:

```text
READ-UNCOMMITTED
```

## 🧪 Dirty Read Demonstration

This experiment requires two MySQL command prompt sessions.

```text
┌─────────────────────┐       ┌─────────────────────┐
│     SESSION 1       │       │     SESSION 2       │
│   Transaction A     │       │   Transaction B     │
└──────────┬──────────┘       └──────────┬──────────┘
           │                             │
           │ UPDATE CGPA = 8.50          │
           │ NOT COMMITTED               │
           │                             │
           │                             │ SELECT CGPA
           │                             │
           │                             │ Reads 8.50
           │                             │
           │ ROLLBACK                    │
           │                             │
           ▼                             ▼
        9.70                         Dirty Read
```

### 🖥️ Session 1 — Transaction A

Login:

```bash
mysql -u root -p
```

Select the database:

```sql
USE college;
```

Set isolation level:

```sql
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
```

Check the isolation level:

```sql
SELECT @@transaction_isolation;
```

Start the transaction:

```sql
START TRANSACTION;
```

Update the student's CGPA:

```sql
UPDATE student
SET cgpa = 8.50
WHERE roll_no = 101;
```

Check the value:

```sql
SELECT cgpa
FROM student
WHERE roll_no = 101;
```

Output:

```text
8.50
```

⚠️ Do not execute `COMMIT` or `ROLLBACK` yet.

### 🖥️ Session 2 — Transaction B

Open another Command Prompt and login:

```bash
mysql -u root -p
```

Select the database:

```sql
USE college;
```

Set isolation level:

```sql
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
```

Start the transaction:

```sql
START TRANSACTION;
```

Read the student's CGPA:

```sql
SELECT cgpa
FROM student
WHERE roll_no = 101;
```

Under `READ UNCOMMITTED`, Session 2 may read:

```text
8.50
```

even though Session 1 has not committed the change.

This is called a:

> ⚠️ Dirty Read

### ↩️ Rollback Session 1

Return to Session 1:

```sql
ROLLBACK;
```

Check the value:

```sql
SELECT cgpa
FROM student
WHERE roll_no = 101;
```

The original value is restored:

```text
9.70
```

The value `8.50` was never permanently committed.

## 🧬 ACID Properties

Transactions follow four important properties known as ACID.

**A — Atomicity**

A transaction is treated as a single unit. Either all operations are completed or none of them are.

**C — Consistency**

The database remains in a valid state before and after a transaction.

**I — Isolation**

Concurrent transactions should not improperly interfere with each other.

**D — Durability**

Once a transaction is committed, its changes remain permanently stored.

## 📊 Important Commands

| Command | Purpose |
|---|---|
| `START TRANSACTION;` | Starts a transaction |
| `COMMIT;` | Permanently saves changes |
| `ROLLBACK;` | Undoes uncommitted changes |
| `SET SESSION TRANSACTION ISOLATION LEVEL ...;` | Sets isolation level |
| `SELECT @@transaction_isolation;` | Checks current isolation level |
| `SELECT * FROM student;` | Displays student records |

## 🎯 Learning Outcomes

After completing this practical, the student will be able to:

- Understand SQL transactions.
- Create and manage MySQL databases.
- Use `START TRANSACTION`.
- Use `COMMIT` and `ROLLBACK`.
- Understand ACID properties.
- Understand transaction isolation levels.
- Implement `READ UNCOMMITTED`.
- Demonstrate a Dirty Read.
- Work with concurrent MySQL sessions.

---

# ⚙️ How to Run

## MySQL Command Line

Open Command Prompt:

```bash
mysql -u root -p
```

Enter your MySQL password.

Then select the required database:

```sql
USE school_db;
```

### View available databases

```sql
SHOW DATABASES;
```

### View tables

```sql
SHOW TABLES;
```

### Describe a table

```sql
DESCRIBE students;
```

### View all records

```sql
SELECT * FROM students;
```

---

# 📁 Project Structure

```text
Chaitanya_sql/
│
├── ecommerce_db.sql
├── college_demo.sql
├── hospital_db.sql
├── school_db.sql
├── transactions.sql
└── README.md
```

---

# 🧪 Useful MySQL Commands

| Command | Purpose |
|---|---|
| `SHOW DATABASES;` | Show all databases |
| `USE database_name;` | Select a database |
| `SHOW TABLES;` | Show tables |
| `DESCRIBE table_name;` | Show table structure |
| `SELECT * FROM table_name;` | View records |
| `SHOW INDEX FROM table_name;` | View indexes |
| `EXPLAIN SELECT ...;` | Analyze query execution |

---

# 🎯 Learning Objectives

This repository helps practice:

- Database creation
- Table creation
- Primary keys
- Foreign keys
- Constraints
- Relationships
- Normalization
- CRUD operations
- SQL queries
- ER modeling
- Indexing
- Query optimization
- MySQL CLI usage

---

# 🛠️ Tech Stack

**Database:** MySQL 8.0+

**Tools:**
- MySQL Workbench
- MySQL Command Line Interface (CLI)

---

# 📄 License

This project is for educational purposes and coursework.

---

# 👨‍💻 Author

**Chaitanya Deo**

GitHub: https://github.com/deochaitanya2006/Chaitanya_sql

---

## © Copyright

Copyright © Chaitanya Deo. All rights reserved.
