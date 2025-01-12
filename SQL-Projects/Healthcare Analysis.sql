-- Exploratory Data Analysis

SELECT * FROM health;

-- Creating duplicate table to save the raw file
CREATE TABLE health2
LIKE health;

INSERT INTO health2
SELECT * FROM health;

SELECT * FROM health2;


-- Check for any missing values in key fields
SELECT COUNT(*) AS MissingVal
FROM health
WHERE `Name` IS NULL OR GENDER IS NULL OR Blood_Type IS NULL OR Insurance_Provider IS NULL;


-- Check for duplicate values and delete if any found
WITH cte_new as
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY `Name`, Age, Gender,
Blood_Type, Medical_Condition, Date_of_Admission, Doctor, Hospital, Insurance_Provider,
Billing_Amount, Room_Number, Admission_Type, Discharge_Date, Medication, Test_Results) as row_num
FROM health2
)
SELECT *
FROM cte_new
WHERE row_num > 1;


CREATE TABLE `health3` (
  `Name` varchar(255) DEFAULT NULL,
  `Age` int DEFAULT NULL,
  `Gender` varchar(50) DEFAULT NULL,
  `Blood_Type` varchar(10) DEFAULT NULL,
  `Medical_Condition` text,
  `Date_of_Admission` date DEFAULT NULL,
  `Doctor` varchar(255) DEFAULT NULL,
  `Hospital` varchar(255) DEFAULT NULL,
  `Insurance_Provider` varchar(255) DEFAULT NULL,
  `Billing_Amount` decimal(10,2) DEFAULT NULL,
  `Room_Number` varchar(50) DEFAULT NULL,
  `Admission_Type` varchar(50) DEFAULT NULL,
  `Discharge_Date` date DEFAULT NULL,
  `Medication` text,
  `Test_Results` text,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


INSERT INTO health3
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY `Name`, Age, Gender,
Blood_Type, Medical_Condition, Date_of_Admission, Doctor, Hospital, Insurance_Provider,
Billing_Amount, Room_Number, Admission_Type, Discharge_Date, Medication, Test_Results) as row_num
FROM health2;

DELETE FROM health3
WHERE row_num > 1;

ALTER TABLE health3
DROP COLUMN row_num;

-- Check how many patients are admitted to each hospital
SELECT Hospital, COUNT(*) AS Number_of_Patients
FROM health3
GROUP BY Hospital
ORDER BY 2 DESC;


-- Check how many patients are covered by each insurance provider
SELECT Insurance_Provider, COUNT(*) Number_of_Patients
FROM health3
GROUP BY Insurance_Provider
ORDER BY 2 DESC;


-- Check the most common blood type in patients
SELECT Blood_Type, COUNT(*) as count_of_blood_type
FROM health3
GROUP BY Blood_Type
ORDER BY 2 DESC;


-- Identify which doctor treated the most number of patients
SELECT Doctor, COUNT(*) Number_of_Patients
FROM health3
GROUP BY Doctor
ORDER BY 2 desc
LIMIT 1;


-- Stay duration for each patient in each hospital
SELECT `Name`,Hospital, Date_of_Admission, Discharge_Date,
		DATEDIFF(Discharge_Date, Date_of_Admission) AS Stay_Duration
FROM health3;


-- Check how does is gender related to the frequency of certain medical conditions
SELECT Gender, Medical_Condition, COUNT(*) as Gender_specific
FROM health3
GROUP BY Gender, Medical_Condition
ORDER BY 3 desc;


-- Check how many patients fall into each age bracket (Young, Middle Age, Old)
SELECT `Name`, Age,
CASE
	WHEN Age BETWEEN 13 AND 24 THEN 'Young'
	WHEN Age BETWEEN 25 AND 60 THEN 'Adult'
	WHEN Age > 60 THEN 'Old'
END AS Age_Bracket
FROM health3;


-- Check what is the common Medical Condition in Young age group(13-24)
SELECT Medical_Condition, COUNT(*) as Number_of_Patients
FROM health3
WHERE Age BETWEEN 13 AND 24
GROUP BY Medical_Condition
ORDER BY Medical_Condition DESC;
