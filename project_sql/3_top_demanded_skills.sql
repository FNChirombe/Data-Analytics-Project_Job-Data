/*
What are the most in-demand skills for Data Analysts?
-Join job postings to inner join table similar to query 2.
-Identify the top 5 most frequently listed skills for Data Analyst roles.
-Focus on all job postings.
-Reason: This query provides insights into the skills that are most sought after in the Data Analyst job market, helping job seekers prioritize skill development.
*/  

/*
Question: What skills are required for the top-paying data analyst jobs?
-Use the top 10 highest paying Data Analyst roles from the frist query.
-Add specific skills required for these roles.
-Reason: It provides a detailed look at which highest paying jobs demand certain skills,
helping job seekers understand which skills to develop that align with top salaries.
*/


SELECT *
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC
LIMIT 5; --overview of the top 5 most frequently listed skills for all roles

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND
      job_work_from_home = True
GROUP BY skills
ORDER BY demand_count DESC  
LIMIT 5;

/*Results: This query provides a list of the top 5 most frequently listed skills for Data Analysts, allowing job seekers to identify which skills are in high demand in the field.
[
  {
    "skills": "sql",
    "demand_count": "7291"
  },
  {
    "skills": "excel",
    "demand_count": "4611"
  },
  {
    "skills": "python",
    "demand_count": "4330"
  },
  {
    "skills": "tableau",
    "demand_count": "3745"
  },
  {
    "skills": "power bi",
    "demand_count": "2609"
  }
]
*/