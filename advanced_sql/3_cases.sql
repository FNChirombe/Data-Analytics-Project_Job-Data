CREATE TABLE january_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

Create table february_jobs AS
SELECT *     
FROM job_postings_fact                                                            
wHERE EXTRACT(MONTH FROM job_posted_date) = 2;

create table march_jobs AS
SELECT *   
FROM job_postings_fact 
where extract(month from job_posted_date) = 3;