# CSC 4480 – Final Project: Student Gradebook
**Spring 2026** | Clarence Potente, Christopher Jones, John Ahn

---

## Project Summary

This project implements a relational database system that models a professor's gradebook. It tracks students enrolled across multiple course sections, records their scores across assignment categories (participation, homework, tests, quizzes, and projects), applies each professor's custom grade weighting, and computes final grades for every student.

---

## Database Schema Overview

| Table | Description |
|---|---|
| `students` | Student records (ID, first/last name) |
| `professors` | Professor records (ID, first/last name) |
| `courses` | Course catalog (ID, name, department, semester) |
| `sections` | Links a course to a professor via CRN |
| `gradeScale` | Per-professor category weights (must sum to 100%) |
| `participation` | Weekly participation scores per student per section |
| `homework` | Up to 3 homework scores per student per section |
| `tests` | Up to 2 test scores per student per section |
| `quizzes` | Up to 2 quiz scores per student per section |
| `projects` | One project score per student per section |
| `studentGrades` | Weighted category scores and computed final grade |
| `gradebook` | Final GPA-point letter grade per student per section |

---

## How to Run

### Requirements
- Oracle SQL (or any SQL environment compatible with `varchar2` and `decimal` types)
- Access to a SQL client (e.g. Oracle SQL Developer, SQL*Plus, or a browser-based Oracle tool)

### Steps

1. **Clone the repository**
   ```
   git clone <your-repo-url>
   cd <repo-folder>
   ```

2. **Open your SQL client** and connect to your database instance.

3. **Run the script**
   - Open `gradebook.sql` in your SQL client
   - Execute the entire file from top to bottom
   - The script will:
     1. Drop any existing tables (safe to re-run)
     2. Create all tables with appropriate constraints and foreign keys
     3. Insert all sample data
     4. Compute weighted grades and populate `studentGrades`
     5. Populate the `gradebook` with final GPA-point grades

4. **Verify output** — the script includes `select *` statements throughout so you can confirm each table is populated correctly as it runs.

---

## Sample Data

The database is pre-populated with the following:

- **6 students:** Clarence Potente, Christopher Jones, John Ahn, Antonio Fiorentino Wong, Tommy Duffy, Gurkirat Singh
- **4 professors:** Bob Smith, Samir Tally, Timothy Scott, Mary Jane
- **3 courses:** C++ (CompSci), Data Structures (CompSci), World War II (History)
- **3 sections:** CRN 76317 (C++/Smith), CRN 76318 (C++/Tally), CRN 54626 (History/Scott)

Each professor uses a different grade weighting. For example:
- Prof. Smith: 5% participation, 15% homework, 40% tests, 20% quizzes, 20% projects
- Prof. Scott: 40% participation, 5% homework, 35% tests, 20% quizzes, 0% projects

---

## Grading Scale

The grading scale for the `gradebook` table:

| Grade | Minimum Score |
|---|---|
| A | 94% |
| A- | 90% |
| B+ | 87% |
| B | 84% |
| B- | 80% |
| C+ | 77% |
| C | 74% |
| C- | 70% |
| D+ | 67% |
| D | 64% |
| D- | 60% |
| F | Below 60% |

---

## Contributors

| Name | Contributions |
|---|---|
| Clarence Potente | Table creation, foreign keys, grade scale setup, studentGrades insert logic |
| John Ahn | studentGrades query design and inline documentation |
| Christopher Jones | Additional data population (History section, remaining student enrollments), gradebook final grade computation, gradeScale primary key fix, recalculate block fix, README |
