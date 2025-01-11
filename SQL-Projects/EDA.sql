SELECT * FROM health;

-- Check for any missing values in key fields
SELECT COUNT(*) AS MissingVal
FROM health
WHERE `Name` IS NULL OR GENDER IS NULL OR Blood_Type IS NULL OR Insurance_Provider IS NULL;


-- Check how many patients are admitted to each hospital
SELECT Hospital, COUNT(*) AS Number_of_Patients
FROM health
GROUP BY Hospital
ORDER BY 2 DESC;


-- Check how many patients are covered by each insurance provider
SELECT Insurance_Provider, COUNT(*) Number_of_Patients
FROM health
GROUP BY Insurance_Provider
ORDER BY 2 DESC;


-- Check the most common blood type in patients
SELECT Blood_Type, COUNT(*) as count_of_blood_type
FROM health
GROUP BY Blood_Type
ORDER BY 2 DESC;


-- Identify which doctor treated the most number of patients
SELECT Doctor, COUNT(*) Number_of_Patients
FROM health
GROUP BY Doctor
ORDER BY 2 desc
LIMIT 1;


-- Average Stay
SELECT `Name`, Date_of_Admission, Discharge_Date
FROM health;


-- Check how does is gender related to the frequency of certain medical conditions
SELECT Gender, Medical_Condition, COUNT(*) as Gender_specific
FROM health
GROUP BY Gender, Medical_Condition
ORDER BY 3 desc;

-- Check how many patients fall into each age bracket (Young, Middle Age, Old)
SELECT * FROM health;


-- Check what is the common Medical Condition in Young age group(13-29)
SELECT Medical_Condition, COUNT(*) as count_of_condition
FROM health
WHERE Age BETWEEN 13 AND 29
GROUP BY Medical_Condition
ORDER BY Medical_Condition DESC;


-- Check average billing amount for different admission type
SELECT Admission_Type, AVG(Billing_Amount) Avg_bill_amnt
FROM health
GROUP BY Admission_Type;





