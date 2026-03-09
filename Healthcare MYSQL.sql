show tables;

SELECT * FROM doctor;
SELECT * FROM Patient;
SELECT * FROM visit;
SELECT * FROM treatments;
SELECT * FROM labresults;


-- 1.kpi for Total Doctors--------
create table kpi1 as
SELECT CONCAT(COUNT(*), 'k') AS TotalDoctors
FROM healthcare.doctor;

select * from kpi1;

-- 2.kpi for Total Patients---------
create table kpi2 as
SELECT concat(COUNT(*),'k') AS TotalPatient
FROM healthcare.Patient;
select * from kpi2;

-- 3.kpi for Total Visits-----------
create table kpi3 as
SELECT concat(COUNT(*),'k') AS TotalVisits
FROM healthcare.visit;
select * from kpi3;

-- 4.kpi for Total Lab test Conducted----------
create table kpi4 as
SELECT concat(COUNT(*),'k')AS TotalLabTestConducted
FROM healthcare.labresults;
select * from kpi4;

-- 5.Average Age of Patients------------
create table kpi5 as
SELECT 
    AVG(TIMESTAMPDIFF(
        YEAR,
        STR_TO_DATE(`Date Of Birth`, '%d-%m-%Y'),
        CURDATE()
    )) AS AverageAge
FROM healthcare.patient;
select * from kpi5;

-- 6.Top 5 Diagnosed Conditions----------
create table kpi6 as
SELECT Diagnosis, COUNT(*) AS TOTAL_CASES
FROM visit 
GROUP BY Diagnosis
ORDER BY TOTAL_CASES DESC
LIMIT 5;
select * from kpi6;

-- 7.Treatment Cost Per Visit ----------
create table kpi7 as
SELECT 
     CONCAT('$',ROUND(AVG(REPLACE(`Treatment Cost`, "$", '') + 0), 2))AS Avg_Treatment_Cost_per_visit

FROM treatments;
select * from kpi7;

-- 8.Percentage of Abnormal Lab Results------------
CREATE TABLE kpi8 AS
SELECT 
    CONCAT(
        ROUND((SUM(IF(`Test Result` = 'Abnormal', 1, 0)) * 100.0) / COUNT(*), 2),
        '%'
    ) AS percent_of_result
FROM labresults;

select * from kpi8;

-- 9.Doctor Workload (Avg. Patients Per Doctor)---------
create table kpi9 as
SELECT 
    Round(COUNT(`Patient ID`) / COUNT(DISTINCT `Doctor ID`))AS Avg_patients_per_doctor
FROM visit;
select * from kpi9;

-- 10.Follow-Up Rate-------------
create table kpi10 as
SELECT 
    Round((SUM(IF(`Follow Up Required` = 'Yes', 1, 0)) * 100.0) / COUNT(*),2) AS Follow_up_Rate,
	Round((SUM(IF(`Follow Up Required` = 'No', 1, 0)) * 100.0) / COUNT(*), 2) AS FollowUp_No_Rate
FROM visit;
select * from kpi10;

