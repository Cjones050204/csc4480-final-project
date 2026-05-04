-- drop tables

drop table gradebook;
drop table studentGrades;
drop table projects;
drop table quizzes;
drop table tests;
drop table homework;
drop table participation;
drop table gradeScale;
drop table sections;
drop table courses;
drop table professors;
drop table students;


-- create tables

create table students(
    studentID varchar2(6) primary key not null,
    firstName varchar2(12),
    lastName varchar2(15)
);

create table professors(
    profID varchar2(6) primary key not null,
    firstName varchar2(10),
    lastName varchar2(15)
);

create table courses(
    courseID varchar2(6) primary key not null,
    courseName varchar2(15),
    department varchar2(16),
    semester varchar2(6)
);

create table sections(
    CRN varchar2(5) primary key not null,
    courseID varchar2(6),
    profID varchar2(6)
);

create table gradeScale(
    profID varchar2(6),
    participation decimal(6,5),
    homework decimal(6,5),
    tests decimal(6,5),
    quizzes decimal(6,5),
    projects decimal(6,5)
);

-- school is 5 weeks long
create table participation(
    CRN varchar2(5),
    studentID varchar2(6),
    week1 decimal(6,5),
    week2 decimal(6,5),
    week3 decimal(6,5),
    week4 decimal(6,5),
    week5 decimal(6,5),
    participationFinal decimal(6,5)
);

-- limit: 3 hw
create table homework(
    CRN varchar2(5),
    studentID varchar2(6),
    homework1 decimal(6,5),
    homework2 decimal(6,5),
    homework3 decimal(6,5),
    homeworkFinal decimal(6,5)
);

-- limit: 2 tests
create table tests(
    CRN varchar2(5),
    studentID varchar2(6),
    test1 decimal(6,5),
    test2 decimal(6,5),
    testFinal decimal(6,5)
);

-- limit: 2 quizzes
create table quizzes(
    CRN varchar2(5),
    studentID varchar2(6),
    quiz1 decimal(6,5),
    quiz2 decimal(6,5),
    quizFinal decimal(6,5)
);

-- only 1 project allowed
create table projects(
    CRN varchar2(5),
    studentID varchar2(6),
    onlyProject decimal(6,5)
);

create table studentGrades(
    CRN varchar2(5),
    studentID varchar2(6),
    participation decimal(6,5),
    homework decimal(6,5),
    tests decimal(6,5),
    quizzes decimal(6,5),
    projects decimal(6,5),
    finalGrade decimal(6,5)
);

create table gradebook(
    studentID varchar2(6),
    CRN varchar2(5),
    finalLetterGrade varchar2(15)
);


-- adding foreign keys

alter table sections
    add foreign key (courseID) references courses(courseID);
alter table sections
    add foreign key (profID) references professors(profID);

alter table gradeBook
    add foreign key (studentID) references students(studentID);
alter table gradeBook
    add foreign key (CRN) references sections(CRN);

alter table gradeScale
    add foreign key (profID) references professors(profID);

alter table participation
    add foreign key (CRN) references sections(CRN);
alter table participation
    add foreign key (studentID) references students(studentID);

alter table homework
    add foreign key (CRN) references sections(CRN);
alter table homework
    add foreign key (studentID) references students(studentID);

alter table tests
    add foreign key (CRN) references sections(CRN);
alter table tests
    add foreign key (studentID) references students(studentID);

alter table quizzes
    add foreign key (CRN) references sections(CRN);
alter table quizzes
    add foreign key (studentID) references students(studentID);

alter table projects
    add foreign key (CRN) references sections(CRN);
alter table projects
    add foreign key (studentID) references students(studentID);

alter table studentGrades
    add foreign key (CRN) references sections(CRN);
alter table studentGrades
    add foreign key (studentID) references students(studentID);


-- insert values

insert into students values('CP1000', 'Clarence', 'Potente');
insert into students values('CJ2000', 'Christopher', 'Jones');
insert into students values('JA3000', 'John', 'Ahn');
insert into students values('AFW400', 'Antonio', 'Fiorentino Wong');
insert into students values('TD5000', 'Tommy', 'Duffy');
insert into students values('GS6000', 'Gurkirat', 'Singh');
select * from students;

insert into professors values('BS1001', 'Bob', 'Smith');
insert into professors values('ST2001', 'Samir', 'Tally');
insert into professors values('TS3001', 'Timothy', 'Scott');
insert into professors values('MJ4001', 'Mary', 'Jane');
select * from professors;

insert into courses values('CS1000', 'C++', 'CompSci', 'Fall');
insert into courses values('CS1001', 'Data Structures', 'CompSci', 'Spring');
insert into courses values('HS2004', 'World War II', 'History', 'Fall');
select * from courses;

insert into sections values('76317', 'CS1000', 'BS1001');
insert into sections values('76318', 'CS1000', 'ST2001');
insert into sections values('54626', 'HS2004', 'TS3001');
insert into sections values('76320', 'CS1001', 'MJ4001');
select * from sections;

insert into gradeScale values('BS1001', 0.05, 0.15, 0.40, 0.20, 0.20);
insert into gradeScale values('ST2001', 0.05, 0.10, 0.60, 0.15, 0.10);
insert into gradeScale values('TS3001', 0.40, 0.05, 0.35, 0.20, 0.00);
insert into gradeScale values('MJ4001', 0.20, 0.10, 0.00, 0.25, 0.50);
select * from gradeScale;

insert into participation values('76317', 'CP1000', 1.00, 0.95, 0.98, 0.95, 1.00, NULL);
insert into participation values('76317', 'AFW400', 0.85, 0.90, 0.00, 0.90, 1.00, NULL);
insert into participation values('76320', 'GS6000', 1.00, 1.00, 1.00, 1.00, 1.00, NULL);
update participation
    set participationFinal = (week1 + week2 + week3 + week4 + week5) / 5;

insert into homework values('76317', 'CP1000', 1.00, 1.00, 1.00, NULL);
insert into homework values('76317', 'AFW400', 0.95, 0.90, 0.80, NULL);
insert into homework values('76320', 'GS6000', 0.94, 0.78, 0.93, NULL);
update homework
    set homeworkFinal = (homework1 + homework2 + homework3) / 3;

insert into tests values('76317', 'CP1000', 0.98, 0.95, NULL);
insert into tests values('76317', 'AFW400', 0.95, 0.80, NULL);
insert into tests values('76320', 'GS6000', 0.99, 0.98, NULL);
update tests
    set testFinal = (test1 + test2) / 2;

insert into quizzes values('76317', 'CP1000', 0.95, 0.92, NULL);
insert into quizzes values('76317', 'AFW400', 0.87, 0.94, NULL);
insert into quizzes values('76320', 'GS6000', 0.91, 0.88, NULL);
update quizzes
    set quizFinal = (quiz1 + quiz2) / 2;

insert into projects values('76317', 'CP1000', 0.97);
insert into projects values('76317', 'AFW400', 0.89);
insert into projects values ('76320', 'GS6000', 0.92);

-- ============================================================
-- POPULATE ADDITIONAL DATA (added by Clarence Potente)
-- Enrolls CJ2000 and JA3000 into CS section 76318 (Samir Tally)
-- ============================================================

-- PARTICIPATION
insert into participation values('76318', 'CJ2000', 0.80, 0.73, 1.00, 0.93, 1.00, NULL);
insert into participation values('76318', 'JA3000', 1.00, 0.90, 0.89, 0.60, 1.00, NULL);
update participation
    set participationFinal = (week1 + week2 + week3 + week4 + week5) / 5
    where participationFinal is NULL;

-- HOMEWORK
insert into homework values('76318', 'CJ2000', 0.90, 0.80, 1.00, NULL);
insert into homework values('76318', 'JA3000', 0.95, 1.00, 0.92, NULL);
update homework
    set homeworkFinal = (homework1 + homework2 + homework3) / 3
    where homeworkFinal is NULL;

-- TESTS
insert into tests values('76318', 'CJ2000', 0.96, 0.90, NULL);
insert into tests values('76318', 'JA3000', 0.83, 0.90, NULL);
update tests
    set testFinal = (test1 + test2) / 2
    where testFinal is NULL;

-- QUIZZES
insert into quizzes values('76318', 'CJ2000', 0.75, 1.00, NULL);
insert into quizzes values('76318', 'JA3000', 0.80, 0.90, NULL);
update quizzes
    set quizFinal = (quiz1 + quiz2) / 2
    where quizFinal is NULL;

-- PROJECTS
insert into projects values('76318', 'CJ2000', 0.88);
insert into projects values('76318', 'JA3000', 0.79);


-- ============================================================
-- POPULATE ADDITIONAL DATA (added by Christopher Jones)
-- Enrolls CJ2000 and GS6000 into History section (54626)
-- Enrolls CP1000 into History section (54626)
-- Enrolls TD5000 into CS section 76317 (Bob Smith)
-- Enrolls GS6000 into CS section 76318 (Samir Tally)
-- ============================================================


-- PARTICIPATION

-- Section 54626 (History, TS3001)
insert into participation values('54626', 'TD5000', 0.90, 0.85, 0.95, 1.00, 0.88, NULL);
insert into participation values('54626', 'GS6000', 1.00, 0.95, 0.90, 0.85, 1.00, NULL);
insert into participation values('54626', 'CP1000', 0.75, 0.80, 0.85, 0.90, 0.70, NULL);

-- Section 76317 (C++, BS1001) - adding TD5000
insert into participation values('76317', 'TD5000', 0.60, 0.75, 0.80, 0.70, 0.65, NULL);

-- Section 76318 (C++, ST2001) - adding GS6000
insert into participation values('76318', 'GS6000', 0.95, 1.00, 0.90, 0.88, 0.92, NULL);

update participation
    set participationFinal = (week1 + week2 + week3 + week4 + week5) / 5
    where participationFinal is NULL;


-- HOMEWORK

-- Section 54626 (History) -- TS3001 only weights hw at 5%
insert into homework values('54626', 'TD5000', 0.88, 0.92, 0.79, NULL);
insert into homework values('54626', 'GS6000', 1.00, 0.95, 0.98, NULL);
insert into homework values('54626', 'CP1000', 0.70, 0.65, 0.80, NULL);

-- Section 76317 - TD5000
insert into homework values('76317', 'TD5000', 0.72, 0.68, 0.75, NULL);

-- Section 76318 - GS6000
insert into homework values('76318', 'GS6000', 0.88, 0.91, 0.95, NULL);

update homework
    set homeworkFinal = (homework1 + homework2 + homework3) / 3
    where homeworkFinal is NULL;


-- TESTS

-- Section 54626 (History)
insert into tests values('54626', 'TD5000', 0.78, 0.82, NULL);
insert into tests values('54626', 'GS6000', 0.91, 0.94, NULL);
insert into tests values('54626', 'CP1000', 0.65, 0.72, NULL);

-- Section 76317 - TD5000
insert into tests values('76317', 'TD5000', 0.70, 0.74, NULL);

-- Section 76318 - GS6000
insert into tests values('76318', 'GS6000', 0.89, 0.93, NULL);

update tests
    set testFinal = (test1 + test2) / 2
    where testFinal is NULL;


-- QUIZZES

-- Section 54626 (History)
insert into quizzes values('54626', 'TD5000', 0.80, 0.76, NULL);
insert into quizzes values('54626', 'GS6000', 0.93, 0.88, NULL);
insert into quizzes values('54626', 'CP1000', 0.60, 0.68, NULL);

-- Section 76317 - TD5000
insert into quizzes values('76317', 'TD5000', 0.65, 0.70, NULL);

-- Section 76318 - GS6000
insert into quizzes values('76318', 'GS6000', 0.85, 0.90, NULL);

update quizzes
    set quizFinal = (quiz1 + quiz2) / 2
    where quizFinal is NULL;


-- PROJECTS
-- Note: TS3001 weights projects at 0.00, but rows still inserted for completeness

-- Section 54626 (History)
insert into projects values('54626', 'TD5000', 0.83);
insert into projects values('54626', 'GS6000', 0.96);
insert into projects values('54626', 'CP1000', 0.74);

-- Section 76317 - TD5000
insert into projects values('76317', 'TD5000', 0.71);

-- Section 76318 - GS6000
insert into projects values('76318', 'GS6000', 0.92);

-- PRINT TABLES
select * from participation;
select * from homework;
select * from tests;
select * from quizzes;
select * from projects;

-- STUDENT GRADES
-- (john's work, read added comments for flow)
insert into studentGrades (CRN, studentID, participation, homework, tests, quizzes, projects) -- all of these values are basically variables for the final studentGrade tables
select sections.CRN,                                        -- goes into CRN
    participation.studentID,                                -- value is inserted into studentID^
    participation.participationFinal * gradeScale.participation, -- calculated values are inserted into participation
    homework.homeworkFinal * gradeScale.homework,           -- homework
    tests.testFinal * gradeScale.tests,                     -- tests
    quizzes.quizFinal * gradeScale.quizzes,                 -- quizzes
    projects.onlyProject * gradeScale.projects              -- projects
from sections, participation, gradeScale, homework, tests, quizzes, projects -- allows the usage of the data from these tables for the select above

-- the WHERE is important so duplicates or unwanted values aren't calculated

-- makes sure all CRN is accounted for, but problem is full cross-products
where sections.CRN = participation.CRN
and sections.CRN = homework.CRN
and sections.CRN = tests.CRN
and sections.CRN = quizzes.CRN
and sections.CRN = projects.CRN
-- makes sure studentID in each section/CRN is only mentioned once per assignment
and participation.studentID = homework.studentID
and participation.studentID = tests.studentID
and participation.studentID = quizzes.studentID
and participation.studentID = projects.studentID
and sections.profID = gradeScale.profID; -- links the professors grading scale to the sections

update studentGrades
    set finalGrade = (participation + homework + tests + quizzes + projects);
select * from studentGrades;


-- GRADEBOOK
-- Converts finalGrade to GPA points: A(>=0.90)=4.00, B(>=0.80)=3.00,
-- C(>=0.70)=2.00, D(>=0.60)=1.00, F(<0.60)=0.00

insert into gradebook (studentID, CRN, finalLetterGrade)
select studentID, CRN,
    case
        when finalGrade >= 0.94 then 'A'
        when finalGrade >= 0.90 then 'A-'
        when finalGrade >= 0.87 then 'B+'
        when finalGrade >= 0.84 then 'B'
        when finalGrade >= 0.80 then 'B-'
        when finalGrade >= 0.77 then 'C+'
        when finalGrade >= 0.74 then 'C'
        when finalGrade >= 0.70 then 'C-'
        when finalGrade >= 0.67 then 'D+'
        when finalGrade >= 0.64 then 'D'
        when finalGrade >= 0.60 then 'D-'
        else 'F'
    end
from studentGrades;

select * from gradebook;

-- COMMANDS
-- Create
    insert into students values ('AB7000', 'Alice', 'Brown');
-- Read
    select * from students where studentID = 'AB7000';
-- Update
    update students set lastName = 'Green' where studentID = 'AB7000';
    select * from students where studentID = 'AB7000';

    select * from quizzes where studentID = 'CJ2000' and CRN = '76318';
    update quizzes
    set quiz1 = 0.92
    where studentID = 'CJ2000' and CRN = '76318';
    
-- CALCULATE FINAL GRADES AGAIN
update participation
    set participationFinal = (week1 + week2 + week3 + week4 + week5) / 5;

update homework
    set homeworkFinal = (homework1 + homework2 + homework3) / 3;

update tests
    set testFinal = (test1 + test2) / 2;

update quizzes
    set quizFinal = (quiz1 + quiz2) / 2;

update studentGrades
    set finalGrade = (participation + homework + tests + quizzes + projects);

-- SHOW UPDATED GRADE
select * from quizzes where studentID = 'CJ2000' and CRN = '76318';