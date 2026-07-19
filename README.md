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
#### Findings

## 📊 Top 10 Highest-Paying Remote Data Analyst Jobs (2023)

This table shows the **10 highest-paying fully remote Data Analyst** roles (including Director and Principal-level positions) posted in 2023.

| Job ID   | Job Title                                      | Location | Schedule   | Salary (USD) | Posted Date          | Company                                  |
|----------|------------------------------------------------|----------|------------|--------------|----------------------|------------------------------------------|
| 226942   | Data Analyst                                   | Anywhere | Full-time  | 650,000      | 2023-02-20           | Mantys                                   |
| 547382   | Director of Analytics                          | Anywhere | Full-time  | 336,500      | 2023-08-23           | Meta                                     |
| 552322   | Associate Director - Data Insights             | Anywhere | Full-time  | 255,830      | 2023-06-18           | AT&T                                     |
| 99305    | Data Analyst, Marketing                        | Anywhere | Full-time  | 232,423      | 2023-12-05           | Pinterest Job Advertisements             |
| 1021647  | Data Analyst (Hybrid/Remote)                   | Anywhere | Full-time  | 217,000      | 2023-01-17           | Uclahealthcareers                        |
| 168310   | Principal Data Analyst (Remote)                | Anywhere | Full-time  | 205,000      | 2023-08-09           | SmartAsset                               |
| 731368   | Director, Data Analyst - HYBRID                | Anywhere | Full-time  | 189,309      | 2023-12-07           | Inclusively                              |
| 310660   | Principal Data Analyst, AV Performance Analysis| Anywhere | Full-time  | 189,000      | 2023-01-05           | Motional                                 |
| 1749593  | Principal Data Analyst                         | Anywhere | Full-time  | 186,000      | 2023-07-11           | SmartAsset                               |
| 387860   | ERM Data Analyst                               | Anywhere | Full-time  | 184,000      | 2023-06-09           | Get It Recruit - Information Technology  |

> **Note**: All roles are 100% remote (`Anywhere`) and full-time. Salaries represent yearly averages.

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
#### Insights
Top-paying roles consistently require SQL + Python as core skills, paired with visualization tools (Tableau, Power BI) and cloud platforms (Azure, AWS, Snowflake, Databricks).
Director and Principal-level positions demand broader stacks, including DevOps and collaboration tools such as Jenkins, Bitbucket, Jira, Confluence, and GitLab.
Senior remote Data Analyst jobs in 2023 favored modern data engineering skills (PySpark, Pandas, NumPy, Go) alongside traditional analytics tools.

3. Top demanded skills
   
The first query joins job postings with their skills and returns the top 5 highest-paying jobs along with every skill listed for them. The second query filters only remote Data Analyst roles, counts skill occurrences, and returns the 5 most frequently requested skills.

   ```sql
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
```
#### Findings
- SQL is the most in-demand skill for remote Data Analyst roles (7,291 mentions), followed by Excel, Python, Tableau, and Power BI.
- The core remote Data Analyst tech stack in 2023 centers on SQL + Python combined with visualization tools (Tableau/Power BI).
- Traditional tools like Excel still rank very high, showing that strong foundational skills remain essential even for high-paying remote positions.

4. Top job-related skills vs Salary
This query joins job postings with their required skills, filters for Data Analyst roles with salary data, and calculates the average salary associated with each skill. It then returns the top 25 skills linked to the highest average salaries.

```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
        --AND job_work_from_home = True
GROUP BY 
    skills
ORDER BY  
    avg_salary DESC
LIMIT 25;
```
#### Findings
- Niche and emerging skills (SVN, Solidity, Couchbase, DataRobot, Golang) are associated with the highest average salaries for Data Analyst roles.
- Modern data engineering and ML tools (Terraform, Kafka, PyTorch, TensorFlow, Airflow) command significantly higher compensation than traditional skills.
- Top-paying skills often combine specialized technologies (version control, cloud, ML frameworks) with strong data infrastructure knowledge.

5. Optimal Skills to Learn as a new Data Analyst

This query uses two CTEs to calculate (1) how often each skill appears and (2) the average salary for remote Data Analyst jobs. It then joins the results, filters for skills appearing in more than 10 jobs, and returns the top 25 skills ordered by highest average salary.

```sql
WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst'
          AND salary_year_avg IS NOT NULL
          AND job_work_from_home = True
    GROUP BY 
        skills_dim.skill_id
), average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 2) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst' AND
            salary_year_avg IS NOT NULL
            AND job_work_from_home = True
    GROUP BY 
        skills_job_dim.skill_id
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE demand_count > 10 
ORDER BY avg_salary DESC,   
         demand_count DESC
LIMIT 25;
```

#### Findings
-Go, Confluence, Hadoop, Snowflake, and Azure are the skills linked to the highest average salaries for remote Data Analyst roles while maintaining solid demand.
-Cloud and data infrastructure skills (Snowflake, Azure, AWS, BigQuery, Redshift) consistently deliver above-average pay for remote positions.
-Core skills like Python, Tableau, and R appear far more frequently but are associated with slightly lower average salaries compared to specialised engineering tools.

6. Visualisation
<img width="1950" height="1125" alt="skills_bubble_animation" src="https://github.com/user-attachments/assets/c9f79b69-81c1-472e-8875-cb7d6ead12b8" />


# - What I learned

- I got much better at writing complex SQL queries using joins and CTEs to combine job postings with skill data, which helped me pull out more useful insights from the database.
- I improved at turning raw numbers (like salaries and skill counts) into clear, interactive visualisations that actually tell a story people can understand.
- I learned how to connect different parts of an analysis — from finding in-demand skills to linking them with salaries — into one smooth project instead of doing everything in isolation.

# - Conclusions

## Insights

-Senior/leadership roles dominate the highest salaries.
- SQL + Python form the essential core skill set.
- Cloud skills (Snowflake, Azure, AWS) deliver clear salary premiums.
- DevOps tools (GitLab, Jira, Bitbucket) appear in top-paying roles.
- High-paying remote opportunities were available year-round.

This project gave me a complete, hands-on experience of what it’s like to work as a data analyst — from querying real job market data to presenting insights in an engaging way. It strengthened both my technical skills and my ability to communicate findings clearly, which I know will be valuable in my future work.
