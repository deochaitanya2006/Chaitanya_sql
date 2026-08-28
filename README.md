Chaitanya_sql

SQL Practicals

MySQL database practicals covering schema design, constraints, relationships, normalization, and CRUD operations.

Contents

#

Database

Description

1

ecommerce_db

E-commerce platform — customers, products, orders, payments, and reviews

2

college_demo

College management — departments, students, courses, faculty, and enrollments

3

hospital_db

Hospital management — patients, doctors, appointments, and admissions

1. ecommerce_db

A relational database modeling a typical online store.

Tables: Categories, Customers, Addresses, Suppliers, Products, Orders, Order_Items, Payments, Reviews

Highlights:

Primary and foreign keys for relational integrity

ENUM and CHECK constraints for data validation

Generated Order_Items.subtotal column

Appropriate ON DELETE actions

Sample data included

Run:

mysql -u root -p < ecommerce_db.sql

2. college_demo

A college management database for departments, students, courses, faculty, and enrollments.

Tables: department, student, course, enrollment, faculty, employee

Highlights:

Composite primary key on enrollment

Foreign keys between related tables

CHECK constraint for semester values

UNIQUE constraints for email, Aadhaar, and phone numbers

Normalized relational design

Run:

mysql -u root -p < college_demo.sql

3. hospital_db

A simple MySQL-based Hospital Database Management System designed to manage patient, doctor, appointment, and hospital admission information.

📌 Overview

This project demonstrates:

Database and table creation

Primary and foreign keys

One-to-many relationships

Data insertion

Basic SQL queries

ER diagram and relational database design

🗂️ Tables

Table

Description

patients

Stores patient details

doctors

Stores doctor details and specialization

appointments

Stores appointments, doctors, patients, status, and consultation fees

admissions

Stores hospital admissions, diagnosis, discharge dates, and treatment costs

🔗 ER Relationship Summary

PATIENTS (1) ──────── (N) APPOINTMENTS (N) ──────── (1) DOCTORS
     │
     │ 1
     │
     │ N
ADMISSIONS

One patient can have many appointments.

One doctor can have many appointments.

One patient can have many admissions.

🔑 Foreign Keys

appointments.patient_id → patients.patient_id
appointments.doctor_id  → doctors.doctor_id
admissions.patient_id   → patients.patient_id

📋 Main Attributes

Patients

patient_id — Primary Key

patient_name

gender

age

city

registration_date

Doctors

doctor_id — Primary Key

doctor_name

specialization

department

Appointments

appointment_id — Primary Key

patient_id — Foreign Key

doctor_id — Foreign Key

appointment_date

status

consultation_fee

Admissions

admission_id — Primary Key

patient_id — Foreign Key

admission_date

discharge_date

diagnosis

treatment_cost

⚙️ How to Run

Open MySQL Workbench or MySQL CLI and run the SQL script in this order:

CREATE DATABASE hospital_db;
USE hospital_db;

Then create the tables and insert the sample data.

To view the tables:

SELECT * FROM patients;
SELECT * FROM doctors;
SELECT * FROM appointments;
SELECT * FROM admissions;

Note: SELECT * FROM medicines; is not valid for the current schema because a medicines table has not been created.

🎯 Purpose

This database is intended for educational use to demonstrate MySQL, relational database design, primary keys, foreign keys, relationships, and ER modeling.

Requirements

MySQL 8.0+

MySQL Workbench or MySQL CLI

General Usage

mysql -u root -p

Then run the required SQL file:

SOURCE path/to/script.sql;

🛠️ Tech Stack

Database: MySQL

📄 License

This project is for educational purposes and coursework.

👨‍💻 Author

Chaitanya Deo

Copyright © Chaitanya Deo
