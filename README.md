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







# - What I learned
# - Conclusions

