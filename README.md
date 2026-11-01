# CodeAtlas – Competitive Programming Database

CodeAtlas is an RDBMS mini-project made using **C++, MySQL and MySQL Connector/C++**.

The main idea of this project is to store and manage competitive programming data from platforms like Codeforces, AtCoder and LeetCode in a structured database.

It stores information about users, platforms, problems, contests, submissions, programming languages and verdicts. It also includes different SQL queries and database objects to demonstrate the concepts learned in DBMS.

## Technologies Used

- C++
- MySQL
- MySQL Connector/C++
- CMake
## Environment Setup

### Required Dependencies

Make sure the following dependencies are installed before building the project:

| Dependency | Purpose |
|---|---|
| C++ Compiler (Clang/GCC) | Compiles the C++ source code |
| CMake (3.20 or above) | Configures and builds the project |
| MySQL Server | Stores and manages the project database |
| MySQL Connector/C++ | Connects the C++ application to MySQL |
| OpenSSL 3 | Required by the MySQL Connector/C++ setup |
| Git | Clones the project repository |

### macOS

If you are using macOS, you can install the required dependencies using Homebrew:

```bash
brew install cmake mysql mysql-connector-c++ openssl@3
```

Make sure that your C++ compiler and MySQL server are available.

Start the MySQL server before building and executing the project.

### Windows and Linux

Homebrew is a package manager primarily used on macOS (it also supports Linux). Windows users can install the required dependencies using suitable package managers or install them manually.

The `CMakeLists.txt` file currently contains local Homebrew paths for MySQL Connector/C++ and OpenSSL. If you are using another operating system, you will need to update these paths according to your installation.

**Note:** The project has currently been configured and tested in a macOS environment. Setup on Windows and Linux may require additional configuration.
## Features

### 1. Database Design
- Created relational tables for storing project data.
- Used primary keys and foreign keys.
- Added constraints like UNIQUE, NOT NULL and CHECK.
- Designed relationships between different tables.

### 2. SQL Operations
The project includes different SQL operations such as:

- CREATE, ALTER, DROP and TRUNCATE
- INSERT, UPDATE and DELETE
- SELECT queries
- Aggregate functions
- GROUP BY and HAVING
- Joins
- Nested queries and subqueries
- UNION

### 3. Views

The project contains three views:

- `problem_platform_view`
- `user_submission_view`
- `accepted_submissions_view`

### 4. Indexes

The following indexes are created:

- `idx_problem_name`
- `idx_submission_user`
- `idx_submission_user_date`

### 5. Stored Procedures

Three stored procedures are implemented:

- `get_all_users()`
- `get_problems_by_difficulty(p_difficulty)`
- `get_user_submissions(p_user_id)`

### 6. Triggers

The project includes three triggers:

- `before_submission_insert`
- `after_submission_insert`
- `before_rating_update`

These are used for validation and maintaining submission audit records.

### 7. Transactions and Security

SQL examples are included for:

- COMMIT
- ROLLBACK
- SAVEPOINT
- GRANT
- REVOKE

## Database Tables

The database contains 12 main tables and one additional audit table.

| Table Name | Purpose |
|---|---|
| users | Stores user details |
| platforms | Stores platform details |
| platform_accounts | Stores users' platform accounts |
| problems | Stores programming problems |
| tag | Stores problem topics |
| problem_tag | Connects problems with tags |
| contests | Stores contest details |
| contest_problem | Connects contests with problems |
| contest_participation | Stores contest participation |
| languages | Stores programming languages |
| verdicts | Stores submission verdicts |
| submissions | Stores submission details |
| submission_audit | Stores submission audit records |

## Analytics Reports

The project includes 10 SQL reports:

1. Platform-wise Problem Counts
2. Submission Verdict Distribution
3. User Submission Activity
4. Most Attempted Problems
5. Platform Acceptance Rates
6. Programming Language Usage
7. Contest Participation Summary
8. Problems by Difficulty
9. Topic-wise Problem Counts
10. Active Users

## C++ Application

The project has a menu-driven C++ application connected to MySQL.

The main menu contains three options:

```text
========================================
                 CODEATLAS
       RDBMS Learning & Analytics
========================================
1. Project Overview
2. Database Design and Modelling
3. Run MySQL Report
0. Exit
========================================
```

**Project Overview:** Shows the current database statistics, such as total users, platforms, problems, contests, submissions, tables and views.

**Database Design and Modelling:** Allows us to view all tables, check table structures, see primary keys, foreign-key relationships and database views.

**Run MySQL Report:** Allows us to select and execute any of the 10 predefined analytical reports.

## Project Structure

```text
CodeAtlas/
│
├── core/
│   └── main.cpp
│
├── sql/
│   ├── 01_create_table.sql
│   ├── 02_constraints.sql
│   ├── 03_alter_operations.sql
│   ├── 04_seed_data.sql
│   ├── 05_dml_operations.sql
│   ├── 06_joins.sql
│   ├── 07_subqueries.sql
│   ├── 08_views.sql
│   ├── 09_indexes.sql
│   ├── 10_transactions.sql
│   ├── 11_privileges.sql
│   ├── 12_procedures.sql
│   ├── 13_triggers.sql
│   ├── 14_reports.sql
│   └── 15_final_verification.sql
│
├── build/
├── .vscode/
├── CMakeLists.txt
├── .gitignore
└── README.md
```

## How to Run the Project

### 1. Requirements

Make sure you have:

- C++ compiler
- CMake 3.20 or later
- MySQL Server
- MySQL Connector/C++
- OpenSSL

### 2. Clone the Repository

```bash
git clone <https://github.com/byaditi/CodeAtlas.git>
cd CodeAtlas
```

### 3. Set Up the Database

Start MySQL and execute the SQL files from the `sql` folder.

Start with:

1. `01_create_table.sql`
2. `02_constraints.sql`
3. `03_alter_operations.sql`
4. `04_seed_data.sql`

Then execute the remaining SQL files according to their purpose to create views, indexes, procedures, triggers and reports.

### 4. Database Connection

The project currently uses the following MySQL connection:

```cpp
mysqlx::Session session(
    "127.0.0.1",
    33060,
    "root",
    ""
);
```

Change the username, password or port if your MySQL configuration is different.

### 5. Build the Project

```bash
cmake -S . -B build
cmake --build build
```

### 6. Run

```bash
./build/CodeAtlas
```


---

This project was developed as part of learning and implementing different RDBMS concepts.

> **To-do (hopefully):** I will try building my own database from scratch instead of using mysql workbench, just to understand how everything actually works behind the scenes.
