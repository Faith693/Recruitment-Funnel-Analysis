SELECT * FROM mackenzie_carter_consulting;


--1. Understand your question
--2. Understand the table you need to answer the question
--3. Understand the columns from the table that you need to answer the question
--4. Understand the functions, clauses that we need to answer the question


--How many candidates progress through each funnel stage (funnel conversion rate)?
--applicant_id,phone_date,HM_DATE,TECH1,TECH2,OFFER,HIRE
--COUNT,AS


--Question 1
SELECT count(applicant_id) AS Total_applications, 
count(phone_interview_date) AS Phone_interviews, 
count(hm_interview_date) AS hm_interview, 
count(tech_stage1_date) AS tech_stage1,
count(tech_stage2_date) AS tech_stage2, 
count(offer_date) AS offers, 
count(hire_date) AS Hires
FROM mackenzie_carter_consulting;



--Question 2
--What is the average time-to-hire by department, role, and recruiter?
--APPLICATION_DATE, HIRE_DATE, DEPARTMENT, JOB_TITLE, RECRUITER_NAME
--AVERAGE, ROUND


SELECT 
round(avg(hire_date - application_date),2) AS Average_time_to_hire, 
department, 
job_title, 
recruiter_name 
FROM mackenzie_carter_consulting 
WHERE hire_date is not null
group by department, job_title, recruiter_name
order by average_time_to_hire desc;


--Question 3
--Which sources of hire deliver the best ROI (hires per cost, quality score)?
-- source_of_application,roi_score
--AVERAGE, ORDER BY


SELECT source_of_application, round(cast(avg(roi_score)as decimal),2) as ROI
FROM mackenzie_carter_consulting WHERE hire_date is not null
group by source_of_application
order by ROI DESC;


--Question 4
-- Where do most rejections occur, and what are the top rejection reasons?
--rejection_by,rejection_reason
--order by, count


SELECT 
rejection_by, 
rejection_reason,
count(rejection_reason) as total_rejections
FROM mackenzie_carter_consulting 
WHERE rejection_by is not null
group by rejection_by, rejection_reason
order by total_rejections desc;


--Question 5
--How does candidate diversity (gender/ethnicity) impact --progression or outcome?
--applicant_id, hire_date, gender, ethnicity


SELECT 
count(applicant_id) as Total_Application, 
gender, 
ethnicity, 
Count(hire_date) as Hires
FROM mackenzie_carter_consulting 
group by gender, ethnicity
order by 4 desc;


--Question 6
-- What are the average candidate experience scores by recruiter or source?

--average candidate experience scores by recruiter
SELECT recruiter_name,
ROUND (CAST(AVG(candidate_experience_score) as decimal), 2) AS avg_experience_score
FROM mackenzie_carter_consulting
GROUP BY recruiter_name
ORDER BY avg_experience_score DESC;


--average candidate experience scores by Source
SELECT source_of_application,
ROUND (CAST(AVG(candidate_experience_score) as decimal), 2) AS avg_experience_score
FROM mackenzie_carter_consulting
GROUP BY source_of_application
ORDER BY avg_experience_score DESC;


--Question 7
-- Which departments or job levels have the highest offer decline rates?


--highest offer decline rates by departments
SELECT department,
ROUND(CAST(COUNT(*) FILTER (WHERE offer_status = 'Declined') * 100.0 / COUNT(*)as decimal),2) AS decline_rate_percent
FROM mackenzie_carter_consulting
GROUP BY department
ORDER BY decline_rate_percent DESC;

--highest offer decline rates by job levels
SELECT job_level,
ROUND(COUNT(*) FILTER (WHERE offer_status = 'Declined') * 100.0 / COUNT(*),2) AS decline_rate_percent
FROM mackenzie_carter_consulting
GROUP BY job_level
ORDER BY decline_rate_percent DESC;

















