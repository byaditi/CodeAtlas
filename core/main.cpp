#include <limits>
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
    cout << "                 CODEATLAS\n";
    cout << "       RDBMS Learning & Analytics\n";
    cout << "========================================\n";
    cout << "1. Project Overview\n";
    cout << "2. Database Design and Modelling\n";
    cout << "3. Run MySQL Report\n";
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
void displayResult(mysqlx::SqlResult& result) {
    unsigned int columns = result.getColumnCount();
    if (columns == 0) {
        cout << "Query executed successfully.\n";
        return;
    }
    for (unsigned int i = 0; i < columns; i++) {
        cout << result.getColumn(i).getColumnLabel();
        if (i + 1 < columns) cout << " | ";
    }
    cout << '\n';
    for (unsigned int i = 0; i < columns; i++) {
        cout << "----------------";
        if (i + 1 < columns) cout << "-+-";
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
    if (rowCount == 0) cout << "No records found.\n";
    else cout << "\nTotal records: " << rowCount << '\n';
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
    int choice = -1;
    try {
        mysqlx::Session session("127.0.0.1", 33060, "root", "");
        session.sql("USE CodeAtlas").execute();
        while (choice != 0) {
            cout << "\n========== Database Design and Modelling ==========\n";
            cout << "1. Show all tables\n";
            cout << "2. Describe a table\n";
            cout << "3. Show primary keys\n";
            cout << "4. Show foreign key relationships\n";
            cout << "5. Show database views\n";
            cout << "0. Back to Main Menu\n";
            cout << "Choose an option: ";
            choice = getChoice();

            switch (choice) {
                case 1: {
                    mysqlx::SqlResult result = session.sql(
                        "SELECT table_name "
                        "FROM information_schema.tables "
                        "WHERE table_schema = 'CodeAtlas' "
                        "AND table_type = 'BASE TABLE' "
                        "ORDER BY table_name"
                    ).execute();
                    displayResult(result);
                    break;
                }
                case 2: {
                    string tableName;
                    cout << "Enter table name: ";
                    cin >> tableName;
                    mysqlx::SqlResult result = session.sql(
                        "SELECT column_name, column_type, is_nullable, "
                        "column_key, column_default "
                        "FROM information_schema.columns "
                        "WHERE table_schema = 'CodeAtlas' "
                        "AND table_name = ? "
                        "ORDER BY ordinal_position"
                    ).bind(tableName).execute();
                    displayResult(result);
                    break;
                }
                case 3: {
                    mysqlx::SqlResult result = session.sql(
                        "SELECT table_name, column_name "
                        "FROM information_schema.key_column_usage "
                        "WHERE table_schema = 'CodeAtlas' "
                        "AND constraint_name = 'PRIMARY' "
                        "ORDER BY table_name, ordinal_position"
                    ).execute();
                    displayResult(result);
                    break;
                }
                case 4: {
                    mysqlx::SqlResult result = session.sql(
                        "SELECT table_name, column_name, "
                        "referenced_table_name, referenced_column_name "
                        "FROM information_schema.key_column_usage "
                        "WHERE table_schema = 'CodeAtlas' "
                        "AND referenced_table_name IS NOT NULL "
                        "ORDER BY table_name"
                    ).execute();

                    displayResult(result);
                    break;
                }
                case 5: {
                    mysqlx::SqlResult result = session.sql(
                        "SELECT table_name "
                        "FROM information_schema.views "
                        "WHERE table_schema = 'CodeAtlas' "
                        "ORDER BY table_name"
                    ).execute();
                    displayResult(result);
                    break;
                }
                case 0:
                    cout << "Returning to main menu...\n";
                    break;
                default:
                    cout << "Invalid choice. Try again.\n";
            }
        }
        session.close();
    }
    catch (const mysqlx::Error& error) {
        cout << "\nMySQL error: " << error.what() << '\n';
    }
    catch (const exception& error) {
        cout << "\nError: " << error.what() << '\n';
    }
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
// ---------------- PROJECT OVERVIEW ----------------
void projectOverviewMenu() {
    try {
        mysqlx::Session session("127.0.0.1", 33060, "root", "");
        session.sql("USE CodeAtlas").execute();
        cout << "\n========== CodeAtlas Project Overview ==========\n";
        mysqlx::SqlResult result = session.sql(
            "SELECT "
            "(SELECT COUNT(*) FROM users) AS total_users, "
            "(SELECT COUNT(*) FROM platforms) AS total_platforms, "
            "(SELECT COUNT(*) FROM problems) AS total_problems, "
            "(SELECT COUNT(*) FROM contests) AS total_contests, "
            "(SELECT COUNT(*) FROM submissions) AS total_submissions, "
            "(SELECT COUNT(*) FROM information_schema.tables "
            "WHERE table_schema = 'CodeAtlas' "
            "AND table_type = 'BASE TABLE') AS total_tables, "
            "(SELECT COUNT(*) FROM information_schema.views "
            "WHERE table_schema = 'CodeAtlas') AS total_views"
        ).execute();
        cout << "\nLive database statistics:\n";
        displayResult(result);
        session.close();
    }
    catch (const mysqlx::Error& error) {
        cout << "\nMySQL error: " << error.what() << '\n';
    }
    catch (const exception& error) {
        cout << "\nError: " << error.what() << '\n';
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
                projectOverviewMenu();
                break;
            case 2:
                databaseDesignMenu();
                break;
            case 3:
                if (!runDatabaseReport()) choice = 0;
                break;
            case 0:
                cout << "\nExiting CodeAtlas. Goodbye!\n";
                break;
            default:
                cout << "\nInvalid choice. Enter a number from 0 to 3.\n";
        }
    }

    return 0;
}
