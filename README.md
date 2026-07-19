# SQL Project

# - Introduction
Join me as I dive into the data job market and explore top paying roles, in-demand skills, an analysis on high demand vs high salary with a focus on data analyst jobs.
SQL queries: Please find them here: [project_sql folder](/project_sql/)

# - Background
The questions I wanted answered are:
1. What are the top-paying data analyst roles?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for Data Analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# - Tools I used
I used the following tools:
- **SQL**: SQL is the foundational language used to query, filter, and aggregate the job postings and skill relationships in the dataset, directly mirroring the most in-demand skill (SQL with 7,291 mentions) identified across the remote Data Analyst roles.
- **PostgreSQL**: PostgreSQL serves as the relational database backend to store and efficiently query the normalised jobs, job_skills, -and aggregated skill tables, enabling scalable analysis of salary trends and co-occurrence patterns beyond simple CSV loading.
- **Visual Studio Code**: Visual Studio Code is the primary IDE used to write, debug, and iteratively develop the Python scripts (generate_data.py, Streamlit app), Plotly visualisations, and the self-contained index.html dashboard.
- **Git and GitHub**  Git provides version control for all project files (code, data CSVs, and dashboard), and GitHub hosts the repository, enables collaboration, and deploys the fully populated interactive HTML dashboard via GitHub Pages.


# - The Analysis

Each query of the project was used to gain some insights on the Data Analyst job market. I approached each question in this way:

### 1. Top paying Data Analyst Jobs
To identify the highest-paying jobs, I filtered data analyst roles by average yearly salary and by location (remote). The highest paying remote jobs were highlighted by the query.

```sql 
    SELECT
        job_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_posted_date,
        name as company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short = 'Data Analyst' AND 
          job_location = 'Anywhere' AND  
          salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10;
```
Findings
Senior leadership roles (Director, Principal, Associate Director) dominate the highest salaries, accounting for 7 of the 10 top remote positions.
SmartAsset, Meta, and AT&T lead in high-paying remote hires, highlighting strong demand from fintech and major tech/telecom companies.
Top remote Data Analyst roles were posted throughout 2023 with no clear seasonal pattern, offering year-round opportunities.
<img width="463" height="266" alt="image" src="https://github.com/user-attachments/assets/5cc525e6-ac87-41d9-8d9b-d31caf1939da" />

### 2. Top-paying job skills
This query first identifies the highest-paying remote Data Analyst jobs using a CTE, then joins the results with skill tables to return each job along with all its required skills, ordered by salary. The final output shows the top 30 skill rows across the highest-paid roles.

```sql
    WITH top_paying_jobs AS 
(
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        job_posted_date,
        name as company_name
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short LIKE '%Data Analyst%' AND 
    job_location = 'Anywhere' AND  
    salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
)

SELECT (top_paying_jobs.*),
       skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC
LIMIT 30; 

```
Insights
Top-paying roles consistently require SQL + Python as core skills, paired with visualization tools (Tableau, Power BI) and cloud platforms (Azure, AWS, Snowflake, Databricks).
Director and Principal-level positions demand broader stacks, including DevOps and collaboration tools such as Jenkins, Bitbucket, Jira, Confluence, and GitLab.
Senior remote Data Analyst jobs in 2023 favored modern data engineering skills (PySpark, Pandas, NumPy, Go) alongside traditional analytics tools.





# - What I learned
# - Conclusions

