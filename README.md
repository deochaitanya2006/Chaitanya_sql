# Chaitanya_sql
# SQL Practicals

MySQL database practicals covering schema design, constraints, relationships, and CRUD operations.

## Contents

| # | Database | Description |
|---|----------|-------------|
| 1 | `ecommerce_db` | E-commerce platform schema — customers, products, orders, payments, reviews, and cart |
| 2 | `college_demo` | College management schema — departments, students, courses, faculty, and enrollments |

---

## 1. `ecommerce_db`

An e-commerce database modeling a typical online store.

**Tables:** `Categories`, `Customers`, `Addresses`, `Suppliers`, `Products`, `Orders`, `Order_Items`, `Payments`, `Reviews`, `Cart`

**Highlights:**
- `ENUM` types for status fields (order status, payment method/status, gender)
- `CHECK` constraints for data validation (price, discount %, stock, rating)
- Generated column: `Order_Items.subtotal` computed as `quantity * unit_price`
- Foreign keys with mixed `ON DELETE` behavior (`CASCADE`, `RESTRICT`, `SET NULL`)
- Sample data pre-loaded for all tables

**Setup:**
```bash
mysql -u root -p < ecommerce_db.sql
```

---

## 2. `college_demo`

A college management database modeling departments, students, courses, and enrollments.

**Tables:** `department`, `student`, `course`, `enrollment`, `faculty`, `employee`

**Highlights:**
- Composite primary key on `enrollment` (`roll_no`, `course_id`, `semester`)
- `CHECK` constraint restricting `semester` to 1–8
- Foreign keys linking students, courses, and faculty back to `department`
- Unique constraints on `email`, `aadhar_no`, and `phone_no`

**Setup:**
```bash
mysql -u root -p < college_demo.sql
```

---

## Requirements

- MySQL 8.0+ (for generated columns and `CHECK` constraint support)

## Usage

```bash
mysql -u root -p
SOURCE path/to/script.sql;
```
For Experiment 3:
College Management Database (college_demo)

A relational database schema for managing college data — departments, students, courses, faculty, and enrollments — built in MySQL.

📌 Overview

This project models a simple college management system with 5 interrelated tables. It demonstrates core relational database design principles including primary keys, foreign keys, composite keys, and normalization up to BCNF.

🗂️ Schema Structure
Table	Description
department	Stores department details
student	Stores student records, linked to a department
course	Stores course details, linked to a department
faculty	Stores faculty details, linked to a department
enrollment	Junction table linking students to courses (many-to-many), with semester and grade
Entity Relationship Summary
One department → many students, courses, and faculty
One student → many course enrollments (via enrollment)
One course → many student enrollments (via enrollment)
🏗️ Table Definitions
sql
CREATE TABLE department (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE student (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE,
    aadhar_no VARCHAR(12) UNIQUE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

CREATE TABLE course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50) NOT NULL,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);

CREATE TABLE enrollment (
    roll_no INT,
    course_id INT,
    semester INT CHECK (semester BETWEEN 1 AND 8),
    grade CHAR(2),
    PRIMARY KEY (roll_no, course_id, semester),
    FOREIGN KEY (roll_no) REFERENCES student(roll_no),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);

CREATE TABLE faculty (
    faculty_id INT PRIMARY KEY,
    faculty_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE,
    phone_no VARCHAR(15) UNIQUE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES department(dept_id)
);
📊 Sample Data
sql
INSERT INTO department (dept_id, dept_name) VALUES
(1, 'Computer Science'),
(2, 'Mechanical'),
(3, 'Electronics');

INSERT INTO student (roll_no, name, email, aadhar_no, dept_id) VALUES
(101, 'Chaitanya Deo', 'chaitanya@example.com', '123456789012', 1),
(102, 'Varun Gharote', 'varuniversel@example.com', '234567890123', 2),
(103, 'Siddhi', 'siddi@example.com', '345678901234', 1);

INSERT INTO course (course_id, course_name, dept_id) VALUES
(201, 'Database Systems', 1),
(202, 'Thermodynamics', 2),
(203, 'Digital Circuits', 3);

INSERT INTO enrollment (roll_no, course_id, semester, grade) VALUES
(101, 201, 3, 'A'),
(101, 203, 4, 'B'),
(102, 202, 3, 'A'),
(103, 201, 3, 'B');

INSERT INTO faculty VALUES
(201, 'Dr. Sharma', 'sharma@gmail.com', '9876543210', 1),
(202, 'Prof. Mehta', 'mehta@gmail.com', '9876543211', 2),
(203, 'Dr. Rao', 'rao@gmail.com', '9876543212', 3);
🧩 Normalization Analysis

The schema is normalized up to BCNF (Boyce-Codd Normal Form).

1NF — First Normal Form ✅

All columns hold atomic, single values with no repeating groups (e.g., student.email stores one email per row, not a list).

2NF — No Partial Dependency ✅

Relevant only to tables with composite keys. department, student, course, and faculty have single-column primary keys, so 2NF is automatic. enrollment has the composite key (roll_no, course_id, semester), and its only non-key column grade depends on the full key combination (a grade can differ per semester for the same student-course pair), satisfying 2NF.

3NF — No Transitive Dependency ✅

No non-key column depends on another non-key column:

student, course, and faculty reference dept_id (a foreign key) instead of duplicating dept_name, which avoids a transitive dependency like roll_no → dept_id → dept_name.
enrollment.grade depends directly on the full composite key, not on any other non-key attribute.
BCNF — Boyce-Codd Normal Form ✅

Every determinant in the schema is a candidate key:

Table	Functional Dependency	Determinant is a key?
department	dept_id → dept_name	✅
student	roll_no → name, email, aadhar_no, dept_id	✅
course	course_id → course_name, dept_id	✅
faculty	faculty_id → faculty_name, email, phone_no, dept_id	✅
enrollment	(roll_no, course_id, semester) → grade	✅

No BCNF violations exist since no non-key attribute determines any other attribute.

Design Highlights
Foreign keys instead of duplication — department names are stored once in department and referenced elsewhere via dept_id, eliminating redundancy.
Junction table for many-to-many relationships — enrollment correctly resolves the many-to-many relationship between student and course, with semester and grade as relationship attributes.
Constraints for data integrity — UNIQUE constraints on emails/aadhar/phone numbers, and a CHECK constraint ensuring semester stays between 1 and 8.
🛠️ Tech Stack
Database: MySQL
🚀 How to Run
bash
mysql -u root -p < college_demo.sql

Or run the statements directly in MySQL Workbench / CLI in the order: department → student → course → enrollment → faculty.

📄 License

This project is for educational purposes as part of coursework




E-Commerce Database (ecommerce_db)

A relational database schema for an e-commerce platform — covering customers, products, orders, payments, and reviews — built in MySQL.

📌 Overview

This project models a typical e-commerce backend with 9 interrelated tables, supporting customer management, multi-address shipping, supplier-linked product catalogs, order processing, payments, and product reviews.

🗂️ Schema Structure
Table	Description
Categories	Product categories (Electronics, Fashion, etc.)
Customers	Registered customer accounts
Addresses	Customer shipping addresses (one customer → many addresses)
Suppliers	Product suppliers/vendors
Products	Product catalog, linked to a category and supplier
Orders	Customer orders, linked to a customer and shipping address
Order_Items	Line items per order (many-to-many between Orders and Products)
Payments	Payment record per order (1-to-1 with Orders)
Reviews	Customer product reviews and ratings
Entity Relationship Summary
One customer → many addresses, orders, reviews
One category → many products
One supplier → many products
One order → many order items; one order → one payment
One product → many order items, many reviews
🏗️ Table Definitions
sql
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) UNIQUE,
    password VARCHAR(255) NOT NULL,
    gender ENUM('Male', 'Female', 'Other') DEFAULT 'Other',
    date_of_birth DATE,
    registered_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Addresses (
    address_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    address_line VARCHAR(150) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    pincode VARCHAR(10) NOT NULL,
    country VARCHAR(50) DEFAULT 'India',
    is_default BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(100) UNIQUE,
    contact_phone VARCHAR(15),
    address VARCHAR(150)
);

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    supplier_id INT,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    discount_percent DECIMAL(5,2) DEFAULT 0 CHECK (discount_percent BETWEEN 0 AND 100),
    stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    description TEXT,
    added_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    address_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    order_status ENUM('Pending','Confirmed','Shipped','Delivered','Cancelled') DEFAULT 'Pending',
    total_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (address_id) REFERENCES Addresses(address_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) GENERATED ALWAYS AS (quantity * unit_price) STORED,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL UNIQUE,
    payment_method ENUM('Credit Card','Debit Card','UPI','Net Banking','Cash on Delivery') NOT NULL,
    payment_status ENUM('Pending','Successful','Failed','Refunded') DEFAULT 'Pending',
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    amount_paid DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    customer_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

⚠️ Note: The seed data includes an INSERT INTO Cart statement, but no CREATE TABLE Cart is defined in this schema. Add a Cart table (e.g. cart_id, customer_id, product_id, quantity, with foreign keys to Customers and Products) before running that insert, or remove it if cart functionality isn't part of this version.

📊 Sample Data
sql
INSERT INTO Categories (category_name, description) VALUES
('Electronics', 'Gadgets, devices and accessories'),
('Fashion', 'Clothing, footwear and accessories'),
('Home & Kitchen', 'Furniture, decor and kitchen appliances'),
('Books', 'Fiction, non-fiction and academic books'),
('Sports', 'Sports gear and fitness equipment');

INSERT INTO Suppliers (supplier_name, contact_email, contact_phone, address) VALUES
('TechWorld Distributors', 'contact@techworld.com', '9876543210', 'Mumbai, Maharashtra'),
('FashionHub Pvt Ltd', 'sales@fashionhub.com', '9823456712', 'Nagpur, Maharashtra'),
('HomeEssentials Co', 'info@homeessentials.com', '9765432109', 'Pune, Maharashtra'),
('BookLand Publishers', 'orders@bookland.com', '9654321098', 'Delhi'),
('SportsGear Inc', 'support@sportsgear.com', '9543210987', 'Bengaluru, Karnataka');

INSERT INTO Customers (first_name, last_name, email, phone, password, gender, date_of_birth) VALUES
('Chaitanya', 'Deshmukh', 'chaitanya@example.com', '9000000001', 'hashed_pw_1', 'Male', '2003-05-14'),
('Parth', 'Salankar', 'parth@example.com', '9000000002', 'hashed_pw_2', 'Male', '2003-08-22'),
('Sneha', 'Kulkarni', 'sneha@example.com', '9000000003', 'hashed_pw_3', 'Female', '2002-11-10'),
('Rohan', 'Patil', 'rohan@example.com', '9000000004', 'hashed_pw_4', 'Male', '2001-02-28'),
('Ananya', 'Sharma', 'ananya@example.com', '9000000005', 'hashed_pw_5', 'Female', '2003-07-19');

INSERT INTO Addresses (customer_id, address_line, city, state, pincode, is_default) VALUES
(1, '12 MG Road', 'Akola', 'Maharashtra', '444001', TRUE),
(2, '45 Civil Lines', 'Nagpur', 'Maharashtra', '440001', TRUE),
(3, '78 FC Road', 'Pune', 'Maharashtra', '411005', TRUE),
(4, '23 Andheri West', 'Mumbai', 'Maharashtra', '400058', TRUE),
(5, '9 Sector 15', 'Chandigarh', 'Chandigarh', '160015', TRUE);

INSERT INTO Products (product_name, category_id, supplier_id, price, discount_percent, stock_quantity, description) VALUES
('Wireless Bluetooth Earbuds', 1, 1, 1999.00, 10.00, 150, 'Noise-cancelling wireless earbuds with 24hr battery'),
('Smartwatch Pro', 1, 1, 4999.00, 15.00, 80, 'Fitness tracking smartwatch with AMOLED display'),
('Men Casual Shirt', 2, 2, 899.00, 5.00, 200, '100% cotton casual shirt'),
('Women Running Shoes', 2, 2, 2499.00, 20.00, 120, 'Lightweight running shoes for daily training'),
('Non-Stick Cookware Set', 3, 3, 3499.00, 12.00, 60, '5-piece non-stick cookware set'),
('LED Table Lamp', 3, 3, 799.00, 0.00, 90, 'Adjustable brightness LED table lamp'),
('The Silent Patient (Novel)', 4, 4, 399.00, 8.00, 250, 'Bestselling psychological thriller'),
('DBMS Textbook', 4, 4, 650.00, 0.00, 100, 'Database Management Systems academic textbook'),
('Yoga Mat', 5, 5, 599.00, 10.00, 180, 'Anti-slip yoga mat 6mm thickness'),
('Dumbbell Set 10kg', 5, 5, 2199.00, 5.00, 70, 'Pair of rubber coated dumbbells');

INSERT INTO Orders (customer_id, address_id, order_status, total_amount) VALUES
(1, 1, 'Delivered', 6398.00),
(2, 2, 'Shipped', 899.00),
(3, 3, 'Pending', 3499.00),
(4, 4, 'Confirmed', 2499.00),
(1, 1, 'Delivered', 999.00);

INSERT INTO Order_Items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 2, 1999.00),
(1, 2, 1, 4999.00),
(2, 3, 1, 899.00),
(3, 5, 1, 3499.00),
(4, 4, 1, 2499.00),
(5, 7, 1, 399.00),
(5, 9, 1, 599.00);

INSERT INTO Payments (order_id, payment_method, payment_status, amount_paid) VALUES
(1, 'UPI', 'Successful', 6398.00),
(2, 'Credit Card', 'Successful', 899.00),
(3, 'Cash on Delivery', 'Pending', 3499.00),
(4, 'Debit Card', 'Successful', 2499.00),
(5, 'UPI', 'Successful', 998.00);
🧩 Normalization Analysis

The schema is normalized up to BCNF (Boyce-Codd Normal Form) for its transactional tables, with two intentional denormalized fields kept for practical/performance reasons (explained below).

1NF — First Normal Form ✅

Every column stores a single atomic value — no comma-separated lists or repeating groups anywhere (e.g., a customer's phone holds one number, not multiple).

2NF — No Partial Dependency ✅

Only relevant to tables with composite keys. Every table here uses a single-column surrogate primary key (category_id, customer_id, address_id, supplier_id, product_id, order_id, order_item_id, payment_id, review_id) — even Order_Items, which represents a many-to-many relationship, uses its own order_item_id rather than a composite (order_id, product_id) key. Since there are no composite keys, 2NF is automatically satisfied throughout.

3NF — No Transitive Dependency ✅

No non-key column depends on another non-key column instead of the primary key:

Addresses, Products, Orders, Reviews all reference related entities via foreign keys (customer_id, category_id, supplier_id, product_id) instead of duplicating descriptive data like category_name or customer_name.
Payments.order_id is UNIQUE, correctly modeling the 1-to-1 relationship with Orders without merging the two tables.
BCNF — Boyce-Codd Normal Form ✅

Every determinant is a candidate key:

Table	Functional Dependency	Determinant is a key?
Categories	category_id → category_name, description, created_at	✅
Customers	customer_id → first_name, ..., registered_on	✅
Addresses	address_id → customer_id, address_line, ...	✅
Suppliers	supplier_id → supplier_name, contact_email, ...	✅
Products	product_id → product_name, category_id, price, ...	✅
Orders	order_id → customer_id, address_id, order_status, ...	✅
Order_Items	order_item_id → order_id, product_id, quantity, unit_price	✅
Payments	payment_id → order_id, payment_method, ... (and order_id → payment_id since it's unique)	✅
Reviews	review_id → product_id, customer_id, rating, comment	✅

No non-key attribute in any table determines another non-key attribute, so there are no BCNF violations.

⚠️ Intentional Denormalization (design trade-offs, not normalization flaws)

Two fields technically hold values derivable from other tables, but they're kept deliberately for correctness and performance reasons, not by oversight:

Order_Items.unit_price — duplicates Products.price at the time of purchase. This is required, not a redundancy bug: Products.price can change over time, but an order must preserve the price the customer actually paid. Removing this column would corrupt historical order totals whenever a product's price changes.
Orders.total_amount — is the sum of quantity * unit_price across that order's Order_Items rows, so it's a derived/aggregate value rather than an independent fact. It's stored directly (rather than calculated via SUM() on every read) purely for query performance — a common and accepted denormalization in OLTP schemas. The trade-off: application logic must keep it in sync with Order_Items (e.g., recalculate on insert/update/delete of order items, or maintain via a trigger).
Design Highlights
Surrogate keys everywhere (AUTO_INCREMENT) keep joins simple and avoid composite-key complexity, even for the Order_Items bridge table.
ON DELETE policies are deliberately varied: CASCADE for dependent records that should disappear with their parent (e.g., a customer's addresses), RESTRICT for records that must not be deleted while referenced (e.g., a product still in an order), and SET NULL where the relationship is optional (e.g., a product's supplier).
CHECK constraints enforce domain integrity — non-negative prices/stock, ratings between 1–5, discount percentages between 0–100.
Generated column (Order_Items.subtotal) computes quantity * unit_price automatically via GENERATED ALWAYS AS ... STORED, avoiding a manually-maintained redundant field.
🛠️ Tech Stack
Database: MySQL
🚀 How to Run
bash
mysql -u root -p < ecommerce_db.sql

Or run the statements directly in MySQL Workbench / CLI in the order: Categories → Suppliers → Customers → Addresses → Products → Orders → Order_Items → Payments → Reviews.

🏥 Hospital Database Management System

A simple MySQL-based Hospital Database Management System designed to store and manage information about patients, doctors, appointments, and hospital admissions.

📌 Project Overview

This project demonstrates the use of MySQL relational databases, including:

Database and table creation
Primary and foreign keys
Relationships between tables
Data insertion
Basic SQL queries
🗂️ Database Structure

The database is named:

hospital_db
Tables
Table	Description
patients	Stores patient details
doctors	Stores doctor details
appointments	Stores patient appointments and consultation fees
admissions	Stores hospital admission and treatment details
🔗 Relationships
PATIENTS (1) ──────── (N) APPOINTMENTS (N) ──────── (1) DOCTORS
     │
     │ 1
     │
     │ N
ADMISSIONS
Foreign Keys
appointments.patient_id → patients.patient_id
appointments.doctor_id → doctors.doctor_id
admissions.patient_id → patients.patient_id
📋 Table Attributes
Patients
patient_id – Primary Key
patient_name – Patient name
gender – Gender
age – Age
city – City
registration_date – Registration date
Doctors
doctor_id – Primary Key
doctor_name – Doctor name
specialization – Medical specialization
department – Department
Appointments
appointment_id – Primary Key
patient_id – Foreign Key
doctor_id – Foreign Key
appointment_date – Appointment date
status – Appointment status
consultation_fee – Consultation fee
Admissions
admission_id – Primary Key
patient_id – Foreign Key
admission_date – Admission date
discharge_date – Discharge date
diagnosis – Patient diagnosis
treatment_cost – Treatment cost
⚙️ How to Run
Open MySQL Workbench or any MySQL client.
Run the database creation and table creation queries.
Insert the sample data.
Select the database:
USE hospital_db;
View the tables:
SELECT * FROM patients;
SELECT * FROM doctors;
SELECT * FROM appointments;
SELECT * FROM admissions;
⚠️ Note

The query:

SELECT * FROM medicines;

will produce an error because a medicines table has not been created in the current database.

🎯 Purpose

This project is suitable for learning and demonstrating SQL, MySQL, relational database design, primary keys, foreign keys, and ER modeling.

## Author

Copy righted by Chaitanya Deo 
