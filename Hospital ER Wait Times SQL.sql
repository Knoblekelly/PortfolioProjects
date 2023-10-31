-- Import Data and View

SELECT * FROM [Hospital ER];

-- Simplify Date Format

SELECT date, CONVERT(date, date) FROM [Hospital ER]
UPDATE [Hospital ER] SET date = CONVERT(date, date)
SELECT * FROM [Hospital ER]

-- Check Patient Wait times

SELECT MAX(patient_waittime) FROM [Hospital ER]
SELECT MIN(patient_waittime) FROM [Hospital ER]
SELECT AVG(patient_waittime) FROM [Hospital ER]

-- Average cannot be computed as current form, error: "Operand data type varchar is invalid for avg operator"
-- Verify data type is the problem

SELECT * FROM INFORMATION_SCHEMA.COLUMNS

-- Use CAST AS to change varchar to int

SELECT AVG(CAST(patient_waittime AS int)) FROM [Hospital ER]

-- Max is 60, Min is 10, Avg is 35
-- Look at all entries with max/min/avg wait times

SELECT * FROM [Hospital ER] WHERE patient_waittime = 60
SELECT * FROM [Hospital ER] WHERE patient_waittime = 10
SELECT * FROM [Hospital ER] WHERE patient_waittime = 35

-- Look at distribution of data across the mean

SELECT COUNT(patient_id) FROM [Hospital ER] WHERE patient_waittime < 35
SELECT COUNT(patient_id) FROM [Hospital ER] WHERE patient_waittime > 35

-- Patients with waittimes shorter than average is 4474
-- Patients with waittimes longer than average is 4583

-- Investigate differences in average wait time for various patient demographics

SELECT patient_gender, AVG(CAST(patient_waittime AS int)) FROM [Hospital ER] GROUP BY patient_gender
SELECT patient_age, AVG(CAST(patient_waittime AS int)) FROM [Hospital ER] GROUP BY patient_age
SELECT patient_sat_score, AVG(CAST(patient_waittime AS int)) FROM [Hospital ER] GROUP BY patient_sat_score ORDER BY patient_sat_score
SELECT patient_race, AVG(CAST(patient_waittime AS int)) FROM [Hospital ER] GROUP BY patient_race

-- All demographics seem to show an even distribution, implying that none of the patients' demographics influenced their wait times

-- Check if department refferal is a factor in wait time

SELECT department_referral, AVG(CAST(patient_waittime AS int)) FROM [Hospital ER] GROUP BY department_referral

-- Department referral also seems to have no bearing on patient wait times

--Overall, it would seem that none of the categories measured in this data set had a significant effect on the patient wait times.