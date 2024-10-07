-- =============================================
-- Create Classes Table
-- =============================================

-- Create a classes table to store information about the number of students in each class.
-- The table is created by selecting distinct classID and counting the number of students in each class.
CREATE TABLE IF NOT EXISTS classes AS
SELECT classID, COUNT(*) AS `Number of Students`
FROM students
GROUP BY classID;

-- =============================================
-- ALTER TABLE Statements to Modify Data Types
-- =============================================

-- Modify the classID column in the classes table to be VARCHAR(5) and set as primary key
ALTER TABLE classes
MODIFY classID VARCHAR(5) NOT NULL,
ADD PRIMARY KEY (classID);

-- Modify the sessionID column in the sessions table to be VARCHAR(10) and set as primary key
ALTER TABLE sessions
MODIFY sessionID VARCHAR(10) NOT NULL,
ADD PRIMARY KEY (sessionID);

-- Modify the studentID column in the students table to be VARCHAR(10), set as primary key,
-- Modify classID to be VARCHAR(10), and add a foreign key constraint
ALTER TABLE students
MODIFY studentID VARCHAR(10) NOT NULL,
ADD PRIMARY KEY (studentID),
MODIFY classID VARCHAR(10) NOT NULL,
ADD FOREIGN KEY (classID) REFERENCES classes(classID);

-- Modify the subjectID column in the subjects table to be VARCHAR(10) and set as primary key
ALTER TABLE subjects
MODIFY subjectID VARCHAR(10) NOT NULL,
ADD PRIMARY KEY (subjectID);

-- Modify the scores table by dropping the existing primary key,
-- Modifying sessionID, studentID, and subjectID columns to be VARCHAR(10),
-- Add a new composite primary key, and foreign keys referencing other tables
ALTER TABLE scores
DROP PRIMARY KEY,
MODIFY SessionID VARCHAR(10) NOT NULL,
MODIFY StudentID VARCHAR(10) NOT NULL,
MODIFY SubjectID VARCHAR(10) NOT NULL,
ADD PRIMARY KEY (SessionID, StudentID, SubjectID),
ADD FOREIGN KEY (SessionID) REFERENCES sessions(SessionID),
ADD FOREIGN KEY (StudentID) REFERENCES students(StudentID),
ADD FOREIGN KEY (SubjectID) REFERENCES subjects(SubjectID);

-- =============================================
-- Create View for Class Average
-- =============================================

-- Create a view named class_average that stores the average scores for each class, for each subject.
-- This view is based on the scores table and calculates the average total score for each subject and class.
CREATE VIEW class_average AS
SELECT AVG(total) AS `Class Average`, subjectID, classID
FROM scores sc 
JOIN students st ON st.studentID = sc.studentID
GROUP BY subjectID, classID;

-- =============================================
-- Main Query to Retrieve Student Scores and Details
-- =============================================

-- This SELECT query retrieves detailed information about student scores, including averages 
-- and student details to be loaded into excel.
SELECT 
    sc.studentID,
    su.subjectID AS A,
    su.name AS Subjects,
    FirstCA AS `1ST ASS. 10%`,
    SecondCA AS `2ND ASS. 10%`,
    MIDTERM AS `MID-TERM TEST 20%`,
    EXAM AS `EXAMS 60%`,
    TOTAL AS `TOTAL`,
    grade AS `SUBJECT GRADE`,
    `CLASS AVERAGE`,
    age,
    `Number of Students`,
    st.name,
    RESUMPTION_DATE,
    gender,
    cl.classID,
    `SESSION NAME`
FROM scores sc
JOIN students st ON st.studentID = sc.studentID
JOIN classes cl ON cl.classID = st.classID
JOIN sessions se ON se.sessionID = sc.sessionID
JOIN subjects su ON su.subjectID = sc.subjectID
JOIN class_average ca ON ca.subjectID = sc.subjectID
    AND ca.classID = st.classID
ORDER BY sc.subjectID;