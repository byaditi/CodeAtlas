
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <stdexcept>
#include <vector>
#include <algorithm>
#include <cctype>

#include <mysqlx/xdevapi.h>
using namespace std;
// ---------------- MAIN MENU ----------------

void showMenu() {
    cout << "\n========================================\n";
    cout << "                 CodeAtlas\n";
    cout << "       RDBMS Learning & Analytics\n";
    cout << "========================================\n";
    cout << "1. Project Overview\n";
    cout << "2. Database Design and Modelling\n";
    cout << "3. SQL Queries and Operations\n";
    cout << "4. Database Objects and Stored Programs\n";
    cout << "5. Transactions and Security\n";
    cout << "6. Advanced DBMS Concepts\n";
    cout << "7. Run MySQL Report\n";
    cout << "0. Exit\n";
    cout << "----------------------------------------\n";
    cout << "Choose an option: ";
}

// ---------------- SUBMENU HELPER ----------------

int getChoice() {
    int choice;
    if (!(cin >> choice)) {
        cin.clear();
        cin.ignore(10000, '\n');
        return -1;
    }
    return choice;
}
void showTopics(const string& title, const string topics[],int count, const string& sqlFile) {
    int choice = -1;
    while (choice != 0) {
        cout << "\n========== " << title << " ==========\n";
        for (int i = 0; i < count; i++) {
            cout << i + 1 << ". " << topics[i] << "\n";
        }
        cout << "0. Back to Main Menu\n";
        cout << "Choose a topic: ";
        choice = getChoice();

        if (choice >= 1 && choice <= count) {
            cout << "\nTopic: " << topics[choice - 1] << "\n";
            cout << "Related SQL files: " << sqlFile << "\n";
            cout << "Use these files to study or run the relevant SQL "
                    "examples in MySQL Workbench.\n";
        }
        else if (choice == 0) {
            cout << "Returning to main menu...\n";
        }
        else {
            cout << "Invalid choice. Please try again.\n";
        }
    }
}

// ---------------- DATABASE DESIGN ----------------

void databaseDesignMenu() {
    const string topics[] = {
        "Introduction to DBMS and Database Concepts",
        "Data Models and Relational Model",
        "Entity-Relationship (ER) Modelling",
        "ER-to-Relational Model Conversion",
        "Relational Schema Design",
        "Normalization: 1NF, 2NF, 3NF and BCNF",
        "Keys and Integrity Constraints",
        "Database Schema Creation (DDL)"
    };
    showTopics(
        "Database Design and Modelling",
        topics,
        8,
        "sql/01_create_table.sql, sql/02_constraints.sql, "
        "sql/03_alter_operations.sql"
    );
}
// ---------------- SQL QUERIES ----------------
void sqlQueriesMenu() {
    const string topics[] = {
        "DDL: CREATE, ALTER, DROP and TRUNCATE",
        "DML: INSERT, UPDATE and DELETE",
        "Basic SELECT Queries and WHERE",
        "Aggregate Functions: COUNT, SUM, AVG, MIN, MAX",
        "GROUP BY and HAVING",
        "INNER JOIN and OUTER JOINS",
        "Nested Queries and Subqueries",
        "Set Operations",
        "ORDER BY and DISTINCT",
        "Competitive Programming Analytics Queries"
    };
    showTopics(
        "SQL Queries and Operations",
        topics,
        10,
        "sql/03_alter_operations.sql, sql/05_dml_operations.sql, "
        "sql/06_joins.sql, sql/07_subqueries.sql, sql/14_reports.sql"
    );
}

// ---------------- DATABASE OBJECTS ----------------
void databaseObjectsMenu() {
    const string topics[] = {
        "Views",
        "Indexes and Query Optimization",
        "Stored Procedures",
        "Triggers",
        "MySQL Stored Programs and Database Programming"
    };
    showTopics(
        "Database Objects and Stored Programs",
        topics,
        5,
        "sql/08_views.sql, sql/09_indexes.sql, "
        "sql/12_procedures.sql, sql/13_triggers.sql"
    );
}
// ---------------- TRANSACTIONS AND SECURITY ----------------
void transactionsMenu() {
    const string topics[] = {
        "ACID Properties",
        "Transaction Control: COMMIT and ROLLBACK",
        "SAVEPOINT",
        "Transaction Schedules",
        "Conflict Serializability",
        "Concurrency Control and Locking",
        "Database Recovery",
        "User Privileges: GRANT and REVOKE"
    };
    showTopics(
        "Transactions and Security",
        topics,
        8,
        "sql/10_transactions.sql, sql/11_privileges.sql"
    );
}
// ---------------- ADVANCED DBMS ----------------
void advancedDBMSMenu() {
    const string topics[] = {
        "Indexing and B+ Trees",
        "Query Processing and Optimization",
        "Distributed Databases",
        "Database Failure and Recovery Techniques",
        "Concurrency Problems",
        "Introduction to NoSQL",
        "Relational Databases vs NoSQL",
        "Real-World Database Applications"
    };
    showTopics(
        "Advanced DBMS Concepts",
        topics,
        8,
        "See the relevant examples in the sql/ directory"
    );
}
// ---------------- SQL FILE READER ----------------
string readSQLFile(const string& filePath) {
    ifstream file(filePath);
    if (!file.is_open()) {
        throw runtime_error("Could not open SQL file: " + filePath);
    }
    stringstream buffer;
    buffer << file.rdbuf();
    return buffer.str();
}
// ---------------- SQL QUERY SPLITTER ----------------
// Separates individual SQL statements from the combined reports file.
vector<string> splitSQLStatements(const string& sql) {
    vector<string> queries;
    istringstream input(sql);
    string line;
    string statement;
    while (getline(input, line)) {
        // Skip full-line SQL comments.
        string trimmed = line;
        trimmed.erase(
            trimmed.begin(),
            find_if(trimmed.begin(), trimmed.end(),[](unsigned char ch) { return !isspace(ch); })
        );
        if (trimmed.empty() || trimmed.rfind("--", 0) == 0) {
            continue;
        }
        statement += line + "\n";
        size_t position;

        while ((position = statement.find(';')) != string::npos) {
            string query = statement.substr(0, position);
            query.erase(
                query.begin(),
                find_if(query.begin(), query.end(),
                        [](unsigned char ch) { return !isspace(ch); })
            );
            query.erase(
                find_if(query.rbegin(), query.rend(),
                        [](unsigned char ch) { return !isspace(ch); }).base(),
                query.end()
            );
            string lowerQuery = query;
            transform(
                lowerQuery.begin(),
                lowerQuery.end(),
                lowerQuery.begin(),
                [](unsigned char ch) { return tolower(ch); }
            );
            // Ignore USE statements because the database is selected in C++.
            if (!query.empty() && lowerQuery.rfind("use ", 0) != 0) {
                queries.push_back(query);
            }
            statement = statement.substr(position + 1);
        }
    }
    return queries;
}

// ---------------- RUN DATABASE REPORT ----------------

// Returns true when the user chooses Main Menu, false when they choose Exit.

bool runDatabaseReport() {
    const string reportNames[] = {
        "Platform-wise Problem Counts",
        "Submission Verdict Distribution",
        "User Submission Activity",
        "Most Attempted Problems",
        "Platform Acceptance Rates",
        "Programming Language Usage",
        "Contest Participation Summary",
        "Problems by Difficulty",
        "Topic-wise Problem Counts",
        "Active Users"
    };
    int choice = -1;
    while (true) {
        cout << "\n========== CodeAtlas Analytics ==========\n";
        for (int i = 0; i < 10; i++) {
            cout << i + 1 << ". " << reportNames[i] << '\n';
        }
        cout << "11. Main Menu\n";
        cout << "0. Exit CodeAtlas\n";
        cout << "-----------------------------------------\n";
        cout << "Choose a report: ";

        choice = getChoice();

        if (choice == 11) {
            cout << "Returning to main menu...\n";
            return true;
        }
        if (choice == 0) {
            cout << "Exiting CodeAtlas. Goodbye!\n";
            return false;
        }
        if (choice < 1 || choice > 10) {
            cout << "Invalid choice. Please choose 1-11 or 0 to exit.\n";
            continue;
        }
        try {
            // Read all report queries from the combined SQL file.
            string sqlContent = readSQLFile("sql/14_reports.sql");
            vector<string> queries = splitSQLStatements(sqlContent);
            if (queries.size() < 10) {
                throw runtime_error(
                    "Expected 10 report queries in sql/14_reports.sql, "
                    "but found only " + to_string(queries.size()) + "."
                );
            }
            cout << "\nSelected report: " << reportNames[choice - 1] << '\n';

            // Connect using MySQL X Protocol.
            mysqlx::Session session(
                "127.0.0.1",
                33060,
                "root",
                ""
            );
            session.sql("USE CodeAtlas").execute();
            cout << "\nConnected to CodeAtlas successfully!\n";
            cout << "\n========== Report Results ==========\n";
            // Execute only the selected report query.
            mysqlx::SqlResult result =
                session.sql(queries[choice - 1]).execute();
            unsigned int columns = result.getColumnCount();
            if (columns == 0) {
                cout << "Query executed successfully.\n";
            }
            else {
                for (unsigned int i = 0; i < columns; i++) {
                    cout << result.getColumn(i).getColumnLabel();

                    if (i + 1 < columns) cout << " | ";
                }
                cout << '\n';

                for (unsigned int i = 0; i < columns; i++) {
                    cout << "----------------";
                    if (i + 1 < columns) {
                        cout << "-+-";
                    }
                }
                cout << '\n';
                int rowCount = 0;
                for (mysqlx::Row row : result) {
                    for (unsigned int i = 0; i < columns; i++) {
                        if (row[i].isNull()) cout << "NULL";
                        else cout << row[i];
                        if (i + 1 < columns) cout << " | ";
                    }
                    cout << '\n';
                    rowCount++;
                }
                if (rowCount == 0) {
                    cout << "No records found for this report.\n";
                }
                else {
                    cout << "\nTotal rows: " << rowCount << '\n';
                }
            }
            cout << "====================================\n";
            session.close();
        }
        catch (const mysqlx::Error& error) {
            cerr << "\nMySQL error: " << error.what() << '\n';
        }
        catch (const exception& error) {
            cerr << "\nError: " << error.what() << '\n';
        }
    }
}

// ---------------- MAIN PROGRAM ----------------

int main() {
    int choice = -1;
    while (choice != 0) {
        showMenu();
        choice = getChoice();
        switch (choice) {
            case 1:
                cout << "\nCodeAtlas is a competitive programming "
                        "database and analytics project.\n";
                cout << "It organizes platforms, users, problems, "
                        "contests and submissions.\n";
                cout << "The project demonstrates concepts from "
                        "the RDBMS syllabus.\n";
                break;
            case 2:
                databaseDesignMenu();
                break;
            case 3:
                sqlQueriesMenu();
                break;
            case 4:
                databaseObjectsMenu();
                break;
            case 5:
                transactionsMenu();
                break;
            case 6:
                advancedDBMSMenu();
                break;
            case 7:
                if (!runDatabaseReport()) {
                    choice = 0;
                }
                break;
            case 0:
                cout << "\nExiting CodeAtlas. Goodbye!\n";
                break;
            default:
                cout << "\nInvalid choice. Enter a number from 0 to 7.\n";
        }
    }

    return 0;
}
