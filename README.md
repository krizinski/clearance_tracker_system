Student Clearance Tracking System
A database-driven web application that digitizes the student clearance process for graduating Senior High and College students — replacing manual, paper-based clearance forms with a centralized online system.

----------Overview-----------

The system allows:
Students to track their clearance status in real time across all required offices.
Office staff to approve or reject clearance requests digitally.
Admins to monitor overall progress and generate reports.

It solves common problems with the manual process: long queues during clearance season, lost or misplaced forms, no real-time status visibility, and error-prone manual record-keeping.

---------Architecture----------
The system follows a classic three-tier architecture:
LayerRoleTechnologyPresentation LayerFrontend / UIHTML, CSS, JavaScriptApplication LayerBackend / Business LogicPHP (Laravel) or Python (Django)Data LayerDatabaseMySQL
Note: Pick one backend stack (PHP/Laravel or Python/Django) — not both.


-------Database Design-----------
The database (clearance_db) consists of three core tables:
students — student records (who needs clearance).
requirements — offices/requirements that must be cleared.
status / remarks — links students to requirements, tracking approval state and staff remarks.

Includes stored procedures covering full CRUD operations and sample seed data for testing.

--------------Getting Started----------
Prerequisites
XAMPP (bundles MySQL + Apache + phpMyAdmin)
A code editor (e.g. VS Code)
PHP or Python environment depending on chosen backend stack

------------Setup----------------

Install and start XAMPP; launch MySQL and Apache from the control panel.
Open phpMyAdmin at http://localhost/phpmyadmin.
Run the provided SQL script (clearance_system.sql) in the SQL tab to create the database, tables, stored procedures, and sample data.
Test the stored procedures to confirm CRUD operations work.
Set up the backend (PHP/Laravel or Python/Django) to connect to clearance_db.
Build/connect the frontend pages (student login, clearance status view, staff approval page, admin dashboard).

-------------Project Modules----------
Student Portal — login, view clearance status per office (cleared/pending indicators).
Staff Portal — approve/reject clearance requests per office.
Admin Dashboard — monitor all students' progress, generate reports.


----------------Status--------------
This project is under active development as part of a course requirement (prelim/midterm deliverables).
